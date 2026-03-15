package com.icbt.model;

import junit.framework.TestCase;

public class UserTest extends TestCase {

    public void testConstructorWithAllFieldsShouldInitializeValues() {
        User user = new User(7, "admin", "secret", "MANAGER");

        assertEquals(7, user.getId());
        assertEquals("admin", user.getUsername());
        assertEquals("secret", user.getPassword());
        assertEquals("MANAGER", user.getRole());
    }

    public void testConstructorWithoutIdShouldInitializeValues() {
        User user = new User("staff", "pwd", "RECEPTION");

        assertEquals(0, user.getId());
        assertEquals("staff", user.getUsername());
        assertEquals("pwd", user.getPassword());
        assertEquals("RECEPTION", user.getRole());
    }

    public void testSettersShouldUpdateValues() {
        User user = new User();

        user.setId(10);
        user.setUsername("cashier");
        user.setPassword("pw123");
        user.setRole("CASHIER");

        assertEquals(10, user.getId());
        assertEquals("cashier", user.getUsername());
        assertEquals("pw123", user.getPassword());
        assertEquals("CASHIER", user.getRole());
    }
}
