package timetweak.backend.People;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/people")
public class PeopleController {

    private final PeopleService peopleService;

    @Autowired
    public PeopleController(PeopleService peopleService) {
        this.peopleService = peopleService;
    }

    @GetMapping("/username/{username}")
    public People getPeopleByUsername(@PathVariable("username") String username) {
        return peopleService.getPeopleByUsername(username);
    }

    @DeleteMapping("/remove/username/{username}")
    public void removePeopleByUsername(@PathVariable("username") String username) {
        peopleService.removePeople(username);
    }


}
