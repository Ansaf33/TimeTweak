package timetweak.backend.Appointment;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/appointment")
public class AppointmentController {
    private final AppointmentService appointmentService;

    public AppointmentController(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    @GetMapping("/all")
    public List<Appointment> getAllAppointments() {
        return appointmentService.getAllAppointments();
    }

    @GetMapping("/student/reg/{regNo}")
    public List<Appointment> getAppointmentsByStudent(@PathVariable("regNo") String regNo) {
        return appointmentService.getAppointmentsByStudent(regNo);
    }

    @GetMapping("/faculty/reg/{facultyId}")
    public List<Appointment> getAppointmentsByFaculty(@PathVariable("facultyId") String facultyId) {
        return appointmentService.getAppointmentsByFaculty(facultyId);

    }

    @PostMapping("/add")
    public void addAppointment(@RequestBody Appointment appointment) {
        appointmentService.addAppointment(appointment);
    }

    @DeleteMapping("/remove/{appId}")
    public void removeAppointment(@PathVariable("appId") Long appId) {
        appointmentService.removeAppointment(appId);
    }










}
