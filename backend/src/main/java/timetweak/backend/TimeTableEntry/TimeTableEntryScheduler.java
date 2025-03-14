package timetweak.backend.TimeTableEntry;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TimeTableEntryScheduler {
    private final TimeTableEntryService service;

    public TimeTableEntryScheduler(TimeTableEntryService service) {
        this.service = service;
    }

    @Scheduled(cron = "00 30 22 * * ?")
    public void update() {
        LocalDate today = LocalDate.now();
        LocalDate nextWeek = today.plusWeeks(1);

        // list of timetable entries that is to be deleted
        List<TimeTableEntry> entries = service.getEntriesByDate(today);

        // remove today's entries (since today is done)
        service.removeListofEntries(entries);

        // if a rescheduled class was over, no need to repeat it next week
        List<TimeTableEntry> newEntries = entries.stream().filter(
                entry -> entry.getType().equals(typeOfEntry.ORIGINAL)
        ).map(
                entry -> new TimeTableEntry(nextWeek, entry.getSlotIdentifier(), entry.getCourseIdentifier(), typeOfEntry.ORIGINAL,true)
        ).toList();

        // add list of new entries
        service.addListofEntries(newEntries);

    }




}
