package org.javaclub.uppercasefunction;

import lombok.extern.slf4j.Slf4j;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.function.Function;

@SpringBootApplication
@Slf4j
public class UppercaseFunctionApplication {

    @Bean
    public Function<String, String> uppercase() {
        return input -> {
            log.info("reverse input {}", input);
            return new StringBuilder(input.toUpperCase()).reverse().toString();
        };
    }

    public static void main(String[] args) {
        SpringApplication.run(UppercaseFunctionApplication.class, args);
    }

}

