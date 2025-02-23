package timetweak.backend.People.Faculty;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import org.hibernate.annotations.Proxy;
import timetweak.backend.Course.Course;
import timetweak.backend.People.People;
import timetweak.backend.People.roleType;

import java.util.ArrayList;
import java.util.List;

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

    public Faculty() {}

    public Faculty(String username, String password, String facultyId) {
        super(username, password, roleType.FACULTY);
        this.facultyId = facultyId;
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

}
