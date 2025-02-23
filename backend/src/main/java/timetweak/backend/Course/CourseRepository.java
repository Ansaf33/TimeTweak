package timetweak.backend.Course;

import jakarta.persistence.GeneratedValue;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseRepository extends CrudRepository<Course, Long> {

    public Course findByCourseId(String courseId);

}
