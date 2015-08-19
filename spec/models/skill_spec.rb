require 'rails_helper'

RSpec.describe Skill, :type => :model do

  context 'db' do
    context 'indexes' do
      it { should have_db_index(:title).unique(true) }
    end

    context 'columns' do
      it { should have_db_column(:title).of_type(:string).with_options(:null => false) }
    end
  end

  context 'validation' do

    before do
      @skill = create(:skill)
    end

    it "requires title" do
      expect(@skill).to validate_presence_of(:title)
    end

    it "requires unique title" do
      expect(@skill).to validate_uniqueness_of(:title)
    end

    context 'associations' do
      it 'should have many specified skills' do
        expect(@skill).to have_many(:specified_skills).dependent(:delete_all)
      end
    end

  end

end