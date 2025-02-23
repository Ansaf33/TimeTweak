package timetweak.backend.People.Student;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;
import timetweak.backend.People.PeopleService;

@RestController
@RequestMapping("/student")
public class StudentController {

    private final StudentService studentService;

    @Autowired
    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping("/reg={regNo}")
    public Student getStudent(@PathVariable("regNo") String regNo) {
        return studentService.getStudentByRegNo(regNo);
    }


    @PostMapping("/add")
    public void addStudent(@RequestBody Student student) {
        studentService.addStudent(student);
    }

    @GetMapping("/reg/{regNo}/add/courseId/{courseId}")
    public void addCourse(@PathVariable("regNo") String regNo, @PathVariable("courseId") String courseId) {
        studentService.addCourseToStudent(regNo, courseId);
    }



}
