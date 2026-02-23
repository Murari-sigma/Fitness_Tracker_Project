package com.project.fitness.security;

import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;



@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtils jwtUtils;


    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {
        System.out.println("JwtAuthFilter Called");

        try {
            String header = request.getHeader("Authorization");

            System.out.println("Header Length: " + (header != null ? header.length() : "null"));
            System.out.println("Header Raw Value: [" + header + "]");

            String jwt = jwtUtils.getJwtFromHeader(request);

            System.out.println("Extracted JWT: " + jwt);




            if (jwt != null && jwtUtils.validateJwtToken(jwt)) {
                System.out.println("TOKEN HERE:"+ jwt);
                String userId = jwtUtils.getUserIdFromToken(jwt);


                Claims claims = jwtUtils.getAllClaims(jwt);
                List<String> roles = claims.get("roles", List.class);
                System.out.println("ROLES: " + roles);
                List<GrantedAuthority> authorities = List.of();
                if(roles != null) {
                    authorities = roles
                            .stream()
                            .map(role -> (GrantedAuthority) new SimpleGrantedAuthority("ROLE_"+ role))
                            .toList();
                }


                UsernamePasswordAuthenticationToken authentication =
                        new UsernamePasswordAuthenticationToken(
                                userId,
                                null,
                                authorities
                        );

                authentication.setDetails(
                        new WebAuthenticationDetailsSource().buildDetails(request));

                SecurityContextHolder.getContext().setAuthentication(authentication);
                System.out.println("AUTHSET: "+ SecurityContextHolder.getContext().getAuthentication());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        filterChain.doFilter(request, response);

    }

    private String parseJwt(HttpServletRequest request){
        String jwt = jwtUtils.getJwtFromHeader(request);

        return jwt;
    }
}














//        String header = request.getHeader("Authorization");
//
//        if (header != null && header.startsWith("Bearer ")) {
//
//            String token = header.substring(7);
//
//            try {
//                Jws<Claims> jwsClaims = Jwts.parser()
//                        .verifyWith(jwtUtils.getKey())
//                        .build()
//                        .parseSignedClaims(token);
//
//                Claims claims = jwsClaims.getPayload();
//
//                String username = claims.getSubject();
//
//                List<String> roles = claims.get("roles", List.class);
//                if (roles == null) {
//                    roles = Collections.emptyList();
//                }
//
//                List<SimpleGrantedAuthority> authorities =
//                        roles.stream()
//                                .map(SimpleGrantedAuthority::new)
//                                .collect(Collectors.toList());
//
//                UsernamePasswordAuthenticationToken authentication =
//                        new UsernamePasswordAuthenticationToken(username, null, authorities);
//
//                SecurityContextHolder.getContext().setAuthentication(authentication);
//
//
//            } catch (Exception e) {
//                System.out.println("Invalid JWT Token: " + e.getMessage());
//            }
//        }
//
//        filterChain.doFilter(request, response);
//    }
//}


