package timetweak.backend.TimeTableEntry;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import timetweak.backend.Components.slotName;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

@Configuration
public class TimeTableEntryConfig {

    //@Bean
    CommandLineRunner runner(TimeTableEntryRepository repo,TimeTableEntryService service) {
        return args -> {
            List<TimeTableEntry> entries = List.of(
                    // COMPUTER NETWORKS
                    new TimeTableEntry(LocalDate.of(2025,3,3),slotName.A2,"CS3006D",typeOfEntry.ORIGINAL,true),
                    new TimeTableEntry(LocalDate.of(2025,3,6),slotName.A2,"CS3006D",typeOfEntry.ORIGINAL,true),
                    new TimeTableEntry(LocalDate.of(2025,3,7),slotName.A2,"CS3006D",typeOfEntry.ORIGINAL,true),
                    // COMPILER DESIGN
                    new TimeTableEntry(LocalDate.of(2025,3,3),slotName.B2,"CS3005D",typeOfEntry.ORIGINAL,true),
                    new TimeTableEntry(LocalDate.of(2025,3,4),slotName.B2,"CS3005D",typeOfEntry.ORIGINAL,true),
                    new TimeTableEntry(LocalDate.of(2025,3,7),slotName.B2,"CS3005D",typeOfEntry.ORIGINAL,true),
                    // SOFTWARE ENGINEERING
                    new TimeTableEntry(LocalDate.of(2025,3,3),slotName.C2,"CS3004D",typeOfEntry.ORIGINAL,true),
                    new TimeTableEntry(LocalDate.of(2025,3,4),slotName.C2,"CS3004D",typeOfEntry.ORIGINAL,true),
                    new TimeTableEntry(LocalDate.of(2025,3,5),slotName.C2,"CS3004D",typeOfEntry.ORIGINAL,true),
                    // PRINCIPLES OF MANAGEMENT
                    new TimeTableEntry(LocalDate.of(2025,3,4),slotName.D2,"ME3104D",typeOfEntry.ORIGINAL,true),
                    new TimeTableEntry(LocalDate.of(2025,3,5),slotName.D2,"ME3104D",typeOfEntry.ORIGINAL,true),
                    new TimeTableEntry(LocalDate.of(2025,3,6),slotName.D2,"ME3104D",typeOfEntry.ORIGINAL,true)
            );
            service.addListofEntries(entries);

        };
    }


    // all original entries made up-to-date with current week
   @Bean
    CommandLineRunner commandLineRunner(TimeTableEntryRepository repo) {
        return args -> {
            // get original entries
            List<TimeTableEntry> entries = repo.findTimeTableEntriesByType(typeOfEntry.ORIGINAL);
            LocalDate thisMonday = LocalDate.now().with(DayOfWeek.MONDAY);

            // change date to current week
            entries.forEach(entry -> {
                DayOfWeek entryDay = entry.getDate().getDayOfWeek();
                LocalDate nextOccurrence = thisMonday.with(entryDay);

                entry.setDate(nextOccurrence);

                repo.save(entry);

            });

        };

    }


}
