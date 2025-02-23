package timetweak.backend.People.Faculty;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import timetweak.backend.Course.Course;

import java.util.List;

@Service
public class FacultyService {

    private final FacultyRepository facultyRepository;

    @Autowired
    public FacultyService(FacultyRepository facultyRepository) {
        this.facultyRepository = facultyRepository;

    }

    public Faculty getFaculty(String facultyId){
        return facultyRepository.findByFacultyId(facultyId);
    }

    public void addFaculty(Faculty faculty) {
        Faculty existingFaculty = facultyRepository.findByFacultyId(faculty.getFacultyId());
        if (existingFaculty != null) {
            throw new RuntimeException("Faculty with same ID already exists");
        }
        facultyRepository.save(faculty);
    }

    public List<Faculty> getAllFaculty() {
        return facultyRepository.findAll();
    }

    public List<Course> getCoursesByFaculty(String facultyId ) {
        return facultyRepository.findByFacultyId(facultyId).getCourseList();

    }
}
