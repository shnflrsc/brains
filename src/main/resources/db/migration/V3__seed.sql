WITH peashooter AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Peashooter',
        'Peashooters are your first line of defense. They shoot peas at attacking zombies.',
        'TBD',
        'NORMAL',
        'Unlocked: Default',
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
    is_single_use
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
    FALSE
FROM peashooter;

WITH sunflower AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Sunflower',
        'Sunflowers are essential for you to produce extra sun. Try planting as many as you can!',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 1-1',
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
    is_single_use
)
SELECT
    entry_id,
    50,
    'FAST',
    NULL,
    NULL,
    NULL,
    25,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM sunflower;

WITH cherry_bomb AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Cherry Bomb',
        'Cherry Bombs can blow up all zombies in an area. They have a short fuse so plant them near' ||
            'zombies.',
        'TBD',
        'HIGH',
        'Unlocked: Beat Level 1-2',
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
    is_single_use
)
SELECT
    entry_id,
    150,
    'VERY_SLOW',
    'EXTREMELY_HIGH',
    NULL,
    '3x3',
    NULL,
    FALSE,
    FALSE,
    TRUE,
    TRUE
FROM cherry_bomb;

WITH wallnut AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Wall-nut',
        'Wall-nuts have hard shells which you can use to protect your other plants.',
        'TBD',
        'VERY_HIGH',
        'Unlocked: Beat Level 1-3',
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
    is_single_use
)
SELECT
    entry_id,
    50,
    'SLOW',
    NULL,
    NULL,
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM wallnut;

WITH potato_mine AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Potato Mine',
        'Potato Mines pack a powerful punch, but they need a while to arm themselves. You should plant' ||
            'them ahead of zombies. They will explode on contact.',
        'TBD',
        'HIGH',
        'Unlocked: Beat Level 1-5',
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
    is_single_use
)
SELECT
    entry_id,
    25,
    'SLOW',
    'EXTREMELY_HIGH',
    NULL,
    'Single tile',
    NULL,
    FALSE,
    FALSE,
    TRUE,
    TRUE
FROM potato_mine;

WITH snow_pea AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Snow Pea',
        'Snow Peas shoot frozen peas that damage and slow the enemy.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 1-6',
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
    is_single_use
)
SELECT
    entry_id,
    175,
    'FAST',
    'NORMAL',
    'Straight',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM snow_pea;

WITH chomper AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Chomper',
        'Chompers can devour a zombie whole, but they are vulnerable while chewing.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 1-7',
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
    is_single_use
)
SELECT
    entry_id,
    150,
    'FAST',
    'EXTREMELY_HIGH',
    'Adjacent tile',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM chomper;

WITH repeater AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Repeater',
        'Repeaters fire two peas at a time.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 1-8',
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
    is_single_use
)
SELECT
    entry_id,
    200,
    'FAST',
    'HIGH',
    'Straight',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM repeater;

WITH puffshroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Puff-shroom',
        'Puff-shrooms are cheap, but can only fire a short distance.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 1-10',
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
    is_single_use
)
SELECT
    entry_id,
    0,
    'FAST',
    'NORMAL',
    'Short',
    NULL,
    NULL,
    TRUE,
    FALSE,
    FALSE,
    FALSE
FROM puffshroom;

WITH sunshroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Sun-shroom',
        'Sun-shrooms give small sun at first and normal sun later.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 2-1',
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
    is_single_use
)
SELECT
    entry_id,
    25,
    'FAST',
    NULL,
    NULL,
    NULL,
    15,
    TRUE,
    FALSE,
    FALSE,
    FALSE
FROM sunshroom;

WITH fumeshroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Fume-shroom',
        'Fume-shrooms shoot fumes that can pass through screen doors.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 2-2',
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
    is_single_use
)
SELECT
    entry_id,
    75,
    'FAST',
    'NORMAL',
    'Short',
    NULL,
    NULL,
    TRUE,
    FALSE,
    FALSE,
    FALSE
FROM fumeshroom;

WITH grave_buster AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Grave Buster',
        'Plant Grave Busters on graves to remove the graves.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 2-3',
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
    is_single_use
)
SELECT
    entry_id,
    75,
    'FAST',
    NULL,
    NULL,
    'Single grave',
    NULL,
    FALSE,
    FALSE,
    TRUE,
    TRUE
