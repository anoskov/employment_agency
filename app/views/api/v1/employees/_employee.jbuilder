json.id             employee.id
json.fname          employee.first_name
json.lname          employee.last_name
json.sname          employee.surname
json.contact_info   employee.contact_info
json.job_status     employee.job_status
json.desired_salary employee.desired_salary
json.skills do
  json.array! employee.skills, :id, :title
end
if with_vacancies
  json.ideal_vacancies do
    json.partial! 'vacancy', :collection => employee.ideal_vacancies, :as => :vacancy
  end
  json.potential_vacancies do
    json.partial! 'vacancy', :collection => employee.potential_vacancies, :as => :vacancy
  end
end