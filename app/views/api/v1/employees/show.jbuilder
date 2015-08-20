json.result do
  json.partial! 'employee', :locals => { :employee => @employee, :with_vacancies => true }
end