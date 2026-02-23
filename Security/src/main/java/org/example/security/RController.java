package org.example.security;

//import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;


@RestController
public class RController {
//    @PreAuthorize("hasRole('ADMIN')")


    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    JwtUtils jwtUtils;


//    @PreAuthorize("hasAnyRole('ADMIN','USER')")

    @GetMapping("/hello")
        public String sayhello() {
            return "Hello";
        }

    @GetMapping("/admin/hello")
    public String sayAdminhello() {
        return "Hello, Admin";
    }

    @GetMapping("/user/hello")
    public String sayUserhello() {
        return "Hello, User";
    }

    @PostMapping("/signin")
    public String login(@RequestBody LoginRequest loginRequest) {
        Authentication authentication;

        try {
            authentication = authenticationManager.authenticate(
                 new UsernamePasswordAuthenticationToken(
                         loginRequest.getUsername(),
                         loginRequest.getPassword()
                 )
            );
        } catch (AuthenticationException e) {
            e.printStackTrace();
            return "Could not authenticate";
        }

        SecurityContextHolder.getContext().setAuthentication(authentication);
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String jwtToken = jwtUtils.generateToken(userDetails);
        return jwtToken;
    }
}
