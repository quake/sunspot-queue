require "sunspot/queue/helpers"

module Sunspot::Queue::Sidekiq
  class RemovalJob
    include ::Sunspot::Queue::Helpers

    def self.perform(klass, id)
      without_proxy do
        ::Sunspot.remove_by_id(klass, id)
      end
    end
  end
end
