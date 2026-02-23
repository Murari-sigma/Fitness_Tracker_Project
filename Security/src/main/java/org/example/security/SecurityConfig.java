package org.example.security;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.sql.DataSource;

import static org.springframework.security.authorization.AuthorityReactiveAuthorizationManager.hasRole;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    @Autowired
    DataSource dataSource;

    @Autowired
    JwtAuthFilter authFilter;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http.csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authorizeRequests ->
                        authorizeRequests
                                .requestMatchers("/admin/**").hasRole("ADMIN")
                                .requestMatchers("/user/**").hasAnyRole("USER", "ADMIN")
                                .requestMatchers("/signin").permitAll()
                                .requestMatchers("/").permitAll()       
                                .anyRequest().authenticated()
                );


        http.addFilterBefore(authFilter,
                UsernamePasswordAuthenticationFilter.class);


        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        UserDetails user1 = User.withUsername("user1")
//                .password("{noop}password1")
                .password(passwordEncoder().encode("password1"))
                .roles("USER")  // ROLE_USER
                .build();

        UserDetails user2 = User.withUsername("user2")
//                .password("{noop}password2")
                .password(passwordEncoder().encode("password2"))
                .roles("USER")  // ROLE_USER
                .build();

        UserDetails admin = User.withUsername("admin")
//                .password("{noop}adminPassword")
                .password(passwordEncoder().encode("adminPassword"))
                .roles("ADMIN")   // ROLE_USER
                .build();

//        return new InMemoryUserDetailsManager(user1, user2, admin);

        JdbcUserDetailsManager userDetailsManager =
                new JdbcUserDetailsManager(dataSource);

        if (!userDetailsManager.userExists("user1")) {
            userDetailsManager.createUser(user1);
        }
        if (!userDetailsManager.userExists("user2")) {
            userDetailsManager.createUser(user2);
        }
        if (!userDetailsManager.userExists("admin")) {
            userDetailsManager.createUser(admin);
        }

        return userDetailsManager;

    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }


    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration builder) throws Exception {
        return builder.getAuthenticationManager();
    }
}
