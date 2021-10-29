# --Queues
Sidekiq::Queue.all

Sidekiq::Queue.new # the "default" queue
Sidekiq::Queue.new('mailer')

Sidekiq::Queue.new.size

queue = Sidekiq::Queue.new('mailer')
queue.each do |job|
  job.klass # => 'MyWorker'
  job.args # => [1, 2, 3]
  # See also `display_class` and `display_args` methods if your job is wrapped by the ActiveJob adapter some other extension.
  # to get the original job class and only the job arguments.
  job.delete if job.jid == 'abcdef1234567890'
end

Sidekiq::Queue.new.find_job(somejid)

# ---Named Queues

time = Time.zone.now.to_f
jid = '80b1e7e46381a20c0c567285'
Sidekiq::ScheduledSet.new.delete_by_jid(time, jid)

# --- Bulk Queueing
200.times do |idx|
  # each loader job will push 1000 jobs of some other type
  Loader.perform_async(idx)
end

class Loader
  include Sidekiq::Worker
  SIZE = 1000

  def perform(idx)
    # assume we want to create a job for each of 200,000 database records
    # query for our set of 1000 records
    results = SomeModel.limit(SIZE).offset(idx * SIZE).select(:id)
    # push 1000 jobs in one network call to Redis, saves 999 round trips
    Sidekiq::Client.push_bulk('class' => SomeJob, 'args' => results.map { |x| [x.id] })
  end
end
