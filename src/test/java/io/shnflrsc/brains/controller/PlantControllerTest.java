package io.shnflrsc.brains.controller;

import io.shnflrsc.brains.dto.PageResponse;
import io.shnflrsc.brains.dto.PlantFilter;
import io.shnflrsc.brains.dto.PlantResponse;
import io.shnflrsc.brains.dto.PlantSummary;
import io.shnflrsc.brains.exception.GlobalExceptionHandler;
import io.shnflrsc.brains.exception.ResourceNotFoundException;
import io.shnflrsc.brains.model.Speed;
import io.shnflrsc.brains.model.Stat;
import io.shnflrsc.brains.service.PlantService;
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
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = PlantController.class)
@Import(GlobalExceptionHandler.class)
class PlantControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private PlantService plantService;

    @Test
    void listPlants_ReturnsPaginatedResponse() throws Exception {
        PlantResponse peashooter = PlantResponse.builder()
                .id(1L)
                .name("Peashooter")
                .description("Shoots peas")
                .history("Hard work")
                .toughness(Stat.NORMAL)
                .sunCost((short) 100)
                .recharge(Speed.FAST)
                .damage(Stat.NORMAL)
                .build();

        PageResponse<PlantResponse> pageResponse = PageResponse.<PlantResponse>builder()
                .data(List.of(peashooter))
                .page(0)
                .size(20)
                .totalElements(1)
                .totalPages(1)
                .first(true)
                .last(true)
                .build();

        when(plantService.getPlants(any(PlantFilter.class), any(Pageable.class)))
                .thenReturn(pageResponse);

        mockMvc.perform(get("/api/v1/plants")
                        .param("name", "Pea")
                        .param("toughness", "NORMAL")
                        .param("page", "0")
                        .param("size", "10")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.data", hasSize(1)))
                .andExpect(jsonPath("$.data[0].id", is(1)))
                .andExpect(jsonPath("$.data[0].name", is("Peashooter")))
                .andExpect(jsonPath("$.page", is(0)))
                .andExpect(jsonPath("$.size", is(20)))
                .andExpect(jsonPath("$.totalElements", is(1)))
                .andExpect(jsonPath("$.totalPages", is(1)))
                .andExpect(jsonPath("$.first", is(true)))
                .andExpect(jsonPath("$.last", is(true)));
    }

    @Test
    void getPlant_ById_ReturnsPlantDetails() throws Exception {
        PlantResponse gatlingPea = PlantResponse.builder()
                .id(11L)
                .name("Gatling Pea")
                .description("Shoots 4 peas")
                .history("Military veteran")
                .toughness(Stat.NORMAL)
                .sunCost((short) 250)
                .recharge(Speed.VERY_SLOW)
                .prerequisite(PlantSummary.builder().id(10L).name("Repeater").build())
                .build();

        when(plantService.getPlantByIdentifier("11")).thenReturn(gatlingPea);

        mockMvc.perform(get("/api/v1/plants/11")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(11)))
                .andExpect(jsonPath("$.name", is("Gatling Pea")))
                .andExpect(jsonPath("$.sunCost", is(250)))
                .andExpect(jsonPath("$.recharge", is("VERY_SLOW")))
                .andExpect(jsonPath("$.prerequisite.id", is(10)))
                .andExpect(jsonPath("$.prerequisite.name", is("Repeater")));
    }

    @Test
    void getPlant_BySlug_ReturnsPlantDetails() throws Exception {
        PlantResponse peashooter = PlantResponse.builder()
                .id(1L)
                .name("Peashooter")
                .sunCost((short) 100)
                .build();

        when(plantService.getPlantByIdentifier("peashooter")).thenReturn(peashooter);

        mockMvc.perform(get("/api/v1/plants/peashooter")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(1)))
                .andExpect(jsonPath("$.name", is("Peashooter")));
    }

    @Test
    void getPlant_NotFound_ReturnsProblemDetail() throws Exception {
        when(plantService.getPlantByIdentifier("nonexistent"))
                .thenThrow(new ResourceNotFoundException("Plant", "nonexistent"));

        mockMvc.perform(get("/api/v1/plants/nonexistent")
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isNotFound())
                .andExpect(header().string("Content-Type", containsString("application/problem+json")))
                .andExpect(jsonPath("$.status", is(404)))
                .andExpect(jsonPath("$.title", is("Resource Not Found")))
                .andExpect(jsonPath("$.detail", containsString("Plant not found with identifier: 'nonexistent'")));
    }
}
