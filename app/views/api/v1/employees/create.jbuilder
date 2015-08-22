json.result do
  if @employee.errors.empty?
    json.partial! 'api/v1/layouts/success', locals: {message: 'Работник добавлен'}
    json.id @employee.id
  else
    json.partial! 'api/v1/layouts/failure', locals: {message: 'Произошла ошибка', errors: @employee.errors}
  end
end