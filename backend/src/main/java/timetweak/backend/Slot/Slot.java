package timetweak.backend.Slot;

import jakarta.persistence.*;
import timetweak.backend.Components.slotName;
import timetweak.backend.Course.Course;
import timetweak.backend.TimeTableEntry.TimeTableEntry;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table
public class Slot {
    @Id
    @SequenceGenerator(
            sequenceName = "Slot_sequence",
            name = "Slot_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "Slot_sequence"
    )
    private Long id;

    //@Enumerated(EnumType.STRING)
    private slotName name;

    @OneToMany(
            mappedBy = "slot"
    )
    private List<TimeTableEntry> timeTableEntries = new ArrayList<>();


    public Slot() {}

    public Slot(slotName name) {
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public slotName getName() {
        return name;
    }

    public void setName(slotName name) {
        this.name = name;
    }


}

