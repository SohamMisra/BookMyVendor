package Final.Year.Project.bmv.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
                .allowedOriginPatterns(   // ← change allowedOrigins to allowedOriginPatterns
                        "https://bookmyvendor.vercel.app",
                        "http://localhost:3000",
                        "https://bmvindia.online",
                        "http://bmvindia.online"
                )
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH")
                .allowedHeaders(          // ← list headers explicitly instead of "*"
                        "Authorization",
                        "Content-Type",
                        "Accept",
                        "Origin",
                        "X-Requested-With"
                )
                .allowCredentials(true);
    }
}