FROM grave_buster;

WITH hypnoshroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Hypno-shroom',
        'When eaten, Hypno-shrooms will make a zombie turn around and fight for you.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 2-5',
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
    is_single_use
)
SELECT
    entry_id,
    75,
    'SLOW',
    NULL,
    NULL,
    NULL,
    NULL,
    TRUE,
    FALSE,
    TRUE,
    TRUE
FROM hypnoshroom;

WITH scaredyshroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Scaredy-shroom',
        'Scaredy-shrooms are long-ranged shooters that hide when enemies get near them.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 2-6',
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
    is_single_use
)
SELECT
    entry_id,
    25,
    'FAST',
    'NORMAL',
    'Straight',
    NULL,
    NULL,
    TRUE,
    FALSE,
    FALSE,
    FALSE
FROM scaredyshroom;

WITH iceshroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Ice-shroom',
        'Ice-shrooms temporarily immobilize all zombies on the screen.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 2-7',
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
    is_single_use
)
SELECT
    entry_id,
    75,
    'VERY_SLOW',
    'NORMAL',
    NULL,
    'Whole screen',
    NULL,
    TRUE,
    FALSE,
    TRUE,
    TRUE
FROM iceshroom;

WITH doomshroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Doom-shroom',
        'Doom-shrooms destroy everything in a large area and leave a crater that can''t be planted on.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 2-8',
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
    is_single_use
)
SELECT
    entry_id,
    125,
    'VERY_SLOW',
    'EXTREMELY_HIGH',
    NULL,
    'Large area',
    NULL,
    TRUE,
    FALSE,
    TRUE,
    TRUE
FROM doomshroom;

WITH lily_pad AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Lily Pad',
        'Lily pads let you plant non-aquatic plants on top of them.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 2-10',
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
    is_single_use
)
SELECT
    entry_id,
    25,
    'FAST',
    NULL,
    NULL,
    'Pool tile',
    NULL,
    FALSE,
    TRUE,
    FALSE,
    FALSE
FROM lily_pad;

WITH squash AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Squash',
        'Squashes will smash the first zombie that gets close to it.',
        'TBD',
        'HIGH',
        'Unlocked: Beat Level 3-1',
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
    is_single_use
)
SELECT
    entry_id,
    50,
    'SLOW',
    'EXTREMELY_HIGH',
    NULL,
    'Single tile',
    NULL,
    FALSE,
    FALSE,
    TRUE,
    TRUE
FROM squash;

WITH threepeater AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Threepeater',
        'Threepeaters shoot peas in three lanes.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 3-2',
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
    is_single_use
)
SELECT
    entry_id,
    325,
    'FAST',
    'NORMAL',
    'Straight',
    'Three lanes',
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM threepeater;

WITH tangle_kelp AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Tangle Kelp',
        'Tangle Kelp are aquatic plants that pull the first zombie that nears them underwater.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 3-3',
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
    is_single_use
)
SELECT
    entry_id,
    25,
    'SLOW',
    'EXTREMELY_HIGH',
    NULL,
    'Underwater tile',
    NULL,
    FALSE,
    TRUE,
    TRUE,
    TRUE
FROM tangle_kelp;

WITH jalapeno AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Jalapeno',
        'Jalapenos destroy an entire lane of zombies.',
        'TBD',
        'HIGH',
        'Unlocked: Beat Level 3-5',
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
    is_single_use
)
SELECT
    entry_id,
    125,
    'VERY_SLOW',
    'EXTREMELY_HIGH',
    NULL,
    'One lane',
    NULL,
    FALSE,
    FALSE,
    TRUE,
    TRUE
FROM jalapeno;

WITH spikeweed AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Spikeweed',
        'Spikeweeds pop tires and hurt any zombies that step on them.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 3-6',
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
    is_single_use
)
SELECT
    entry_id,
    100,
    'FAST',
    'NORMAL',
    NULL,
    'Ground tile',
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM spikeweed;

WITH torchwood AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Torchwood',
        'Torchwoods turn peas that pass through them into fireballs that deal twice as much damage.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 3-7',
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
    is_single_use
)
SELECT
    entry_id,
    175,
    'FAST',
    NULL,
    NULL,
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM torchwood;

