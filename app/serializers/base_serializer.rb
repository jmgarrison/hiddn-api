class BaseSerializer < ActiveModel::Serializer

  attributes :errors

  def errors
    if object.errors.present?
      object.errors.to_hash
    else
      nil
    end
  end

end
