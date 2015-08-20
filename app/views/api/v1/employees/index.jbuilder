json.result do
  json.partial! 'employee', :collection => @employees, :as => :employee, :with_vacancies => false
end