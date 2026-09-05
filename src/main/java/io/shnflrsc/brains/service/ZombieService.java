package io.shnflrsc.brains.service;

import io.shnflrsc.brains.dto.PageResponse;
import io.shnflrsc.brains.dto.ZombieFilter;
import io.shnflrsc.brains.dto.ZombieResponse;
import io.shnflrsc.brains.exception.ResourceNotFoundException;
import io.shnflrsc.brains.model.Zombie;
import io.shnflrsc.brains.repository.ZombieRepository;
import io.shnflrsc.brains.repository.ZombieSpecifications;
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
public class ZombieService {

    private final ZombieRepository zombieRepository;

    @Transactional(readOnly = true)
    public PageResponse<ZombieResponse> getZombies(ZombieFilter filter, Pageable pageable) {
        Pageable remappedPageable = remapSort(pageable);
        Page<Zombie> page = zombieRepository.findAll(ZombieSpecifications.withFilter(filter), remappedPageable);
        return PageResponse.from(page, ZombieResponse::from);
    }

    @Transactional(readOnly = true)
    public ZombieResponse getZombieByIdentifier(String identifier) {
        if (identifier == null || identifier.isBlank()) {
            throw new ResourceNotFoundException("Zombie", identifier);
        }

        String trimmed = identifier.trim();
        Optional<Zombie> zombieOptional;

        if (trimmed.matches("^\\d+$")) {
            zombieOptional = zombieRepository.findByIdWithEntry(Long.parseLong(trimmed));
        } else {
            String normalized = PlantService.normalizeSlug(trimmed);
            zombieOptional = zombieRepository.findByNormalizedName(normalized);
        }

        Zombie zombie = zombieOptional.orElseThrow(() -> new ResourceNotFoundException("Zombie", identifier));
        return ZombieResponse.from(zombie);
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
