package com.bd.hotel.reservations.web.controller;

import com.bd.hotel.reservations.application.service.AuthService;
import com.bd.hotel.reservations.web.dto.request.LoginRequest;
import com.bd.hotel.reservations.web.dto.request.ClienteRegisterRequest;
import com.bd.hotel.reservations.web.dto.response.ClienteRegisterResponse;
import com.bd.hotel.reservations.web.dto.response.LoginResponse;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<ClienteRegisterResponse> register(
            @Valid @RequestBody ClienteRegisterRequest request
    ) {
        ClienteRegisterResponse response = authService.register(request);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(response);
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

}