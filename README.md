
## API Documentation

This document provides a comprehensive list of APIs developed for each entity in the Spring Boot Application.

---

### **PEOPLE Entity**

- **GET /people/username/{username}**  
  - **Function**: Returns the user with the provided username `{username}`.

- **DELETE /people/remove/username/{username}**  
  - **Function**: Removes the user with the provided username `{username}`.

---

### **STUDENT Entity**

- **GET /student/reg/{regNo}**  
  - **Function**: Returns details of the student with registration number `{regNo}`.

- **GET /student/reg/{regNo}/courses/all**  
  - **Function**: Returns a list of courses that the student with registration number `{regNo}` is enrolled in.

- **POST /student/add**  
  - **Function**: Adds a student to the repository.
  - **Example Request Body**:
    ```json
    {
      "username": "Gokulkrishna V",
      "password": "thisispassword",
      "role": "STUDENT",
      "regNo": "B220295CS",
      "branch": "CS",
      "batch": "MORNING"
    }
    ```

- **DELETE /student/reg/{regNo}/remove**  
  - **Function**: Deletes the student with registration number `{regNo}`.

- **POST /student/reg/{regNo}/course/add/{courseId}**  
  - **Function**: Adds course with courseId `{courseId}` to the student with registration number `{regNo}`.

- **DELETE /student/reg/{regNo}/course/remove/{courseId}**  
  - **Function**: Removes course with courseId `{courseId}` from the student with registration number `{regNo}`.

- **GET /student/reg/{regNo}/appointments/all**  
  - **Function**: Returns a list of appointments for the student with registration number `{regNo}`.

- **GET /student/reg/{regNo}/appointment/{appId}**  
  - **Function**: Returns appointment details of the student with appointment ID `{appId}`.

- **PUT /student/reg/{regNo}/appointment/{appId}/update-reason**  
  - **Function**: Allows modification of the reason for an appointment.
  - **Request Body**: A string containing the new reason.
 
- **PUT /student/reg/{regNo}/update/username**
  - **Function**: Changes the username of the student with registration number `{regNo}`
  - **Request Body**: A string containing the new username

- **PUT /student/reg/{regNo}/update/password**
  - **Function**: Changes the password of the student with registration number `{regNo}`
  - **Request Body**: A string containing the new password
  
---

### **FACULTY Entity**

- **GET /faculty/id/{facultyId}**  
  - **Function**: Returns faculty details for the provided faculty ID `{facultyId}`.

- **GET /faculty/all**  
  - **Function**: Returns a list of all faculty members.

- **POST /faculty/add**  
  - **Function**: Adds a faculty member (already in DB, so not required).

- **GET /faculty/id/{facultyId}/courses**  
  - **Function**: Returns the list of courses taught by the faculty `{facultyId}`.

- **POST /faculty/id/{facultyId}/course/add/{courseId}**  
  - **Function**: Adds the course `{courseId}` to the faculty `{facultyId}`.

- **DELETE /faculty/id/{facultyId}/course/remove/{courseId}**  
  - **Function**: Removes the course `{courseId}` from the faculty `{facultyId}`.

- **GET /faculty/id/{facultyId}/appointments/all**  
  - **Function**: Returns all appointments where the faculty `{facultyId}` is the recipient.

- **GET /faculty/id/{facultyId}/appointments/{appId}**  
  - **Function**: Returns appointment details with ID `{appId}` for faculty `{facultyId}`.

- **PUT /faculty/id/{facultyId}/appointment/{appId}/to/{newStatus}**  
  - **Function**: Updates the status of an appointment (PENDING, APPROVED, REJECTED).

- **PUT /faculty/id/{facultyId}/reschedule/{rescheduleId}/to/{newStatus}**  
  - **Function**: Updates the status of a reschedule request (PENDING, APPROVED, REJECTED).
 
- **PUT /faculty/id/{facultyId}/update/username**
  - **Function**: Changes the username of the faculty with facultyId `{facultyId}`
  - **Request Body**: A string containing the new username

- **PUT /faculty/id/{facultyId}/update/password**
  - **Function**: Changes the password of the faculty with facultyId `{facultyId}`
  - **Request Body**: A string containing the new password

---

### **CLASSREP Entity**

- **GET /CR/reg/{regNo}**  
  - **Function**: Returns the Class Representative with registration number `{regNo}`.

- **POST /CR/add**  
  - **Function**: Adds a Class Representative.
  - **Example**: Same as the student's request body.

- **GET /CR/all**  
  - **Function**: Returns all Class Representatives.

---

### **COURSE Entity**

- **POST /course/add**  
  - **Function**: Adds a course to the repository (not recommended, as all courses are already in the DB).

- **GET /course/all**  
  - **Function**: Returns a list of all courses.

- **GET /course/{courseId}**  
  - **Function**: Returns course details for `{courseId}`.
  - **Example**: `/course/CS3005D`

- **GET /course/{courseId}/timing**  
  - **Function**: Returns timetable entries for course `{courseId}`.

---

### **APPOINTMENT Entity**

- **GET /appointment/all**  
  - **Function**: Returns a list of all appointments.

- **GET /appointment/student/reg/{regNo}**  
  - **Function**: Returns a list of all appointments made by student `{regNo}`.
  - **Example**: `/appointment/student/reg/B220172CS`

- **GET /appointment/faculty/reg/{facultyId}**  
  - **Function**: Returns all appointments where faculty `{facultyId}` is a recipient.

- **POST /appointment/add**  
  - **Function**: Adds an appointment.

- **DELETE /appointment/remove/{appId}**  
  - **Function**: Removes an appointment with ID `{appId}`.

---

### **RESCHEDULE Entity**

- **GET /reschedule/all**  
  - **Function**: Returns a list of all reschedule requests.

- **POST /reschedule/add**  
  - **Function**: Adds a reschedule request.
  - **Example Request Body**:
    ```json
    {
      "status": "PENDING",
      "ogDate": "2025-04-01",
      "ogSlotIdentifier": 5,
      "newDate": "2025-04-02",
      "newSlotIdentifier": 6,
      "facultyIdentifier": "AB",
      "crIdentifier": "B220182CS",
      "reason": "Faculty unavailable on original date"
    }
    ```

- **DELETE /reschedule/remove/{id}**  
  - **Function**: Removes reschedule request with ID `{id}`.

- **GET /reschedule/reg/{id}**  
  - **Function**: Returns reschedule requests made by class-rep `{id}`.
  - **Example**: `/reschedule/reg/B220182CS`

---

### **SLOT Entity**

- **GET /slot/all**  
  - **Function**: Returns a list of all slots.

---

### **TIMETABLE Entity**

- **GET /tt/all**  
  - **Function**: Returns all timetable entries.

- **GET /tt/all/active/{status}**  
  - **Function**: Returns timetable entries with active status `{status}`.

- **GET /tt/all/{branch}/{batch}**  
  - **Function**: Returns timetable entries for `{branch}` and `{batch}`.

- **POST /tt/add**  
  - **Function**: Adds a timetable entry.

- **PUT /tt/change/date/{date}/slot/{slot}/{active}**  
  - **Function**: Changes timetable entry status.

- **GET /tt/free/slots/date/{date}/branch/{branch}/batch/{batch}**  
  - **Function**: Returns free slots for `{branch}` and `{batch}` on `{date}`.

