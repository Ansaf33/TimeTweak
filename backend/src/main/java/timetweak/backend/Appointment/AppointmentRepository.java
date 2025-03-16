package timetweak.backend.Appointment;

import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

        public Appointment findAppointmentByAppId(String appId);

        public List<Appointment> findAppointmentsByDateBefore(LocalDate date);
}
