package timetweak.backend.People.Student;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import timetweak.backend.Course.Course;
import timetweak.backend.Course.CourseRepository;

@Service
public class StudentService {

    private final StudentRepository studentRepository;
    private final CourseRepository courseRepository;

    @Autowired
    public StudentService(StudentRepository studentRepository, CourseRepository courseRepository) {
        this.studentRepository = studentRepository;
        this.courseRepository = courseRepository;
    }

    // GET STUDENT BY REGISTRATION NUMBER
    public Student getStudentByRegNo(String regNo) {
        return studentRepository.findByRegNo(regNo);
    }

    // ADD STUDENT TO DATABASE
    public void addStudent(Student student) {
        Student existingStudent = studentRepository.findByRegNo(student.getRegNo());

        // if student already exists
        if (existingStudent != null) {
            throw new IllegalArgumentException("Student already exists");
        }
        studentRepository.save(student);
    }

    // ENROLL STUDENT IN A COURSE
    public void addCourseToStudent(String regNo,String courseId) {
        Student student = getStudentByRegNo(regNo);
        Course course = courseRepository.findByCourseId(courseId);

        // if student is already enrolled in course
        if (student.getEnrolledCourses().contains(course)){
            throw new RuntimeException("Student already enrolled in course");
        }

        // if course does not exist
        if( courseRepository.findByCourseId(course.getCourseId()) == null) {
            throw new RuntimeException("Course does not exist");
        }

        student.addCourse(course);
        studentRepository.save(student);

    }

}
