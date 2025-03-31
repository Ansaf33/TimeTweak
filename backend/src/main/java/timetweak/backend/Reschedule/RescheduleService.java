package timetweak.backend.Reschedule;

import java.util.List;
import static java.util.UUID.randomUUID;

import org.springframework.stereotype.Service;

import timetweak.backend.People.ClassRep.ClassRep;
import timetweak.backend.People.ClassRep.ClassRepRepository;
import timetweak.backend.People.Faculty.Faculty;
import timetweak.backend.People.Faculty.FacultyRepository;
import timetweak.backend.Slot.Slot;
import timetweak.backend.Slot.SlotRepository;
import timetweak.backend.TimeTableEntry.TimeTableEntry;
import timetweak.backend.TimeTableEntry.TimeTableEntryRepository;

@Service
public class RescheduleService {

    private final RescheduleRepository rescheduleRepository;
    private final ClassRepRepository classRepRepository;
    private final FacultyRepository facultyRepository;
    private final SlotRepository slotRepository;
    private final TimeTableEntryRepository timeTableEntryRepository;

    public RescheduleService(SlotRepository slotRepository,RescheduleRepository rescheduleRepository, ClassRepRepository classRepRepository, FacultyRepository facultyRepository, TimeTableEntryRepository timeTableEntryRepository) {
        this.rescheduleRepository = rescheduleRepository;
        this.classRepRepository = classRepRepository;
        this.facultyRepository = facultyRepository;
        this.slotRepository = slotRepository;
        this.timeTableEntryRepository = timeTableEntryRepository;
    }

    // returning all reschedule requests
    public List<Reschedule> getAllRequests() {
        return rescheduleRepository.findAll();
    }

    // returns requests made by CR of ID 'ID'
    public List<Reschedule> getRequestsById(String id) {
        ClassRep cr = classRepRepository.findByRegNo(id);
        if( cr == null ){
            throw new RuntimeException("Student not found");
        }
        return cr.getRequests();
    }

    // adding a reschedule request
    public void add(Reschedule reschedule) {

        // set the slots
        Slot ogs = slotRepository.findSlotByName(reschedule.getOgSlotIdentifier());
        Slot ns = slotRepository.findSlotByName(reschedule.getNewSlotIdentifier());
        if( ogs == null || ns == null ){
            throw new RuntimeException("Slot not found");
        }
        reschedule.setOgSlot(ogs);
        reschedule.setNewSlot(ns);

        // set the faculty
        Faculty f = facultyRepository.findByFacultyId(reschedule.getFacultyIdentifier());
        if( f == null ){
            throw new RuntimeException("Faculty not found");
        }
        reschedule.setFaculty(f);

        // set the class-rep
        ClassRep CR = classRepRepository.findByRegNo(reschedule.getCrIdentifier());
        if(CR == null) {
            throw new RuntimeException("Class-Rep not found");
        }
        reschedule.setCr(CR);

        // -------------------------------------- VALIDATE DATA ---------------------------------------
        TimeTableEntry existingEntryInOrigin = timeTableEntryRepository.findTimeTableEntryByDateAndSlot(
                reschedule.getOgDate(),
                reschedule.getOgSlot()
        );
        if( existingEntryInOrigin == null || !existingEntryInOrigin.isActive() ){
            throw new RuntimeException("Entry of date " + reschedule.getOgDate() + " and slot " + reschedule.getOgSlot().getName() + " not occupied.");
        }
        TimeTableEntry existingEntryInFinal = timeTableEntryRepository.findTimeTableEntryByDateAndSlot(
                reschedule.getNewDate(),
                reschedule.getNewSlot()
        );
        if( existingEntryInFinal != null && existingEntryInFinal.isActive()  ){
            throw new RuntimeException("Entry of date " + reschedule.getNewDate() + " and slot " + reschedule.getNewSlot().getName() + " is occupied.");
        }

        // --------------------------------------- VALIDATION DONE ------------------------------------

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
