package timetweak.backend.People;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class PeopleService {

    private PeopleRepository peopleRepository;

    @Autowired
    public PeopleService(PeopleRepository peopleRepository) {
        this.peopleRepository = peopleRepository;
    }

    // find person by username
    public People getPeopleByUsername(String username) {
        People people = peopleRepository.findByUsername(username);
        if (people == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Person not found");
        }
        return people;
    }

    // remove person by username
    public void removePeople(String username) {
        peopleRepository.deleteByUsername(username);
    }


}
