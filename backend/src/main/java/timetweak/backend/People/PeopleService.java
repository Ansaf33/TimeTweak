package timetweak.backend.People;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PeopleService {

    private PeopleRepository peopleRepository;

    @Autowired
    public PeopleService(PeopleRepository peopleRepository) {
        this.peopleRepository = peopleRepository;
    }

    // find person by username
    public People getPeopleByUsername(String username) {
        return peopleRepository.findByUsername(username);
    }

}
