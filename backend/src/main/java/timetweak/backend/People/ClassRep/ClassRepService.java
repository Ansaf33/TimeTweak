package timetweak.backend.People.ClassRep;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import timetweak.backend.People.Student.Student;
import timetweak.backend.People.Student.StudentRepository;

import java.util.List;

@Service
public class ClassRepService {
    private final ClassRepRepository classRepRepository;
    private final StudentRepository studentRepository;


    @Autowired
    public ClassRepService(ClassRepRepository classRepRepository, StudentRepository studentRepository) {
        this.classRepRepository = classRepRepository;
        this.studentRepository = studentRepository;
    }

    // get class-rep by registration number in the student database
    public ClassRep getClassRepByRegNo(String id) {
        return classRepRepository.findByRegNo(id);
    }


    // adds class-rep to database
    public void addClassRep(ClassRep classRep) {
        Student existingStudent = studentRepository.findByRegNo(classRep.getRegNo());
        if (existingStudent != null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Class rep already exists");
        }
        classRepRepository.save(classRep);
    }

    // getting a list of all students
    public List<ClassRep> getAllClassReps() {
        return classRepRepository.findAll();
    }
}
