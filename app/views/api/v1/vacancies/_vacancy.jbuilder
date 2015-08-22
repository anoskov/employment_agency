json.id              vacancy.id
json.title           vacancy.title
json.salary_begin    vacancy.salary.begin
json.salary_end      vacancy.salary.end
json.contact_info    vacancy.contact_info
json.expiration_date vacancy.expiration_date
json.created_date    vacancy.created_date
json.skills do
  json.array! vacancy.skills, :id, :title
end
if with_candidates
  json.ideal_candidates do
    json.partial! 'employee', :collection => vacancy.ideal_candidates, :as => :employee
  end
  json.potential_candidates do
    json.partial! 'employee', :collection => vacancy.potential_candidates, :as => :employee
  end
end