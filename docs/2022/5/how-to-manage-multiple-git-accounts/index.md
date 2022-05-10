# How to manage multiple git accounts

## Write in front

一般情况下只需要用一个 git 账号就可以满足开发需求。

但是在某些特殊情况下，可能需要同时在几个 git 账号之间切换，满足不同项目的开发需求。

譬如：

* GitHub 中需要开发一些开源项目，用的是自己的个人邮箱。
* 在学校的实验室里需要开发一些实验室的项目，而实验室又自己搭建了 GitLab，那么又有一个账号，可能用的是学校的 edu 后缀邮箱。

那么这个时候如何在自己的多个 git 账号间丝滑切换就变得比较重要。

## My solution

首先假定我有两个账号。

一个是 GitHub 账号，具体信息如下：

```plain title=".gitconfig.dup4"
[user]
    name = Dup4
    email = git@dup4.com
```

另一个是 GitLab 账号，具体信息如下：

```plain title=".gitconfig.panlyuzhi"
[user]
    name = panlyuzhi
    email = panlyuzhi@hznu.edu.cn
```

### Authentication

首先是鉴权，对于 GitHub 或是 GitLab，如果要 push 或者拉取私有仓库（对于 GitHub），那么都需要鉴权。

我个人比较倾向于 ssh 鉴权，

我会生成两套 SSH key，一套用于 GitHub，另一套用于 GitLab。

至于如何生成 SSH key，以及如何将 SSH key 添加到 GitHub/GitLab，可以参考 [GitHub 文档](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)，对于 GitLab，也是大同小异。

### Configuration

对于配置，我会在 `$HOME` 目录下，生成两套配置，命名为：

* `.gitconfig.dup4`
* `.gitconfig.panlyuzhi`

### Switch between accounts

那么对于账号间的切换，我会在 `~/.bashrc` 中，写下一个函数。

```bash
function change_git() {
    target="${1}"

    if [[ -z "${target}" ]]; then
        echo "current: $(git config user.name)"
        return
    fi

    echo "before: $(git config user.name)"
    cp ~/.gitconfig."${target}" ~/.gitconfig

    ssh-add -d ~/.ssh/id_rsa_dup4
    ssh-add -d ~/.ssh/id_rsa_panlyuzhi

    ssh-add ~/.ssh/id_rsa_"${target}"

    echo "after: $(git config user.name)"
}
```

这个函数，主要干了以下事情：

* 将指定账号的 `.gitconfig.${target}` 拷贝到 `~/.gitconfig`。
* 清空 ssh-agent 中托管的 ssh 私钥，并将指定账号的 SSH 私钥加入到 ssh-agent。
* 输出相关 log。

PS: 如果要启用 ssh-agent，可能需要在启动 terminal 的时候，执行一下 `eval "$(ssh-agent -s)" >/dev/null`，常用的做法是将它加入到 `~/.bashrc` 或 `~/.zshrc` 中。

### Actual operation

那么如果我要切换 git 账号，那么我只需要在 terminal 中输入 `change_git dup4` 或者 `change_git panlyuzhi` 即可。

如果你仔细观察上面那个函数，你会发现，如果不传入参数，直接执行 `change_git`，那么会显示当前正在使用的 git 账号。

当然，我是一个很懒的人，所以我受不了 `change_git` 那么长的命令，所以我会在我的 `~/.bashrc` 中加一个 `alias cg=change_git`。
