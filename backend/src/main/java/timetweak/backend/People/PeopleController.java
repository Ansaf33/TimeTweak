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

    @PutMapping("/update/username/{og_username}/to/{new_username}")
    public void updateUsername(@PathVariable String og_username, @PathVariable String new_username) {
        peopleService.updateUsername(og_username,new_username);
    }

    @PutMapping("/update/password/{username}/to/{new_password}")
    public void updatePassword(@PathVariable String username, @PathVariable String new_password) {
        peopleService.updatePassword(username,new_password);
    }

}
