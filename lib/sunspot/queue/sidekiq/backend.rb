require "sunspot/queue/sidekiq/index_job"
require "sunspot/queue/sidekiq/removal_job"

module Sunspot::Queue::Sidekiq
  class Backend
    attr_reader :configuration

    def initialize(configuration = Sunspot::Queue.configuration)
      @configuration = configuration
    end

    def index(klass, id)
      index_job.delay.perform(klass, id)
    end

    def remove(klass, id)
      removal_job.delay.perform(klass, id)
    end

    private

    def index_job
      configuration.index_job || ::Sunspot::Queue::Sidekiq::IndexJob
    end

    def removal_job
      configuration.removal_job || ::Sunspot::Queue::Sidekiq::RemovalJob
    end
  end
end
