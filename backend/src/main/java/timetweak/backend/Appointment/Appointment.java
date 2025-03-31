package timetweak.backend.Appointment;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import timetweak.backend.Components.slotName;
import timetweak.backend.People.Faculty.Faculty;
import timetweak.backend.People.Student.Student;

@Entity
@Table
public class Appointment {
    @Id
    @SequenceGenerator(
            sequenceName = "Appointment_sequence",
            name = "Appointment_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.AUTO,
            generator = "Appointment_sequence"
    )
    private Long id;

    public Long getId() {
        return id;
    }

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(
            name = "student_id"
    )
    @JsonIgnore
    private Student client;
    private String clientIdentifier;


    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(
            name = "faculty_id"
    )
    @JsonIgnore
    private Faculty recipient;
    private String recipientIdentifier;

    private String appId;

    @Enumerated(EnumType.STRING)
    private appStatus status;

    private slotName slot;
    private LocalDate date;
    private String reason;

    public Appointment(appStatus status, slotName slot,String recipientIdentifier, String clientIdentifier, LocalDate date, String reason) {
        this.status = status;
        this.slot = slot;
        this.recipientIdentifier = recipientIdentifier;
        this.clientIdentifier = clientIdentifier;
        this.date = date;
        this.reason = reason;
    }

    public Appointment(){}

    public String getAppId() {
        return appId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getClientIdentifier() {
        return clientIdentifier;
    }

    public void setClientIdentifier(String clientId) {
        this.clientIdentifier = clientId;
    }

    public String getRecipientIdentifier() {
        return recipientIdentifier;
    }

    public void setRecipientIdentifier(String facultyId) {
        this.recipientIdentifier = facultyId;
    }

    public Student getClient() {
        return client;
    }

    public void setClient(Student client) {
        this.client = client;
    }

    public Faculty getRecipient() {
        return recipient;
    }

    public void setRecipient(Faculty recipient) {
        this.recipient = recipient;
    }

    public appStatus getStatus() {
        return status;
    }

    public void setStatus(appStatus status) {
        this.status = status;
    }

    public slotName getSlot() {
        return slot;
    }

    public void setSlot(slotName slot) {
        this.slot = slot;
    }

}
