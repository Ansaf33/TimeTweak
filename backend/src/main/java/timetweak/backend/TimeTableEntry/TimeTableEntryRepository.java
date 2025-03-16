package timetweak.backend.TimeTableEntry;

import org.springframework.data.jpa.repository.JpaRepository;
import timetweak.backend.Slot.Slot;

import java.time.LocalDate;
import java.util.List;

public interface
TimeTableEntryRepository extends JpaRepository<TimeTableEntry, Long> {


    List<TimeTableEntry> findTimeTableEntriesByDateBetween(LocalDate date1, LocalDate date2);



    List<TimeTableEntry> findTimeTableEntriesByActive(boolean active);

    TimeTableEntry findTimeTableEntryByDateAndSlot(LocalDate date, Slot slot);


}
