package timetweak.backend.Appointment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.Local;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import timetweak.backend.TimeTableEntry.TimeTableEntry;
import timetweak.backend.TimeTableEntry.typeOfEntry;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

@Service
public class AppointmentScheduler {

    private final AppointmentRepository appointmentRepository;

    @Autowired
    public AppointmentScheduler(AppointmentRepository appointmentRepository) {
        this.appointmentRepository = appointmentRepository;
    }

    /*
    deletes appointments that have passed
    frequency : every Friday
    deleted appointments : dates passed
     */
    @Scheduled(cron = "00 59 11 * * FRI")
    public void update(){
        // find appointments that have already passed
        List<Appointment> listOfAppointments = appointmentRepository.findAppointmentsByDateBefore(LocalDate.now());
        appointmentRepository.deleteAll(listOfAppointments);
    }

}
