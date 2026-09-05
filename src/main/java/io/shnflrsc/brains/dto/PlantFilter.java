package io.shnflrsc.brains.dto;

import io.shnflrsc.brains.model.Speed;
import io.shnflrsc.brains.model.Stat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PlantFilter {

    private String name;
    private Stat toughness;
    private Speed recharge;
    private Stat damage;
    private Boolean isNocturnal;
    private Boolean isAquatic;
    private Boolean isInstantUse;
    private Boolean isSingleUse;
}
