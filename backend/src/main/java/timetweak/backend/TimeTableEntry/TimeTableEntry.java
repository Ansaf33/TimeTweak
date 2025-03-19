package timetweak.backend.TimeTableEntry;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import timetweak.backend.Components.slotName;
import timetweak.backend.Course.Course;
import timetweak.backend.People.Student.batch;
import timetweak.backend.People.Student.branch;
import timetweak.backend.Slot.Slot;

import java.time.LocalDate;

@Entity
@Table
public class TimeTableEntry {
    @Id
    @SequenceGenerator(
            name = "TimeTableEntry_sequence",
            sequenceName = "TimeTableEntry_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.AUTO,
            generator = "TimeTableEntry_sequence"
    )
    private Long id;


    @ManyToOne
    @JoinColumn(
            name = "slot_id"
    )
    @JsonIgnore
    private Slot slot;
    private slotName slotIdentifier;

    @ManyToOne
    @JoinColumn(
            name = "course_id"
    )
    @JsonIgnore
    private Course course;
    private String courseIdentifier;

    private LocalDate date;
    private boolean active;
    private typeOfEntry type;
    private branch branch;
    private batch batch;


    public TimeTableEntry() {}

    public TimeTableEntry(branch branch,batch batch, LocalDate date, slotName slotIdentifier, String courseIdentifier, typeOfEntry type,boolean active) {
        this.batch = batch;
        this.branch = branch;
        this.date = date;
        this.slotIdentifier = slotIdentifier;
        this.courseIdentifier = courseIdentifier;
        this.type = type;
        this.active = active;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public typeOfEntry getType() {
        return type;
    }

    public void setType(typeOfEntry type) {
        this.type = type;
    }

    public slotName getSlotIdentifier() {
        return slotIdentifier;
    }

    public void setSlotIdentifier(slotName slotIdentifier) {
        this.slotIdentifier = slotIdentifier;
    }

    public String getCourseIdentifier() {
        return courseIdentifier;
    }

    public void setCourseIdentifier(String courseIdentifier) {
        this.courseIdentifier = courseIdentifier;
    }

    public Slot getSlot() {
        return slot;
    }

    public void setSlot(Slot slot) {
        this.slot = slot;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public branch getBranch() {
        return branch;
    }

    public void setBranch(branch branch) {
        this.branch = branch;
    }

    public batch getBatch() {
        return batch;
    }

    public void setBatch(batch batch) {
        this.batch = batch;
    }
}
