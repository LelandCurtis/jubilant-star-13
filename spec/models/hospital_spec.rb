require 'rails_helper'

RSpec.describe Hospital do
  describe 'relationships' do
    it { should have_many(:doctors) }
    it { should have_many(:doctor_patients).through(:doctors) }
    it { should have_many(:patients).through(:doctor_patients) }
  end

  describe 'instance methods' do
    describe '#doctor_count' do
      it "returns the number of doctors that work at this hospital" do
        # edge case: no doctors
        hospital = create(:hospital)
        expect(hospital.doctor_count).to eq(0)

        doctors = create_list(:doctor, 5, hospital: hospital)
        expect(hospital.doctor_count).to eq(5)

        doctors = create_list(:doctor, 3, hospital: hospital)
        expect(hospital.doctor_count).to eq(8)

        doctors = create_list(:doctor, 10)
        expect(hospital.doctor_count).to eq(8)
      end
    end

    describe '#universities' do
      it "returns a list of unique university names that this hospitals doctors attended" do
        hospital = create(:hospital)

        # edge case: no doctors
        expect(hospital.universities).to eq([])

        doctor_1 = create(:doctor, hospital: hospital, university: "Yale")
        doctor_2 = create(:doctor, hospital: hospital, university: "Yale")
        doctor_3 = create(:doctor, hospital: hospital, university: "Harvard")
        doctor_4 = create(:doctor, hospital: hospital, university: "Princeton")

        expect(hospital.universities).to eq(["Harvard", "Princeton", "Yale"])

        doctor_5 = create(:doctor, university: "Stanford")
        expect(hospital.universities).to eq(["Harvard", "Princeton", "Yale"])

        doctor_6 = create(:doctor, hospital: hospital, university: "Stanford")
        expect(hospital.universities).to eq(["Harvard", "Princeton", "Stanford", "Yale"])
      end
    end
  end
end
