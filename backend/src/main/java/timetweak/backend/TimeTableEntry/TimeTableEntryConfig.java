package timetweak.backend.TimeTableEntry;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import timetweak.backend.Components.slotName;

import java.time.DayOfWeek;
import java.util.List;

@Configuration
public class TimeTableEntryConfig {

    //@Bean
    CommandLineRunner runner(TimeTableEntryRepository repo,TimeTableEntryService service) {
        return args -> {
            List<TimeTableEntry> entries = List.of(
                    // COMPUTER NETWORKS
                    new TimeTableEntry(DayOfWeek.MONDAY,slotName.A2,"CS3006D"),
                    new TimeTableEntry(DayOfWeek.THURSDAY,slotName.A2,"CS3006D"),
                    new TimeTableEntry(DayOfWeek.FRIDAY,slotName.A2,"CS3006D"),
                    // COMPILER DESIGN
                    new TimeTableEntry(DayOfWeek.MONDAY,slotName.B2,"CS3005D"),
                    new TimeTableEntry(DayOfWeek.TUESDAY,slotName.B2,"CS3005D"),
                    new TimeTableEntry(DayOfWeek.FRIDAY,slotName.B2,"CS3005D"),
                    // SOFTWARE ENGINEERING
                    new TimeTableEntry(DayOfWeek.MONDAY,slotName.C2,"CS3004D"),
                    new TimeTableEntry(DayOfWeek.TUESDAY,slotName.C2,"CS3004D"),
                    new TimeTableEntry(DayOfWeek.WEDNESDAY,slotName.C2,"CS3004D"),
                    // PRINCIPLES OF MANAGEMENT
                    new TimeTableEntry(DayOfWeek.TUESDAY,slotName.D2,"ME3104D"),
                    new TimeTableEntry(DayOfWeek.WEDNESDAY,slotName.D2,"ME3104D"),
                    new TimeTableEntry(DayOfWeek.THURSDAY,slotName.D2,"ME3104D")
            );
            service.addListofEntries(entries);

        };
    }
}
