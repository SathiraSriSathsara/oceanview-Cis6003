package com.icbt.model;

import junit.framework.TestCase;

public class RoomTest extends TestCase {

    public void testConstructorWithTypeAndPriceShouldInitializeFields() {
        Room room = new Room("Deluxe", 125.0);

        assertNull(room.getRoomNo());
        assertEquals("Deluxe", room.getRoomType());
        assertEquals(125.0, room.getPricePerNight(), 0.0);
        assertNull(room.getStatus());
    }

    public void testFullConstructorShouldInitializeAllFields() {
        Room room = new Room("A101", "Suite", 250.0, "Available");

        assertEquals("A101", room.getRoomNo());
        assertEquals("Suite", room.getRoomType());
        assertEquals(250.0, room.getPricePerNight(), 0.0);
        assertEquals("Available", room.getStatus());
    }

    public void testSettersShouldUpdateValues() {
        Room room = new Room();

        room.setRoomNo("B202");
        room.setRoomType("Standard");
        room.setPricePerNight(80.0);
        room.setStatus("Occupied");

        assertEquals("B202", room.getRoomNo());
        assertEquals("Standard", room.getRoomType());
        assertEquals(80.0, room.getPricePerNight(), 0.0);
        assertEquals("Occupied", room.getStatus());
    }
}
