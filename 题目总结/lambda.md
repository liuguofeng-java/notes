## lambda

#### 1.常用函数式接口

**Supplier接口**

java.util.function.Supplier<T> 接口仅包含一个无参的方法：T get() 。用来获取一个泛型参数，可以指定类型的对象数据。由于这是一个函数式接口，这也就意味着对应的Lambda表达式需要“对外提供”一个符合泛型类型的对象数据。

**Consumer接口**

java.util.function.Consumer<T> 接口则正好与Supplier接口相反，它不是生产一个数据，⽽是消费一个数据，其数据类型由泛型决定。

- Consumer接口中包含抽象方法 void accept(T t) ，意思是说消费一个执行泛型的数据
- Consumer 接口中包含默认方法：andThen

**Predicate接口**

有时候我们需要对某种类型的数据进行判断，从而得到一个boolean值结果。这时可以使用

- 用java.util.function.Predicate<T>接口。
- Predicate 接口中包含一个抽象方法：boolean test(T t)
- 该接口也存在三个默认的方法，分别是and 、 or 和negate， 分别表示与 、或 、非三种逻辑处理。

**Function接口**

java.util.function.Function<T,R>接口用来根据一个类型的数据得到另一个类型的数据，前者称为前置条件，后者称为后置条件。

- Function 接口中最主要的抽象方法是：R apply(T t) ，根据类型T的参数获取类型R的结果。
- Function接口中有一个默认的andThen方法，用来进行组合操作。

#### 2.parallelStream 并行流

