package io.shnflrsc.brains.dto;

import io.shnflrsc.brains.model.Plant;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PlantSummary {

    private Long id;
    private String name;

    public static PlantSummary from(Plant plant) {
        if (plant == null) {
            return null;
        }
        return PlantSummary.builder()
                .id(plant.getId())
                .name(plant.getEntry() != null ? plant.getEntry().getName() : null)
                .build();
    }
}