WITH tallnut AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Tall-nut',
        'Tall-nuts are heavy-duty wall plants that can''t be vaulted over.',
        'TBD',
        'VERY_HIGH',
        'Unlocked: Beat Level 3-8',
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
    is_single_use
)
SELECT
    entry_id,
    125,
    'SLOW',
    NULL,
    NULL,
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM tallnut;

WITH seashroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Sea-shroom',
        'Sea-shrooms are aquatic plants that shoot short ranged spores.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 3-10',
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
    is_single_use
)
SELECT
    entry_id,
    0,
    'SLOW',
    'NORMAL',
    'Short',
    NULL,
    NULL,
    TRUE,
    TRUE,
    FALSE,
    FALSE
FROM seashroom;

WITH plantern AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Plantern',
        'Planterns light up an area, letting you see through fog.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 4-1',
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
    is_single_use
)
SELECT
    entry_id,
    25,
    'SLOW',
    NULL,
    NULL,
    NULL,
    NULL,
    FALSE,
    FALSE,
    TRUE,
    FALSE
FROM plantern;

WITH cactus AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Cactus',
        'Cactuses shoot spikes that can hit both ground and air targets.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 4-2',
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
    is_single_use
)
SELECT
    entry_id,
    125,
    'FAST',
    'NORMAL',
    'Straight (also air)',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM cactus;

WITH blover AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Blover',
        'Blovers blow away all balloon zombies and fog.',
        'TBD',
        'HIGH',
        'Unlocked: Beat Level 4-3',
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
    is_single_use
)
SELECT
    entry_id,
    100,
    'FAST',
    NULL,
    NULL,
    'Whole screen',
    NULL,
    FALSE,
    FALSE,
    TRUE,
    TRUE
FROM blover;

WITH split_pea AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Split Pea',
        'Split Peas shoot peas forward and backwards.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 4-5',
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
    is_single_use
)
SELECT
    entry_id,
    125,
    'FAST',
    'HIGH',
    'Straight (both directions)',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM split_pea;

WITH starfruit AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Starfruit',
        'Starfruits shoot stars in 5 directions.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 4-6',
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
    is_single_use
)
SELECT
    entry_id,
    125,
    'FAST',
    'NORMAL',
    'Five directions',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM starfruit;

WITH pumpkin AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Pumpkin',
        'Pumpkins protect plants that are within their shells.',
        'TBD',
        'VERY_HIGH',
        'Unlocked: Beat Level 4-7',
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
    is_single_use
)
SELECT
    entry_id,
    125,
    'SLOW',
    NULL,
    NULL,
    'Single tile',
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM pumpkin;

WITH magnetshroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Magnet-shroom',
        'Magnet-shrooms remove helmets and other metal objects from zombies.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 4-8',
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
    is_single_use
)
SELECT
    entry_id,
    100,
    'FAST',
    NULL,
    'Area around',
    'Metal objects',
    NULL,
    TRUE,
    FALSE,
    FALSE,
    FALSE
FROM magnetshroom;

WITH cabbagepult AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Cabbage-pult',
        'Cabbage-pults hurl cabbages at the enemy.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 4-10',
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
    is_single_use
)
SELECT
    entry_id,
    100,
    'FAST',
    'HIGH',
    'Lobbed',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM cabbagepult;

WITH flower_pot AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Flower Pot',
        'Flower Pots let you plant on the roof.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 5-1',
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
    is_single_use
)
SELECT
    entry_id,
    25,
    'FAST',
    NULL,
    NULL,
    'Roof tile',
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM flower_pot;

WITH kernelpult AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Kernel-pult',
        'Kernel-pults fling corn kernels and butter at zombies.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 5-2',
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
    is_single_use
)
SELECT
    entry_id,
    100,
    'FAST',
    'HIGH',
    'Lobbed',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM kernelpult;

WITH coffee_bean AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Coffee Bean',
        'Use Coffee Beans to wake up sleeping mushrooms.',
        'TBD',
        'HIGH',
        'Unlocked: Beat Level 5-3',
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
    is_single_use
)
SELECT
    entry_id,
    75,
    'FAST',
    NULL,
    NULL,
    'Single sleeping mushroom',
    NULL,
    FALSE,
    FALSE,
    TRUE,
    TRUE
FROM coffee_bean;

