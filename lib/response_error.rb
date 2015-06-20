class ResponseError

  TRANSLATION_SCOPE = 'responses.errors.'

  class << self
    def message(message = nil)
      @@message = message if message
      @@message
    end

    def status(status = nil)
      @@status = status if status
      @@status
    end

    def to_json(options = {})
      as_json.to_json
    end

    def as_json(options = {})
      status = if @@status.is_a?(Symbol)
        Rack::Utils::SYMBOL_TO_STATUS_CODE[@status]
      else
        @@status
      end

      message = if @message.is_a?(Symbol)
        I18n.t(TRANSLATION_SCOPE + @@message.to_s)
      else
        @@message
      end

      { message: message, status: status }
    end
  end

end
