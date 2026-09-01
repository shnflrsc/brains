CREATE TYPE entry_type AS ENUM (
    'PLANT',
    'ZOMBIE'
);

CREATE TYPE stat AS ENUM (
    'LOW',
    'NORMAL',
    'HIGH',
    'VERY_HIGH',
    'EXTREMELY_HIGH'
);

CREATE TYPE speed AS ENUM (
    'VERY_SLOW',
    'SLOW',
    'NORMAL',
    'FAST'
);
CREATE TABLE entries (
    entry_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    history TEXT NOT NULL,
    toughness stat NOT NULL,
    special VARCHAR(255),
    entry_type entry_type NOT NULL
);

CREATE TABLE plants (
    entry_id BIGINT PRIMARY KEY,
    sun_cost SMALLINT NOT NULL,
    recharge speed NOT NULL,
    damage stat,
    range VARCHAR(255),
    area VARCHAR(255),
    sun_production SMALLINT,
    is_nocturnal BOOLEAN NOT NULL,
    is_aquatic BOOLEAN NOT NULL,
    is_instant_use BOOLEAN NOT NULL,
    is_single_use BOOLEAN NOT NULL,
    prerequisite_plant_id BIGINT,

    CONSTRAINT fk_plants_entry
        FOREIGN KEY (entry_id)
        REFERENCES entries (entry_id),

    CONSTRAINT fk_plants_prerequisite
        FOREIGN KEY (prerequisite_plant_id)
        REFERENCES plants (entry_id)
);

CREATE TABLE zombies (
    entry_id BIGINT PRIMARY KEY,
    speed speed NOT NULL,

    CONSTRAINT fk_zombies_entry
        FOREIGN KEY (entry_id)
        REFERENCES entries (entry_id)
);

CREATE TABLE zombies_weaknesses (
    zombie_id BIGINT NOT NULL,
    weakness_plant_id BIGINT NOT NULL,

    PRIMARY KEY (zombie_id, weakness_plant_id),

    CONSTRAINT fk_zombie_weaknesses_zombie
        FOREIGN KEY (zombie_id)
        REFERENCES zombies (entry_id),

    CONSTRAINT fk_zombie_weaknesses_plant
        FOREIGN KEY (weakness_plant_id)
        REFERENCES plants (entry_id)
);
