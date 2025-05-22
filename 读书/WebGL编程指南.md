## WebGL编程指南

> WebGL 是一项在网页上渲染三维图形的技术，本书详细讲述了如何编写顶点着色器和片元着色器,如何实现该机的渲染技术,如逐顶点光照、阴影、基本的交互操作(如选中三维物体)等。

#### 1.使用着色器绘制一个点

1. 什么是着色器

   > 要使用WebGL进行绘图就必须使用着色器。在代码中,着色器程序是以字符串的形式“嵌入”在JavaScript文件中的,在程序真正开始运行前它就已经设置好了

   - 顶点着色器(Vertex shader) :处理每个顶点的位置、法线、纹理坐标等属性，通常用于实现**几何变换**（如平移、旋转、投影）

   - 片元着色器（Fragment Shader）:- 计算每个片元（Fragment，可理解为像素）的颜色值，通常用于实现 '像素级渲染效果'。

2. 绘制一个点

   ```js
   // 顶点着色器
   const VSHADER_SOURCE = `
     void main(){
       gl_Position = vec4(0, 0.0, 0.0, 1.0); // 设置点的位置
       gl_PointSize = 10.0; // 设置点的大小
     }
   `
   // 片元着色器
   const FSHADER_SOURCE = `
     void main(){
       gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0); // 设置点的颜色
     }
   `
   const canvas = document.getElementById('canvas')
   const gl = getWebGLContext(canvas)
   // 初始化着色器
   if (!initShaders(gl, VSHADER_SOURCE, FSHADER_SOURCE)) {
     console.log('Failed to initialize shaders.');
   }
   gl.clearColor(0, 0, 0, 1)
   gl.clear(gl.COLOR_BUFFER_BIT);
   gl.drawArrays(gl.POINTS, 0, 1)
   ```

   | 类型  | 和变量名     | 描述                             |
   | :---: | ------------ | -------------------------------- |
   | vec4  | gl_Position  | 内置变量，表示顶点位置           |
   | float | gl_PointSize | 内置变量，表示点的尺寸（像素数） |
   | vec4  | gl_FragColor | 内置变量，表示颜色               |

   

#### 2.着色器变量

1. attribute和uniform

   > `attribute`:传递**每个顶点独享**的数据（如顶点位置、颜色、法线）。且只能用于**顶点着色器**
   > `uniform` :变量 :传递**所有顶点 / 片元共享**的数据（如变换矩阵、光照参数、时间）,可以用于**顶点着色器**和**片元着色器** 

2. 使用attribute变量改变位置和大小

   ```js
   const VSHADER_SOURCE = `
     attribute vec4 a_Position; // 顶点位置
     attribute float a_PointSize; // 点大小
     void main(){
       gl_Position = a_Position; // 设置点的位置
       gl_PointSize = a_PointSize; // 设置点的大小
     }
   `
   const FSHADER_SOURCE = `
     precision mediump float; // 精度设置(无法理解，文中并没有详细解释)
     uniform vec4 u_FragColor; // 片元颜色
     void main(){
       gl_FragColor = u_FragColor; // 设置片元颜色
     }
   `
   
   const canvas = document.getElementById('canvas')
   const gl = getWebGLContext(canvas)
   
   // 初始化着色器
   if (!initShaders(gl, VSHADER_SOURCE, FSHADER_SOURCE)) {
     console.log('Failed to initialize shaders.');
   }
   
   // 通过 gl.getAttribLocation() 获取变量的存储位置
   const a_Position = gl.getAttribLocation(gl.program, 'a_Position')
   // 通过 gl.vertexAttrib3f() 设置变量的值
   gl.vertexAttrib3f(a_Position, 0.5, 0.0, 0.0)
   
   const a_PointSize = gl.getAttribLocation(gl.program, 'a_PointSize')
   gl.vertexAttrib1f(a_PointSize, 90.0)
   
   // 通过 gl.getUniformLocation() 获取变量的存储位置
   const u_FragColor = gl.getUniformLocation(gl.program, 'u_FragColor')
   gl.uniform4f(u_FragColor, 0.0, 1.0, 0.0, 1.0)
   
   
   gl.clearColor(0, 0, 0, 1)
   gl.clear(gl.COLOR_BUFFER_BIT);
   gl.drawArrays(gl.POINTS, 0, 1)
   ```
   

#### 3.如何绘制一个三角形、平移、旋转

