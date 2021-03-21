class InquiryMailer < ApplicationMailer

  # 環境ファイルにすることで、お問い合わせしたの内容が、ちゃんと自分のsend_mailで設定したアドレスに届く
  default to: ENV['SEND_MAIL'] # 送信元アドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:from => inquiry.email, :subject => 'お問い合わせがあったよ！')
  end

  def send_mail(inquiry)
    @inquiry = inquiry
    mail(:to => inquiry.email, :subject => 'お問い合わせありがとうございます。')
  end



end
