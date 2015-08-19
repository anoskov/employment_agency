class NameValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'allowed only cyrillic chars') unless value =~ /\A[А-Яа-я]+\z/
  end

end