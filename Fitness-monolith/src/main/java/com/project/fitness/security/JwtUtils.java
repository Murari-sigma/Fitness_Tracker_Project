package com.project.fitness.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.security.Key;
import java.util.Date;
import java.util.List;

@Component
public class JwtUtils {


private static String jwtSecret = "YS1zdHJpbmctc2VjcmV0LWF0LWxlYXN0LTI1Ni1iaXRzLWxvbmc=";
private static int jwtExpirationMs = 172800000;

public static Claims getAllClaims(String jwt) {
    return Jwts.parser()
            .verifyWith((SecretKey) key())
            .build()
            .parseSignedClaims(jwt)
            .getPayload();

}

    public String getJwtFromHeader(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");

        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7).trim();

        }

        return null;
    }

  public static String generateToken(String userId, String role){
    return Jwts.builder()
            .subject(userId)
            .claim("roles", List.of(role))
                    .issuedAt(new Date())
            .expiration(new Date(new Date().getTime()+ jwtExpirationMs))
            .signWith(key())
            .compact();
  }



public String generateTokenFromUsername(UserDetails userDetails) {
    return Jwts.builder()
            .subject(userDetails.getUsername())
            .claim("roles",
                    userDetails.getAuthorities().stream()
                            .map(auth -> auth.getAuthority())
                            .toList()
            )
            .issuedAt(new Date())
            .expiration(new Date(new Date().getTime() + jwtExpirationMs))
            .signWith((SecretKey) key())
            .compact();
}



public boolean validateJwtToken(String JwtToken) {
    try {
        Jwts.parser().verifyWith((SecretKey) key()).build()
                .parseSignedClaims(JwtToken);

    } catch (Exception e) {
        e.printStackTrace();
    }
    return true;

}

public static Key key() {
    return Keys.hmacShaKeyFor(Decoders.BASE64.decode(jwtSecret));
}

public String getUserIdFromToken(String jwt) {
    return Jwts.parser()
            .verifyWith((SecretKey) key())
            .build()
            .parseSignedClaims(jwt)
            .getPayload()
            .getSubject();
}

}
