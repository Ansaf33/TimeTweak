package timetweak.backend.Course;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import timetweak.backend.People.Faculty.FacultyService;

import java.util.List;

@Configuration
public class CourseConfig {

    //@Bean
    public CommandLineRunner course_runner(CourseRepository courseRepository, FacultyService facultyService) {
        return args -> {
            List<Course> courseList = List.of(
                    new Course("MA1012E", "Maths-II", "Advanced mathematical concepts for engineering applications.", facultyService.getFacultyById("AB")),
                    new Course("CS1013E", "Discrete Structures II", "Study of discrete mathematics and its applications in computing.", facultyService.getFacultyById("AB")),
                    new Course("PH1001E", "Physics of Materials", "Understanding material properties and their applications in engineering.", facultyService.getFacultyById("AMC")),
                    new Course("BT1001E", "Biology for Engineers", "Fundamentals of biology for engineering students.", facultyService.getFacultyById("AMP")),
                    new Course("CS1011E", "Program Design", "Introduction to programming concepts and software development.", facultyService.getFacultyById("AJ")),
                    new Course("CS1012E", "Logic Design", "Design and analysis of digital logic circuits.", facultyService.getFacultyById("NKB")),
                    new Course("CS2013E", "Theory of Computation", "Formal languages, automata theory, and computational complexity.", facultyService.getFacultyById("SM")),
                    new Course("CS2011E", "Database Management Systems", "Concepts of relational databases, SQL, and database design.", facultyService.getFacultyById("PD")),
                    new Course("MA2012E", "Maths-IV", "Advanced mathematical techniques for engineering.", facultyService.getFacultyById("VAR")),
                    new Course("CS2012E", "Operating Systems", "Design and implementation of modern operating systems.", facultyService.getFacultyById("TAS")),
                    new Course("CS2019E", "Professional Ethics", "Ethical issues in computing and professional responsibility.", facultyService.getFacultyById("VRC")),
                    new Course("CS4053E", "Data Mining", "Techniques for extracting knowledge from large datasets.", facultyService.getFacultyById("GG")),
                    new Course("CS4051E", "Introduction to Bioinformatics", "Application of computational methods in biology.", facultyService.getFacultyById("KAN")),
                    new Course("CS3006D", "Computer Networks", "Fundamentals of networking, protocols, and communication.", facultyService.getFacultyById("HVN")),
                    new Course("CS3005D", "Compiler Design", "Design and implementation of compilers.", facultyService.getFacultyById("SN")),
                    new Course("CS3004D", "Software Engineering", "Apply software engineering principles to build reliable software systems.", facultyService.getFacultyById("KMJ")),
                    new Course("ME3104D", "Principles of Management", "Introduction to management principles and business strategies.", facultyService.getFacultyById("JPB")),
                    new Course("CS4044D", "Machine Learning", "Fundamentals of machine learning algorithms and applications.", facultyService.getFacultyById("JPB")),
                    new Course("CS4050D", "Design and Analysis of Algorithms", "Study of algorithm design techniques and complexity analysis.", facultyService.getFacultyById("PC")),
                    new Course("CS4038D", "Data Mining", "Exploring data patterns using machine learning and statistical methods.", facultyService.getFacultyById("GG")),
                    new Course("CS4036E", "Algorithms in Optimization", "Optimization algorithms and their applications.", facultyService.getFacultyById("MK")),
                    new Course("CS4062D", "Introduction to Information Security", "Security threats, cryptography, and risk management.", facultyService.getFacultyById("JJ")),
                    new Course("CS4037D", "Cloud Computing", "Distributed computing and cloud infrastructure.", facultyService.getFacultyById("SC")),
                    new Course("CS4041D", "Natural Language Processing", "Understanding computational linguistics and language models.", facultyService.getFacultyById("CMC")),
                    new Course("CS4032D", "Computer Architecture", "Design and analysis of computer hardware architectures.", facultyService.getFacultyById("SK")),
                    new Course("CS4063D", "Topics in Cryptography", "Advanced cryptographic techniques and security models.", facultyService.getFacultyById("AP")),
                    new Course("CS4048D", "Mathematical Foundations of Machine Learning", "Mathematical concepts used in ML algorithms.", facultyService.getFacultyById("JP")),
                    new Course("CS4027D", "Topics in Algorithms", "Exploration of advanced algorithmic concepts.", facultyService.getFacultyById("RP")),
                    new Course("CS4033D", "Distributed Computing", "Principles and applications of distributed systems.", facultyService.getFacultyById("PM")),
                    new Course("CS4046D", "Computer Vision", "Image processing and AI-based vision systems.", facultyService.getFacultyById("SKB")),
                    new Course("CS4049D", "Advanced Computer Networks", "Networking technologies and security.", facultyService.getFacultyById("SNB")),
                    new Course("CS6312E", "Intelligent Agents", "Autonomous systems and agent-based computing.", facultyService.getFacultyById("PARK")),
                    new Course("CS6205E", "Topics in Information Security", "Current trends in cybersecurity and information security.", facultyService.getFacultyById("AMP")),
                    new Course("CS6206E", "Systems Security", "Securing modern computing systems.", facultyService.getFacultyById("PARK")),
                    new Course("CS6113E", "Topics in Database Design", "Advanced topics in database architectures.", facultyService.getFacultyById("SDMK")),
                    new Course("CS6302E", "Theoretical Foundations of Machine Learning", "Mathematical and statistical foundations for ML.", facultyService.getFacultyById("PNP")),
                    new Course("CS6306E", "Advanced Deep Learning and Computer Vision", "State-of-the-art deep learning models for vision tasks.", facultyService.getFacultyById("VK")),
                    new Course("CS6315E", "Neural Networks and Deep Learning", "Understanding neural network architectures.", facultyService.getFacultyById("PNP")),
                    new Course("CS6106E", "Bioinformatics", "Computational methods in biological data analysis.", facultyService.getFacultyById("KAN")),
                    new Course("CS6304E", "Machine Learning", "Supervised and unsupervised learning techniques.", facultyService.getFacultyById("GG")),
                    new Course("CS6319E", "Topics in Data Mining", "Advanced data mining techniques.", facultyService.getFacultyById("AMP")),
                    new Course("CS6305E", "Advanced Data Structures and Algorithms", "Optimization and implementation of complex data structures.", facultyService.getFacultyById("SR"))
            );

            courseRepository.saveAll(courseList);





        };
    }
}
