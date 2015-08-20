json.id             employee.id
json.name           employee.name
json.contact_info   employee.contact_info
json.job_status     employee.job_status
json.desired_salary employee.desired_salary
json.skills do
  json.array! employee.skills, :id, :title
end