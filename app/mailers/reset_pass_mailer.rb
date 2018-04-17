class ResetPassMailer < ApplicationMailer
  default from: 'no-reply@gmail.com'

  def reset_pass_requested
    mail(to: 'd84_fin_analyst@yahoo.com', subject: 'Password reset requested for infinite-loops-chess application')
  end
end
