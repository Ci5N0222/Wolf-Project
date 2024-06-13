package commons;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class EmailConfig {

    private static final String CONFIG_FILE = "/email.properties";
    private static Properties properties;

    static {
        loadProperties();
    }

    private static void loadProperties() {
        properties = new Properties();
        try (InputStream inputStream = EmailConfig.class.getResourceAsStream(CONFIG_FILE)) {
            properties.load(inputStream);
        } catch (IOException e) {
            throw new RuntimeException("이메일 설정 파일 로드 실패: " + e.getMessage());
        }
    }

    public static String getUsername() {
        return properties.getProperty("email.username");
    }

    public static String getPassword() {
        return properties.getProperty("email.password");
    }

    public static Properties getProperties() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.naver.com");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.ssl.enable", "true");
        return props;
    }
}
