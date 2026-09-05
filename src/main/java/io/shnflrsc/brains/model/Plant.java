package io.shnflrsc.brains.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "plants")
public class Plant {

    @Id
    @Column(name = "entry_id")
    @EqualsAndHashCode.Include
    private Long id;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @MapsId
    @JoinColumn(name = "entry_id")
    @ToString.Exclude
    private Entry entry;

    @Column(name = "sun_cost", nullable = false)
    private short sunCost;

    @Column(name = "recharge", nullable = false)
    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private Speed recharge;

    @Column(name = "damage")
    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private Stat damage;

    @Column(name = "range", length = 255)
    private String range;

    @Column(name = "area", length = 255)
    private String area;

    @Column(name = "sun_production")
    private Short sunProduction;

    @Column(name = "is_nocturnal", nullable = false)
    private boolean isNocturnal;

    @Column(name = "is_aquatic", nullable = false)
    private boolean isAquatic;

    @Column(name = "is_instant_use", nullable = false)
    private boolean isInstantUse;

    @Column(name = "is_single_use", nullable = false)
    private boolean isSingleUse;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "prerequisite_plant_id")
    @ToString.Exclude
    private Plant prerequisite;

    @OneToMany(mappedBy = "prerequisite")
    @ToString.Exclude
    @Builder.Default
    private Set<Plant> unlockedPlants = new HashSet<>();

    @ManyToMany(mappedBy = "weaknesses", fetch = FetchType.LAZY)
    @ToString.Exclude
    @Builder.Default
    private Set<Zombie> effectiveAgainst = new HashSet<>();

    public void setEntry(Entry entry) {
        this.entry = entry;
        if (entry != null && entry.getPlant() != this) {
            entry.setPlant(this);
        }
    }

    public void addUnlockedPlant(Plant plant) {
        if (plant != null) {
            this.unlockedPlants.add(plant);
            plant.setPrerequisite(this);
        }
    }

    public void removeUnlockedPlant(Plant plant) {
        if (plant != null) {
            this.unlockedPlants.remove(plant);
            plant.setPrerequisite(null);
        }
    }
}
