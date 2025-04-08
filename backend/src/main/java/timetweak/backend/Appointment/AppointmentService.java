package timetweak.backend.Appointment;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import org.springframework.web.server.ResponseStatusException;
import timetweak.backend.People.Faculty.Faculty;
import timetweak.backend.People.Faculty.FacultyRepository;
import timetweak.backend.People.Faculty.FacultyService;
import timetweak.backend.People.Student.Student;
import timetweak.backend.People.Student.StudentRepository;
import timetweak.backend.People.Student.StudentService;

@Service
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;
    private final StudentService studentService;
    private final FacultyService facultyService;


    @Autowired
    public AppointmentService(AppointmentRepository appointmentRepository, StudentService studentService, FacultyService facultyService) {
        this.appointmentRepository = appointmentRepository;
        this.studentService = studentService;
        this.facultyService = facultyService;
    }

    // getting all appointments from relation
    public List<Appointment> getAllAppointments() {
        return appointmentRepository.findAll();
    }

    // getting appointments for a particular student with registration number 'regNo'
    public List<Appointment> getAppointmentsByStudent(String regNo) {
        Student s = studentService.getStudentByRegNo(regNo);
        return s.getAppointmentList();
    }

    // adding appointment to relation
    public void addAppointment(Appointment appointment) {
        Student s = studentService.getStudentByRegNo(appointment.getClientIdentifier());
        Faculty f = facultyService.getFacultyById(appointment.getRecipientIdentifier());

        // add appointment to student repository
        appointment.setClient(s);
        appointment.setClientName(s.getUsername());

        // add appointment to faculty repository
        appointment.setRecipient(f);
        appointment.setRecipientName(f.getUsername());

        // add appointment to appointment repository ( ... generate unique appointment ID )
        appointment.setAppId(UUID.randomUUID().toString());
        appointmentRepository.save(appointment);
    }

    // getting appointments for a particular faculty that student has set
    public List<Appointment> getAppointmentsByFaculty(String facultyId) {
        Faculty f = facultyService.getFacultyById(facultyId);
        if(f == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Faculty not found");
        }
        return f.getAppointmentList();
    }

    // removes appointment from database
    public void removeAppointment(String appId) {
        Appointment a = appointmentRepository.findAppointmentByAppId(appId);
        if(a == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Appointment not found");
        }
        appointmentRepository.delete(a);
    }

}
