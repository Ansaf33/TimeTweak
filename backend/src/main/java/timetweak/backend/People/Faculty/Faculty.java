package timetweak.backend.People.Faculty;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrimaryKeyJoinColumn;
import timetweak.backend.Appointment.Appointment;
import timetweak.backend.Course.Course;
import timetweak.backend.People.People;
import timetweak.backend.People.roleType;
import timetweak.backend.Reschedule.Reschedule;

@Entity
@PrimaryKeyJoinColumn(name="id")
public class Faculty extends People {
    private String facultyId;

    @OneToMany(
            mappedBy = "faculty",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @JsonManagedReference
    private List<Course> courseList = new ArrayList<>();

    @OneToMany(
            mappedBy = "recipient",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    private List<Appointment>appointmentList = new ArrayList<>();

    @OneToMany(
            mappedBy = "faculty"
    )
    private List<Reschedule>rescheduleList = new ArrayList<>();

    public Faculty() {}

    public Faculty(String username, String password, String facultyId) {
        super(username, password, roleType.FACULTY);
        this.facultyId = facultyId;
    }

    public void addAppointment(Appointment appointment) {
        appointmentList.add(appointment);
    }

    public List<Appointment> getAppointmentList() {
        return appointmentList;
    }

    public String getFacultyId() {
        return facultyId;
    }

    public void setFacultyId(String facultyId) {
        this.facultyId = facultyId;
    }

    public void addCourse(Course course) {
        courseList.add(course);
    }

    public List<Course> getCourseList() {
        return courseList;
    }

    public void addReschedule(Reschedule reschedule) {
        rescheduleList.add(reschedule);
    }

    public List<Reschedule> getRescheduleList() {
        return rescheduleList;
    }

    public void setRescheduleList(List<Reschedule> rescheduleList) {
        this.rescheduleList = rescheduleList;
    }

    public void setAppointmentList(List<Appointment> appointmentList) {
        this.appointmentList = appointmentList;
    }

    public void setCourseList(List<Course> courseList) {
        this.courseList = courseList;
    }
}
