package timetweak.backend.People.ClassRep;

import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrimaryKeyJoinColumn;
import timetweak.backend.People.People;
import timetweak.backend.People.Student.Student;
import timetweak.backend.People.roleType;
import timetweak.backend.Reschedule.Reschedule;

import java.util.List;

@Entity
@PrimaryKeyJoinColumn(name = "id")
public class ClassRep extends Student {

    private String course;

    @OneToMany(
            mappedBy = "cr"
    )
    private List<Reschedule> requests;

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

    public void addRequest(Reschedule reschedule) {
        requests.add(reschedule);
    }

    public List<Reschedule> getRequests() {
        return requests;
    }

}
