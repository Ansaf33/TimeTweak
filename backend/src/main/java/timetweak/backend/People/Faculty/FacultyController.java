package timetweak.backend.People.Faculty;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import timetweak.backend.Course.Course;

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







}
