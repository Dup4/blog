# A shallow copy problem in Python 3

最近在开发 `board-spider` 过程中，遇到一个深拷贝的问题，感觉挺别致的。

代码简化如下：

```python3
import typing

class Team:
    def __init__(self, extra: typing.Dict[str, typing.Any] = {}):
        self.extra = extra

def work(teams: typing.List[Team]):
    for team in teams:
        if some condition:
            team.extra["a"] = True
```

如果在初始化的时候使用的是默认的 `{}`，那么你会发现，经过 `work` 函数处理之后，每个 `team` 的 `extra["a"]` 的值都是一样的。

因为每个 `team.extra` 都指向那个 `{}` 对象。

其中一个解决方案是，在 `__init__` 作用域内，给它赋予一个默认值，比如：

```python3
import typing

class Team:
    def __init__(self, extra: typing.Dict[str, typing.Any] = None):
        if extra is not None:
            self.extra = extra
        else:
            self.extra = {}
```
