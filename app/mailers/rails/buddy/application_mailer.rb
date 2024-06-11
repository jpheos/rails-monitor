# frozen_string_literal: true

module Rails
  module Buddy
    class ApplicationMailer < ActionMailer::Base
      default from: 'from@example.com'
      layout 'mailer'
    end
  end
end
