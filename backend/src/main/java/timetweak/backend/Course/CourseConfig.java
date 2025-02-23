package timetweak.backend.Course;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import timetweak.backend.People.Faculty.FacultyService;

import java.util.List;

@Configuration
public class CourseConfig {

    public CommandLineRunner course_runner(CourseRepository courseRepository, FacultyService facultyService) {
        return args -> {
            List<Course> courseList = List.of(
                    new Course("MA1012E", "Maths-II", "Advanced mathematical concepts for engineering applications.", facultyService.getFaculty("AB")),
                    new Course("CS1013E", "Discrete Structures II", "Study of discrete mathematics and its applications in computing.", facultyService.getFaculty("AB")),
                    new Course("PH1001E", "Physics of Materials", "Understanding material properties and their applications in engineering.", facultyService.getFaculty("AMC")),
                    new Course("BT1001E", "Biology for Engineers", "Fundamentals of biology for engineering students.", facultyService.getFaculty("AMP")),
                    new Course("CS1011E", "Program Design", "Introduction to programming concepts and software development.", facultyService.getFaculty("AJ")),
                    new Course("CS1012E", "Logic Design", "Design and analysis of digital logic circuits.", facultyService.getFaculty("NKB")),
                    new Course("CS2013E", "Theory of Computation", "Formal languages, automata theory, and computational complexity.", facultyService.getFaculty("SM")),
                    new Course("CS2011E", "Database Management Systems", "Concepts of relational databases, SQL, and database design.", facultyService.getFaculty("PD")),
                    new Course("MA2012E", "Maths-IV", "Advanced mathematical techniques for engineering.", facultyService.getFaculty("VAR")),
                    new Course("CS2012E", "Operating Systems", "Design and implementation of modern operating systems.", facultyService.getFaculty("TAS")),
                    new Course("CS2019E", "Professional Ethics", "Ethical issues in computing and professional responsibility.", facultyService.getFaculty("VRC")),
                    new Course("CS4053E", "Data Mining", "Techniques for extracting knowledge from large datasets.", facultyService.getFaculty("GG")),
                    new Course("CS4051E", "Introduction to Bioinformatics", "Application of computational methods in biology.", facultyService.getFaculty("KAN")),
                    new Course("CS3006D", "Computer Networks", "Fundamentals of networking, protocols, and communication.", facultyService.getFaculty("HVN")),
                    new Course("CS3005D", "Compiler Design", "Design and implementation of compilers.", facultyService.getFaculty("SN")),
                    new Course("CS3004D", "Software Engineering", "Apply software engineering principles to build reliable software systems.", facultyService.getFaculty("KMJ")),
                    new Course("ME3104D", "Principles of Management", "Introduction to management principles and business strategies.", facultyService.getFaculty("JPB")),
                    new Course("CS4044D", "Machine Learning", "Fundamentals of machine learning algorithms and applications.", facultyService.getFaculty("JPB")),
                    new Course("CS4050D", "Design and Analysis of Algorithms", "Study of algorithm design techniques and complexity analysis.", facultyService.getFaculty("PC")),
                    new Course("CS4038D", "Data Mining", "Exploring data patterns using machine learning and statistical methods.", facultyService.getFaculty("GG")),
                    new Course("CS4036E", "Algorithms in Optimization", "Optimization algorithms and their applications.", facultyService.getFaculty("MK")),
                    new Course("CS4062D", "Introduction to Information Security", "Security threats, cryptography, and risk management.", facultyService.getFaculty("JJ")),
                    new Course("CS4037D", "Cloud Computing", "Distributed computing and cloud infrastructure.", facultyService.getFaculty("SC")),
                    new Course("CS4041D", "Natural Language Processing", "Understanding computational linguistics and language models.", facultyService.getFaculty("CMC")),
                    new Course("CS4032D", "Computer Architecture", "Design and analysis of computer hardware architectures.", facultyService.getFaculty("SK")),
                    new Course("CS4063D", "Topics in Cryptography", "Advanced cryptographic techniques and security models.", facultyService.getFaculty("AP")),
                    new Course("CS4048D", "Mathematical Foundations of Machine Learning", "Mathematical concepts used in ML algorithms.", facultyService.getFaculty("JP")),
                    new Course("CS4027D", "Topics in Algorithms", "Exploration of advanced algorithmic concepts.", facultyService.getFaculty("RP")),
                    new Course("CS4033D", "Distributed Computing", "Principles and applications of distributed systems.", facultyService.getFaculty("PM")),
                    new Course("CS4046D", "Computer Vision", "Image processing and AI-based vision systems.", facultyService.getFaculty("SKB")),
                    new Course("CS4049D", "Advanced Computer Networks", "Networking technologies and security.", facultyService.getFaculty("SNB")),
                    new Course("CS6312E", "Intelligent Agents", "Autonomous systems and agent-based computing.", facultyService.getFaculty("PARK")),
                    new Course("CS6205E", "Topics in Information Security", "Current trends in cybersecurity and information security.", facultyService.getFaculty("AMP")),
                    new Course("CS6206E", "Systems Security", "Securing modern computing systems.", facultyService.getFaculty("PARK")),
                    new Course("CS6113E", "Topics in Database Design", "Advanced topics in database architectures.", facultyService.getFaculty("SDMK")),
                    new Course("CS6302E", "Theoretical Foundations of Machine Learning", "Mathematical and statistical foundations for ML.", facultyService.getFaculty("PNP")),
                    new Course("CS6306E", "Advanced Deep Learning and Computer Vision", "State-of-the-art deep learning models for vision tasks.", facultyService.getFaculty("VK")),
                    new Course("CS6315E", "Neural Networks and Deep Learning", "Understanding neural network architectures.", facultyService.getFaculty("PNP")),
                    new Course("CS6106E", "Bioinformatics", "Computational methods in biological data analysis.", facultyService.getFaculty("KAN")),
                    new Course("CS6304E", "Machine Learning", "Supervised and unsupervised learning techniques.", facultyService.getFaculty("GG")),
                    new Course("CS6319E", "Topics in Data Mining", "Advanced data mining techniques.", facultyService.getFaculty("AMP")),
                    new Course("CS6305E", "Advanced Data Structures and Algorithms", "Optimization and implementation of complex data structures.", facultyService.getFaculty("SR"))
            );

            courseRepository.saveAll(courseList);





        };
    }
}
