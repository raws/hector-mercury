module Hector
  module Mercury
    class Payload
      def initialize(json)
        @json = JSON.parse(json, symbolize_names: true)[:event] rescue {}
      end

      def from
        @json[:from]
      end

      def text
        @json[:text]
      end

      def to
        @json[:to]
      end

      def type
        @type ||= (@json[:type] || '').strip.downcase.to_sym
      end

      def valid?
        type_valid? && from_valid? && to_valid? && text_valid?
      end

      private

      def from_valid?
        !!Session.normalize(from)
      rescue ErroneousNickname
        false
      end

      def text_valid?
        text.present?
      end

      def to_valid?
        to.present?
      end

      def type_valid?
        Event::TYPES.include? type
      end
    end
  end
end
