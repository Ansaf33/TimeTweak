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







}
