module Slack
  class MessageAttachment
    ATTRIBUTES = [*Settings.message.attachment.attributes, :fields].map(&:to_sym).freeze
    attr_accessor *ATTRIBUTES

    def initialize(attributes = {})
      ATTRIBUTES.each{|k,v| send("#{k}=", v) }
      self.fields = []
    end

    def to_json(options = {})
      payload.to_json
    end

    private

    def payload
      Hash.new.tap do |payload|
        ATTRIBUTES.each do |attribute|
          value = send(attribute)
          next unless value || (attribute == :fields && value.empty?)

          payload[attribute] = value
        end
      end
    end
  end
end
