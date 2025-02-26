package timetweak.backend.TimeTableEntry;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import timetweak.backend.Components.slotName;
import timetweak.backend.Components.timing;
import timetweak.backend.Course.Course;
import timetweak.backend.Slot.Slot;

import java.time.DayOfWeek;
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


    public TimeTableEntry() {}

    public TimeTableEntry(LocalDate date, slotName slotIdentifier,String courseIdentifier) {
        this.date = date;

        this.slotIdentifier = slotIdentifier;
        this.courseIdentifier = courseIdentifier;
    }

    public TimeTableEntry(Slot slot, Course course, LocalDate date, timing startTime, timing endTime) {
        this.slot = slot;
        this.course = course;
        this.date = date;
    }

    public TimeTableEntry(slotName slotIdentifier, String courseIdentifier, LocalDate date) {
        this.slotIdentifier = slotIdentifier;
        this.courseIdentifier = courseIdentifier;
        this.date = date;
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

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
