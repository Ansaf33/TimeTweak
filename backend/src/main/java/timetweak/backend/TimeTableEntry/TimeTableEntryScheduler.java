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

    @Scheduled(cron = "55 59 23 * * ?")
    public void update() {
        LocalDate today = LocalDate.now();
        LocalDate nextWeek = today.plusWeeks(1);

        // list of timetable entries that is to be deleted
        List<TimeTableEntry> entries = service.getEntriesByDate(today);

        // remove today's entries (since today is done)
        service.removeListofEntries(entries);

        List<TimeTableEntry> newEntries = entries.stream().map(
                entry -> new TimeTableEntry(nextWeek, entry.getSlotIdentifier(), entry.getCourseIdentifier(), typeOfEntry.ORIGINAL)
        ).toList();

        // add list of new entries
        service.addListofEntries(newEntries);

    }




}
