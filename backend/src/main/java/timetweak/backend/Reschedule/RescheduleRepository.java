package timetweak.backend.Reschedule;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RescheduleRepository extends JpaRepository<Reschedule, Long> {

    void deleteRescheduleByRescheduleId(String id);

    Reschedule findRescheduleByRescheduleId(String id);


}
