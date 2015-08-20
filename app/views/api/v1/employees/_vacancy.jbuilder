json.title           vacancy.title
json.salary_begin    vacancy.salary.begin
json.salary_end      vacancy.salary.end
json.contact_info    vacancy.contact_info
json.expiration_date vacancy.expiration_date
json.created_date    vacancy.created_date
json.skills do
  json.array! vacancy.skills, :id, :title
end