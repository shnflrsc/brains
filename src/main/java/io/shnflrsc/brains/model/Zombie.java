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
@Table(name = "zombies")
public class Zombie {

    @Id
    @Column(name = "entry_id")
    @EqualsAndHashCode.Include
    private Long id;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @MapsId
    @JoinColumn(name = "entry_id")
    @ToString.Exclude
    private Entry entry;

    @Column(name = "speed", nullable = false)
    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private Speed speed;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "zombies_weaknesses",
        joinColumns = @JoinColumn(name = "zombie_id"),
        inverseJoinColumns = @JoinColumn(name = "weakness_plant_id")
    )
    @ToString.Exclude
    @Builder.Default
    private Set<Plant> weaknesses = new HashSet<>();

    public void setEntry(Entry entry) {
        this.entry = entry;
        if (entry != null && entry.getZombie() != this) {
            entry.setZombie(this);
        }
    }

    public void addWeakness(Plant plant) {
        if (plant != null) {
            this.weaknesses.add(plant);
            plant.getEffectiveAgainst().add(this);
        }
    }

    public void removeWeakness(Plant plant) {
        if (plant != null) {
            this.weaknesses.remove(plant);
            plant.getEffectiveAgainst().remove(this);
        }
    }
}
