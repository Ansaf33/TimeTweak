package timetweak.backend.Slot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/slot")
public class SlotController {

    private final SlotService slotService;
    @Autowired
    public SlotController(SlotService slotService) {
        this.slotService = slotService;
    }

    @GetMapping("/all")
    public List<Slot> getAllSlots() {
        return slotService.getAllSlots();

    }


}
