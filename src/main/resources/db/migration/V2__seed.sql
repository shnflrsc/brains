WITH peashooter AS (
    INSERT INTO entries (name, description, history, toughness, entry_type)
    VALUES (
        'Peashooter',
        'Peashooters are your first line of defense. ' ||
            'They shoot peas at attacking zombies.',
        'How can a single plant grow and shoot so many peas so quickly? ' ||
            'Peashooter says, "Hard work, commitment, and a healthy, ' ||
            'well-balanced breakfast of sunlight and high-fiber carbon dioxide ' ||
            'make it all possible."',
        'NORMAL',
        'PLANT'
    )
    RETURNING entry_id
)
INSERT INTO plants (
    entry_id,
    sun_cost,
    recharge,
    damage,
    range,
    area,
    sun_production,
    is_nocturnal,
    is_aquatic,
    is_instant_use,
    is_single_use,
    prerequisite_plant_id
)
SELECT
    entry_id,
    100,
    'FAST',
    'NORMAL',
    'Straight',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE,
    NULL
FROM peashooter;

WITH regular_zombie AS (
    INSERT INTO entries (name, description, history, toughness, entry_type)
    VALUES (
        'Zombie',
        'Regular Garden-variety Zombie',
        'This zombie loves brains. Can''t get enough. Brains, brains, brains, ' ||
            'day in and night out. Old and stinky brains? Rotten brains? ' ||
            'Brains clearly past their prime? Doesn''t matter. ' ||
            'Regular zombie wants ''em.',
        'LOW',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM regular_zombie;
