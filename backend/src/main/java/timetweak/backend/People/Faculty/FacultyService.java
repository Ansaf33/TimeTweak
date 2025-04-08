package timetweak.backend.People.Faculty;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import org.springframework.web.server.ResponseStatusException;
import timetweak.backend.Appointment.Appointment;
import timetweak.backend.Appointment.AppointmentRepository;
import timetweak.backend.Appointment.appStatus;
import timetweak.backend.Course.Course;
import timetweak.backend.Course.CourseRepository;
import timetweak.backend.Reschedule.Reschedule;
import timetweak.backend.Reschedule.RescheduleRepository;
import timetweak.backend.Reschedule.reqStatus;
import timetweak.backend.TimeTableEntry.TimeTableEntry;
import timetweak.backend.TimeTableEntry.TimeTableEntryRepository;
import timetweak.backend.TimeTableEntry.TimeTableEntryService;
import timetweak.backend.TimeTableEntry.typeOfEntry;

@Service
public class FacultyService {

    private final FacultyRepository facultyRepository;
    private final AppointmentRepository appointmentRepository;
    private final RescheduleRepository rescheduleRepository;
    private final CourseRepository courseRepository;

    private final TimeTableEntryRepository timeTableEntryRepository;
    private final TimeTableEntryService timeTableEntryService;

    @Autowired
    public FacultyService(FacultyRepository facultyRepository, AppointmentRepository appointmentRepository, RescheduleRepository rescheduleRepository, TimeTableEntryRepository timeTableEntryRepository, TimeTableEntryService timeTableEntryService,CourseRepository courseRepository) {
        this.facultyRepository = facultyRepository;
        this.appointmentRepository = appointmentRepository;
        this.rescheduleRepository = rescheduleRepository;
        this.timeTableEntryRepository = timeTableEntryRepository;
        this.timeTableEntryService = timeTableEntryService;
        this.courseRepository = courseRepository;
    }


    // returns faculty by facultyID
    public Faculty getFacultyById(String facultyId) {
        Faculty f = facultyRepository.findByFacultyId(facultyId);
        if (f == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Could not find faculty with id " + facultyId);
        }
        return f;
    }

    // adds faculty to database
    public void addFaculty(Faculty faculty) {
        Faculty existingFaculty = facultyRepository.findByFacultyId(faculty.getFacultyId());
        if (existingFaculty != null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Faculty with id " + faculty.getFacultyId() + " already exists");
        }
        facultyRepository.save(faculty);
    }

    // adds course to faculty
    public void addCourseToFaculty(String facultyId, String courseId) {
        Faculty faculty = getFacultyById(facultyId);
        Course course = courseRepository.findByCourseId(courseId);
        if(course == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Course with id " + courseId + " does not exist");
        }

        faculty.addCourse(course);
        course.setFaculty(faculty);
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
        Faculty f = getFacultyById(facultyId);

        Appointment a = appointmentRepository.findAppointmentByAppId(appId);
        if(a == null || !f.getAppointmentList().contains(a) ) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Appointment with id " + appId + " does not exist");
        }
        a.setStatus(newStatus);
        appointmentRepository.save(a);


    }

    // getting all appointments for the faculty with facultyId
    public List<Appointment> getAllAppointments(String facultyId) {
        Faculty f = getFacultyById(facultyId);
        return f.getAppointmentList();
    }

    // getting appointment with specific appointmentId for faculty with facultyId
    public Appointment getAppointment(String facultyId, String appointmentId) {
        Faculty f  = getFacultyById(facultyId);
        Appointment a = appointmentRepository.findAppointmentByAppId(appointmentId);
        if ( a == null || !f.getAppointmentList().contains(a)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Appointment with id " + appointmentId + " does not exist");
        }

        return a;
    }

    // updating status for rescheduling
    public Reschedule updateReschedule(String facultyId, String rescheduleId, reqStatus newStatus) {
        Faculty f = getFacultyById(facultyId);
        Reschedule r = rescheduleRepository.findRescheduleByRescheduleId(rescheduleId);
        if( r == null || !f.getRescheduleList().contains(r) ) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Reschedule with id " + rescheduleId + " does not exist");
        }
        r.setStatus(newStatus);

        // ------------------------ if request is approved by faculty, changes made on TimeTableEntry
        if( newStatus == reqStatus.APPROVED) {
            TimeTableEntry oldEntry = timeTableEntryRepository.findTimeTableEntryByDateAndSlot(
                    r.getOgDate(),
                    r.getOgSlot()
            );
            oldEntry.setActive(false);
            TimeTableEntry modifiedEntry = new TimeTableEntry(oldEntry.getBranch(),oldEntry.getBatch(),r.getNewDate(), r.getNewSlotIdentifier(), oldEntry.getCourseIdentifier(), typeOfEntry.MODIFIED,true);
            timeTableEntryService.addEntry(modifiedEntry);

        }
        rescheduleRepository.save(r);

        return r;

    }


    // updates username of faculty
    public void updateUsername(String facultyId, String username) {
        Faculty f = getFacultyById(facultyId);
        f.setUsername(username);
        facultyRepository.save(f);
    }

    // updates password of faculty
    public void updatePassword(String facultyId, String password) {
        Faculty f = getFacultyById(facultyId);
        f.setPassword(password);
        facultyRepository.save(f);
    }


    // removes course from faculty
    public void removeCourseFromFaculty(String facultyId, String courseId) {
        Faculty f = getFacultyById(facultyId);
        Course c = courseRepository.findByCourseId(courseId);
        if( !f.getCourseList().contains(c) ) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Course with id " + courseId + " does not exist in faculty " + facultyId);
        }
        f.removeCourse(c);
        facultyRepository.save(f);
    }
}
