package io.shnflrsc.brains.service;

import io.shnflrsc.brains.dto.PageResponse;
import io.shnflrsc.brains.dto.PlantFilter;
import io.shnflrsc.brains.dto.PlantResponse;
import io.shnflrsc.brains.exception.ResourceNotFoundException;
import io.shnflrsc.brains.model.Plant;
import io.shnflrsc.brains.repository.PlantRepository;
import io.shnflrsc.brains.repository.PlantSpecifications;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PlantService {

    private final PlantRepository plantRepository;

    @Transactional(readOnly = true)
    public PageResponse<PlantResponse> getPlants(PlantFilter filter, Pageable pageable) {
        Pageable remappedPageable = remapSort(pageable);
        Page<Plant> page = plantRepository.findAll(PlantSpecifications.withFilter(filter), remappedPageable);
        return PageResponse.from(page, PlantResponse::from);
    }

    @Transactional(readOnly = true)
    public PlantResponse getPlantByIdentifier(String identifier) {
        if (identifier == null || identifier.isBlank()) {
            throw new ResourceNotFoundException("Plant", identifier);
        }

        String trimmed = identifier.trim();
        Optional<Plant> plantOptional;

        if (trimmed.matches("^\\d+$")) {
            plantOptional = plantRepository.findByIdWithEntry(Long.parseLong(trimmed));
        } else {
            String normalized = normalizeSlug(trimmed);
            plantOptional = plantRepository.findByNormalizedName(normalized);
        }

        Plant plant = plantOptional.orElseThrow(() -> new ResourceNotFoundException("Plant", identifier));
        return PlantResponse.from(plant);
    }

    public static String normalizeSlug(String input) {
        if (input == null) {
            return "";
        }
        return input.replaceAll("[\\s\\-_]+", "").toLowerCase();
    }

    private Pageable remapSort(Pageable pageable) {
        if (pageable.getSort().isUnsorted()) {
            return pageable;
        }
        List<Sort.Order> remapped = new ArrayList<>();
        for (Sort.Order order : pageable.getSort()) {
            String property = order.getProperty();
            if ("name".equalsIgnoreCase(property) || "toughness".equalsIgnoreCase(property)) {
                remapped.add(new Sort.Order(order.getDirection(), "entry." + property.toLowerCase()));
            } else {
                remapped.add(order);
            }
        }
        return PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by(remapped));
    }
}
