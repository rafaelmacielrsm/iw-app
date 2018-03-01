class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    attribute_name = attribute.to_s.gsub('_before_type_cast', '').to_sym
    
    begin 
      Date.parse(value) unless value.class == Date       
    rescue ArgumentError
      if value.empty?
        record.errors.add(attribute_name, "can't be blank") 
      else
        record.errors.add(attribute_name, "is not a valid date") 
      end
    end
  end
end