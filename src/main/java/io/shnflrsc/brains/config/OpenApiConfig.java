package io.shnflrsc.brains.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI almanacOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Brains API")
                        .description("Public REST API providing PvZ1 plants and zombies almanac entries.")
                        .version("v1.0.0")
                        .contact(new Contact()
                                .name("Darl Shanen Floresca")));
    }
}
