require 'rails_helper'

RSpec.describe 'doctor show page' do
  it "shows all of the doctors information" do
    doctor = create(:doctor, name: 'Bob', speciality: 'eye stuff', university: 'Yale')

    visit(doctor_path(doctor))

    expect(page).to have_content('Bob')
    expect(page).to have_content('eye stuff')
    expect(page).to have_content('Yale')
  end

  it "shows the name where the doctor works" do
    hospital = create(:hospital, name: 'Judes')
    doctor = create(:doctor, hospital: hospital)

    visit(doctor_path(doctor))

    within "div.hospital" do
      expect(page).to have_content("Judes")
    end
  end

  it "shows the names of all patients that this doctor has" do
    doctor = create(:doctor)
    patient_1 = create(:patient_with_doctor, name: "Billy", doctor: doctor)
    patient_2 = create(:patient_with_doctor, name: "Amy", doctor: doctor)
    patient_3 = create(:patient_with_doctor, name: "Charlie", doctor: doctor)

    visit(doctor_path(doctor))

    within "div.patients" do
      expect(page).to have_content('Billy')
      expect(page).to have_content('Amy')
      expect(page).to have_content('Charlie')
    end
  end
end