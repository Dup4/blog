# Google Code Jam Round 2 2022 Record

???+ info "Contents"
    [TOC]

## Info

* [Practice Link](https://codingcompetitions.withgoogle.com/codejam/round/00000000008778ec)
* [Code Repo Link](https://github.com/Dup4/Google-Coding-Competitions/tree/main/CodeJam/2022/Round-2)
* Score: 22
* Rank: 1682

## Problems

### Spiraling Into Control

题意：

给出一个 $n \cdot n$ 的蛇形矩阵。

从 $(x_0, y_0)$ 能够到达 $(x_1, y_1)$，当且仅当 $(x_0, y_0)$ 和 $(x_1, y_1)$ 相邻，并且在蛇形矩阵上 $(x_1, y_1)$ 上对应的数字大于 $(x_0, y_0)$ 上对应的数字。

现在要求从 $1$ 走到 $n \cdot n$，并且恰好用 $k$ 步，问是否可能，可能的话，给出中间跳跃的步骤。

思路：

猜想了一下，当前这一步是否选择跳跃，取决于跳跃后剩余的最大步数是否大于等于可用步数，是的话，就跳跃。

但是大 case TLE 了。

??? info "Small Case Code"
    ```cpp
    ---8<--
    Google-Coding-Competitions/CodeJam/2022/Round-2/a/a.cpp
    ---8<--
    ```

### Pixelated Circle

题意：

给出两种在矩阵上「画圆」的函数，求两种方式画出来的「黑点」的数量差异。

思路：

小 case 就将题面中的伪代码翻译一下，然后跑一遍，求个数量的 diff。

??? info "Small Case Code"
    ```cpp
    ---8<--
    Google-Coding-Competitions/CodeJam/2022/Round-2/b/b.cpp
    ---8<--
    ```

### Saving the Jelly

题意：

在一个足球场上，有 $n$ 个人，$n + 1$ 个糖果。

第 $i$ 个人的位置是 $(x_i, y_i)$。

第 $j$ 个糖果的位置是 $(x_j, y_j)$。

现在有个教练，每次可以指定第 $i$ 个人去拿糖果，这个人只能选择离自己最近的一颗糖果，如果有多颗糖果离自己最近，那么由教练指定他拿取哪一颗。

问，有没有方案，使得标号为 $0$ 的糖果，最后不被拿走？

思路：

针对小 case：

全排列枚举人拿的顺序，然后暴力 check。

check 的时候，如果某个人在轮到时有多个候选糖果，怎么办？

只要不取 $0$，其它随便取。

因为如果存在这个人一定得取某一颗糖果，那么最后方案才能跑通的话，那么肯定有另一种排列使得优先级更高的人在前面取走他所需的糖果。

??? info "Small Case Code"
    ```cpp
    ---8<--
    Google-Coding-Competitions/CodeJam/2022/Round-2/c/c.cpp
    ---8<--
    ```

### I, O Bot

题意：

在一个一维平面上，有 $n$ 个 ball，然后一辆收集车从 $0$ 开始出发，移动一单位需要花费 $1$ 单位的能量。

ball 有两种形状，`0` 形状和 `1` 形状。

收集车上有两个容器，其中一个容器能装 `0` 形状的 ball，另一个容器能装 `1` 形状的 ball。

但是可以花费 $C$ 单位的能量将一个形状的 ball 变成另外一个形状。

收集了 ball 之后，收集车可以回到 $0$ 位置储存球。

问将所有球都收集到 $0$ 位置最少需要多少单位的能量？

思路：

考虑，正负坐标轴是两个独立的子问题，分开做。

在比赛时想了个错误做法。

$f_{i, j}$ 表示处理完前 $i$ 个位置，$j$ 有三种状态，分别为 $0, 1, 2$。

* $0$ 表示还剩一个 `0` 形状的 ball 还没收集。
* $1$ 表示还剩一个 `1` 形状的 ball 还没收集。
* $2$ 表示前 $i$ 个 ball 收集完了。

然后 dp 即可。

但是这样会发现样例中的 case2 都过不了。因为它是留了两个 `0` 形状的 ball，和后面两个 `1` 形状的 ball，分别组合一起，进行两趟回收。

问题可能出在只维护剩一个 `0`/`1` 形状的 ball 的状态可能不够。但是如果维护的数量大了，空间复杂度又顶不住。

??? info "Wrong Code"
    ```cpp
    ---8<--
    Google-Coding-Competitions/CodeJam/2022/Round-2/d/d.cpp
    ---8<--
    ```

留坑。
