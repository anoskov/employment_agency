describe "Employees API" do

  before :all do
    @employee = create(:employee, :with_all_skills)
    create(:employee, skills: [Skill.first, Skill.last])
  end

  it 'sends a list of Employees' do
    get '/api/v1/employees'
    expect(response).to be_success
    expect(json['result'].length).to eq(2)

    employee = json['result'][0]
    expect(employee['name']).to eq @employee.name
    expect(employee['contact_info']).to eq @employee.contact_info
    expect(employee['job_status']).to eq @employee.job_status
    expect(employee['desired_salary']).to eq @employee.desired_salary
    expect(employee['skills'].length).to eq @employee.skills.length
  end

  it 'show a specific Employee' do
    get "/api/v1/employees/#{@employee.id}"
    expect(response).to be_success

    employee = json['result']
    expect(employee['name']).to eq @employee.name
    expect(employee['contact_info']).to eq @employee.contact_info
    expect(employee['job_status']).to eq @employee.job_status
    expect(employee['desired_salary']).to eq @employee.desired_salary
    expect(employee['skills'].length).to eq @employee.skills.length
    expect(employee['ideal_vacancies'].length).to eq @employee.ideal_vacancies.length
    expect(employee['potential_vacancies'].length).to eq @employee.potential_vacancies.length
  end

  it 'return msg if Employee not found' do
    get "/api/v1/employees/567"
    expect(response).not_to be_success

    expect(json['result']['msg']).to eq 'Запись не найдена'
  end

  context 'new' do
    it 'create a Employee if attributes is valid' do
      attributes = {
              :fname => 'Иванов',
              :lname => 'Максим',
              :sname => 'Валерьевич',
              :contact_info => 'max.ivanov@gmail.com',
              :job_status => 'Ищу работу',
              :desired_salary => 60000,
              :skills_attributes => [{:title => 'Python'}, {:title => 'RSpec'}, {:title => 'Ruby'}]
      }
      post "/api/v1/employees", attributes
      expect(response).to be_success

      expect(json['result']['msg']).to eq 'Работник добавлен'

      expect(Skill.exists?(:title => 'Python')).to be_truthy
      expect(Skill.exists?(:title => 'RSpec')).to be_truthy

      employee = Employee.last
      expect(employee.first_name).to     eq attributes[:fname]
      expect(employee.last_name).to      eq attributes[:lname]
      expect(employee.surname).to        eq attributes[:sname]
      expect(employee.contact_info).to   eq attributes[:contact_info]
      expect(employee.job_status).to     eq attributes[:job_status]
      expect(employee.desired_salary).to eq attributes[:desired_salary]
      expect(employee.skills.length).to  eq 3
    end

    it 'show errors if attributes is invalid' do
      post "/api/v1/employees", {}

      expect(response).to_not be_success
      expect(json['result']['msg']).to eq 'Произошла ошибка'
      expect(json['result']['errors']).not_to be_empty
    end
  end

  context 'destroy' do
    it 'destroy Employee' do
      delete "/api/v1/employees/#{@employee.id}"

      expect(response).to be_success
      expect(json['result']['msg']).to eq 'Работник удален'

      expect(Employee.exists?(:id => @employee.id)).not_to be_truthy
    end

    it 'return msg if Employee not found' do
      delete "/api/v1/employees/567"
      expect(response).not_to be_success

      expect(json['result']['msg']).to eq 'Запись не найдена'
    end
  end

  context 'edit' do
    it 'update a Employee if attributes is valid' do
      attributes = @employee.attributes
      attributes[:fname] = @employee.first_name
      attributes[:lname] = @employee.last_name
      attributes[:sname] = @employee.surname
      attributes[:desired_salary] = 120000
      attributes[:skills_attributes] = [{:title => 'Ruby'}, {:title => 'MySQL'}]

      put "/api/v1/employees/#{@employee.id}", attributes
      expect(response).to be_success

      expect(json['result']['msg']).to eq 'Данные работника обновлены'

      expect(Skill.exists?(:title => 'MySQL')).to be_truthy

      @employee = Employee.find(@employee.id)

      expect(@employee.desired_salary).to eq attributes[:desired_salary]
      expect(@employee.skills.length).to  eq 4
    end

    it 'show errors if attributes is invalid' do
      attributes = @employee.attributes
      attributes[:fname] = 'Andrey'

      put "/api/v1/employees/#{@employee.id}", attributes
      expect(response).not_to be_success

      expect(json['result']['msg']).to eq 'Произошла ошибка'
      expect(json['result']['errors']).not_to be_empty
    end
  end

end