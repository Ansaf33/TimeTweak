package timetweak.backend.TimeTableEntry;

import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface
TimeTableEntryRepository extends JpaRepository<TimeTableEntry, Long> {

    List<TimeTableEntry> findTimeTableEntriesByDate(LocalDate date);

    List<TimeTableEntry> findTimeTableEntriesByType(typeOfEntry type);
}
