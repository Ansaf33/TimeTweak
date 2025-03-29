# TimeTweak
## Back-end API Documentation

TimeTweak is developed for **Software Engineering (CS3091D)** in S6. Below is a comprehensive list of APIs available in the Spring Boot application.

---

## **PEOPLE Entity**

1. **GET /people/username/{username}**  
   - Returns the user with the given username.

2. **DELETE /people/remove/username/{username}**  
   - Removes the user with the given username.

---

## **STUDENT Entity**

1. **GET /student/reg/{regNo}**  
   - Returns details of a student with the given registration number.

2. **GET /student/reg/{regNo}/courses/all**  
   - Returns a list of courses the student is enrolled in.

3. **POST /student/add**  
   - Adds a student to the repository.
   - **Example Request Body:**
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

4. **DELETE /student/reg/{regNo}/remove**  
   - Deletes the student with the given registration number.

5. **POST /student/reg/{regNo}/add/{courseId}**  
   - Enrolls the student in the specified course.

6. **GET /student/reg/{regNo}/appointments/all**  
   - Returns all appointments for the student.

7. **GET /student/reg/{regNo}/appointment/{appId}**  
   - Returns a specific appointment of the student.

8. **PUT /student/reg/{regNo}/appointment/{appId}/update-reason**  
   - Updates the reason for an appointment.

---

## **FACULTY Entity**

1. **GET /faculty/id/{facultyId}**  
   - Returns faculty details by ID.

2. **GET /faculty/all**  
   - Returns a list of all faculty members.

3. **POST /faculty/add**  
   - Adds a faculty member (if not already present).

4. **GET /faculty/id/{facultyId}/courses**  
   - Returns courses assigned to the faculty.

5. **POST /faculty/id/{facultyId}/course/add/{courseId}**  
   - Assigns a course to the faculty.

6. **GET /faculty/id/{facultyId}/appointments/all**  
   - Returns all appointments where the faculty is the recipient.

7. **GET /faculty/id/{facultyId}/appointments/{appId}**  
   - Returns a specific appointment for the faculty.

8. **PUT /faculty/id/{facultyId}/appointment/{appId}/to/{newStatus}**  
   - Updates appointment status (PENDING, APPROVED, REJECTED).

9. **PUT /faculty/id/{facultyId}/reschedule/{rescheduleId}/to/{newStatus}**  
   - Updates a reschedule request status.

---

## **CLASSREP Entity**

1. **GET /CR/reg/{regNo}**  
   - Returns details of the Class Representative.

2. **POST /CR/add**  
   - Adds a Class Representative.

3. **GET /CR/all**  
   - Returns all Class Representatives.

---

## **COURSE Entity**

1. **POST /course/add**  
   - Adds a course (not recommended as courses are predefined).

2. **GET /course/all**  
   - Returns a list of all courses.

3. **GET /course/{courseId}**  
   - Returns details of the specified course.

4. **GET /course/{courseId}/timing**  
   - Returns timetable entries for the specified course.

---

## **APPOINTMENT Entity**

1. **GET /appointment/all**  
   - Returns all appointments.

2. **GET /appointment/student/reg/{regNo}**  
   - Returns all appointments made by the student.

3. **GET /appointment/faculty/reg/{facultyId}**  
   - Returns all appointments where the faculty is a recipient.

4. **POST /appointment/add**  
   - Adds an appointment to the database.

5. **DELETE /appointment/remove/{appId}**  
   - Removes an appointment by ID.

---

## **RESCHEDULE Entity**

1. **GET /reschedule/all**  
   - Returns all reschedule requests.

2. **POST /reschedule/add**  
   - Adds a reschedule request.
   - **Example Request Body:**
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

3. **DELETE /reschedule/remove/{id}**  
   - Removes a reschedule request by ID.

4. **GET /reschedule/reg/{id}**  
   - Returns reschedule requests made by a class representative.

---

## **SLOT Entity**

1. **GET /slot/all**  
   - Returns a list of all slots.

---

## **TIMETABLE Entry Entity**

1. **GET /tt/all**  
   - Returns all timetable entries.

2. **GET /tt/all/active/{status}**  
   - Returns timetable entries filtered by active status.

3. **GET /tt/all/{branch}/{batch}**  
   - Returns timetable entries for a specific branch and batch.

4. **POST /tt/add**  
   - Adds a new timetable entry.
   - **Example Request Body:**
     ```json
     {
       "date": "2025-03-21",
       "slotIdentifier": 9,
       "courseIdentifier": "CS4036E",
       "active": true,
       "type": "ORIGINAL",
       "branch": "CS",
       "batch": "MORNING"
     }
     ```

5. **PUT /tt/change/date/{date}/slot/{slot}/{active}**  
   - Updates the active status of a timetable entry.

6. **GET /tt/free/slots/date/{date}/branch/{branch}/batch/{batch}**  
   - Returns free slots for a given date, branch, and batch.

---

