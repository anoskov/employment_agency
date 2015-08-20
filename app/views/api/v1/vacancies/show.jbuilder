json.result do
  json.partial! 'vacancy', :locals => { :vacancy => @vacancy, :with_candidates => true }
end