package timetweak.backend.People.ClassRep;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import timetweak.backend.People.Student.Student;
import timetweak.backend.People.Student.StudentRepository;
import timetweak.backend.People.Student.StudentService;

@RestController
@RequestMapping("/CR")
public class ClassRepController {

    private final ClassRepService classRepService;
    private final StudentService studentService;

    @Autowired
    public ClassRepController(ClassRepService classRepService, StudentRepository studentRepository, StudentService studentService) {
        this.classRepService = classRepService;
        this.studentService = studentService;
    }

    @GetMapping("/reg={regNo}")
    public Student getClassRep(@PathVariable("regNo") String regNo) {
        return classRepService.getStudentByRegNo("regNo");
    }

    @PostMapping("/add")
    public void addClassRep(@RequestBody ClassRep classRep) {
        classRepService.addClassRep(classRep);
    }


}