WITH garlic AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Garlic',
        'Garlic diverts zombies into other lanes.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 5-5',
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
    is_single_use
)
SELECT
    entry_id,
    50,
    'FAST',
    NULL,
    NULL,
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM garlic;

WITH umbrella_leaf AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Umbrella Leaf',
        'Umbrella Leaves protect nearby plants from bungees and catapults.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 5-6',
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
    is_single_use
)
SELECT
    entry_id,
    100,
    'FAST',
    NULL,
    NULL,
    'Protected area',
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM umbrella_leaf;

WITH marigold AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Marigold',
        'Marigolds give you silver and gold coins.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 5-7',
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
    is_single_use
)
SELECT
    entry_id,
    50,
    'SLOW',
    NULL,
    NULL,
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM marigold;

WITH melonpult AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Melon-pult',
        'Melon-pults do heavy damage to groups of zombies.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 5-8',
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
    is_single_use
)
SELECT
    entry_id,
    300,
    'FAST',
    'VERY_HIGH',
    'Lobbed',
    'Splash',
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM melonpult;

WITH gatling_pea AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Gatling Pea',
        'Gatling Peas shoot four peas at a time, and are an upgrade of Repeater.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 3-4 / $5000',
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
    is_single_use
)
SELECT
    entry_id,
    250,
    'VERY_SLOW',
    'VERY_HIGH',
    'Straight',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM gatling_pea;

WITH twin_sunflower AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Twin Sunflower',
        'Twin Sunflowers give twice as much sun as normal Sunflower, of which they are an upgrade.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 3-4 / $5000',
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
    is_single_use
)
SELECT
    entry_id,
    150,
    'VERY_SLOW',
    NULL,
    NULL,
    NULL,
    50,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM twin_sunflower;

WITH gloomshroom AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Gloom-shroom',
        'Gloom-shrooms release heavy fumes in an area around themselves, and are an upgrade of Fume-shroom.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 4-4 / $7500',
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
    is_single_use
)
SELECT
    entry_id,
    150,
    'VERY_SLOW',
    'NORMAL',
    'Surrounding area',
    NULL,
    NULL,
    TRUE,
    FALSE,
    FALSE,
    FALSE
FROM gloomshroom;

WITH cattail AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Cattail',
        'Cattails can attack any lane and shoot down balloon zombies too, and are an upgrade of Lily Pad.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 4-4 / $10,000',
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
    is_single_use
)
SELECT
    entry_id,
    225,
    'VERY_SLOW',
    'HIGH',
    'Any lane (also air)',
    NULL,
    NULL,
    FALSE,
    TRUE,
    FALSE,
    FALSE
FROM cattail;

WITH winter_melon AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Winter Melon',
        'Winter Melons do heavy damage and slow groups of zombies, and are an upgrade of Melon-pult.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Adventure Mode / $10,000',
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
    is_single_use
)
SELECT
    entry_id,
    200,
    'VERY_SLOW',
    'VERY_HIGH',
    'Lobbed',
    'Splash',
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM winter_melon;

WITH gold_magnet AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Gold Magnet',
        'Gold Magnets collect coins and diamonds for you, and are an upgrade of Magnet-shroom.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 5-1 / $3000',
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
    is_single_use
)
SELECT
    entry_id,
    50,
    'VERY_SLOW',
    NULL,
    'Area around',
    NULL,
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM gold_magnet;

WITH spikerock AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Spikerock',
        'Spikerocks pop multiple tires and damage zombies that walk over it, and are an upgrade of' ||
            'Spikeweed.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Level 5-1 / $7500',
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
    is_single_use
)
SELECT
    entry_id,
    125,
    'VERY_SLOW',
    'HIGH',
    NULL,
    'Ground tile',
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM spikerock;

WITH cob_cannon AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Cob Cannon',
        'Click on the Cob Cannon to launch deadly cobs of corn. An upgrade for two Kernel-pults.',
        'TBD',
        'NORMAL',
        'Unlocked: Beat Adventure Mode / $20,000',
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
    is_single_use
)
SELECT
    entry_id,
    500,
    'VERY_SLOW',
    'EXTREMELY_HIGH',
    'Lobbed (click to target)',
    'Single tile',
    NULL,
    FALSE,
    FALSE,
    FALSE,
    FALSE
