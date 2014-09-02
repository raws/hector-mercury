module Hector
  module Mercury
    class Event
      TYPES = %i(action message)

      def initialize(message)
        @message = message
        @payload = Payload.new(@message.body)
      end

      def deliver
        if valid?
          deliver_based_on_type
          delete_message
        end
      end

      private

      def delete_message
        EventMachine.defer { @message.delete }
      end

      def deliver_action
        # TODO Deliver a real action
        deliver_message
      end

      def deliver_based_on_type
        case type
        when :action then deliver_action
        when :message then deliver_message
        end
      end

      def deliver_message
        case to
        when Channel
          to.broadcast :privmsg, to.name, source: source, text: text
        when Session
          to.respond_with :privmsg, to.nickname, source: source, text: text
        end
      end

      def find_channel(name)
        Channel.find name
      rescue NoSuchChannel
        nil
      end

      def find_session(name)
        Session.find name
      rescue ErroneousNickname
        nil
      end

      def from
        @payload.from.strip
      end

      def source
        "#{from}!#{username}@#{Hector.server_name}"
      end

      def text
        @payload.text
      end

      def to
        @to ||= find_channel(@payload.to) || find_session(@payload.to)
      end

      def type
        @payload.type
      end

      def username
        from.downcase.parameterize
      end

      def valid?
        @payload.valid?
      end
    end
  end
end
