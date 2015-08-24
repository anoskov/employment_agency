describe "Vacancies API" do

  before :all do
    @vacancy = create(:vacancy, :with_all_skills)
    create(:vacancy, skills: [Skill.first, Skill.last])
  end

  it 'sends a list of Vacancies' do
    get '/api/v1/vacancies'
    expect(response).to be_success
    expect(json['result'].length).to eq(2)

    vacancy = json['result'][0]
    expect(vacancy['title']).to eq @vacancy.title
    expect(vacancy['expiration_date']).to eq @vacancy.expiration_date.strftime('%Y-%m-%d')
    expect(vacancy['created_date']).to eq @vacancy.created_date
    expect(vacancy['contact_info']).to eq @vacancy.contact_info
    expect(vacancy['salary_begin']).to eq @vacancy.salary.begin
    expect(vacancy['salary_end']).to eq @vacancy.salary.end + 1
    expect(vacancy['skills'].length).to eq @vacancy.skills.length

  end

  it 'show a specific Vacancy' do
    get "/api/v1/vacancies/#{@vacancy.id}"
    expect(response).to be_success

    vacancy = json['result']
    expect(vacancy['title']).to eq @vacancy.title
    expect(vacancy['expiration_date']).to eq @vacancy.expiration_date.strftime('%Y-%m-%d')
    expect(vacancy['created_date']).to eq @vacancy.created_date
    expect(vacancy['contact_info']).to eq @vacancy.contact_info
    expect(vacancy['salary_begin']).to eq @vacancy.salary.begin
    expect(vacancy['salary_end']).to eq @vacancy.salary.end + 1
    expect(vacancy['skills'].length).to eq @vacancy.skills.length
    expect(vacancy['ideal_candidates'].length).to eq @vacancy.ideal_candidates.length
    expect(vacancy['potential_candidates'].length).to eq @vacancy.potential_candidates.length
  end

  it 'return msg if Vacancy not found' do
    get "/api/v1/vacancies/567"
    expect(response).not_to be_success

    expect(json['result']['msg']).to eq 'Запись не найдена'
  end

  context 'new' do
    it 'create a Vacancy if attributes is valid' do
      attributes = {
          :title => 'Senior developer',
          :expiration_date => Date.new(2015, 8, 30),
          :contact_info => 'e-mail: hr@example.com',
          :salary_begin => 90000,
          :salary_end => 100000,
          :skills_attributes => [{:title => 'Python'}, {:title => 'RSpec'}, {:title => 'Ruby'}]
      }
      post "/api/v1/vacancies", attributes
      expect(response).to be_success

      expect(json['result']['msg']).to eq 'Вакансия добавлена'

      expect(Skill.exists?(:title => 'Python')).to be_truthy
      expect(Skill.exists?(:title => 'RSpec')).to be_truthy

      vacancy = Vacancy.last
      expect(vacancy.title).to                eq attributes[:title]
      expect(vacancy.expiration_date).to      eq attributes[:expiration_date]
      expect(vacancy.contact_info).to         eq attributes[:contact_info]
      expect(vacancy.salary.begin).to         eq attributes[:salary_begin]
      expect(vacancy.salary.end).to           eq attributes[:salary_end]
      expect(vacancy.skills.length).to  eq 3
    end

    it 'show errors if attributes is invalid' do
      post "/api/v1/vacancies", {}

      expect(response).to_not be_success
      expect(json['result']['msg']).to eq 'Произошла ошибка'
      expect(json['result']['errors']).not_to be_empty
    end
  end

  context 'destroy' do
    it 'destroy Vacancy' do
      delete "/api/v1/vacancies/#{@vacancy.id}"

      expect(response).to be_success
      expect(json['result']['msg']).to eq 'Вакансия удалена'

      expect(Vacancy.exists?(:id => @vacancy.id)).not_to be_truthy
    end

    it 'return msg if Vacancy not found' do
      delete "/api/v1/vacancies/567"
      expect(response).not_to be_success

      expect(json['result']['msg']).to eq 'Запись не найдена'
    end
  end

  context 'edit' do
    it 'update a Vacancy if attributes is valid' do
      attributes = @vacancy.attributes
      attributes[:salary_begin] = 50000
      attributes[:salary_end]   = 60000
      attributes[:expiration_date] = Date.new(2015, 10, 4)
      attributes[:skills_attributes] = [{:title => 'Ruby'}, {:title => 'MySQL'}]

      put "/api/v1/vacancies/#{@vacancy.id}", attributes
      expect(response).to be_success

      expect(json['result']['msg']).to eq 'Вакансия обновлена'

      expect(Skill.exists?(:title => 'MySQL')).to be_truthy

      @vacancy = Vacancy.find(@vacancy.id)

      expect(@vacancy.salary.begin).to    eq attributes[:salary_begin]
      expect(@vacancy.salary.end).to      eq attributes[:salary_end]
      expect(@vacancy.expiration_date).to eq attributes[:expiration_date]
      expect(@vacancy.skills.length).to  eq 2
    end
  end

end