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
public class ZombieFilter {

    private String name;
    private Stat toughness;
    private Speed speed;
}
