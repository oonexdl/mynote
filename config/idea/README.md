### 设置

- 安装 [IntelliJ IDEA Community](https://www.jetbrains.com/idea/download/) 。
- 安装插件：Lombok Plugin 、Alibaba Java Coding Guidelines 、Bash Support 、 Markdown Support 。
- 做如下设置：
    - Editor > General > Auto Import > 开启 “Add unambiguous imports on the fly” 和 “Optimize imports on the fly(for current project)”，如此会自动维护 imports 。
    - Build, Execution, Deployment > Build Tools
        - Maven > Importing > “Automatically download” 全开启，如此会自动下载 maven 依赖的源码和文档。
        - Compiler > 开启 “Build project automatically”，如此保存文件时会自动编译，进而自动重启项目，如果觉得重启太频繁，可以不开，需要重启的时候构建项目即可。
    - Keymap > 设置 Reformat Code 快捷键为你的保存快捷键（ctrl + s），如此保存时会自动 format 。
