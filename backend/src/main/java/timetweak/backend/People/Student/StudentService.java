package timetweak.backend.People.Student;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import timetweak.backend.Appointment.Appointment;
import timetweak.backend.Appointment.AppointmentRepository;
import timetweak.backend.Appointment.AppointmentService;
import timetweak.backend.Course.Course;
import timetweak.backend.Course.CourseRepository;

import java.util.List;

@Service
public class StudentService {

    private final StudentRepository studentRepository;
    private final CourseRepository courseRepository;
    private final AppointmentRepository appointmentRepository;

    @Autowired
    public StudentService(StudentRepository studentRepository, CourseRepository courseRepository, AppointmentRepository appointmentRepository) {
        this.studentRepository = studentRepository;
        this.courseRepository = courseRepository;
        this.appointmentRepository = appointmentRepository;
    }

    // returns student with registration number 'regNo'
    public Student getStudentByRegNo(String regNo) {
        return studentRepository.findByRegNo(regNo);
    }

    // adds student to database
    public void addStudent(Student student) {
        Student existingStudent = studentRepository.findByRegNo(student.getRegNo());

        // if student already exists
        if (existingStudent != null) {
            throw new IllegalArgumentException("Student already exists");
        }
        studentRepository.save(student);
    }

    // enroll student to a course
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

    // returns all appointments made by student with regNo
    public List<Appointment> getAllAppointments(String regNo) {
        Student student = getStudentByRegNo(regNo);
        if( student == null) {
            throw new RuntimeException("Student does not exist");
        }
        return student.getAppointmentList();
    }

    // returns appointment made by student with 'regNo' by 'appId'
    public Appointment getAppointment(String regNo, String appointmentId) {
        Student student = getStudentByRegNo(regNo);
        if( student == null) {
            throw new RuntimeException("Student does not exist");
        }
        Appointment a = appointmentRepository.findAppointmentByAppId(appointmentId);
        if (a == null) {
            throw new RuntimeException("Appointment does not exist");
        }
        if( !student.getAppointmentList().contains(a)) {
            throw new RuntimeException("Appointment does not exist in student.");
        }
        return a;

    }

    // updating appointment reason
    public void changeAppointmentReason(String regNo,String appId,String reason) {
        Student student = getStudentByRegNo(regNo);
        if( student == null) {
            throw new RuntimeException("Student does not exist");
        }
        Appointment a = appointmentRepository.findAppointmentByAppId(appId);
        if (a == null) {
            throw new RuntimeException("Appointment does not exist");
        }
        if( !student.getAppointmentList().contains(a)) {
            throw new RuntimeException("Appointment does not exist in student.");
        }
        a.setReason(reason);
        appointmentRepository.save(a);


    }

    // remove student with regNo 'regNo'
    public void removeStudentByRegNo(String regNo) {
        Student student = getStudentByRegNo(regNo);
        if( student == null) {
            throw new RuntimeException("Student does not exist");
        }
        studentRepository.delete(student);
    }

    // returns a list of courses enrolled by the student
    public List<Course> getAllCourses(String regNo) {
        Student student = getStudentByRegNo(regNo);
        if( student == null) {
            throw new RuntimeException("Student does not exist");
        }
        return student.getEnrolledCourses();
    }
}
