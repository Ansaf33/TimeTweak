package timetweak.backend.TimeTableEntry;

import org.springframework.boot.CommandLineRunner;
import timetweak.backend.Components.slotName;

import java.util.List;

public class TimeTableEntryConfig {

    CommandLineRunner runner(TimeTableEntryRepository repo) {
        return args -> {
            List<TimeTableEntry> entries = List.of(
            );
            repo.saveAll(entries);

        };
    }
}
