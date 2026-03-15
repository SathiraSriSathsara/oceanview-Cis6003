package com.icbt.service;

import java.lang.reflect.Field;

import com.icbt.dao.ReservationDAO;
import com.icbt.model.Reservation;

import junit.framework.TestCase;

public class ReservationServiceTest extends TestCase {

    public void testAddReservationShouldDelegateToDao() throws Exception {
        ReservationService service = new ReservationService();
        CapturingReservationDAO fakeDao = new CapturingReservationDAO();

        Field daoField = ReservationService.class.getDeclaredField("reservationDAO");
        daoField.setAccessible(true);
        daoField.set(service, fakeDao);

        Reservation reservation = new Reservation(
                "RES-777",
                "Unit Tester",
                "Kandy",
                "0712345678",
                "Suite",
                "2026-06-01",
                "2026-06-03"
        );

        service.addReservation(reservation);

        assertSame(reservation, fakeDao.savedReservation);
    }

    private static class CapturingReservationDAO extends ReservationDAO {
        private Reservation savedReservation;

        @Override
        public void saveReservation(Reservation reservation) {
            this.savedReservation = reservation;
        }
    }
}
