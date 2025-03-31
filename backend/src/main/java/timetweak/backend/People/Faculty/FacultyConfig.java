package timetweak.backend.People.Faculty;

import java.util.List;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Bean;

@Configuration
public class FacultyConfig {

    //@Bean
    @SuppressWarnings("unused")
    CommandLineRunner faculty_runner(FacultyRepository facultyRepository) {
        return args -> {
            List<Faculty> facultyList = List.of(
                    new Faculty("Anand Babu N B", "anandbabunb", "AB"),
                    new Faculty("Ashwin Jacob", "ashwinjacob", "AJ"),
                    new Faculty("Anu Mary Chacko", "anumarychacko", "AMC"),
                    new Faculty("Amit Praseed", "amitpraseed", "AMP"),
                    new Faculty("Anil Pinapati", "anilpinapati", "AP"),
                    new Faculty("Chandramani Choudhary", "chandramanichoudhary", "CMC"),
                    new Faculty("Gopakumar G", "gopakumarg", "GG"),
                    new Faculty("Hiran V Nath", "hiranvnath", "HVN"),
                    new Faculty("Joe Cheri Ross", "joecheriross", "JCR"),
                    new Faculty("Jimmy Jose", "jimmyjose", "JJ"),
                    new Faculty("Jay Prakash", "jayprakash", "JP"),
                    new Faculty("Jayaraj P B", "jayarajpb", "JPB"),
                    new Faculty("K Abdul Nazeer", "kabdulnazeer", "KAN"),
                    new Faculty("K Manjusha", "kmanjusha", "KMJ"),
                    new Faculty("Lijiya A", "lijiyaa", "LA"),
                    new Faculty("Muralikrishnan K", "muralikrishnank", "MK"),
                    new Faculty("M Prabu", "mprabu", "MP"),
                    new Faculty("Nirmal Kumar Boran", "nirmalkumarboran", "NKB"),
                    new Faculty("P Arun Raj Kumar", "parunrajkumar", "PARK"),
                    new Faculty("Priya Chandran", "priyachandran", "PC"),
                    new Faculty("Pranesh Das", "praneshdas", "PD"),
                    new Faculty("P Muneeswaran", "pmuneeswaran", "PM"),
                    new Faculty("P N Pournami", "pnpournami", "PNP"),
                    new Faculty("Raju Hazari", "rajuhazari", "RH"),
                    new Faculty("Saleena N", "saleenan", "SN"),
                    new Faculty("Renjith P", "renjithp", "RP"),
                    new Faculty("Sudarshan Chakravorthy", "sudarshanchakravorthy", "SC"),
                    new Faculty("S D Madhu Kumar", "sdmadhukumar", "SDMK"),
                    new Faculty("Saidalavi Kalady", "saidalavikalady", "SK"),
                    new Faculty("Santosh Kumar Behera", "santoshkumarbehera", "SKB"),
                    new Faculty("Sreenu Naik Bhukya", "sreenunaikbhukya", "SNB"),
                    new Faculty("Subashini R", "subashinir", "SR"),
                    new Faculty("Subhasree M", "subhasreem", "SM"),
                    new Faculty("Shweta", "shweta", "SW"),
                    new Faculty("S Sheerazuddin", "ssheerazuddin", "SZ"),
                    new Faculty("T A Sumesh", "tasumesh", "TAS"),
                    new Faculty("T M Srinivasa", "tmsrinivasa", "TMS"),
                    new Faculty("T Veni", "tveni", "TV"),
                    new Faculty("Umamaheswara Sharma", "umamaheswarasharma", "UMS"),
                    new Faculty("Vasudevan A R", "vasudevanar", "VAR"),
                    new Faculty("Vidhya Kamakshi", "vidhyakamakshi", "VK"),
                    new Faculty("Vinod Pathari", "vinodpathari", "VP"),
                    new Faculty("Venkatarami Reddy Chintappalli", "venkataramireddyc", "VRC")
            );
            facultyRepository.saveAll(facultyList);
        };
    }
}
