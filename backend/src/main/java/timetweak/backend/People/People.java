package timetweak.backend.People;

import jakarta.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class People {
    @Id
    @SequenceGenerator(
            sequenceName = "People_sequence",
            name = "People_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.AUTO,
            generator = "People_sequence"
    )
    private Long id;
    private String username;
    private String password;

    @Enumerated(EnumType.STRING)
    private roleType role;

    public People(){}

    public People(String username, String password, roleType role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public roleType getRole() {
        return role;
    }

    public void setRole(roleType role) {
        this.role = role;
    }
}



