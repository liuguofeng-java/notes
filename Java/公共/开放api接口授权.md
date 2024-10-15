## 开放api接口授权

##### 1.签名验证和生成

```java
/**
 * 签名验证和生成
 *
 * @author liuguofeng
 * @date 2024/10/12 17:39
 **/
public class SignatureUtil {

    /**
     * 验证签名是否合法
     *
     * @param secretId  secretId
     * @param timestamp 时间戳
     * @param secretKey secretKey
     * @param signature 签名
     * @return 结果
     * @throws Exception 错误信息
     */
    public static boolean validate(String secretId, String timestamp, String secretKey, String signature) throws Exception {
        // 获取请求中的所有参数
        Map<String, String> params = new HashMap<>();

        // 还原传递的参数
        params.put("secretId", secretId);
        params.put("timestamp", timestamp);

        // 生成新的签名
        String computedSignature = generateSignature(secretId, timestamp, secretKey);

        // 对比传入的签名和生成的签名
        return signature.equals(computedSignature);
    }


    // 测试时间戳:2024-10-14 9:34:56
    private static String timestamp = "1728869696999";
    private static String secretId = "AKIDz8krbAJ5ykBZQpn74WFkmLPx7gnPhESA";
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
}
```

##### 2.切面类

```java
/**
 * 开放接口授权切面
 *
 * @author liuguofeng
 * @date 2024/10/14 10:45
 **/
@Component
@Aspect
@Log4j2
@ConfigurationProperties(prefix = "oauth")
public class OAuthAspect {

    // 假设从配置文件或数据库中获取密钥
    private Map<String, String> secretKeyStore = new HashMap<String, String>() {{
        put("AKIDz8krbAJ5ykBZQpn74WFkmLPx7gnPhESA", "Gu6t8xGARNpq86cd98joQYCN3Cozk1qA");
    }};

    @Autowired
    private HttpServletRequest request;

    @Pointcut("@annotation(org.jeecg.common.aspect.annotation.OAuth)")
    public void oAuthPointcut() {
    }


    @Before("oAuthPointcut()")
    public void before() {
        String secretId = request.getHeader("secretId");
        String timestamp = request.getHeader("timestamp");
        String signature = request.getHeader("signature");

        if (secretId == null) {
            throw new JeecgBootException(3000, "'secretId' headers is empty!");
        }
        if (timestamp == null) {
            throw new JeecgBootException(3000, "'timestamp' headers is empty!");
        }
        if (signature == null) {
            throw new JeecgBootException(3000, "'signature' headers is empty!");
        }


        // 检查 secretId 是否存在
        String secretKey = secretKeyStore.get(secretId);
        if (secretKey == null) {
            throw new JeecgBootException(3001, "Invalid secretId");
        }

        // 验证请求是否过期 (如超过5分钟，按需求调整)
        long requestTime = Long.parseLong(timestamp);
        if (System.currentTimeMillis() - requestTime > 5 * 60 * 1000) {
            throw new JeecgBootException(3002, "Request is expired");
        }

        // 验证签名
        try {
            if (!SignatureUtil.validate(secretId, timestamp, secretKey, signature)) {
                throw new JeecgBootException(3003, "Invalid signature");
            }
        } catch (Exception e) {
            log.error("验证签名报错了:" + e.getMessage());
            e.printStackTrace();
            throw new JeecgBootException(3003, "Error during signature validation");
        }
    }
}
```

##### 3.开放接口授权注解类

```java
/**
 * 开放接口授权
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE,ElementType.METHOD})
@Documented
public @interface OAuth {

}
```

