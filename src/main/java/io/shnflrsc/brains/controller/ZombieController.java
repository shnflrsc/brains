package io.shnflrsc.brains.controller;

import io.shnflrsc.brains.dto.PageResponse;
import io.shnflrsc.brains.dto.ZombieFilter;
import io.shnflrsc.brains.dto.ZombieResponse;
import io.shnflrsc.brains.service.ZombieService;
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
@RequestMapping("/api/v1/zombies")
@RequiredArgsConstructor
@Tag(name = "Zombies", description = "Endpoints for exploring zombie almanac entries")
public class ZombieController {

    private final ZombieService zombieService;

    @GetMapping
    @Operation(summary = "List zombies", description = "Retrieve a paginated list of zombies with optional filtering and sorting.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved zombie list")
    })
    public ResponseEntity<PageResponse<ZombieResponse>> listZombies(
            @ParameterObject ZombieFilter filter,
            @ParameterObject @PageableDefault(size = 20) Pageable pageable
    ) {
        return ResponseEntity.ok(zombieService.getZombies(filter, pageable));
    }

    @GetMapping("/{identifier}")
    @Operation(summary = "Get zombie by ID or slug", description = "Retrieve a single zombie by its numeric ID (e.g. 1) or normalized name/slug (e.g. 'zombie', 'buckethead-zombie').")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Zombie found"),
            @ApiResponse(responseCode = "404", description = "Zombie not found",
                    content = @Content(schema = @Schema(implementation = ProblemDetail.class)))
    })
    public ResponseEntity<ZombieResponse> getZombie(
            @Parameter(description = "Numeric entry ID or zombie name/slug", example = "zombie")
            @PathVariable("identifier") String identifier
    ) {
        return ResponseEntity.ok(zombieService.getZombieByIdentifier(identifier));
    }
}
