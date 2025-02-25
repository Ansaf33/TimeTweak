package timetweak.backend.People;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PeopleRepository extends JpaRepository<People, Long> {

    public People findByUsername(String username);
    public void deleteByUsername(String username);
}
