package timetweak.backend.Course;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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


    public List<Course> getAllCourses() {
        return (List<Course>) courseRepository.findAll();
    }

    public Course getCourseById(String courseId) {
        return courseRepository.findByCourseId(courseId);

    }

    public List<TimeTableEntry> getTimingsofCourse(String courseId) {
        Course c = courseRepository.findByCourseId(courseId);
        return c.getTimeTableEntries();
    }
}
