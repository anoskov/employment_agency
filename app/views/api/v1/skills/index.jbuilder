json.result do
  json.partial! 'skill', :collection => @skills, :as => :skill
end