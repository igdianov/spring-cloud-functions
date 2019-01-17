package org.javaclub.reverse;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.function.Function;

@SpringBootApplication
public class ReverseApplication {

    @Bean
    Function<String, String> reverse() {
        return input -> new StringBuilder(input).reverse().toString();
    }

    public static void main(String[] args) {
        SpringApplication.run(ReverseApplication.class, args);
    }

}

