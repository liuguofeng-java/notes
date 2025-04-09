## nginx配置文件

##### 1.root 和 alias 区别

> `root` 定义了资源的根目录，Nginx 会将 URL 中匹配的路径拼接到 `root` 指定的目录后，用于定位文件。
>
> `alias` 用于替换匹配的路径，与 `root` 不同，`alias` 不会拼接 `location` 中的路径，而是直接替换整个路径。

1. **root **如下配置, 当用户访问 `/static/images/logo.png` 时，Nginx 会尝试读取文件路径:`/var/www/html/static/images/logo.png`

   ```nginx
   location /static/ {
   	root /var/www/html;
   }
   ```

2. **alias**如下配置,当用户访问 `/static/images/logo.png` 时，Nginx 会尝试读取文件路径：`/var/www/html/assets/images/logo.png`

   ```nginx
   location /static/ {
   	alias /var/www/html/assets/;
   }
   ```

3. **alias**错误配置

   > 1.alias配置不能加~表达式
   >
   > 2.使用 `alias` 时忘记加 `/`,会导致403

   ```nginx
   location ~/static/ {
   	alias /var/www/html/assets;
   }
   ```

4. 总结

   - `root` 会将匹配的 `location` 路径保留并拼接到指定的根目录路径后。
   - `alias` 用于替换匹配的路径，与 `root` 不同，`alias` 不会拼接 `location` 中的路径，而是直接替换整个路径。