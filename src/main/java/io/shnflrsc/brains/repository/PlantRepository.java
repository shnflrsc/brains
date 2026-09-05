package io.shnflrsc.brains.repository;

import io.shnflrsc.brains.model.Plant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PlantRepository extends JpaRepository<Plant, Long>, JpaSpecificationExecutor<Plant> {

    @Query("SELECT p FROM Plant p JOIN FETCH p.entry WHERE p.id = :id")
    Optional<Plant> findByIdWithEntry(@Param("id") Long id);

    @Query("SELECT p FROM Plant p JOIN FETCH p.entry e WHERE LOWER(REPLACE(REPLACE(e.name, ' ', ''), '-', '')) = :normalized")
    Optional<Plant> findByNormalizedName(@Param("normalized") String normalized);
}
