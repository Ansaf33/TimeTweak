package timetweak.backend.TimeTableEntry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/tt")
public class TimeTableEntryController {

    private final TimeTableEntryService timeTableEntryService;

    @Autowired
    public TimeTableEntryController(TimeTableEntryService timeTableEntryService) {
        this.timeTableEntryService = timeTableEntryService;
    }

    @GetMapping("/all")
    public List<TimeTableEntry> getAll() {
        return timeTableEntryService.getAllEntries();
    }

    @PostMapping("/add")
    public void addEntry(@RequestBody TimeTableEntry entry) {
        timeTableEntryService.addEntry(entry);
    }

    @DeleteMapping("/remove")
    public void removeEntry(@RequestBody TimeTableEntry entry) {
        timeTableEntryService.remove(entry);
    }


}
