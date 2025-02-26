package timetweak.backend.People.ClassRep;

import jakarta.persistence.Entity;
import jakarta.persistence.PrimaryKeyJoinColumn;
import timetweak.backend.People.People;
import timetweak.backend.People.Student.Student;
import timetweak.backend.People.roleType;

@Entity
@PrimaryKeyJoinColumn(name = "id")
public class ClassRep extends Student {

    private String course;

    public ClassRep() {}

    public ClassRep(String username, String password, roleType role, String regNo, String batch, String branch, String course) {
        super(username, password, role, regNo, batch, branch);
        this.course = course;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

}
