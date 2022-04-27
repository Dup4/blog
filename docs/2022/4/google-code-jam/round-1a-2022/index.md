# Google Code Jam Round 1A 2022 Tutorial

???+ info "Contents"
    [TOC]

## Info

* [Practice Link](https://codingcompetitions.withgoogle.com/codejam/round/0000000000877ba5)
* [Code Repo Link](https://github.com/Dup4/Google-Coding-Competitions/tree/main/CodeJam/2022/Round-1A)
* Video: [BiliBili](https://www.bilibili.com/video/BV1oS4y1P7F6), [Youtube](https://youtu.be/hpk7ejw1VPk)
* Score: 69
* Rank: 734

## Problems

### Double or One Thing

题意：

给出一个字符串 $S$，长度为 $n$，对于每个字符可以选择是否复制一个并且追加在其之后。

那么一共有 $2^n$ 种可能的字符串。

![](./iShot2022-04-15%2009.51.44.png)

比如上面这个例子，就是将高亮处的字符复制了一份的结果。

要求字典序最小的字符串。

思路：

对于小 case，$n$ 最大只有 $10$，可以构造出所有可能的字符串，然后排序，取第一个即可。

??? info "Code"
    ```cpp
    ---8<--
    Google-Coding-Competitions/CodeJam/2022/Round-1A/a/a.cpp
    ---8<--
    ```

对于大 case：

我们考虑，假设有一个字符串 $T$，我们能以 $\mathcal{O}(n^2)$ 复杂度的 dp 去判断它能否通过 $S$ 构造出来。

那么我们就贪心去按位构造 $T$，然后去 check 就行。

如何判断 $T$ 能否通过 $S$ 构造出来？

考虑 $f_{i, j}$ 表示 $S$ 的前 $i$ 位和 $T$ 的前 $j$ 位是否匹配。

转移有：

$$
\left.
\begin{array}{l}
\text{$s_i$ = $t_j$ :} & f_{i, j} \;|\; f_{i - 1, j - 1}\\
\text{$s_i$ = $t_{j - 1}$ :} & f_{i, j} \;|\; f_{i - 1, j - 2}
\end{array}
\right\}
= f_{i, j}
$$

??? info "Code"
    ```cpp
    ---8<--
    Google-Coding-Competitions/CodeJam/2022/Round-1A/a/a1.cpp
    ---8<--
    ```

### Equal Sum

题意：

交互题。

$n = 100$。

你先给出 $n$ 个互不相同数，然后 jury 给出 $n$ 个互不相同（并且与你的 $n$ 个数也互不相同）数。

你需要将数分成两堆，要求两堆数的和相等。

给出的数的范围是 $[1, 10^9]$。

思路：

考虑将 $10^9$ 以下的 $2$ 的幂次的数都给出来。

那么这就已经可以构造出 $10^9$ 以下的任何数了。

之后将 jury 给出的 $n$ 个数放在一起排序，先给出大的数，直到剩余的数小于 $10^9$，然后用 $2$ 的幂次去构造这个数字。

注意给出大的数的过程中要剔除掉 $2$ 的幂次的数。

??? info "Code"
    ```cpp
    ---8<--
    Google-Coding-Competitions/CodeJam/2022/Round-1A/b/b.cpp
    ---8<--
    ```

### Weightlifting

题意：

你是一个举重运动员，你的训练目标是每次将不同重量的圆盘组合套在棍子里。

这个棍子可以视为一个栈。

换句话说，你的训练计划有 $E$ 个步骤。

每个步骤中要求这个棍子里套着的圆盘组合符合训练计划的要求。

你可以做的操作是往棍子上加一个圆盘或者拿掉一个圆盘。

注意，最后要求棍子上没有圆盘。

求最少的操作次数。

思路：

针对小 case：

维护栈中的顺序，`next_permutation` 转移，$\displaystyle ((\frac{9!}{3!})^3)^2 \times 9 \times 3$。

??? info "Code"
    ```cpp
    ---8<--
    Google-Coding-Competitions/CodeJam/2022/Round-1A/c/c.cpp
    ---8<--
    ```
