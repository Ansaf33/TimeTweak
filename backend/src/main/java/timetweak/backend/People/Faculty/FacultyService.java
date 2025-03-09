package timetweak.backend.People.Faculty;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import timetweak.backend.Appointment.Appointment;
import timetweak.backend.Appointment.AppointmentRepository;
import timetweak.backend.Appointment.AppointmentService;
import timetweak.backend.Appointment.appStatus;
import timetweak.backend.Course.Course;
import timetweak.backend.People.Student.Student;
import timetweak.backend.Reschedule.Reschedule;
import timetweak.backend.Reschedule.RescheduleRepository;
import timetweak.backend.Reschedule.reqStatus;

import java.util.List;
import java.util.Optional;

@Service
public class FacultyService {

    private final FacultyRepository facultyRepository;
    private final AppointmentRepository appointmentRepository;
    private final RescheduleRepository rescheduleRepository;

    @Autowired
    public FacultyService(FacultyRepository facultyRepository, AppointmentRepository appointmentRepository, RescheduleRepository rescheduleRepository) {
        this.facultyRepository = facultyRepository;
        this.appointmentRepository = appointmentRepository;
        this.rescheduleRepository = rescheduleRepository;
    }


    // returns faculty by facultyID
    public Faculty getFacultyById(String facultyId) {
        Faculty f = facultyRepository.findByFacultyId(facultyId);
        return f;
    }

    // adds faculty to database
    public void addFaculty(Faculty faculty) {
        Faculty existingFaculty = facultyRepository.findByFacultyId(faculty.getFacultyId());
        if (existingFaculty != null) {
            throw new RuntimeException("Faculty with same ID already exists");
        }
        facultyRepository.save(faculty);
    }

    // returns all faculties
    public List<Faculty> getAllFaculty() {
        return facultyRepository.findAll();
    }

    // returns courses by a faculty with facultyId
    public List<Course> getCoursesByFaculty(String facultyId ) {
        Faculty f = facultyRepository.findByFacultyId(facultyId);
        return f.getCourseList();

    }

    // faculty with facultyId changes appointment with appId to newStatus
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

    // getting all appointments for the faculty with facultyId
    public List<Appointment> getAllAppointments(String facultyId) {
        Faculty f = facultyRepository.findByFacultyId(facultyId);
        if( f == null ){
            throw new RuntimeException("Faculty with same ID does not exist");
        }
        return f.getAppointmentList();
    }

    // getting appointment with specific appointmentId for faculty with facultyId
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

    // updating status for rescheduling
    public void updateReschedule(String facultyId, String rescheduleId, reqStatus newStatus) {
        Faculty f = getFacultyById(facultyId);
        if( f == null ){
            throw new RuntimeException("Faculty with same ID does not exist");
        }
        Reschedule r = rescheduleRepository.findRescheduleByRescheduleId(rescheduleId);
        if( r == null ) {
            throw new RuntimeException("Reschedule with rescheduleId " + rescheduleId + " not found");
        }
        if( !f.getRescheduleList().contains(r) ){
            throw new RuntimeException("Reschedule with rescheduleId " + rescheduleId + " not found in Faculty");
        }
        r.setStatus(newStatus);
        rescheduleRepository.save(r);
    }
}
