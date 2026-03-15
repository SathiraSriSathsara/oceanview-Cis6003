package com.icbt.model;

import java.time.LocalDate;

import junit.framework.TestCase;

public class BillTest extends TestCase {

    public void testSettersAndGettersShouldRoundTripAllFields() {
        Bill bill = new Bill();

        LocalDate checkIn = LocalDate.of(2026, 3, 10);
        LocalDate checkOut = LocalDate.of(2026, 3, 12);
        LocalDate billDate = LocalDate.of(2026, 3, 15);

        bill.setBillId(10);
        bill.setReservationNo("RES-100");
        bill.setGuestName("Alice");
        bill.setRoomType("Deluxe");
        bill.setCheckIn(checkIn);
        bill.setCheckOut(checkOut);
        bill.setNumberOfNights(2L);
        bill.setPricePerNight(150.0);
        bill.setTotalAmount(300.0);
        bill.setBillDate(billDate);
        bill.setPaymentStatus("PAID");

        assertEquals(10, bill.getBillId());
        assertEquals("RES-100", bill.getReservationNo());
        assertEquals("Alice", bill.getGuestName());
        assertEquals("Deluxe", bill.getRoomType());
        assertEquals(checkIn, bill.getCheckIn());
        assertEquals(checkOut, bill.getCheckOut());
        assertEquals(2L, bill.getNumberOfNights());
        assertEquals(150.0, bill.getPricePerNight(), 0.0);
        assertEquals(300.0, bill.getTotalAmount(), 0.0);
        assertEquals(billDate, bill.getBillDate());
        assertEquals("PAID", bill.getPaymentStatus());
    }
}
