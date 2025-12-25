## linux使用Brotli压缩wasm

##### 安装

- **Linux**：通过包管理器安装（如 `sudo apt install brotli` 或 `sudo yum install brotli`）

##### 使用命令：

```sh
# 压缩 WASM 文件（默认生成 .br 后缀的压缩文件）
brotli -q 11 input.wasm

# 指定输出文件名
brotli -q 11 input.wasm -o output.wasm.br

# 查看压缩信息（需结合其他工具，如 ls 或 du）
du -h input.wasm output.wasm.br  # 对比大小
```

##### 先优化 WASM 再压缩（推荐）

WASM 文件本身可能包含冗余信息，可先用专用工具优化体积，再进行 Brotli 压缩，效果更好。常用工具是 **`wasm-opt`**（来自 [Binaryen](https://github.com/WebAssembly/binaryen) 工具集）。