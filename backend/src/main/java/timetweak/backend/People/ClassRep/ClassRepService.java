package timetweak.backend.People.ClassRep;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import timetweak.backend.People.Student.Student;
import timetweak.backend.People.Student.StudentRepository;

@Service
public class ClassRepService {
    private final ClassRepRepository classRepRepository;
    private final StudentRepository studentRepository;

    @Autowired
    public ClassRepService(ClassRepRepository classRepRepository, StudentRepository studentRepository) {
        this.classRepRepository = classRepRepository;
        this.studentRepository = studentRepository;
    }

    // returns class-rep by regNo
    public Student getStudentByRegNo(String regNo) {
        return studentRepository.findByRegNo(regNo);
    }

    // adds class-rep to database
    public void addClassRep(ClassRep classRep) {
        Student existingStudent = getStudentByRegNo(classRep.getRegNo());
        if (existingStudent != null) {
            throw new RuntimeException("Student with registration number already exists");
        }
        classRepRepository.save(classRep);
    }
}
