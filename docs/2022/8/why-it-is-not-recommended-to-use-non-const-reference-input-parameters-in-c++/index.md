# Why it is not recommended to use non-const reference input parameters in C++

## Background

```c++
struct A {
    int a;
    int b;
    std::string c;
};

int main() {
    A a;
    Foo(a);
}
```

之前在设计一个接口的时候，我需要提供一个 `Foo()` 函数，它需要接收一个入参 `A`，并且该参数在函数内部会对其进行修改。

## First ideas

一开始的时候，我没有考虑使用指针，只考虑引用。

也是我写下了第一个函数：

```c++
void Foo(A& a) {
    ...
}
```

但是这样有一个问题，不能传递右值，比如无法像如下代码一样调用：

```c++
Foo(A{
    .a = 1,
    .b = 2,
    .c = "",
});
```

这个简单，我们加一个重载函数即可：

```c++
void Foo(A& a) {
    ...
}

void Foo(A&& a) {
    ...
}
```

这样上述的问题即解决了。

但是这样，对于调用者来说有一个问题，我知道 `Foo` 会修改 `A`，所以我想传入一个 `clone` 后的值，这样需要调用者在调用之前先 `clone` 一份，譬如：

```c++
A a;
A a_clone = a;
Foo(a_clone);
```

这样就会多一步，还多了一个临时变量。

## Final Solution

最后想到，我们可以使用指针，譬如：

```c++
void Foo(A a) {
    ...
}

void Foo(A* a) {
    ...
}
```

如此一来，我们可以这么调用：

```c++
A a;
Foo(a); // 深拷贝
Foo(std::move(a)); // 移动
Foo(&a); // 浅拷贝
```

调用者在调用的时候，只看入参就能判断 `a` 在函数调用前后的变动情况，相对比较清晰，并且不需要多出额外的局部变量。
