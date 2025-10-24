package com.setec.entities.Booked;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity(name = "tbl_booked")
public class Booked {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    private String phoneNumber;
    private String email;
    private String date;
    private String time;
    private int person;

    // No-args constructor
    public Booked() {}

    // All-args constructor
    public Booked(Integer id, String name, String phoneNumber, String email, String date, String time, int person) {
        this.id = id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.date = date;
        this.time = time;
        this.person = person;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    public int getPerson() { return person; }
    public void setPerson(int person) { this.person = person; }
    
    @Override
    public String toString() {
        return "Booked [id=" + id + 
               ", name=" + name + 
               ", phoneNumber=" + phoneNumber + 
               ", email=" + email + 
               ", date=" + date + 
               ", time=" + time + 
               ", person=" + person + "]";
    }

}
