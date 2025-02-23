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

    // get student by regNo
    public Student getStudentByRegNo(String regNo) {
        return studentRepository.findByRegNo(regNo);
    }

    // add student to database
    public void addStudent(Student student) {
        Student existingStudent = studentRepository.findByRegNo(student.getRegNo());
        if (existingStudent != null) {
            throw new IllegalArgumentException("Student already exists");
        }
        studentRepository.save(student);
    }

    // add course to student
    public void addCourseToStudent(String regNo,String courseId) {
        Student student = getStudentByRegNo(regNo);
        Course course = courseRepository.findByCourseId(courseId);

        if (student.getEnrolledCourses().contains(course)){
            throw new RuntimeException("Student already enrolled in course");
        }
        student.addCourse(course);
        studentRepository.save(student);

    }

}
