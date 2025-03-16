package timetweak.backend.TimeTableEntry;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;


import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;


@Service
public class TimeTableEntryScheduler {

    private final TimeTableEntryRepository repository;

    public TimeTableEntryScheduler(TimeTableEntryRepository repository) {
        this.repository = repository;
    }

    // get all entries of current week (all) and shift to next week (Original only), remove rest
    @Scheduled(cron = "00 59 11 * * FRI")
    public void update(){
        System.out.println("Updating time table entry");
        LocalDate thisFriday = LocalDate.now().with(DayOfWeek.FRIDAY);
        LocalDate thisMonday = LocalDate.now().with(DayOfWeek.MONDAY);

        List<TimeTableEntry> previousWeekEntries = repository.findTimeTableEntriesByDateBetween(thisMonday, thisFriday);

        // remove last week's entries
        repository.deleteAll(previousWeekEntries);

        // add new weeks ( filtered out by original )
        List<TimeTableEntry> newEntries = previousWeekEntries.stream().filter(
                entry->entry.getType().equals(typeOfEntry.ORIGINAL)
        ).map(
                entry -> new TimeTableEntry(
                        entry.getDate().plusWeeks(1),
                        entry.getSlotIdentifier(),
                        entry.getCourseIdentifier(),
                        typeOfEntry.ORIGINAL,
                        true
                )
        ).toList();

        // save all in repository
        repository.saveAll(newEntries);

    }




}
