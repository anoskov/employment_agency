require 'rails_helper'

RSpec.describe Vacancy, :type => :model do

  context 'db' do
    context 'columns' do
      it { should have_db_column(:title).of_type(:string).with_options(:null => false) }
      it { should have_db_column(:expiration_date).of_type(:date).with_options(:null => false) }
      it { should have_db_column(:salary).of_type(:int4range).with_options(:null => false) }
      it { should have_db_column(:contact_info).of_type(:text).with_options(:null => false) }
      it { should have_db_column(:created_at).of_type(:datetime).with_options(:null => false) }
    end
  end

  before :all do
    @vacancy = create(:vacancy, :with_all_skills)
  end

  context 'attributes' do

    it 'should hack pg bug' do
      expect(@vacancy).to have_attributes(:salary => 70000..100000)
    end

    context 'associations' do

      it 'should accept nested attributes for skills' do
        expect(@vacancy).to accept_nested_attributes_for(:skills)
      end

      it 'have many specified skills' do
        expect(@vacancy).to have_many(:specified_skills).dependent(:delete_all)
      end

      it 'have many skills' do
        expect(@vacancy).to have_many(:skills).through(:specified_skills)
        expect(Skill.first).to eq @vacancy.skills.first
      end

      it 'have many ideal candidates' do
        expect(@vacancy).to have_many(:ideal_candidates).through(:total_matches)
        @employee = create(:employee, :skills => [*Skill.all])
        expect(@vacancy.ideal_candidates.first).to eq @employee
      end

      it 'have many potential candidates' do
        expect(@vacancy).to have_many(:ideal_candidates).through(:total_matches)
        @employee = create(:employee, :skills => [Skill.first, Skill.last])
        expect(@vacancy.potential_candidates.first).to eq @employee
      end

    end

  end

  context 'validation' do

    it "requires title" do
      expect(@vacancy).to validate_presence_of(:title)
    end

    it "requires expiration date" do
      expect(@vacancy).to validate_presence_of(:expiration_date)
    end

    it "requires contact info" do
      expect(@vacancy).to validate_presence_of(:contact_info)
    end

    it "requires salary" do
      expect(@vacancy).to validate_presence_of(:salary)
    end

    it "requires skills" do
      expect(@vacancy).to validate_presence_of(:skills)
    end

  end

end