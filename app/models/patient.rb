class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :medics, :through => :appointments
  
  def showAppointments
    cuento=Appointments.where(:patient_id=>self.id)
    cuento.each do |apmnt|
      print apmnt
    end
  end
  
end
