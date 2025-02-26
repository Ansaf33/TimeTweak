package timetweak.backend.People.Student;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import org.hibernate.annotations.Proxy;
import timetweak.backend.Appointment.Appointment;
import timetweak.backend.Course.Course;
import timetweak.backend.People.People;
import timetweak.backend.People.roleType;

import java.util.ArrayList;
import java.util.List;

@Entity
@PrimaryKeyJoinColumn(name = "id")
public class Student extends People {

    private String regNo;
    private String batch;
    private String branch;

    @ManyToMany
    @JoinTable(
            name = "student_courses",
            joinColumns = @JoinColumn(name="student_id"),
            inverseJoinColumns = @JoinColumn(name="course_id")
    )
    private List<Course> enrolledCourses = new ArrayList<>();

    @OneToMany(
            mappedBy = "client",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    private List<Appointment>appointmentList = new ArrayList<>();


    public Student() {}

    public Student(String username, String password, roleType role, String regNo, String batch,String branch) {
        super(username, password, roleType.STUDENT);
        this.regNo = regNo;
        this.batch = batch;
        this.branch = branch;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public List<Appointment> getAppointmentList() {
        return appointmentList;
    }

    public void addAppointment(Appointment appointment) {
        appointmentList.add(appointment);
    }

    public String getRegNo() {
        return regNo;
    }

    public void setRegNo(String regNo) {
        this.regNo = regNo;
    }

    public String getBatch() {
        return batch;
    }

    public void setBatch(String batch) {
        this.batch = batch;
    }

    public void addCourse(Course course) {
        enrolledCourses.add(course);
    }

    public void removeCourse(Course course) {
        enrolledCourses.remove(course);
    }

    public List<Course> getEnrolledCourses() {
        return enrolledCourses;
    }

}
