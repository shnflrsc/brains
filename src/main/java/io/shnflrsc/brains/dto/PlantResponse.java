package io.shnflrsc.brains.dto;

import io.shnflrsc.brains.model.Plant;
import io.shnflrsc.brains.model.Speed;
import io.shnflrsc.brains.model.Stat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PlantResponse {

    private Long id;
    private String name;
    private String description;
    private String history;
    private Stat toughness;
    private String special;

    private short sunCost;
    private Speed recharge;
    private Stat damage;
    private String range;
    private String area;
    private Short sunProduction;
    private boolean isNocturnal;
    private boolean isAquatic;
    private boolean isInstantUse;
    private boolean isSingleUse;

    private PlantSummary prerequisite;
    private List<PlantSummary> unlockedPlants;
    private List<ZombieSummary> effectiveAgainst;

    public static PlantResponse from(Plant plant) {
        if (plant == null) {
            return null;
        }
        var entry = plant.getEntry();

        return PlantResponse.builder()
                .id(plant.getId())
                .name(entry != null ? entry.getName() : null)
                .description(entry != null ? entry.getDescription() : null)
                .history(entry != null ? entry.getHistory() : null)
                .toughness(entry != null ? entry.getToughness() : null)
                .special(entry != null ? entry.getSpecial() : null)
                .sunCost(plant.getSunCost())
                .recharge(plant.getRecharge())
                .damage(plant.getDamage())
                .range(plant.getRange())
                .area(plant.getArea())
                .sunProduction(plant.getSunProduction())
                .isNocturnal(plant.isNocturnal())
                .isAquatic(plant.isAquatic())
                .isInstantUse(plant.isInstantUse())
                .isSingleUse(plant.isSingleUse())
                .prerequisite(plant.getPrerequisite() != null ? PlantSummary.from(plant.getPrerequisite()) : null)
                .unlockedPlants(plant.getUnlockedPlants() != null ?
                        plant.getUnlockedPlants().stream().map(PlantSummary::from).toList() :
                        Collections.emptyList())
                .effectiveAgainst(plant.getEffectiveAgainst() != null ?
                        plant.getEffectiveAgainst().stream().map(ZombieSummary::from).toList() :
                        Collections.emptyList())
                .build();
    }
}
