package timetweak.backend.Slot;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import timetweak.backend.Components.slotName;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Configuration
public class SlotConfig {

    //@Bean
    CommandLineRunner runner(SlotRepository slotRepository) {
        return args -> {

            List<Slot> slots = Stream.of(slotName.values())
                    .map(Slot::new)
                    .collect(Collectors.toList());

            slotRepository.saveAll(slots);
        };
    }
}
