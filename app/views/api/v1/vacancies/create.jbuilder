json.result do
  if @vacancy.errors.empty?
    json.partial! 'api/v1/layouts/success', locals: {message: 'Вакансия добавлена'}
    json.id @vacancy.id
  else
    json.partial! 'api/v1/layouts/failure', locals: {message: 'Произошла ошибка', errors: @vacancy.errors}
  end
end