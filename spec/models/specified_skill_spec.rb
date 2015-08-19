require 'rails_helper'

RSpec.describe SpecifiedSkill, :type => :model do

  context 'db' do
    context 'indexes' do
      it { should have_db_index(["owner_id", "owner_type"]).unique(false) }
      it { should have_db_index("skill_id").unique(false) }
    end

    context 'columns' do
      it { should have_db_column(:owner_id).of_type(:integer).with_options(:null => false) }
      it { should have_db_column(:owner_type).of_type(:string).with_options(:null => false) }
      it { should have_db_column(:skill_id).of_type(:integer).with_options(:null => false) }
    end
  end

  context 'association' do
    it { should belong_to(:skill) }
    it { should belong_to(:owner) }
  end

end