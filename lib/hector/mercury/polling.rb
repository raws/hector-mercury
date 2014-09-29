module Hector
  module Mercury
    DELIVER_EVENT = ->(message) do
      begin
        if message
          Hector::Mercury::Event.new(message).deliver
        end
      rescue
      ensure
        message = nil
        Hector::Mercury.poll
      end
    end

    RECEIVE_MESSAGE = -> do
      Hector::Mercury.queue.receive_message rescue nil
    end

    def self.poll
      EventMachine.defer RECEIVE_MESSAGE, DELIVER_EVENT
    end
  end
end
