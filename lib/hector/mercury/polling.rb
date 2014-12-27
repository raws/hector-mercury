module Hector
  module Mercury
    DELIVER_EVENT = ->(event) do
      begin
        event.deliver if event
      rescue => error
        Hector::Mercury.log_error_with_backtrace "Error while delivering event: #{error}", error
      ensure
        event = nil
        Hector::Mercury.poll
      end
    end

    RECEIVE_MESSAGE = -> do
      begin
        if message = Hector::Mercury.queue.receive_message
          Hector::Mercury.log :debug, "Received message: #{message.id}"
          Hector::Mercury::Event.new message
        end
      rescue => error
        Hector::Mercury.log_error_with_backtrace "Error while receiving message: #{error}", error
      end
    end

    def self.poll
      EventMachine.defer RECEIVE_MESSAGE, DELIVER_EVENT
    end
  end
end
