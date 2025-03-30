package timetweak.backend.TimeTableEntry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import timetweak.backend.Components.slotName;
import timetweak.backend.People.Student.batch;
import timetweak.backend.People.Student.branch;
import timetweak.backend.Slot.Slot;


import java.time.LocalDate;
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

    @GetMapping("/all/active/{status}")
    public List<TimeTableEntry> getActiveEntries(@PathVariable boolean status) {
        return timeTableEntryService.getActiveEntries(status);
    }

    @GetMapping("/all/{branch}/{batch}")
    public List<TimeTableEntry> getActiveEntries(@PathVariable branch branch, @PathVariable batch batch) {
        return timeTableEntryService.getEntriesOfBranchAndBatch(branch,batch);
    }

    @PostMapping("/add")
    public void addEntry(@RequestBody TimeTableEntry entry) {
        timeTableEntryService.addEntry(entry);
    }

    @PutMapping("/change/date/{date}/slot/{slotName}/{active}")
    public void removeEntry(@PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date, @PathVariable slotName slotName, @PathVariable boolean active) {
        timeTableEntryService.changeStatus(date,slotName,active);
    }

    @GetMapping("/free/slots/date/{date}/branch/{branch}/batch/{batch}")
    public List<Slot> getFreeSlots(@PathVariable LocalDate date, @PathVariable branch branch, @PathVariable batch batch) {
        return timeTableEntryService.getFreeSlots(date,branch,batch);
    }




}
