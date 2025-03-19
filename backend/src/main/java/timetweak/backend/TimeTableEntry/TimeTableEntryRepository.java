package timetweak.backend.TimeTableEntry;

import org.springframework.data.jpa.repository.JpaRepository;
import timetweak.backend.Components.slotName;
import timetweak.backend.People.Student.batch;
import timetweak.backend.People.Student.branch;
import timetweak.backend.Slot.Slot;

import java.time.LocalDate;
import java.util.List;

public interface
TimeTableEntryRepository extends JpaRepository<TimeTableEntry, Long> {
    List<TimeTableEntry> findTimeTableEntryByDate(LocalDate date);
    List<TimeTableEntry> findTimeTableEntriesByDateBetween(LocalDate date1, LocalDate date2);
    List<TimeTableEntry> findTimeTableEntriesByActive(boolean active);
    TimeTableEntry findTimeTableEntryByDateAndSlot(LocalDate date, Slot slot);
    List<TimeTableEntry> findTimeTableEntryByBatchAndBranch(batch batch, branch branch);
    TimeTableEntry findTimeTableEntryByDateAndSlotIdentifier(LocalDate date, slotName slotIdentifier);
    List<TimeTableEntry> findTimeTableEntriesByType(typeOfEntry typeOf);


}