1. 绘制多个点

   ```js
   function initVertexBuffers(gl) {
     const vertices = new Float32Array([
       0.0, 0.5,
       -0.5, -0.5,
       0.5, -0.5
     ])
     const n = 3
   
     // 创建缓冲区对象
     const vertexBuffer = gl.createBuffer()
     if (!vertexBuffer) {
       console.log('Failed to create the buffer object');
       return -1
     }
   
     // 将缓冲区对象绑定到目标
     gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer)
   
     // 向缓冲区对象分配数据
     gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW)
   
     // 获取变量的存储位置
     const a_Position = gl.getAttribLocation(gl.program, 'a_Position')
     if (a_Position < 0) {
       console.log('Failed to get the storage location of a_Position');
       return -1
     }
   
     // 将缓冲区对象分配给变量
     gl.vertexAttribPointer(a_Position, 2, gl.FLOAT, false, 0, 0)
   
     // 开启变量
     gl.enableVertexAttribArray(a_Position)
   
     return n
   }
   
   const VSHADER_SOURCE = `
     attribute vec4 a_Position;
     void main(){
       gl_Position = a_Position;
       gl_PointSize = 100.0;
     }
   `
   const FSHADER_SOURCE = `
     void main() {
       gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
     }
   `
   
   const canvas = document.getElementById('canvas')
   const gl = getWebGLContext(canvas)
   
   // 初始化着色器
   if (!initShaders(gl, VSHADER_SOURCE, FSHADER_SOURCE)) {
     console.log('Failed to initialize shaders.');
   }
   
   const n = initVertexBuffers(gl)
   console.log('--->n', n);
   if (n < 0) {
     console.log('Failed to set the positions of the vertices');
   }
   
   gl.clearColor(0, 0, 0, 1)
   gl.clear(gl.COLOR_BUFFER_BIT);
   // 这里的1换成了n ，POINTS:绘制点、TRIANGLES:绘制面
   gl.drawArrays(gl.TRIANGLES, 0, n)
   
   ```

2. 平移三角形

   > 原理其实就是通过着色器变量**u_Translation**和位置**a_Position**相加

   ```js
    function initVertexBuffers(gl) {
     const vertices = new Float32Array([
       0.0, 0.5,
       -0.5, -0.5,
       0.5, -0.5
     ])
     const n = 4
   
     // 创建缓冲区对象
     const vertexBuffer = gl.createBuffer()
     if (!vertexBuffer) {
       console.log('Failed to create the buffer object');
       return -1
     }
   
     // 将缓冲区对象绑定到目标
     gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer)
   
     // 向缓冲区对象分配数据
     gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW)
   
     // 获取变量的存储位置
     const a_Position = gl.getAttribLocation(gl.program, 'a_Position')
     if (a_Position < 0) {
       console.log('Failed to get the storage location of a_Position');
       return -1
     }
   
     // 将缓冲区对象分配给变量
     gl.vertexAttribPointer(a_Position, 2, gl.FLOAT, false, 0, 0)
   
     // 开启变量
     gl.enableVertexAttribArray(a_Position)
   
     return n
   }
   
   const VSHADER_SOURCE = `
     attribute vec4 a_Position;
     uniform vec4 u_Translation;
     void main(){
       gl_Position = a_Position + u_Translation;
       gl_PointSize = 10.0;
     }
   `
   const FSHADER_SOURCE = `
     void main() {
       gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
     }
   `
   const canvas = document.getElementById('canvas')
   const gl = getWebGLContext(canvas)
   
   // 初始化着色器
   if (!initShaders(gl, VSHADER_SOURCE, FSHADER_SOURCE)) {
     console.log('Failed to initialize shaders.');
   }
   
   const n = initVertexBuffers(gl)
   console.log('--->n', n);
   if (n < 0) {
     console.log('Failed to set the positions of the vertices');
   }
   
   // 通过 gl.getUniformLocation() 获取变量的存储位置
   const u_Translation = gl.getUniformLocation(gl.program, 'u_Translation')
   gl.uniform4f(u_Translation, -0.5, -0.5, 0.0, 0.0)
   
   gl.clearColor(0, 0, 0, 1)
   gl.clear(gl.COLOR_BUFFER_BIT);
   
   gl.drawArrays(gl.TRIANGLE_FAN, 0, n)
   ```

3. 旋转三角形

   > 旋转要考虑：
   >
   > 1. 旋转轴(图形将围绕旋转轴旋转)。
   >
   > 2. 旋转方向(方向:顺时针或逆时针)。
   >
   > 3. 旋转角度(图形旋转经过的角度)。

   ```js
   ```

   
