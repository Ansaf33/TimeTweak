package timetweak.backend.Reschedule;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/reschedule")
public class RescheduleController {

    private final RescheduleService rescheduleService;
    public RescheduleController(RescheduleService rescheduleService) {
        this.rescheduleService = rescheduleService;
    }


    @GetMapping("/all")
    public List<Reschedule> getAll() {
        return rescheduleService.getAllRequests();
    }


    @PostMapping("/add")
    public void add(@RequestBody Reschedule reschedule) {
        rescheduleService.add(reschedule);
    }

    @DeleteMapping("/remove/{id}")
    public void delete(@PathVariable String id) {
        rescheduleService.remove(id);
    }

    @GetMapping("/reg/{id}")
    public List<Reschedule> getReschedule(@PathVariable String id) {
        return rescheduleService.getRequestsById(id);
    }







}