FROM cob_cannon;

WITH zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Zombie',
        'A normal zombie.',
        'TBD',
        'LOW',
        'First seen: Level 1-1',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM zombie;

WITH flag_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Flag Zombie',
        'Moves slightly faster and signals a huge wave incoming.',
        'TBD',
        'LOW',
        'First seen: Level 1-2',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM flag_zombie;

WITH conehead_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Conehead Zombie',
        'Headwear zombie uses a traffic cone to protect itself.',
        'TBD',
        'NORMAL',
        'First seen: Level 1-3',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM conehead_zombie;

WITH pole_vaulting_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Pole Vaulting Zombie',
        'Vaulting zombie, single jump, jumps over the first plant it encounters with a pole.',
        'TBD',
        'NORMAL',
        'First seen: Level 1-6',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM pole_vaulting_zombie;

WITH buckethead_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Buckethead Zombie',
        'Headwear zombie has a bucket that is extremely resistant to damage.',
        'TBD',
        'HIGH',
        'First seen: Level 1-8',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM buckethead_zombie;

WITH newspaper_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Newspaper Zombie',
        'Shield zombie, moves slowly at first, moves twice as fast after newspaper is destroyed.',
        'TBD',
        'NORMAL',
        'First seen: Level 2-1',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM newspaper_zombie;

WITH screen_door_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Screen Door Zombie',
        'Shield zombie, not affected by Snow Peas unless screen door is removed.',
        'TBD',
        'HIGH',
        'First seen: Level 2-3',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM screen_door_zombie;

WITH football_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Football Zombie',
        'Headwear zombie, very durable, moves fast. Helmet can be removed by Magnet-shroom.',
        'TBD',
        'HIGH',
        'First seen: Level 2-6',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM football_zombie;

WITH dancing_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Dancing Zombie',
        'Dances as it walks, summons Backup Dancers.',
        'TBD',
        'NORMAL',
        'First seen: Level 2-8',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM dancing_zombie;

WITH backup_dancer AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Backup Dancer',
        'Dances as it walks in groups of four. Can be re-summoned if lead Dancing Zombie not killed.',
        'TBD',
        'LOW',
        'First seen: N/A',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'SLOW'
FROM backup_dancer;

WITH ducky_tube_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Ducky Tube Zombie',
        'Only appears in the Pool. Has various helmet variants.',
        'TBD',
        'NORMAL',
        'First seen: Level 3-1',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM ducky_tube_zombie;

WITH snorkel_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Snorkel Zombie',
        'Invulnerable to most plants while underwater. Only resurfaces to eat plants.',
        'TBD',
        'LOW',
        'First seen: Level 3-3',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM snorkel_zombie;

WITH zomboni AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Zomboni',
        'Rides a Zamboni which crushes plants, leaving an ice trail behind.',
        'TBD',
        'HIGH',
        'First seen: Level 3-6',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM zomboni;

WITH zombie_bobsled_team AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Zombie Bobsled Team',
        'Only appears on an ice trail left by a Zomboni. Appears in groups of four.',
        'TBD',
        'HIGH',
        'First seen: N/A',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM zombie_bobsled_team;

WITH dolphin_rider_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Dolphin Rider Zombie',
        'Vaulting zombie, single jump. Much faster while riding dolphin.',
        'TBD',
        'NORMAL',
        'First seen: Level 3-8',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM dolphin_rider_zombie;

WITH jackinthebox_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Jack-in-the-Box Zombie',
        'Carries an exploding jack-in-the-box, moves twice as fast as normal zombies.',
        'TBD',
        'NORMAL',
        'First seen: Level 4-1',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM jackinthebox_zombie;

WITH balloon_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Balloon Zombie',
        'Floats over the ground. Protected from ground attacks. Can be blown away by Blovers.',
        'TBD',
        'LOW',
        'First seen: Level 4-3',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM balloon_zombie;

WITH digger_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Digger Zombie',
        'Digs through ground and appears on left side, eats through defenses from left.',
        'TBD',
        'NORMAL',
        'First seen: Level 4-6',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM digger_zombie;

WITH pogo_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Pogo Zombie',
        'Vaulting zombie, makes multiple jumps. Pogo stick can be stolen by Magnet-shroom.',
        'TBD',
        'NORMAL',
        'First seen: Level 4-8',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM pogo_zombie;

