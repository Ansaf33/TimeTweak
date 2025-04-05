package timetweak.backend.Course;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import timetweak.backend.TimeTableEntry.TimeTableEntry;

import java.util.List;

@Service
public class CourseService {


    private final CourseRepository courseRepository;
    @Autowired
    public CourseService(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    // add course to table
    public void addCourse(Course course) {
         courseRepository.save(course);
    }

    // returns all courses
    public List<Course> getAllCourses() {
        return (List<Course>) courseRepository.findAll();
    }

    // returns course by courseID
    public Course getCourseById(String courseId) {
        Course c = courseRepository.findByCourseId(courseId);
        if (c == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Course not found");
        }
        return c;
    }

    // returns TimeTableEntries for course with courseId
    public List<TimeTableEntry> getTimingsofCourse(String courseId) {
        Course c = courseRepository.findByCourseId(courseId);
        return c.getTimeTableEntries();
    }
}
