package timetweak.backend.Course;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import timetweak.backend.People.Faculty.Faculty;
import timetweak.backend.People.Student.Student;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Course {
    @Id
    @SequenceGenerator(
            name="Course_sequence",
            sequenceName = "Course_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            generator = "Course_sequence",
            strategy = GenerationType.SEQUENCE
    )
    private Long id;

    private String courseId;
    private String title;
    private String description;

    @ManyToOne
    @JoinColumn(name = "faculty_id")
    @JsonBackReference
    private Faculty faculty;

    @ManyToMany(
            mappedBy = "enrolledCourses"
    )

    @JsonIgnore
    private List<Student> enrolledStudents = new ArrayList<>();

    public Course() {}

    public Course(String courseId, String title, String description, Faculty faculty) {
        this.courseId = courseId;
        this.title = title;
        this.description = description;
        this.faculty = faculty;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Student> getEnrolledStudents() {
        return enrolledStudents;
    }

    public void setEnrolledStudents(List<Student> enrolledStudents) {
        this.enrolledStudents = enrolledStudents;
    }

    public void addStudent(Student student) {
        enrolledStudents.add(student);
    }

    public void removeStudent(Student student) {
        enrolledStudents.remove(student);
    }

    public Faculty getFaculty() {
        return faculty;
    }

    public void setFaculty(Faculty faculty) {
        this.faculty = faculty;
    }


}
