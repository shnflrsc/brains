package io.shnflrsc.brains.controller;

import io.shnflrsc.brains.dto.PageResponse;
import io.shnflrsc.brains.dto.PlantSummary;
import io.shnflrsc.brains.dto.ZombieFilter;
import io.shnflrsc.brains.dto.ZombieResponse;
import io.shnflrsc.brains.exception.GlobalExceptionHandler;
import io.shnflrsc.brains.exception.ResourceNotFoundException;
import io.shnflrsc.brains.model.Speed;
import io.shnflrsc.brains.model.Stat;
import io.shnflrsc.brains.service.ZombieService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.WebMvcTest;
import org.springframework.context.annotation.Import;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.hamcrest.Matchers.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = ZombieController.class)
@Import(GlobalExceptionHandler.class)
class ZombieControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private ZombieService zombieService;

    @Test
    void listZombies_ReturnsPaginatedResponse() throws Exception {
        ZombieResponse zombie = ZombieResponse.builder()
                .id(2L)
                .name("Zombie")
                .description("Regular Garden-variety Zombie")
                .history("Loves brains")
                .toughness(Stat.LOW)
                .speed(Speed.NORMAL)
                .build();

        PageResponse<ZombieResponse> pageResponse = PageResponse.<ZombieResponse>builder()
                .data(List.of(zombie))
                .page(0)
                .size(20)
                .totalElements(1)
                .totalPages(1)
                .first(true)
                .last(true)
                .build();

        when(zombieService.getZombies(any(ZombieFilter.class), any(Pageable.class)))
                .thenReturn(pageResponse);

        mockMvc.perform(get("/api/v1/zombies")
                        .param("name", "Zombie")
                        .param("speed", "NORMAL")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.data", hasSize(1)))
                .andExpect(jsonPath("$.data[0].id", is(2)))
                .andExpect(jsonPath("$.data[0].name", is("Zombie")))
                .andExpect(jsonPath("$.page", is(0)))
                .andExpect(jsonPath("$.totalElements", is(1)));
    }

    @Test
    void getZombie_ById_ReturnsZombieWithWeaknesses() throws Exception {
        ZombieResponse buckethead = ZombieResponse.builder()
                .id(5L)
                .name("Buckethead Zombie")
                .description("His bucket makes him extremely tough")
                .history("Bucket history")
                .toughness(Stat.HIGH)
                .speed(Speed.NORMAL)
                .weaknesses(List.of(PlantSummary.builder().id(30L).name("Magnet-shroom").build()))
                .build();

        when(zombieService.getZombieByIdentifier("5")).thenReturn(buckethead);

        mockMvc.perform(get("/api/v1/zombies/5")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(5)))
                .andExpect(jsonPath("$.name", is("Buckethead Zombie")))
                .andExpect(jsonPath("$.weaknesses", hasSize(1)))
                .andExpect(jsonPath("$.weaknesses[0].id", is(30)))
                .andExpect(jsonPath("$.weaknesses[0].name", is("Magnet-shroom")));
    }

    @Test
    void getZombie_BySlug_ReturnsZombie() throws Exception {
        ZombieResponse zombie = ZombieResponse.builder()
                .id(2L)
                .name("Zombie")
                .build();

        when(zombieService.getZombieByIdentifier("zombie")).thenReturn(zombie);

        mockMvc.perform(get("/api/v1/zombies/zombie")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(2)))
                .andExpect(jsonPath("$.name", is("Zombie")));
    }

    @Test
    void getZombie_NotFound_ReturnsProblemDetail() throws Exception {
        when(zombieService.getZombieByIdentifier("unknown-zombie"))
                .thenThrow(new ResourceNotFoundException("Zombie", "unknown-zombie"));

        mockMvc.perform(get("/api/v1/zombies/unknown-zombie")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isNotFound())
                .andExpect(header().string("Content-Type", containsString("application/problem+json")))
                .andExpect(jsonPath("$.status", is(404)))
                .andExpect(jsonPath("$.title", is("Resource Not Found")))
                .andExpect(jsonPath("$.detail", containsString("Zombie not found with identifier: 'unknown-zombie'")));
    }
}
