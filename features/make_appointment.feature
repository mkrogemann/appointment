Feature: Make an appointment
  As a user of 'Appointment'
  I want to be able to make an appointment

  Scenario: I can make an appointment
    Given 'Appointment' has a worker available for the activity "activity" at "12":"00" "today"
    When I request an appointment for this activity at "12":"00" "today"
    Then an appointment is created

  Scenario: I cannot make an appointment
    Given a worker with an appointment at "12":"00" "today"
    Then 'Appointment' denies an attempt to create an appointment at "12":"00" "today"

  Scenario: I receive alternative times for the desired appointment
    Given 'Appointment' has a worker available for the activity "activity" at "15":"30" "today"
    When I request an appointment for this activity at "14":"30" "today"
    Then 'Appointment' offers alternative times for the desired appointment
