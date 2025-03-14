package timetweak.backend.Appointment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.system.ApplicationPid;
import org.springframework.stereotype.Service;
import timetweak.backend.People.Faculty.Faculty;
import timetweak.backend.People.Faculty.FacultyRepository;
import timetweak.backend.People.Faculty.FacultyService;
import timetweak.backend.People.Student.Student;
import timetweak.backend.People.Student.StudentRepository;
import timetweak.backend.People.Student.StudentService;

import java.util.List;
import java.util.UUID;

@Service
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;
    private final StudentService studentService;
    private final FacultyService facultyService;
    private final StudentRepository studentRepository;
    private final FacultyRepository facultyRepository;

    @Autowired
    public AppointmentService(AppointmentRepository appointmentRepository, StudentService studentService, FacultyService facultyService, StudentRepository studentRepository, FacultyRepository facultyRepository) {
        this.appointmentRepository = appointmentRepository;
        this.studentService = studentService;
        this.facultyService = facultyService;
        this.studentRepository = studentRepository;
        this.facultyRepository = facultyRepository;
    }

    // getting all appointments from relation
    public List<Appointment> getAllAppointments() {
        return appointmentRepository.findAll();
    }

    // getting appointments for a particular student with registration number 'regNo'
    public List<Appointment> getAppointmentsByStudent(String regNo) {
        Student s = studentService.getStudentByRegNo(regNo);
        if(s == null) {
            throw new RuntimeException("Student not found");
        }
        return s.getAppointmentList();
    }

    // adding appointment to relation
    public void addAppointment(Appointment appointment) {
        Student s = studentRepository.findByRegNo(appointment.getClientIdentifier());
        if(s == null) {
            throw new RuntimeException("Student not found");
        }
        Faculty f = facultyRepository.findByFacultyId(appointment.getRecipientIdentifier());


        // add appointment to student repository
        appointment.setClient(s);

        // add appointment to faculty repository
        appointment.setRecipient(f);

        // add appointment to appointment repository ( ... generate unique appointment ID )
        appointment.setAppId(UUID.randomUUID().toString());
        appointmentRepository.save(appointment);
    }

    // getting appointments for a particular faculty that student has set
    public List<Appointment> getAppointmentsByFaculty(String facultyId) {
        Faculty f = facultyService.getFacultyById(facultyId);
        if(f == null) {
            throw new RuntimeException("Faculty not found");
        }
        return f.getAppointmentList();
    }

    // removes appointment from database
    public void removeAppointment(String appId) {
        Appointment a = appointmentRepository.findAppointmentByAppId(appId);
        if(a == null) {
            throw new RuntimeException("Appointment not found");
        }
        appointmentRepository.delete(a);
    }

}
