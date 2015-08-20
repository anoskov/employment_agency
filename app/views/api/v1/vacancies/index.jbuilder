json.result do
  json.partial! 'vacancy', :collection => @vacancies, :as => :vacancy, :with_candidates => false
end