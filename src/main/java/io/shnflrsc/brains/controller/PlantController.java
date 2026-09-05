package io.shnflrsc.brains.controller;

import io.shnflrsc.brains.dto.PageResponse;
import io.shnflrsc.brains.dto.PlantFilter;
import io.shnflrsc.brains.dto.PlantResponse;
import io.shnflrsc.brains.service.PlantService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ProblemDetail;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/plants")
@RequiredArgsConstructor
@Tag(name = "Plants", description = "Endpoints for exploring plant almanac entries")
public class PlantController {

    private final PlantService plantService;

    @GetMapping
    @Operation(summary = "List plants", description = "Retrieve a paginated list of plants with optional filtering and sorting.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved plant list")
    })
    public ResponseEntity<PageResponse<PlantResponse>> listPlants(
            @ParameterObject PlantFilter filter,
            @ParameterObject @PageableDefault(size = 20) Pageable pageable
    ) {
        return ResponseEntity.ok(plantService.getPlants(filter, pageable));
    }

    @GetMapping("/{identifier}")
    @Operation(summary = "Get plant by ID or slug", description = "Retrieve a single plant by its numeric ID (e.g. 1) or normalized name/slug (e.g. 'peashooter', 'gatling-pea').")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Plant found"),
            @ApiResponse(responseCode = "404", description = "Plant not found",
                    content = @Content(schema = @Schema(implementation = ProblemDetail.class)))
    })
    public ResponseEntity<PlantResponse> getPlant(
            @Parameter(description = "Numeric entry ID or plant name/slug", example = "peashooter")
            @PathVariable("identifier") String identifier
    ) {
        return ResponseEntity.ok(plantService.getPlantByIdentifier(identifier));
    }
}
