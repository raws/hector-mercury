module Hector
  module Mercury
    DELIVER_EVENT = ->(message) do
      if message
        Hector::Mercury::Event.new(message).deliver rescue nil
      end

      Hector::Mercury.poll
    end

    RECEIVE_MESSAGE = -> { Hector::Mercury.queue.receive_message rescue nil }

    def self.poll
      EventMachine.defer RECEIVE_MESSAGE, DELIVER_EVENT
    end
  end
end
