package com.icbt.model;

import junit.framework.TestCase;

public class ReservationTest extends TestCase {

    public void testConstructorWithoutIdShouldInitializeFields() {
        Reservation reservation = new Reservation(
                "RES-001",
                "John Doe",
                "Colombo",
                "0771234567",
                "Suite",
                "2026-03-15",
                "2026-03-17"
        );

        assertEquals("RES-001", reservation.getReservationNo());
        assertEquals("John Doe", reservation.getGuestName());
        assertEquals("Colombo", reservation.getAddress());
        assertEquals("0771234567", reservation.getContact());
        assertEquals("Suite", reservation.getRoomType());
        assertEquals("2026-03-15", reservation.getCheckIn());
        assertEquals("2026-03-17", reservation.getCheckOut());
    }

    public void testSettersAndGettersShouldRoundTripValues() {
        Reservation reservation = new Reservation();

        reservation.setId(5);
        reservation.setReservationNo("RES-005");
        reservation.setGuestName("Jane Doe");
        reservation.setAddress("Galle");
        reservation.setContact("0710000000");
        reservation.setRoomType("Deluxe");
        reservation.setCheckIn("2026-04-01");
        reservation.setCheckOut("2026-04-02");

        assertEquals(5, reservation.getId());
        assertEquals("RES-005", reservation.getReservationNo());
        assertEquals("Jane Doe", reservation.getGuestName());
        assertEquals("Galle", reservation.getAddress());
        assertEquals("0710000000", reservation.getContact());
        assertEquals("Deluxe", reservation.getRoomType());
        assertEquals("2026-04-01", reservation.getCheckIn());
        assertEquals("2026-04-02", reservation.getCheckOut());
    }
}
