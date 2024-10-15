## 开放api接口授权文档

## 接口请求说明

### 1.接口地址

| 名称         | URL                               |
| ------------ | --------------------------------- |
| 测试接口地址 | http://localhost:8081/jeecg-boot/ |

### 2.关于秘钥

| 参数        | 描述                     |
| ----------- | ------------------------ |
| `secretId`  | 标识发起 API 请求的用户  |
| `secretKey` | 用于对请求进行加密或签名 |

### 3.秘钥获取: 

`secretId`:AKIDz8krbAJ5ykBZQpn74WFkmLPx7gnPhESA

`secretKey`:Gu6t8xGARNpq86cd98joQYCN3Cozk1qA

### 4.请求说明:

在所有Http请求中，秘钥的传递都是通过Header 

| 参数名称    | 传递位置 | 参数类型 | 是否必传 | 描述                                                         |
| ----------- | -------- | -------- | -------- | ------------------------------------------------------------ |
| `secretId`  | `header` | `String` | 是       | 标识发起 API 请求的用户                                      |
| `timestamp` | `header` | `String` | 是       | 实时生成的时间戳。生成的时间戳要小于2分钟，否则超时          |
| `signature` | `header` | `String` | 是       | 生成的签名，用于验证请求的合法性。生成签名参考:鉴权认证>生成签名`signature` |

请求示例:

```shell
url 'http://localhost:8081/jeecg-boot/app/api/wpDataAccess/saveWarning'
header 'secretId: AKIDz8krbAJ5ykBZQpn74WFkmLPx7gnPhESA'
header 'timestamp: 1728869696999'
header 'signature: 9bc48959f7f38015eea84cafbd3d9661756c5f826c7103e0041930af95f1ea37'
```

### 5.生成签名`signature`

#### 1.关于`signature`加密流程

- **构建字符串：**将每个键值对按照 `key=value` 的形式拼接起来，并用 `&` 符号连接它们。
- **初始化 HMAC-SHA256 算法：**使用 HMAC（带密钥的哈希算法）来生成签名。这里使用的是 `HmacSHA256` 算法。
- **生成HMAC密钥：**将传入的 `secretKey`密钥连接在一起作为 HMAC 的密钥。这种方式确保了签名的唯一性，因为即使相同的参数，但不同的时间戳会生成不同的签名。
- **生成签名：**使用之前构建的查询字符串进行哈希计算，生成 HMAC-SHA256 签名。
- **转换为十六进制字符串：**HMAC 生成的哈希值是字节数组，将这个数组中的每个字节转换为两位的十六进制字符，以便于使用或传输。

```java
// 测试时间戳:2024-10-14 9:34:56
private static String timestamp = "1728869696999";
// 秘钥id
private static String secretId = "AKIDz8krbAJ5ykBZQpn74WFkmLPx7gnPhESA";
// 秘钥key
private static String secretKey = "Gu6t8xGARNpq86cd98joQYCN3Cozk1qA";

/**
 * 生成签名
 *
 * @param secretId  秘钥id
 * @param timestamp 时间戳
 * @param secretKey 秘钥key
 * @return 签名字符串
 */
public static String generateSignature(String secretId, String timestamp, String secretKey) throws NoSuchAlgorithmException, InvalidKeyException {

    // 拼接结果:secretId=AKIDz8krbAJ5ykBZQpn74WFkmLPx7gnPhESA&timestamp=1728869696999
    String queryStr = String.format("secretId=%s&timestamp=%s", secretId, timestamp);

    // 初始化 HMAC-SHA256 算法，用于生成签名
    Mac sha256HMAC = Mac.getInstance("HmacSHA256");
    // 将secretKey作为 HMAC 的密钥
    SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
    sha256HMAC.init(secretKeySpec);

    // 使用查询字符串生成 HMAC 签名
    byte[] hash = sha256HMAC.doFinal(queryStr.getBytes(StandardCharsets.UTF_8));
    // 将生成的字节数组转换为十六进制字符串
    StringBuilder sb = new StringBuilder();
    for (byte h : hash) {
        // %02x 保证每个字节都用两位十六进制表示
        sb.append(String.format("%02x", h));
    }
    return sb.toString();
}

/**
 * 执行结果
 */
public static void main(String[] args) throws NoSuchAlgorithmException, InvalidKeyException {
    // 生成签名
    String signature = generateSignature(secretId, timestamp, secretKey);

    // 结果
    System.out.println("secretId:" + secretId);
    System.out.println("timestamp:" + timestamp);
    System.out.println("secretKey:" + secretKey);
    System.out.println("生成的签名:" + signature);
}
```

#### 2.关于生成结果示例

```plain
secretId:AKIDz8krbAJ5ykBZQpn74WFkmLPx7gnPhESA
timestamp:1728869696999
secretKey:Gu6t8xGARNpq86cd98joQYCN3Cozk1qA
生成的签名:9bc48959f7f38015eea84cafbd3d9661756c5f826c7103e0041930af95f1ea37
```

### 6.返回说明

#### 1.返回示例

```json
{
    "success": true,
    "message": "",
    "code": 200,
    "result": null,
    "timestamp": 1728885842231
}
{
    "success": false,
    "message": "'secretId' headers is empty!",
    "code": 3000,
    "result": null,
    "timestamp": 1728885535560
}
```

#### 2.返回参数描述

| 字段参数名称 | 参数类型 | 描述                              |
| ------------ | -------- | --------------------------------- |
| success      | Boolean  | true: 正确的请求，false: 请求失败 |
| message      | String   | 请求失败描述                      |
| code         | Int      | 返回码参考: code返回码描述        |
| timestamp    | Long     | 响应时间戳                        |

#### 3.code返回码描述

| 返回码 | 描述               |
| ------ | ------------------ |
| 3000   | header参数没有传齐 |
| 3001   | secretId不存在     |
| 3002   | timestamp超时      |
| 3003   | signature验证失败  |
| 500    | 系统异常           |
| 200    | 请求成功           |



## 数据接入接口

### 1.天气预警保存接口

**URL**：`/app/api/wpDataAccess/saveWarning`

**Method**：POST

**Content-Type**: application/json

#### 请求参数

| 参数名称     | 字段              | 类型   | 必填 | 参数描述                                                     |
| ------------ | ----------------- | ------ | ---- | ------------------------------------------------------------ |
| 预警名称     | name              | String | 是   | 预警名称                                                     |
| 预警编码     | code              | String | 是   | 预警编码                                                     |
| 预警类型     | type              | String | 是   | 如：大风、大雾、雷电、                                       |
| 预警等级     | level             | String | 是   | 如：橙色、黄色、红色                                         |
| 发布时间     | releaseTime       | Date   | 是   | yyyy-MM-dd HH:mm:ss                                          |
| 预计开始时间 | estimateStartTime | Date   | 是   | yyyy-MM-dd HH:mm:ss                                          |
| 预计结束时间 | estimateEndTime   | Date   | 是   | yyyy-MM-dd HH:mm:ss                                          |
| 预警图标     | icon              | String | 是   | 图片的base64字符串                                           |
| 预警标题     | title             | String | 是   | 如: 崂山区气象台发布大雾橙色预警...                          |
| 预警内容     | content           | String | 是   | 如：崂山区气象台2023年04月19日14时20分发布大雾橙色预警。。。。。 |
| 发布状态     | sendStatus        | String | 是   | 如：发布、解除                                               |

