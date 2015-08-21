describe "Skills API" do

  before :all do
    @employee = create(:employee, :with_all_skills)
  end

  it 'sends a list of Skills' do
    get '/api/v1/skills'
    expect(response).to be_success
    expect(json['result'].length).to eq(3)
  end

end