WITH zombie_yeti AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Zombie Yeti',
        'Runs away if not killed, drops diamonds if killed.',
        'TBD',
        'HIGH',
        'First seen: Level 4-10 (after 2nd playthrough)',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'SLOW'
FROM zombie_yeti;

WITH bungee_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Bungee Zombie',
        'Steals a plant at random positions or drops zombies in final wave.',
        'TBD',
        'NORMAL',
        'First seen: Level 5-1',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM bungee_zombie;

WITH ladder_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Ladder Zombie',
        'Shield zombie, attaches ladder to defensive plants to let others go over.',
        'TBD',
        'HIGH',
        'First seen: Level 5-3',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM ladder_zombie;

WITH catapult_zombie AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Catapult Zombie',
        'Attacks last attackable plant in row until out of basketballs or plants.',
        'TBD',
        'NORMAL',
        'First seen: Level 5-6',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'FAST'
FROM catapult_zombie;

WITH gargantuar AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Gargantuar',
        'Takes two instant kills. Crushes plants instead of eating. Throws Imps when damaged.',
        'TBD',
        'VERY_HIGH',
        'First seen: Level 5-8',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM gargantuar;

WITH imp AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Imp',
        'Thrown by Gargantuars deep into defenses after losing half health.',
        'TBD',
        'LOW',
        'First seen: N/A',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM imp;

WITH dr_zomboss AS (
    INSERT INTO entries (name, description, history, toughness, special, entry_type)
    VALUES (
        'Dr. Zomboss',
        'Final boss, has increased health in Dr. Zomboss''s Revenge.',
        'TBD',
        'EXTREMELY_HIGH',
        'First seen: Level 5-10',
        'ZOMBIE'
    )
    RETURNING entry_id
)
INSERT INTO zombies (entry_id, speed)
SELECT entry_id, 'NORMAL'
FROM dr_zomboss;


UPDATE plants SET prerequisite_plant_id = (SELECT entry_id FROM entries WHERE name = 'Repeater') WHERE entry_id = (SELECT entry_id FROM entries WHERE name = 'Gatling Pea');
UPDATE plants SET prerequisite_plant_id = (SELECT entry_id FROM entries WHERE name = 'Sunflower') WHERE entry_id = (SELECT entry_id FROM entries WHERE name = 'Twin Sunflower');
UPDATE plants SET prerequisite_plant_id = (SELECT entry_id FROM entries WHERE name = 'Fume-shroom') WHERE entry_id = (SELECT entry_id FROM entries WHERE name = 'Gloom-shroom');
UPDATE plants SET prerequisite_plant_id = (SELECT entry_id FROM entries WHERE name = 'Lily Pad') WHERE entry_id = (SELECT entry_id FROM entries WHERE name = 'Cattail');
UPDATE plants SET prerequisite_plant_id = (SELECT entry_id FROM entries WHERE name = 'Melon-pult') WHERE entry_id = (SELECT entry_id FROM entries WHERE name = 'Winter Melon');
UPDATE plants SET prerequisite_plant_id = (SELECT entry_id FROM entries WHERE name = 'Magnet-shroom') WHERE entry_id = (SELECT entry_id FROM entries WHERE name = 'Gold Magnet');
UPDATE plants SET prerequisite_plant_id = (SELECT entry_id FROM entries WHERE name = 'Spikeweed') WHERE entry_id = (SELECT entry_id FROM entries WHERE name = 'Spikerock');
UPDATE plants SET prerequisite_plant_id = (SELECT entry_id FROM entries WHERE name = 'Kernel-pult') WHERE entry_id = (SELECT entry_id FROM entries WHERE name = 'Cob Cannon');

INSERT INTO zombies_weaknesses (zombie_id, weakness_plant_id) VALUES
    ((SELECT entry_id FROM entries WHERE name = 'Football Zombie'), (SELECT entry_id FROM entries WHERE name = 'Magnet-shroom')),
    ((SELECT entry_id FROM entries WHERE name = 'Balloon Zombie'), (SELECT entry_id FROM entries WHERE name = 'Blover')),
    ((SELECT entry_id FROM entries WHERE name = 'Pogo Zombie'), (SELECT entry_id FROM entries WHERE name = 'Magnet-shroom'));
