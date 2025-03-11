package timetweak.backend.TimeTableEntry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import timetweak.backend.Course.CourseRepository;
import timetweak.backend.Slot.SlotRepository;

import java.util.List;

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

    // add entry to timetable repository
    public void addEntry(TimeTableEntry entry) {

        // make change in the course repository
        entry.setCourse(courseRepository.findByCourseId(entry.getCourseIdentifier()));
        courseRepository.save(entry.getCourse());

        // make change in slot repository
        entry.setSlot(slotRepository.findSlotByName(entry.getSlotIdentifier()));
        slotRepository.save(entry.getSlot());

        // make change in timetable repository
        timeTableEntryRepository.save(entry);
    }

    // add list of timetables (for configuration purposes)
    public void addListofEntries(List<TimeTableEntry> entries) {
        for (TimeTableEntry entry : entries) {
            addEntry(entry);
        }
    }

    // removing a timetable entry
    public void remove(TimeTableEntry entry) {
        timeTableEntryRepository.delete(entry);
    }
}
