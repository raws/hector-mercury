### hector-mercury

hector-mercury is a [Hector](https://github.com/sstephenson/hector) extension that lets you push events to your IRC server through an [Amazon SQS](http://aws.amazon.com/sqs/) message queue.

### Usage

In your Hector configuration, load hector-mercury and set up your AWS credentials and SQS queue URL.

```ruby
require 'hector/mercury'

Hector::Mercury.aws_access_key_id = 'VUFUSMZRQSJABJIASEFR'
Hector::Mercury.aws_secret_access_key = 'fhAe8w26O20xm7XNHqo7770CkGTb6YItPvdVVf7xPas'
Hector::Mercury.aws_sqs_queue_url = 'https://sqs.us-east-1.amazonaws.com/4097995653735/my-queue'
```

To push an event to Hector, send a message to your SQS queue with a JSON-encoded body like this:

```json
{
  "event": {
    "type": "message",
    "from": "Wheaties",
    "to": "#perkele",
    "text": "Hello world!"
  }
}
```

Where the `event` object contains these keys:

* `type` -- The event type. The only valid option is `message`.
* `from` -- The nickname from which the event is delivered. You can deliver messages from any nickname, even if nobody with that name is currently connected to the server.
* `to` -- The channel or nickname to which the event is delivered. By specifying a nickname, you can send private messages.
* `text` -- The message text to send.

In order to process messages, your AWS user must be allowed to perform the following actions on your SQS queue:

* `sqs:ChangeMessageVisibility`
* `sqs:DeleteMessage`
* `sqs:GetQueueAttributes`
* `sqs:ReceiveMessage`

### License

(The MIT license)

Copyright (c) 2014 Ross Paffett

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
