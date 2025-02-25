package timetweak.backend.Appointment;

import org.springframework.data.jpa.repository.JpaRepository;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
        public Appointment findAppointmentById(Long id);
}
