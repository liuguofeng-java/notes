## Java发邮件

#### 1. 加jar包

```csharp
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-email</artifactId>
    <version>1.4</version>
</dependency>
```

#### 2.util类

```csharp
// 发件人 账号和密码
public static final String MY_EMAIL_ACCOUNT = "liuguofenglbf@163.com";
public static final String MY_EMAIL_PASSWORD = "lbf19980808";// 密码,是你自己的设置的授权码

// SMTP服务器(这里用的163 SMTP服务器)
public static final String MEAIL_163_SMTP_HOST = "smtp.163.com";
public static final String SMTP_163_PORT = "25";// 端口号,这个是163使用到的;QQ的应该是465或者875

// 收件人
public static final String RECEIVE_EMAIL_ACCOUNT = "1396198931@qq.com";

public static void emailUtil(){
    try{
        Properties p = new Properties();
        p.setProperty("mail.smtp.host", MEAIL_163_SMTP_HOST);
        p.setProperty("mail.smtp.port", SMTP_163_PORT);
        p.setProperty("mail.smtp.socketFactory.port", SMTP_163_PORT);
        p.setProperty("mail.smtp.auth", "true");
        p.setProperty("mail.smtp.socketFactory.class", "SSL_FACTORY");

        Session session = Session.getInstance(p, new Authenticator() {
            // 设置认证账户信息
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(MY_EMAIL_ACCOUNT, MY_EMAIL_PASSWORD);
            }
        });
        session.setDebug(true);
        System.out.println("创建邮件");
        MimeMessage message = new MimeMessage(session);
        // 发件人
        message.setFrom(new InternetAddress(MY_EMAIL_ACCOUNT));
        // 收件人和抄送人
        message.setRecipients(Message.RecipientType.TO, RECEIVE_EMAIL_ACCOUNT);
        message.setRecipients(Message.RecipientType.CC, MY_EMAIL_ACCOUNT);

        // 内容(这个内容还不能乱写,有可能会被SMTP拒绝掉;多试几次吧)
        message.setSubject("验证码");
        message.setContent("<h1>您好;10</h1>", "text/html;charset=UTF-8");
        message.setSentDate(new Date());
        message.saveChanges();
        System.out.println("准备发送");
        Transport.send(message);
    }catch (Exception e){
        System.out.println(e.getMessage());
    }
}
 
```

