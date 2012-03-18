class Medic < ActiveRecord::Base
  has_many:appointments
  has_many:patients, :through => :appointments
  
  def showAppointments
    cuento=Appointments.where(:medic_id=>self.id)
    cuento.each do |apmnt|
      print apmnt
    end
  end
  
end
