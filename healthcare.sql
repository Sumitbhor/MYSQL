use healthcaredb ;
select * from healthcaredb.doctors;
select * from appointments
where DoctorId=2;


select d.firstname, a.status 
from doctors d
join appointments a 
on d.doctorid = a.doctorid 
where d.firstname="Dr. Raj";

select d.FirstName ,p.MedicineName
from doctors d
join appointments a on a.doctorid=d.doctorid
join prescriptions p on p.AppointmentID=a.AppointmentID;

