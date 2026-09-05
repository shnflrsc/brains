package io.shnflrsc.brains.service;

import io.shnflrsc.brains.dto.PageResponse;
import io.shnflrsc.brains.dto.PlantFilter;
import io.shnflrsc.brains.dto.PlantResponse;
import io.shnflrsc.brains.exception.ResourceNotFoundException;
import io.shnflrsc.brains.model.Entry;
import io.shnflrsc.brains.model.EntryType;
import io.shnflrsc.brains.model.Plant;
import io.shnflrsc.brains.model.Speed;
import io.shnflrsc.brains.model.Stat;
import io.shnflrsc.brains.repository.PlantRepository;
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
class PlantServiceTest {

    @Mock
    private PlantRepository plantRepository;

    @InjectMocks
    private PlantService plantService;

    private Plant plant;
    private Entry entry;

    @BeforeEach
    void setUp() {
        entry = Entry.builder()
                .id(1L)
                .name("Peashooter")
                .description("Shoots peas at zombies")
                .history("Hard work and commitment")
                .toughness(Stat.NORMAL)
                .entryType(EntryType.PLANT)
                .build();

        plant = Plant.builder()
                .id(1L)
                .sunCost((short) 100)
                .recharge(Speed.FAST)
                .damage(Stat.NORMAL)
                .range("Straight")
                .isNocturnal(false)
                .isAquatic(false)
                .isInstantUse(false)
                .isSingleUse(false)
                .build();

        entry.setPlant(plant);
    }

    @Test
    void getPlants_RemapsSortAndReturnsPageResponse() {
        Page<Plant> page = new PageImpl<>(List.of(plant), PageRequest.of(0, 10), 1);
        when(plantRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);

        Pageable pageable = PageRequest.of(0, 10, Sort.by(Sort.Direction.ASC, "name"));
        PlantFilter filter = PlantFilter.builder().name("Pea").build();

        PageResponse<PlantResponse> result = plantService.getPlants(filter, pageable);

        assertNotNull(result);
        assertEquals(1, result.getTotalElements());
        assertEquals("Peashooter", result.getData().getFirst().getName());

        ArgumentCaptor<Pageable> captor = ArgumentCaptor.forClass(Pageable.class);
        verify(plantRepository).findAll(any(Specification.class), captor.capture());
        Sort.Order sortOrder = captor.getValue().getSort().getOrderFor("entry.name");
        assertNotNull(sortOrder);
        assertEquals(Sort.Direction.ASC, sortOrder.getDirection());
    }

    @Test
    void getPlantByIdentifier_NumericId_CallsFindByIdWithEntry() {
        when(plantRepository.findByIdWithEntry(1L)).thenReturn(Optional.of(plant));

        PlantResponse response = plantService.getPlantByIdentifier("1");

        assertNotNull(response);
        assertEquals(1L, response.getId());
        assertEquals("Peashooter", response.getName());
        verify(plantRepository).findByIdWithEntry(1L);
        verify(plantRepository, never()).findByNormalizedName(anyString());
    }

    @Test
    void getPlantByIdentifier_Slug_NormalizesAndCallsFindByNormalizedName() {
        when(plantRepository.findByNormalizedName("peashooter")).thenReturn(Optional.of(plant));

        PlantResponse response = plantService.getPlantByIdentifier("pea-shooter");

        assertNotNull(response);
        assertEquals("Peashooter", response.getName());
        verify(plantRepository).findByNormalizedName("peashooter");
        verify(plantRepository, never()).findByIdWithEntry(anyLong());
    }

    @Test
    void getPlantByIdentifier_NotFound_ThrowsResourceNotFoundException() {
        when(plantRepository.findByNormalizedName("unknown")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () ->
                plantService.getPlantByIdentifier("unknown")
        );
    }

    @Test
    void normalizeSlug_StripsHyphensSpacesAndUnderscores() {
        assertEquals("gatlingpea", PlantService.normalizeSlug("Gatling Pea"));
        assertEquals("gatlingpea", PlantService.normalizeSlug("gatling-pea"));
        assertEquals("gatlingpea", PlantService.normalizeSlug("Gatling_Pea"));
        assertEquals("peashooter", PlantService.normalizeSlug("Peashooter"));
        assertEquals("", PlantService.normalizeSlug(null));
    }
}
