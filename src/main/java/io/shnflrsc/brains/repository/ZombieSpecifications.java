package io.shnflrsc.brains.repository;

import io.shnflrsc.brains.dto.ZombieFilter;
import io.shnflrsc.brains.model.Entry;
import io.shnflrsc.brains.model.Zombie;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.util.ArrayList;
import java.util.List;

public final class ZombieSpecifications {

    private ZombieSpecifications() {
    }

    public static Specification<Zombie> withFilter(ZombieFilter filter) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            Join<Zombie, Entry> entryJoin = root.join("entry", JoinType.INNER);

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
                if (filter.getSpeed() != null) {
                    predicates.add(cb.equal(root.get("speed"), filter.getSpeed()));
                }
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
