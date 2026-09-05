package io.shnflrsc.brains.model;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ModelMappingTest {

    @Test
    void testEntryBuilderAndGetters() {
        Entry entry = Entry.builder()
                .id(1L)
                .name("Peashooter")
                .description("Shoots peas")
                .history("Hard work")
                .toughness(Stat.NORMAL)
                .entryType(EntryType.PLANT)
                .special("Direct fire")
                .build();

        assertEquals(1L, entry.getId());
        assertEquals("Peashooter", entry.getName());
        assertEquals("Shoots peas", entry.getDescription());
        assertEquals("Hard work", entry.getHistory());
        assertEquals(Stat.NORMAL, entry.getToughness());
        assertEquals(EntryType.PLANT, entry.getEntryType());
        assertEquals("Direct fire", entry.getSpecial());
        assertNull(entry.getPlant());
        assertNull(entry.getZombie());
    }

    @Test
    void testPlantRelationshipWithEntry() {
        Entry entry = Entry.builder()
                .id(1L)
                .name("Peashooter")
                .description("Shoots peas")
                .history("Pea origin")
                .toughness(Stat.NORMAL)
                .entryType(EntryType.PLANT)
                .build();

        Plant plant = Plant.builder()
                .id(1L)
                .sunCost((short) 100)
                .recharge(Speed.FAST)
                .damage(Stat.NORMAL)
                .range("Straight")
                .isNocturnal(false)
                .isAquatic(false)
                .isInstantUse(false)
                .isSingleUse(false)
                .build();

        entry.setPlant(plant);

        assertSame(plant, entry.getPlant());
        assertSame(entry, plant.getEntry());

        // Verify toString does not cause StackOverflowError
        assertDoesNotThrow(entry::toString);
        assertDoesNotThrow(plant::toString);
    }

    @Test
    void testZombieRelationshipWithEntry() {
        Entry entry = Entry.builder()
                .id(2L)
                .name("Basic Zombie")
                .description("Loves brains")
                .history("Regular zombie")
                .toughness(Stat.LOW)
                .entryType(EntryType.ZOMBIE)
                .build();

        Zombie zombie = Zombie.builder()
                .id(2L)
                .speed(Speed.NORMAL)
                .build();

        entry.setZombie(zombie);

        assertSame(zombie, entry.getZombie());
        assertSame(entry, zombie.getEntry());

        // Verify toString does not cause StackOverflowError
        assertDoesNotThrow(entry::toString);
        assertDoesNotThrow(zombie::toString);
    }

    @Test
    void testPlantPrerequisites() {
        Plant repeater = Plant.builder()
                .id(10L)
                .sunCost((short) 200)
                .recharge(Speed.FAST)
                .build();

        Plant gatlingPea = Plant.builder()
                .id(11L)
                .sunCost((short) 250)
                .recharge(Speed.VERY_SLOW)
                .build();

        repeater.addUnlockedPlant(gatlingPea);

        assertTrue(repeater.getUnlockedPlants().contains(gatlingPea));
        assertSame(repeater, gatlingPea.getPrerequisite());

        repeater.removeUnlockedPlant(gatlingPea);
        assertFalse(repeater.getUnlockedPlants().contains(gatlingPea));
        assertNull(gatlingPea.getPrerequisite());
    }

    @Test
    void testZombieWeaknessesManyToMany() {
        Zombie buckethead = Zombie.builder()
                .id(20L)
                .speed(Speed.NORMAL)
                .build();

        Plant magnetShroom = Plant.builder()
                .id(30L)
                .sunCost((short) 100)
                .recharge(Speed.SLOW)
                .build();

        buckethead.addWeakness(magnetShroom);

        assertTrue(buckethead.getWeaknesses().contains(magnetShroom));
        assertTrue(magnetShroom.getEffectiveAgainst().contains(buckethead));

        buckethead.removeWeakness(magnetShroom);
        assertFalse(buckethead.getWeaknesses().contains(magnetShroom));
        assertFalse(magnetShroom.getEffectiveAgainst().contains(buckethead));
    }

    @Test
    void testEqualsAndHashCodeOnlyIncludeId() {
        Entry entry1 = Entry.builder().id(1L).name("Name 1").build();
        Entry entry2 = Entry.builder().id(1L).name("Name 2").build();
        Entry entry3 = Entry.builder().id(2L).name("Name 1").build();

        assertEquals(entry1, entry2);
        assertEquals(entry1.hashCode(), entry2.hashCode());
        assertNotEquals(entry1, entry3);

        Plant plant1 = Plant.builder().id(1L).sunCost((short) 50).build();
        Plant plant2 = Plant.builder().id(1L).sunCost((short) 100).build();
        Plant plant3 = Plant.builder().id(2L).sunCost((short) 50).build();

        assertEquals(plant1, plant2);
        assertEquals(plant1.hashCode(), plant2.hashCode());
        assertNotEquals(plant1, plant3);

        Zombie zombie1 = Zombie.builder().id(1L).speed(Speed.SLOW).build();
        Zombie zombie2 = Zombie.builder().id(1L).speed(Speed.FAST).build();
        Zombie zombie3 = Zombie.builder().id(2L).speed(Speed.SLOW).build();

        assertEquals(zombie1, zombie2);
        assertEquals(zombie1.hashCode(), zombie2.hashCode());
        assertNotEquals(zombie1, zombie3);
    }
}
