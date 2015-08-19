class ContactInfoValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'invalid') unless is_email?(value) || is_phone_number?(value)
  end

  private

  def is_email?(value)
    value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  def is_phone_number?(value)
    value =~ /\A\+?(?:[0-9]●?){6,14}[0-9]\z/
  end

end