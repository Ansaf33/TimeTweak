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
                    new TimeTableEntry(LocalDate.of(2025,3,10),slotName.A2,"CS3006D",typeOfEntry.ORIGINAL),
                    new TimeTableEntry(LocalDate.of(2025,3,13),slotName.A2,"CS3006D",typeOfEntry.ORIGINAL),
                    new TimeTableEntry(LocalDate.of(2025,3,14),slotName.A2,"CS3006D",typeOfEntry.ORIGINAL),
                    // COMPILER DESIGN
                    new TimeTableEntry(LocalDate.of(2025,3,10),slotName.B2,"CS3005D",typeOfEntry.ORIGINAL),
                    new TimeTableEntry(LocalDate.of(2025,3,11),slotName.B2,"CS3005D",typeOfEntry.ORIGINAL),
                    new TimeTableEntry(LocalDate.of(2025,3,14),slotName.B2,"CS3005D",typeOfEntry.ORIGINAL),
                    // SOFTWARE ENGINEERING
                    new TimeTableEntry(LocalDate.of(2025,3,10),slotName.C2,"CS3004D",typeOfEntry.ORIGINAL),
                    new TimeTableEntry(LocalDate.of(2025,3,11),slotName.C2,"CS3004D",typeOfEntry.ORIGINAL),
                    new TimeTableEntry(LocalDate.of(2025,3,12),slotName.C2,"CS3004D",typeOfEntry.ORIGINAL),
                    // PRINCIPLES OF MANAGEMENT
                    new TimeTableEntry(LocalDate.of(2025,3,11),slotName.D2,"ME3104D",typeOfEntry.ORIGINAL),
                    new TimeTableEntry(LocalDate.of(2025,3,12),slotName.D2,"ME3104D",typeOfEntry.ORIGINAL),
                    new TimeTableEntry(LocalDate.of(2025,3,13),slotName.D2,"ME3104D",typeOfEntry.ORIGINAL)
            );
            service.addListofEntries(entries);

        };
    }



    @Bean
    CommandLineRunner commandLineRunner(TimeTableEntryRepository repo) {
        return args -> {
            // get all entries
            List<TimeTableEntry> entries = repo.findTimeTableEntriesByType(typeOfEntry.ORIGINAL);

            entries.forEach(entry -> {
                DayOfWeek entryDay = entry.getDate().getDayOfWeek();
                LocalDate nextOccurence = LocalDate.now().with(entryDay);

                if( nextOccurence.isBefore(LocalDate.now()) ){
                    nextOccurence = nextOccurence.plusWeeks(1);
                }

                entry.setDate(nextOccurence);
                repo.save(entry);

            });


        };

    }


}
