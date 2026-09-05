package io.shnflrsc.brains.repository;

import io.shnflrsc.brains.model.Zombie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ZombieRepository extends JpaRepository<Zombie, Long>, JpaSpecificationExecutor<Zombie> {

    @Query("SELECT z FROM Zombie z JOIN FETCH z.entry WHERE z.id = :id")
    Optional<Zombie> findByIdWithEntry(@Param("id") Long id);

    @Query("SELECT z FROM Zombie z JOIN FETCH z.entry e WHERE LOWER(REPLACE(REPLACE(e.name, ' ', ''), '-', '')) = :normalized")
    Optional<Zombie> findByNormalizedName(@Param("normalized") String normalized);
}
