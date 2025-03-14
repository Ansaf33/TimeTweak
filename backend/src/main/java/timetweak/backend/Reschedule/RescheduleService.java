package timetweak.backend.Reschedule;

import org.springframework.stereotype.Service;
import timetweak.backend.People.ClassRep.ClassRep;
import timetweak.backend.People.ClassRep.ClassRepRepository;
import timetweak.backend.People.ClassRep.ClassRepService;
import timetweak.backend.People.Faculty.Faculty;
import timetweak.backend.People.Faculty.FacultyRepository;
import timetweak.backend.People.Faculty.FacultyService;
import timetweak.backend.People.Student.Student;
import timetweak.backend.Slot.Slot;
import timetweak.backend.Slot.SlotService;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import static java.util.UUID.randomUUID;

@Service
public class RescheduleService {

    private final RescheduleRepository rescheduleRepository;
    private final ClassRepService classRepService;
    private final ClassRepRepository classRepRepository;
    private final SlotService slotService;
    private final FacultyService facultyService;
    private final FacultyRepository facultyRepository;

    public RescheduleService(RescheduleRepository rescheduleRepository, ClassRepService classRepService, ClassRepRepository classRepRepository, SlotService slotService, FacultyService facultyService, FacultyRepository facultyRepository) {
        this.rescheduleRepository = rescheduleRepository;
        this.classRepService = classRepService;
        this.classRepRepository = classRepRepository;
        this.slotService = slotService;
        this.facultyService = facultyService;
        this.facultyRepository = facultyRepository;
    }

    // returning all reschedule requests
    public List<Reschedule> getAllRequests() {
        return rescheduleRepository.findAll();
    }

    // returns requests made by CR of ID 'ID'
    public List<Reschedule> getRequestsById(String id) {
        ClassRep cr = classRepService.getClassRepByRegNo(id);
        if( cr == null ){
            throw new RuntimeException("Student not found");
        }
        return cr.getRequests();
    }

    // adding a reschedule request
    public void add(Reschedule reschedule) {

        // set the slots
        Slot ogs = slotService.getSlot(reschedule.getOgSlotIdentifier());
        Slot ns = slotService.getSlot(reschedule.getNewSlotIdentifier());
        if( ogs == null || ns == null ){
            throw new RuntimeException("Slot not found");
        }
        reschedule.setOgSlot(ogs);
        reschedule.setNewSlot(ns);

        // set the faculty
        Faculty f = facultyService.getFacultyById(reschedule.getFacultyIdentifier());
        if( f == null ){
            throw new RuntimeException("Faculty not found");
        }
        reschedule.setFaculty(f);

        // set the class-rep
        ClassRep CR = classRepService.getClassRepByRegNo(reschedule.getCrIdentifier());
        if(CR == null) {
            throw new RuntimeException("Class-Rep not found");
        }
        reschedule.setCr(CR);


        // make changes in the rescheduling repository
        reschedule.setRescheduleId(randomUUID().toString());
        rescheduleRepository.save(reschedule);

    }

    // remove a rescheduled request by its rescheduleId
    public void remove(String id) {
        Reschedule r = rescheduleRepository.findRescheduleByRescheduleId(id);
        if( r == null ){
            throw new RuntimeException("Reschedule not found");
        }
        rescheduleRepository.delete(r);
    }



}
