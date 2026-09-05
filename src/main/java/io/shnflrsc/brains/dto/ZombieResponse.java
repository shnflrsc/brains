package io.shnflrsc.brains.dto;

import io.shnflrsc.brains.model.Speed;
import io.shnflrsc.brains.model.Stat;
import io.shnflrsc.brains.model.Zombie;
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
public class ZombieResponse {

    private Long id;
    private String name;
    private String description;
    private String history;
    private Stat toughness;
    private String special;

    private Speed speed;
    private List<PlantSummary> weaknesses;

    public static ZombieResponse from(Zombie zombie) {
        if (zombie == null) {
            return null;
        }
        var entry = zombie.getEntry();

        return ZombieResponse.builder()
                .id(zombie.getId())
                .name(entry != null ? entry.getName() : null)
                .description(entry != null ? entry.getDescription() : null)
                .history(entry != null ? entry.getHistory() : null)
                .toughness(entry != null ? entry.getToughness() : null)
                .special(entry != null ? entry.getSpecial() : null)
                .speed(zombie.getSpeed())
                .weaknesses(zombie.getWeaknesses() != null ?
                        zombie.getWeaknesses().stream().map(PlantSummary::from).toList() :
                        Collections.emptyList())
                .build();
    }
}
