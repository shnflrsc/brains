package io.shnflrsc.brains.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "entries")
public class Entry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "entry_id")
    @EqualsAndHashCode.Include
    private Long id;

    @Column(name = "name", length = 255, nullable = false)
    private String name;

    @Column(name = "description", nullable = false, columnDefinition = "TEXT")
    private String description;

    @Column(name = "history", nullable = false, columnDefinition = "TEXT")
    private String history;

    @Column(name = "toughness", nullable = false)
    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private Stat toughness;

    @Column(name = "special", length = 255)
    private String special;

    @Column(name = "entry_type", nullable = false)
    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private EntryType entryType;

    @OneToOne(mappedBy = "entry", cascade = CascadeType.ALL, orphanRemoval = true)
    @ToString.Exclude
    private Plant plant;

    @OneToOne(mappedBy = "entry", cascade = CascadeType.ALL, orphanRemoval = true)
    @ToString.Exclude
    private Zombie zombie;

    public void setPlant(Plant plant) {
        this.plant = plant;
        if (plant != null && plant.getEntry() != this) {
            plant.setEntry(this);
        }
    }

    public void setZombie(Zombie zombie) {
        this.zombie = zombie;
        if (zombie != null && zombie.getEntry() != this) {
            zombie.setEntry(this);
        }
    }
}
