package timetweak.backend.People.Student;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;
import timetweak.backend.Appointment.Appointment;
import timetweak.backend.Course.Course;
import timetweak.backend.People.PeopleService;

import java.util.List;

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


    @PostMapping("/add")
    public void addStudent(@RequestBody Student student) {
        studentService.addStudent(student);
    }

    @PostMapping("/reg/{regNo}/add/{courseId}")
    public void addStudentToReg(@PathVariable("regNo") String regNo, @PathVariable("courseId") String courseId) {
        studentService.addCourseToStudent(regNo,courseId);
    }

    @GetMapping("/reg/{regNo}/appointment/all")
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












}
