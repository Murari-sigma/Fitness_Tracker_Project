package com.project.fitness.Config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI customAPI(){
        return new OpenAPI()
                .info(new Info()
                        .title("Fitness Tracking API")
                        .version("v1.0")
                        .description("Production Grade API's")
                        .contact(new Contact()
                                .name("Murari Kumar Pandey")
                                .url("https://www.linkedin.com/in/murari-sigma7")
                                .email("pandeymurari571@gmail.com")
                        )
                        .license(new License()
                                .name("MIT License")
                                .url("https://opensource.org/licenses/MIT")));
    }
}
