package io.shnflrsc.brains.service;

import io.shnflrsc.brains.dto.PageResponse;
import io.shnflrsc.brains.dto.ZombieFilter;
import io.shnflrsc.brains.dto.ZombieResponse;
import io.shnflrsc.brains.exception.ResourceNotFoundException;
import io.shnflrsc.brains.model.*;
import io.shnflrsc.brains.repository.ZombieRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ZombieServiceTest {

    @Mock
    private ZombieRepository zombieRepository;

    @InjectMocks
    private ZombieService zombieService;

    private Zombie zombie;
    private Entry entry;

    @BeforeEach
    void setUp() {
        entry = Entry.builder()
                .id(2L)
                .name("Buckethead Zombie")
                .description("Wears a bucket")
                .history("Stole a bucket")
                .toughness(Stat.HIGH)
                .entryType(EntryType.ZOMBIE)
                .build();

        zombie = Zombie.builder()
                .id(2L)
                .speed(Speed.NORMAL)
                .build();

        entry.setZombie(zombie);
    }

    @Test
    void getZombies_RemapsSortAndReturnsPageResponse() {
        Page<Zombie> page = new PageImpl<>(List.of(zombie), PageRequest.of(0, 10), 1);
        when(zombieRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);

        Pageable pageable = PageRequest.of(0, 10, Sort.by(Sort.Direction.DESC, "toughness"));
        ZombieFilter filter = ZombieFilter.builder().name("Bucket").build();

        PageResponse<ZombieResponse> result = zombieService.getZombies(filter, pageable);

        assertNotNull(result);
        assertEquals(1, result.getTotalElements());
        assertEquals("Buckethead Zombie", result.getData().getFirst().getName());

        ArgumentCaptor<Pageable> captor = ArgumentCaptor.forClass(Pageable.class);
        verify(zombieRepository).findAll(any(Specification.class), captor.capture());
        Sort.Order sortOrder = captor.getValue().getSort().getOrderFor("entry.toughness");
        assertNotNull(sortOrder);
        assertEquals(Sort.Direction.DESC, sortOrder.getDirection());
    }

    @Test
    void getZombieByIdentifier_NumericId_CallsFindByIdWithEntry() {
        when(zombieRepository.findByIdWithEntry(2L)).thenReturn(Optional.of(zombie));

        ZombieResponse response = zombieService.getZombieByIdentifier("2");

        assertNotNull(response);
        assertEquals(2L, response.getId());
        assertEquals("Buckethead Zombie", response.getName());
        verify(zombieRepository).findByIdWithEntry(2L);
        verify(zombieRepository, never()).findByNormalizedName(anyString());
    }

    @Test
    void getZombieByIdentifier_Slug_NormalizesAndCallsFindByNormalizedName() {
        when(zombieRepository.findByNormalizedName("bucketheadzombie")).thenReturn(Optional.of(zombie));

        ZombieResponse response = zombieService.getZombieByIdentifier("buckethead-zombie");

        assertNotNull(response);
        assertEquals("Buckethead Zombie", response.getName());
        verify(zombieRepository).findByNormalizedName("bucketheadzombie");
        verify(zombieRepository, never()).findByIdWithEntry(anyLong());
    }

    @Test
    void getZombieByIdentifier_NotFound_ThrowsResourceNotFoundException() {
        when(zombieRepository.findByNormalizedName("unknown")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () ->
                zombieService.getZombieByIdentifier("unknown")
        );
    }
}
