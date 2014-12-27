module Hector
  module Mercury
    class << self
      attr_accessor :aws_access_key_id, :aws_secret_access_key, :aws_sqs_queue_url
      attr_reader :queue

      def load_queue
        sqs = AWS::SQS.new(access_key_id: aws_access_key_id,
          secret_access_key: aws_secret_access_key)
        @queue = sqs.queues[aws_sqs_queue_url]

        Hector::Mercury.log :debug, "Listening on queue: #{@queue.arn}"
      end

      def start
        EventMachine.schedule do
          load_queue
          poll
        end
      end
    end
  end
end
