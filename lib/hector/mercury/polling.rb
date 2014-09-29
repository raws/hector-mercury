module Hector
  module Mercury
    DELIVER_EVENT = ->(event) do
      begin
        event.deliver if event
      rescue
      ensure
        event = nil
        Hector::Mercury.poll
      end
    end

    RECEIVE_MESSAGE = -> do
      begin
        if message = Hector::Mercury.queue.receive_message
          Hector::Mercury::Event.new message
        end
      rescue
      end
    end

    def self.poll
      EventMachine.defer RECEIVE_MESSAGE, DELIVER_EVENT
    end
  end
end
