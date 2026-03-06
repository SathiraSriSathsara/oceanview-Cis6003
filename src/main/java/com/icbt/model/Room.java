package com.icbt.model;

public class Room {

    private String roomNo;
    private String roomType;
    private double pricePerNight;
    private String status;

    public Room() {}

    public Room(String roomType, double pricePerNight) {
        this.roomType = roomType;
        this.pricePerNight = pricePerNight;
    }

    public Room(String roomNo, String roomType, double pricePerNight, String status) {
        this.roomNo = roomNo;
        this.roomType = roomType;
        this.pricePerNight = pricePerNight;
        this.status = status;
    }

    public String getRoomNo() {
        return roomNo;
    }

    public String getRoomType() {
        return roomType;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public String getStatus() {
        return status;
    }

    public void setRoomNo(String roomNo) {
        this.roomNo = roomNo;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
