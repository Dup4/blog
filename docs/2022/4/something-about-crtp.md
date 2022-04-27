# Something About Curiously Recurring Template Pattern(CRTP)

???+ info "Contents"
    [TOC]

## Intro

奇异递归模板模式（curiously recurring template pattern，**CRTP**），是 C++ 模板编程时的一种惯用法，即将派生类作为基类的模板参数。

## General Form

```cpp
// The Curiously Recurring Template Pattern (CRTP)
template <class T>
class Base {
    // methods within Base can use template to access members of Derived
};

class Derived : public Base<Derived> {
    // ...
};
```

CRTP 的起手式一般如上所示。

下面会介绍一些 CRTP 的用例，比如静态多态。

## Dynamic polymorphism

为了更好的介绍 CRTP，我们先回顾一下使用虚函数实现动态多态的基本写法。

```cpp
---8<--
learning-cpp/example/CRTP/dynamic_polymorphism.cpp
---8<--
```

输出结果：

```cpp
---8<--
learning-cpp/example/CRTP/dynamic_polymorphism.out
---8<--
```

一般使用 `virtual` 关键字来在基类声明一个虚函数，在子类中去 `override` 它，在运行时，通过虚表找到指定的函数去执行，这样会存在运行时的开销。

而且派生类的 `override` 是覆写，如果想调用基类原本的 `Show` 函数，还得在派生类中调用一下，这时可以认为 **主动权** 掌握在派生类手上。

## Static polymorphism

我们可以利用 CRTP 来实现静态多态。

```cpp
---8<--
learning-cpp/example/CRTP/static_polymorphism.cpp
---8<--
```

输出结果：

```cpp
---8<--
learning-cpp/example/CRTP/static_polymorphism.out
---8<--
```

由于基类能够在编译期知道派生类的类型，那么通过 `static_cast` 就可以将自己转换成派生类的类型，并且访问派生类的函数。

这时可以发现，调用 `Show` 函数的入口，其实是基类中的 `Show`，多态的行为是基类中 `Show` 函数进行控制的。

可以认为 **主动权** 掌握在基类手上。

想要实现多态也能简单，只需要在函数中声明基类类型时使用模板即可，那么就可以传入不同的派生类类型，来达到多态的目的。

那如果我们想用一个 `vector` 来存不同的派生类呢？

## Static polymorphism combined with dynamic polymorphism

由于 `vector` 只能存储同一类型，对于动态多态，我们只需要存储基类的指针，即可在 `vector` 中存储不同派生类转化成的基类指针。

但是在 CRTP 中实现的静态多态中，基类是个模板类，好像就不太可行了。

```cpp
---8<--
learning-cpp/example/CRTP/static_polymorphism_combined_with_dynamic_polymorphism.cpp
---8<--
```

输出结果：

```cpp
---8<--
learning-cpp/example/CRTP/static_polymorphism_combined_with_dynamic_polymorphism.out
---8<--
```

一个可行的方法是，**动静结合**。

即在 CRTP 基类之上，再声明一个基类，这两个类型之间用动态多态。

虽然仍然存在运行时的开销，但是相比于全链路动态多态，这种 **动静结合** 的方式，开销还是要小一些。

## Object counter

使用 CRTP，我们能够轻易的实现元素构造的计数。

```cpp
---8<--
learning-cpp/example/CRTP/object_counter.cpp
---8<--
```

输出结果：

```cpp
---8<--
learning-cpp/example/CRTP/object_counter.out
---8<--
```

## Polymorphic chaining

这个要解决的问题是说，对 Class 中的函数进行链式调用时，如果调用链中既有基类函数（未被派生类覆写的函数），也有派生类函数，那么这两类函数返回的 this 是不一样的，一旦某个节点返回的 this 是基类类型，那么在这个链式调用的后续，就无法再调用派生类的独有方法。

但是 CRTP 能解决这个问题，因为基类能够拿到派生类的类型，可以将 this 转换成派生类类型。

```cpp
---8<--
learning-cpp/example/CRTP/polymorphic_chaining.cpp
---8<--
```

输出结果：

```cpp
---8<--
learning-cpp/example/CRTP/polymorphic_chaining.out
---8<--
```

## Polymorphic copy construction

使用 CRTP 也能轻易实现派生类的深拷贝，而不用为每个派生类都实现一遍。

其实参考这个 case，可以发现，CRTP 基于模板，有效的使用它，可以比动态多台减少更多的代码重复。

```cpp
---8<--
learning-cpp/example/CRTP/polymorphic_copy_construction.cpp
---8<--
```

输出结果：

```cpp
---8<--
learning-cpp/example/CRTP/polymorphic_copy_construction.out
---8<--
```

## Reference

* https://en.wikipedia.org/wiki/Curiously_recurring_template_pattern
* http://www.vishalchovatiya.com/crtp-c-examples/
