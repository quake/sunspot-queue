require "sunspot/queue/helpers"

module Sunspot::Queue::Sidekiq
  class IndexJob
    include ::Sunspot::Queue::Helpers

    def self.perform(klass, id)
      without_proxy do
        constantize(klass).find(id).solr_index
      end
    end
  end
end
