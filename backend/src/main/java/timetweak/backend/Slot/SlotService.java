package timetweak.backend.Slot;


import org.springframework.stereotype.Service;
import timetweak.backend.Components.slotName;

import java.util.List;

@Service
public class SlotService {

    private final SlotRepository slotRepository;
    public SlotService(SlotRepository slotRepository) {
        this.slotRepository = slotRepository;
    }

    // get all slots
    public List<Slot> getAllSlots() {
        return slotRepository.findAll();
    }

    // find slot by slotName
    public Slot getSlot(slotName name) {
        return slotRepository.findSlotByName(name);
    }
}
