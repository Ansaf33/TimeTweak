package timetweak.backend.Reschedule;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import timetweak.backend.Components.slotName;
import timetweak.backend.Course.Course;
import timetweak.backend.People.ClassRep.ClassRep;
import timetweak.backend.People.Faculty.Faculty;
import timetweak.backend.Slot.Slot;

import java.time.LocalDate;

@Entity
@Table
public class Reschedule {
    @Id
    @SequenceGenerator(
            name = "Reschedule_sequence",
            sequenceName = "Reschedule_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "Reschedule_sequence"
    )
    private long id;

    private String rescheduleId;
    private reqStatus status;

    private LocalDate ogDate;
    @ManyToOne
    @JoinColumn(
            name = "og_slot_id"
    )
    private Slot ogSlot;
    private slotName ogSlotIdentifier;

    private LocalDate newDate;

    @ManyToOne
    @JoinColumn(
            name = "new_slot_id"
    )
    private Slot newSlot;
    private slotName newSlotIdentifier;

    @ManyToOne
    @JoinColumn(
            name = "cr_id"
    )
    @JsonIgnore
    private ClassRep cr;

    @ManyToOne
    @JoinColumn(
            name = "faculty_id"
    )
    @JsonIgnore
    private Faculty faculty;

    private String facultyIdentifier;
    private String crIdentifier;

    private String courseIdentifier;

    private String reason;

    public Reschedule() {}

    public Reschedule(reqStatus status,LocalDate ogDate, slotName ogSlotIdentifier, LocalDate newDate, slotName newSlotIdentifier, String facultyIdentifier, String crIdentifier, String reason) {
        this.ogDate = ogDate;
        this.status = status;
        this.ogSlotIdentifier = ogSlotIdentifier;
        this.newDate = newDate;
        this.newSlotIdentifier = newSlotIdentifier;
        this.facultyIdentifier = facultyIdentifier;
        this.crIdentifier = crIdentifier;
        this.reason = reason;
    }

    public reqStatus getStatus() {
        return status;
    }

    public void setStatus(reqStatus status) {
        this.status = status;
    }

    public Faculty getFaculty() {
        return faculty;
    }

    public void setFaculty(Faculty faculty) {
        this.faculty = faculty;
    }

    public String getFacultyIdentifier() {
        return facultyIdentifier;
    }

    public void setFacultyIdentifier(String facultyIdentifier) {
        this.facultyIdentifier = facultyIdentifier;
    }

    public slotName getOgSlotIdentifier() {
        return ogSlotIdentifier;
    }

    public void setOgSlotIdentifier(slotName ogSlotIdentifier) {
        this.ogSlotIdentifier = ogSlotIdentifier;
    }

    public slotName getNewSlotIdentifier() {
        return newSlotIdentifier;
    }

    public void setNewSlotIdentifier(slotName newSlotIdentifier) {
        this.newSlotIdentifier = newSlotIdentifier;
    }

    public String getCrIdentifier() {
        return crIdentifier;
    }

    public void setCrIdentifier(String crIdentifier) {
        this.crIdentifier = crIdentifier;
    }

    public ClassRep getCr() {
        return cr;
    }

    public void setCr(ClassRep cr) {
        this.cr = cr;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getRescheduleId() {
        return rescheduleId;
    }

    public void setRescheduleId(String rescheduleId) {
        this.rescheduleId = rescheduleId;
    }

    public LocalDate getOgDate() {
        return ogDate;
    }

    public void setOgDate(LocalDate ogDate) {
        this.ogDate = ogDate;
    }

    public LocalDate getNewDate() {
        return newDate;
    }

    public void setNewDate(LocalDate newDate) {
        this.newDate = newDate;
    }

    public Slot getOgSlot() {
        return ogSlot;
    }

    public void setOgSlot(Slot ogSlot) {
        this.ogSlot = ogSlot;
    }

    public Slot getNewSlot() {
        return newSlot;
    }

    public void setNewSlot(Slot newSlot) {
        this.newSlot = newSlot;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getCourseIdentifier() {
        return courseIdentifier;
    }

    public void setCourseIdentifier(String courseIdentifier) {
        this.courseIdentifier = courseIdentifier;
    }
}
