package timetweak.backend.People.Student;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import timetweak.backend.Appointment.Appointment;
import timetweak.backend.Course.Course;

@RestController
@RequestMapping("/student")
public class StudentController {

    private final StudentService studentService;

    @Autowired
    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping("/reg/{regNo}")
    public Student getStudent(@PathVariable("regNo") String regNo) {
        return studentService.getStudentByRegNo(regNo);
    }

    @GetMapping("/reg/{regNo}/courses/all")
    public List<Course> getAllCourses(@PathVariable("regNo") String regNo) {
        return studentService.getAllCourses(regNo);
    }

    @PostMapping("/add")
    public void addStudent(@RequestBody Student student) {
        studentService.addStudent(student);
    }

    @DeleteMapping("/reg/{regNo}/remove")
    public void removeStudent(@PathVariable("regNo") String regNo) {
        studentService.removeStudentByRegNo(regNo);
    }

    @PostMapping("/reg/{regNo}/course/add/{courseId}")
    public void addStudentToReg(@PathVariable("regNo") String regNo, @PathVariable("courseId") String courseId) {
        studentService.addCourseToStudent(regNo,courseId);
    }

    @DeleteMapping("/reg/{regNo}/course/remove/{courseId}")
    public void removeStudentFromReg(@PathVariable("regNo") String regNo, @PathVariable("courseId") String courseId) {
        studentService.removeCourseFromStudent(regNo,courseId);
    }

    @GetMapping("/reg/{regNo}/appointments/all")
    public List<Appointment> getAllAppointments(@PathVariable("regNo") String regNo) {
        return studentService.getAllAppointments(regNo);
    }

    @GetMapping("/reg/{regNo}/appointment/{appId}")
    public Appointment getAppointment(@PathVariable("regNo") String regNo, @PathVariable("appId") String appId) {
        return studentService.getAppointment(regNo,appId);
    }

    @PutMapping("/reg/{regNo}/appointment/{appId}/update-reason")
    public void changeAppointmentReason(@PathVariable("regNo") String regNo,@PathVariable("appId") String appId, @RequestBody String reason) {
        studentService.changeAppointmentReason(regNo,appId,reason);
    }

    @PutMapping("/reg/{regNo}/update/username")
    public void changeUsername(@PathVariable("regNo") String regNo,@RequestBody String username) {
        studentService.updateUsername(regNo,username);
    }

    @PutMapping("/reg/{regNo}/update/password")
    public void changePassword(@PathVariable("regNo") String regNo,@RequestBody String password) {
        studentService.updatePassword(regNo,password);
    }













}
