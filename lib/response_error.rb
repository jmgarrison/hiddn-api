class ResponseError

  TRANSLATION_SCOPE = 'responses.errors.'

  class << self
    def detail(detail = nil)
      @@detail = detail if detail
      @@detail
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

      detail = if @detail.is_a?(Symbol)
        I18n.t(TRANSLATION_SCOPE + @@detail.to_s)
      else
        @@detail
      end

      { detail: detail, status: status }
    end
  end

end
