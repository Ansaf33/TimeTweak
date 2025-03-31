package timetweak.backend.TimeTableEntry;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timetweak.backend.Components.slotName;
import timetweak.backend.Course.CourseRepository;
import timetweak.backend.People.Student.batch;
import timetweak.backend.People.Student.branch;
import timetweak.backend.Slot.Slot;
import timetweak.backend.Slot.SlotRepository;


@Service
public class TimeTableEntryService {

    private final TimeTableEntryRepository timeTableEntryRepository;
    private final CourseRepository courseRepository;
    private final SlotRepository slotRepository;

    @Autowired
    public TimeTableEntryService(TimeTableEntryRepository timeTableEntryRepository, CourseRepository courseRepository, SlotRepository slotRepository) {
        this.timeTableEntryRepository = timeTableEntryRepository;
        this.courseRepository = courseRepository;
        this.slotRepository = slotRepository;
    }

    // get all timetable entries
    public List<TimeTableEntry> getAllEntries() {
        return timeTableEntryRepository.findAll();
    }

    // get active timetable entries
    public List<TimeTableEntry> getActiveEntries(boolean status) {
        return timeTableEntryRepository.findTimeTableEntriesByActive(status);
    }

    // add entry to timetable repository
    public void addEntry(TimeTableEntry entry) {


//        TimeTableEntry existing = timeTableEntryRepository.findTimeTableEntryByDateAndSlotIdentifier(entry.getDate(), entry.getSlotIdentifier());
//        if (existing != null) {
//            throw new RuntimeException("Entry already exists");
//        }

        // make change in the course repository
        entry.setCourse(courseRepository.findByCourseId(entry.getCourseIdentifier()));

        // make change in slot repository
        entry.setSlot(slotRepository.findSlotByName(entry.getSlotIdentifier()));

        // make change in timetable repository
        timeTableEntryRepository.save(entry);
    }

    // add list of timetables (for configuration purposes)
    public void addListofEntries(List<TimeTableEntry> entries) {
        for (TimeTableEntry entry : entries) {
            addEntry(entry);
        }
    }


    // returns timetable entries of branch and batch
    public List<TimeTableEntry> getEntriesOfBranchAndBatch(branch branch, batch batch) {
        return timeTableEntryRepository.findTimeTableEntryByBatchAndBranch(batch, branch);
    }

    // set timetable entry as inactive based on date and slot
    public void changeStatus(LocalDate date, slotName slotName, boolean active) {
        TimeTableEntry entry = timeTableEntryRepository.findTimeTableEntryByDateAndSlotIdentifier(date, slotName);
        if (entry == null) {
            throw new RuntimeException("TimeTableEntry not found");
        }
        entry.setActive(active);
        timeTableEntryRepository.save(entry);
    }

    // get list of free slots for a particular day
    public List<Slot> getFreeSlots(LocalDate date,branch branch,batch batch) {

        // for the particular branch and batch
        List<TimeTableEntry>entries = timeTableEntryRepository.findTimeTableEntryByBatchAndBranch(batch, branch);

        // only entries for the particular date
        entries.removeIf(entry -> !entry.getDate().equals(date));

        entries.forEach(entry -> System.out.println(entry.getDate() + " " + entry.getSlotIdentifier()));

        // gather a list of all slots
        List<Slot> slots = slotRepository.findAll();


        // for each timetable entry, remove that slot
        for (TimeTableEntry entry : entries) {
            slots.remove(entry.getSlot());
        }


        return slots;

    }


}