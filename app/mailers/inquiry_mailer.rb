class InquiryMailer < ApplicationMailer

  # default to: "example@example.com"   # 送信元アドレス
  default to: ENV['SEND_MAIL'] # 送信元アドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:from => inquiry.email, :subject => 'お問い合わせがあったよ！')
  end

end
