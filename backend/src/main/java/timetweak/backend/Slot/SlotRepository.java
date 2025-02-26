package timetweak.backend.Slot;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import timetweak.backend.Components.slotName;

@Repository
public interface SlotRepository extends JpaRepository<Slot, Long> {

    public Slot findSlotByName(slotName name);
}
