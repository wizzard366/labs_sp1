class Appointments < ActiveRecord::Base
  belongs_to :medic
  belongs_to :patient
  def Appointments.assignAppointment(begin_time,end_time,medic_id,patient_id)
    begin
      if Medic.find(medic_id) and Patient.find(patient_id)
	begin
	  if Appointments.where("(begin_time>=Datetime(:begin_t) AND begin_time<=Datetime(:end_t))OR(end_time>=Datetime(:begin_t) AND end_time<=Datetime(:end_t))OR(begin_time<=Datetime(:begin_t) AND end_time>=Datetime(:end_t))",{:begin_t=>begin_time,:end_t=>end_time}).count != 0
	    p "Ya existe una cita en el rango especificado"
	  else
	    cita=Appointments.create(:begin_time=>begin_time,:end_time=>end_time,:medic_id=>medic_id,:patient_id=>patient_id)
	    p "Cita creada con exito"
	    cita
	  end
	end
      end
    rescue =>msj
       p "no es posible crear la cita... medico o pasciente no existe"
    end 
    #Appointments.where("(begin_time>=Datetime(:begin_t) AND begin_time<=Datetime(:end_t))OR(end_time>=Datetime(:begin_t) AND end_time<=Datetime(:end_t))OR(begin_time<=Datetime(:begin_t) AND end_time>=Datetime(:end_t))",{:begin_t=>begin_time,:end_t=>end_time})
  end
  def Appointments.testing
    medico_1=Medic.create(:name =>"medico1",:department =>"cardiologia")
    medico_2=Medic.create(:name =>"medico2",:department =>"cirugia")
    paciente_1=Patient.create(:name =>"paciente1",:address =>"direccion paciente1")
    paciente_2=Patient.create(:name =>"paciente2",:address =>"direccion paciente2")
    cita_1=Appointments.create(:begin_time =>"2012-03-11 14:00:00",:end_time =>"2012-03-11 15:00:00",:medic_id => medico_1.id,:patient_id => paciente_1.id)
    #creando citas, no validas por datetime, de prueba
    Appointments.assignAppointment("2012-03-11 14:01:00","2012-03-11 14:30:00",medico_2.id,paciente_2.id)
    Appointments.assignAppointment("2012-03-11 13:00:00","2012-03-11 14:30:00",medico_2.id,paciente_2.id)
    Appointments.assignAppointment("2012-03-11 13:01:00","2012-03-11 16:30:00",medico_2.id,paciente_2.id)
    #creando citas, no valida por medic_id o patiente_id, de prueba
    Appointments.assignAppointment("2012-03-11 15:30:00","2012-03-11 16:00:00",Medic.last.id+1,paciente_2.id)
    Appointments.assignAppointment("2012-03-11 15:30:00","2012-03-11 16:00:00",medico_2.id,Patient.last.id+1)
    #cita valida
    Appointments.assignAppointment("2012-03-11 15:30:00","2012-03-11 16:00:00",medico_2.id,paciente_2.id)
    #update de citas no validas
    Appointments.editAppointment(cita_1.id,Medic.last.id+1,"2012-03-11 15:30:00","2012-03-11 15:30:00")
    Appointments.editAppointment(cita_1.id,medico_1.id,"2012-03-11 15:31:00","2012-03-11 15:50:00")
    Appointments.editAppointment(Appointments.last.id+1,medico_1.id,"2012-03-11 15:31:00","2012-03-11 15:50:00")
    #update de citas validas
    Appointments.editAppointment(cita_1.id,medico_1.id,"2012-03-11 16:31:00","2012-03-11 16:50:00")
    
    
    
    
  end
  def Appointments.editAppointment (appointment_id,medic_id,begin_time,end_time)
    begin
      if Medic.find(medic_id)
	if Appointments.where("(begin_time>=Datetime(:begin_t) AND begin_time<=Datetime(:end_t))OR(end_time>=Datetime(:begin_t) AND end_time<=Datetime(:end_t))OR(begin_time<=Datetime(:begin_t) AND end_time>=Datetime(:end_t))",{:begin_t=>begin_time,:end_t=>end_time}).count != 0
	  p "no se puede actualizar la cita, ya existe otra durante ese lapso de tiempo"
	else
	  begin
	    Appointments.find(appointment_id).update_attribute(:begin_time,begin_time)
	    Appointments.find(appointment_id).update_attribute(:end_time,end_time)
	    Appointments.find(appointment_id).update_attribute(:medic_id,medic_id)
	    p "cita actualizada con exito"
	  rescue
	    p "el Id. de la cita no existe"
	  end
	end
      end
    rescue
      p "no es posible cabiar la cita... ya que el medico no existe"
    end
  end
  def Appointments.deleteAppointment(appointment_id)
    begin
      if Appointments.find(appointment_id)
	Appointments.delete(appointment_id)
      end
    rescue
      p "no es posible eliminar la cita, el id no existe"
    end
  end
end
