package timetweak.backend.Reschedule;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface RescheduleRepository extends JpaRepository<Reschedule, Long> {
    Reschedule findRescheduleByRescheduleId(String id);
    List<Reschedule> findReschedulesByNewDateBefore(LocalDate newDate);
}
