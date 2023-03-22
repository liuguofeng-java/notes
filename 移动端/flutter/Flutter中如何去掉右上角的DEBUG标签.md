## Flutter中如何去掉右上角的DEBU
```java
void main() {
  runApp(Zodoscope());
}
 
class Zodoscope extends StatefulWidget {
  @override
  _ZodoscopeState createState() => _ZodoscopeState();
}
 
class _ZodoscopeState extends State<Zodoscope> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: MainMenu(),
      debugShowCheckedModeBanner: false,//去掉右上角DEBUG标签
    );
  }
}
```



