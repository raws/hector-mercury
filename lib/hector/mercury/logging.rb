module Hector
  module Mercury
    def self.log(level, message)
      message = '[Mercury] ' + message
      Hector.logger.public_send level, message
    end

    def self.log_error_with_backtrace(message, error)
      ([message] + error.backtrace).each do |line|
        Hector::Mercury.log :error, line
      end
    end
  end
end
