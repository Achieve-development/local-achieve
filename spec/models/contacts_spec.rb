require 'rails_helper'

describe Contact do
  # 名前とメールアドレスと内容があれば有効な状態であること
  it "is valid with title, email, cont " do
    contact = Contact.new(name: '宮岡', email: 'hogehoge@example.com', message: '暑いです')
    expect(contact).to be_valid
  end

  # 名前がなければ無効であること
  it "is invalid without a title" do
    contact = Contact.new(name: '', email: 'hogehoge@example.com', message: '暑いです')
    expect(contact).not_to be_valid
  end

  # メールアドレスがなければ無効であること
  it "is invalid without a title" do
    contact = Contact.new(name: '宮岡', email: '', message: '暑いです')
    expect(contact).not_to be_valid
  end

  # 内容がなければ無効であること
  it "is invalid without a message" do
    contact = Contact.new(name: '宮岡', email: 'hogehoge@example.com', message: '')
    expect(contact).not_to be_valid
  end

  # メールアドレスのフォーマットが正しくなければ無効であること
  it "is invalid format with a email" do
    contact = Contact.new(name: '宮岡', email: 'hogehogeexamplecom', message: '')
    expect(contact).not_to be_valid
  end

end
