package io.shnflrsc.brains.repository;

import io.shnflrsc.brains.dto.PlantFilter;
import io.shnflrsc.brains.model.Entry;
import io.shnflrsc.brains.model.Plant;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.util.ArrayList;
import java.util.List;

public final class PlantSpecifications {

    private PlantSpecifications() {
    }

    public static Specification<Plant> withFilter(PlantFilter filter) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            Join<Plant, Entry> entryJoin = root.join("entry", JoinType.INNER);

            if (filter != null) {
                if (filter.getName() != null && !filter.getName().isBlank()) {
                    predicates.add(cb.like(
                            cb.lower(entryJoin.get("name")),
                            "%" + filter.getName().trim().toLowerCase() + "%"
                    ));
                }
                if (filter.getToughness() != null) {
                    predicates.add(cb.equal(entryJoin.get("toughness"), filter.getToughness()));
                }
                if (filter.getRecharge() != null) {
                    predicates.add(cb.equal(root.get("recharge"), filter.getRecharge()));
                }
                if (filter.getDamage() != null) {
                    predicates.add(cb.equal(root.get("damage"), filter.getDamage()));
                }
                if (filter.getIsNocturnal() != null) {
                    predicates.add(cb.equal(root.get("isNocturnal"), filter.getIsNocturnal()));
                }
                if (filter.getIsAquatic() != null) {
                    predicates.add(cb.equal(root.get("isAquatic"), filter.getIsAquatic()));
                }
                if (filter.getIsInstantUse() != null) {
                    predicates.add(cb.equal(root.get("isInstantUse"), filter.getIsInstantUse()));
                }
                if (filter.getIsSingleUse() != null) {
                    predicates.add(cb.equal(root.get("isSingleUse"), filter.getIsSingleUse()));
                }
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
