package timetweak.backend.Course;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import timetweak.backend.TimeTableEntry.TimeTableEntry;

import java.util.List;

@RestController
@RequestMapping("/course")
public class CourseController {

    private final CourseService courseService;

    @Autowired
    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @PostMapping("/add")
    public void addCourse(@RequestBody Course course) {
        courseService.addCourse(course);
    }

    @GetMapping("/all")
    public List<Course> getAllCourses() {
        return courseService.getAllCourses();
    }

    @GetMapping("/{courseId}")
    public Course getCourse(@PathVariable("courseId") String courseId) {
        return courseService.getCourseById(courseId);
    }

    @GetMapping("/{courseId}/timing")
    public List<TimeTableEntry> getTiming(@PathVariable("courseId") String courseId) {
        return courseService.getTimingsofCourse(courseId);
    }



}
