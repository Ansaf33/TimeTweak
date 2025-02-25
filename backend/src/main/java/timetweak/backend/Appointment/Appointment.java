package timetweak.backend.Appointment;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import timetweak.backend.People.Faculty.Faculty;
import timetweak.backend.People.Student.Student;

import java.time.LocalDateTime;

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

    @ManyToOne
    @JoinColumn(
            name = "student_id"
    )
    @JsonIgnore
    private Student client;
    private String clientIdentifier;


    @ManyToOne
    @JoinColumn(
            name = "faculty_id"
    )
    @JsonIgnore
    private Faculty recipient;
    private String recipientIdentifier;

    private appStatus status;
    private LocalDateTime startTime;
    private LocalDateTime endTime;

    public Appointment(appStatus status, LocalDateTime startTime, LocalDateTime endTime,String recipientIdentifier, String clientIdentifier) {
        this.status = status;
        this.startTime = startTime;
        this.endTime = endTime;
        this.recipientIdentifier = recipientIdentifier;
        this.clientIdentifier = clientIdentifier;
    }

    public Appointment(){}

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

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }


}
