package org.javaclub.reverse;

import lombok.extern.slf4j.Slf4j;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.function.Function;

@SpringBootApplication
@Slf4j
public class ReverseApplication {

    @Bean
    Function<String, String> reverse() {
        return input -> {
            log.info("Reverse input {}", input);
            return new StringBuilder(input).reverse().toString();
        };
    }

    public static void main(String[] args) {
        SpringApplication.run(ReverseApplication.class, args);
    }

}

