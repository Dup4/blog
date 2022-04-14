# Google Code Jam Qualification Round 2022 Tutorial

???+ info "Contents"
    [TOC]

## Info

* [Practice Link](https://codingcompetitions.withgoogle.com/codejam/round/0000000000876ff1)
* [Code Repo Link](https://github.com/Dup4/Google-Coding-Competitions/tree/main/CodeJam/2022/Qualification-Round)
* Score: 71
* Rank: 3630

## Problems

### Punched Cards

题意：

给出 $R$ 和 $C$，按指定规则画图。

思路：

模拟即可。

### 3D Printing

题意：

有 $n$ 台打印机，每台打印机需要 $4$ 种墨水，给出每台打印机中每种墨水的含量。

现在要用每个打印机分别打印一个 logo，打印 logo 需要 $10^6$ 单位的墨水，颜色不限，但是每种颜色的用量需要一致。

问每种颜色的墨水用量是多少，能够满足要求。

思路：

贪心即可。

### d1000000

题意：

有 $n$ 个骰子，第 $i$ 个骰子是 $a_i$ 维的，即含有数字 $[1, a_i]$。

现在目标是要将一部分骰子连起来，并且每个骰子向上的那一面的数字是个顺子，但是不要求从 $1$ 开始。

思路：

* 先不断往右边扩
* 右边扩不了了再往左边扩
* 贪心

### Chain Reactions

题意：

有 $n$ 个反应堆，每个反应堆的 fun 值为 $F_i$。

部分反应堆能连起来，发生连锁反应。

连锁反应产生的 fun 值是发生反应的反应堆集合中的 fun 值的最大值。

但是一个反应堆只能发生一次反应，如果被连锁反应多次触发，在第二次及后续中被触发时它不会发生反应。

连锁反应的关系是一个树，不是图。

现在能手动触发某个反应堆，使其发生反应，如果该反应堆后续连着另外的反应堆，那么就会发生连锁反应。

问以最优的方案去手动触发反应堆，能获得的最大 fun 值之和是多少？

思路：

考虑树形 dp。

每次将最小的 fun 值往父亲合并。

### Twisty Little Passages
