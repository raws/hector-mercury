require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require 'aws-sdk'
require 'json'

require 'hector/mercury/boot'
require 'hector/mercury/event'
require 'hector/mercury/payload'
require 'hector/mercury/polling'

Hector::Mercury.start
