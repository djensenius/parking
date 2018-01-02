# frozen_string_literal: true

module ActionMailerHelpers
  include ActiveJob::TestHelper

  def must_enqueue_action_mailer_job(mailer_class, mailer_method, *args)
    must_enqueue_jobs(1) { yield }
    action_mailer_job_must_be_enqueued(mailer_class, mailer_method, *args)
  end

  ["must", "wont"].each do |verb|
    define_method "action_mailer_job_#{verb}_be_enqueued" do |mailer_class, mailer_method, *args|
      _(enqueued_jobs).public_send "#{verb}_include",
                                   action_mailer_job(mailer_class, mailer_method, *args)
    end
  end

private

  def action_mailer_job(mailer_class, mailer_method, *args)
    {
      job: ActionMailer::DeliveryJob,
      args: [
        mailer_class.to_s,
        mailer_method,
        "deliver_now",
        *ActiveJob::Arguments.serialize(args)
      ],
      queue: "mailers"
    }
  end
end
