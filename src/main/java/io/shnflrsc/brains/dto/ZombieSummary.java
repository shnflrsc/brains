package io.shnflrsc.brains.dto;

import io.shnflrsc.brains.model.Zombie;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ZombieSummary {

    private Long id;
    private String name;

    public static ZombieSummary from(Zombie zombie) {
        if (zombie == null) {
            return null;
        }
        return ZombieSummary.builder()
                .id(zombie.getId())
                .name(zombie.getEntry() != null ? zombie.getEntry().getName() : null)
                .build();
    }
}
