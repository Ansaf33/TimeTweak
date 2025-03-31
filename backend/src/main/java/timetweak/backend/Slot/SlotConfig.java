package timetweak.backend.Slot;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Bean;

import timetweak.backend.Components.slotName;


@Configuration
public class SlotConfig {

    //@Bean
    @SuppressWarnings("unused")
    CommandLineRunner runner(SlotRepository slotRepository) {
        return args -> {

            List<Slot> slots = Stream.of(slotName.values())
                    .map(Slot::new)
                    .collect(Collectors.toList());

            slotRepository.saveAll(slots);
        };
    }
}
