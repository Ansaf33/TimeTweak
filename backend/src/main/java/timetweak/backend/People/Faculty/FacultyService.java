package timetweak.backend.People.Faculty;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import timetweak.backend.Appointment.Appointment;
import timetweak.backend.Appointment.AppointmentRepository;
import timetweak.backend.Appointment.AppointmentService;
import timetweak.backend.Appointment.appStatus;
import timetweak.backend.Course.Course;
import timetweak.backend.People.Student.Student;

import java.util.List;
import java.util.Optional;

@Service
public class FacultyService {

    private final FacultyRepository facultyRepository;
    private final AppointmentRepository appointmentRepository;

    @Autowired
    public FacultyService(FacultyRepository facultyRepository, AppointmentRepository appointmentRepository) {
        this.facultyRepository = facultyRepository;
        this.appointmentRepository = appointmentRepository;
    }

    public Faculty getFacultyById(String facultyId) {
        Faculty f = facultyRepository.findByFacultyId(facultyId);
        return f;
    }

    public void addFaculty(Faculty faculty) {
        Faculty existingFaculty = facultyRepository.findByFacultyId(faculty.getFacultyId());
        if (existingFaculty != null) {
            throw new RuntimeException("Faculty with same ID already exists");
        }
        facultyRepository.save(faculty);
    }

    public List<Faculty> getAllFaculty() {
        return facultyRepository.findAll();
    }

    public List<Course> getCoursesByFaculty(String facultyId ) {
        Faculty f = facultyRepository.findByFacultyId(facultyId);
        return f.getCourseList();

    }

    public void updateAppointment(String facultyId,String appId, appStatus newStatus) {
        Faculty f = facultyRepository.findByFacultyId(facultyId);
        if( f == null ){
            throw new RuntimeException("Faculty with same ID does not exist");
        }

        Appointment a = appointmentRepository.findAppointmentByAppId(appId);
        if(a == null ) {
            throw new RuntimeException("Appointment with appId " + appId + " not found");
        }
        if( !f.getAppointmentList().contains(a) ){
            throw new RuntimeException("Appointment with appId " + appId + " not found in Faculty");
        }
        a.setStatus(newStatus);
        appointmentRepository.save(a);


    }

    public List<Appointment> getAllAppointments(String facultyId) {
        Faculty f = facultyRepository.findByFacultyId(facultyId);
        if( f == null ){
            throw new RuntimeException("Faculty with same ID does not exist");
        }
        return f.getAppointmentList();
    }

    public Appointment getAppointment(String facultyId, String appointmentId) {
        Faculty f  = getFacultyById(facultyId);
        if( f == null) {
            throw new RuntimeException("Faculty does not exist");
        }
        Appointment a = appointmentRepository.findAppointmentByAppId(appointmentId);
        if (a == null) {
            throw new RuntimeException("Appointment does not exist");
        }
        if( !f.getAppointmentList().contains(a)) {
            throw new RuntimeException("Appointment does not exist in faculty.");
        }
        return a;

    }
}
