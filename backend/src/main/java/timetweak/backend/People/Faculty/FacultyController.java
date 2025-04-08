package timetweak.backend.People.Faculty;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import timetweak.backend.Appointment.Appointment;
import timetweak.backend.Appointment.appStatus;
import timetweak.backend.Course.Course;
import timetweak.backend.Reschedule.reqStatus;

import java.util.List;

@RestController
@RequestMapping("/faculty")
public class FacultyController {

    private final FacultyService facultyService;

    @Autowired
    public FacultyController(FacultyService facultyService) {
        this.facultyService = facultyService;
    }

    @GetMapping("/id/{facultyId}")
    public Faculty getFaculty(@PathVariable("facultyId") String facultyId) {
        return facultyService.getFacultyById(facultyId);
    }

    @GetMapping("/all")
    public List<Faculty> getAllFaculties() {
        return facultyService.getAllFaculty();
    }

    @PostMapping("/add")
    public void addFaculty(@RequestBody Faculty faculty) {
        facultyService.addFaculty(faculty);
    }

    @GetMapping("/id/{facultyId}/courses")
    public List<Course> getCourses(@PathVariable("facultyId") String facultyId) {
        return facultyService.getCoursesByFaculty(facultyId);
    }

    @PostMapping("/id/{facultyId}/course/add/{courseId}")
    public void addCourse(@PathVariable("facultyId") String facultyId, @PathVariable("courseId") String courseId) {
        facultyService.addCourseToFaculty(facultyId,courseId);
    }

    @DeleteMapping("/id/{facultyId}/course/remove/{courseId}")
    public void removeCourse(@PathVariable("facultyId") String facultyId, @PathVariable("courseId") String courseId) {
        facultyService.removeCourseFromFaculty(facultyId,courseId);
    }

    @GetMapping("/id/{facultyId}/appointment/all")
    public List<Appointment> getAllAppointments(@PathVariable("facultyId") String facultyId) {
        return facultyService.getAllAppointments(facultyId);
    }

    @GetMapping("/id/{facultyId}/appointment/{appId}")
    public Appointment getAppointment(@PathVariable("facultyId") String facultyId,@PathVariable("appId") String appId) {
        return facultyService.getAppointment(facultyId, appId);
    }

    @PutMapping("/id/{facultyId}/appointment/{appId}/to/{newStatus}")
    public void updateAppointment(@PathVariable("facultyId") String facultyId,@PathVariable("appId") String appId, @PathVariable("newStatus") appStatus newStatus) {
        facultyService.updateAppointment(facultyId,appId,newStatus);
    }

    @PutMapping("/id/{facultyId}/reschedule/{rescheduleId}/to/{newStatus}")
    public void updateReschedule(@PathVariable("facultyId") String facultyId, @PathVariable("rescheduleId") String rescheduleId, @PathVariable("newStatus") reqStatus newStatus) {
        facultyService.updateReschedule(facultyId,rescheduleId,newStatus);
    }

    @PutMapping("/id/{facultyId}/update/username")
    public void updateUsername(@PathVariable("facultyId") String facultyId, @RequestBody String username) {
        facultyService.updateUsername(facultyId,username);
    }

    @PutMapping("/id/{facultyId}/update/password")
    public void updatePassword(@PathVariable("facultyId") String facultyId, @RequestBody String password) {
        facultyService.updatePassword(facultyId,password);
    }








}
