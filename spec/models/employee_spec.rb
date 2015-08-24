require 'rails_helper'

RSpec.describe Employee, :type => :model do

  context 'db' do
    context 'columns' do
      it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
      it { should have_db_column(:contact_info).of_type(:string).with_options(:null => false) }
      it { should have_db_column(:job_status).of_type(:string).with_options(:null => false) }
      it { should have_db_column(:desired_salary).of_type(:integer).with_options(:null => false) }
    end
  end

  before :all do
    @employee = create(:employee, :with_all_skills)
  end

  context 'attributes' do

    it "has first name" do
      expect(@employee).to have_attributes(:fname => 'Андрей')
      expect(@employee).to have_attributes(:first_name => 'Андрей')
    end

    it "has last name" do
      expect(@employee).to have_attributes(:lname => 'Носков')
      expect(@employee).to have_attributes(:last_name => 'Носков')
    end

    it "has surname" do
      expect(@employee).to have_attributes(:sname => 'Геннадьевич')
      expect(@employee).to have_attributes(:surname => 'Геннадьевич')
    end

    it "has name" do
      expect(@employee).to have_attributes(:name => 'Носков Андрей Геннадьевич')
    end

    context 'associations' do

      it 'should accept nested attributes for skills' do
        expect(@employee).to accept_nested_attributes_for(:skills)
      end

      it 'have many specified skills' do
        expect(@employee).to have_many(:specified_skills).dependent(:delete_all)
      end

      it 'have many skills' do
        expect(@employee).to have_many(:skills).through(:specified_skills)
        expect(Skill.first).to eq @employee.skills.first
      end

      it 'have many ideal vacancies' do
        expect(@employee).to have_many(:ideal_vacancies).through(:total_matches)
        @vacancy = create(:vacancy, skills: [*Skill.all])
        expect(@employee.ideal_vacancies.first).to eq @vacancy
      end

      it 'have many potential vacancies' do
        expect(@employee).to have_many(:potential_vacancies).through(:partial_matches)
        @vacancy = create(:vacancy, skills: [*Skill.all, create(:skill, :title => 'Python')])
        expect(@employee.potential_vacancies.first).to eq @vacancy
      end

    end

  end

  context 'validation' do

    it "requires first name" do
      expect(@employee).to validate_presence_of(:fname)
    end

    it "requires last name" do
      expect(@employee).to validate_presence_of(:lname)
    end

    it "requires surname" do
      expect(@employee).to validate_presence_of(:sname)
    end

    it "requires job status" do
      expect(@employee).to validate_presence_of(:job_status)
    end

    it "requires desired salary" do
      expect(@employee).to validate_presence_of(:desired_salary)
    end

    it "requires skills" do
      expect(@employee).to validate_presence_of(:skills)
    end

    it "job status inclusion in acceptable statuses" do
      expect(@employee).to validate_inclusion_of(:job_status)
                               .in_array(['Ищу работу', 'Не ищу работу'])
    end

    context 'custom validations' do

      context 'name' do
        it { should allow_value('Андрей').for(:fname) }
        it { should_not allow_value('Anдрей').for(:fname) }
        it { should allow_value('Носков').for(:lname) }
        it { should_not allow_value('Носkov').for(:lname) }
        it { should allow_value('Геннадьевич').for(:sname) }
        it { should_not allow_value('Геннаdyevich').for(:sname) }
      end

      context 'contact info' do
        it { should allow_value('test@mail.com').for(:contact_info) }
        it { should allow_value('+79651884050').for(:contact_info) }
        it { should_not allow_value('test@mail.com79651113344').for(:contact_info) }
        it { should_not allow_value('14565').for(:contact_info) }
        it { should_not allow_value('asaasd%#@@mail.com').for(:contact_info) }
      end

    end

  end

end