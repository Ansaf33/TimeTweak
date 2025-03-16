package timetweak.backend.Reschedule;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class RescheduleScheduler {

    private final RescheduleRepository repository;
    public RescheduleScheduler(RescheduleRepository repository) {
        this.repository = repository;
    }

    /*
    Deletes expired reschedule requests
    frequency : Every Friday
    deleted item : requests that have newDate < NOW
     */
    @Scheduled(cron = "00 59 11 * * FRI")
    public void update() {
        List<Reschedule> entries = repository.findReschedulesByNewDateBefore(LocalDate.now());
        repository.deleteAll(entries);
    }


}
