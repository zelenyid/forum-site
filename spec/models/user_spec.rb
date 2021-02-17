require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a name' do
    current_user = User.new(
      name: '',
      email: 'qwerty@qwerty.com',
      password: '123456',
      password_confirmation: '123456'
    )

    expect(current_user).to_not be_valid

    current_user.name = 'Barsik'
    expect(current_user).to be_valid
  end

  it 'has an email' do
    current_user = User.new(
      name: 'Barsik',
      email: '',
      password: '123456',
      password_confirmation: '123456'
    )

    expect(current_user).to_not be_valid

    current_user.email = 'qwerty@qwerty.com'
    expect(current_user).to be_valid
  end

  it 'password and password confirmation the same' do
    current_user = User.new(
      name: 'Barsik',
      email: 'qwerty@qwerty.com',
      password: '123456',
      password_confirmation: ''
    )

    expect(current_user).to_not be_valid

    current_user.password_confirmation = '123456'
    expect(current_user).to be_valid
  end

  it 'password presence' do
    current_user = User.new(
      name: 'Barsik',
      email: 'qwerty@qwerty.com',
      password: '',
      password_confirmation: '123456'
    )

    expect(current_user).to_not be_valid

    current_user.password = '123456'
    expect(current_user).to be_valid
  end

  it 'password confirmation presence' do
    current_user = User.new(
      name: 'Barsik',
      email: 'qwerty@qwerty.com',
      password: '123456',
      password_confirmation: ''
    )

    expect(current_user).to_not be_valid

    current_user.password_confirmation = '123456'
    expect(current_user).to be_valid
  end

  it 'password has lenght at least 6 characters' do
    current_user = User.new(
      name: 'Barsik',
      email: 'qwerty@qwerty.com',
      password: '1234',
      password_confirmation: '1234'
    )

    expect(current_user).to_not be_valid

    current_user.password = '123456'
    current_user.password_confirmation = '123456'
    expect(current_user).to be_valid
  end

  it 'email looks like email' do
    current_user = User.new(
      name: 'Barsik',
      email: 'qwerty',
      password: '123456',
      password_confirmation: '123456'
    )

    expect(current_user).to_not be_valid

    current_user.email = 'qwerty@qwerty.com'
    expect(current_user).to be_valid
  end

  it 'name less than 50 characters' do
    current_user = User.new(
      name: 'MbxZw7LmzdoCqPPehYjDhOpIFaK5RVMmWT3sJs4kH2Up0owQaqw', # 51 characters
      email: 'qwerty@qwerty.com',
      password: '123456',
      password_confirmation: '123456'
    )

    expect(current_user).to_not be_valid

    current_user.name = 'MbxZw7LmzdoCqPPehYjDhOpIFaK5RVMmWT3sJs4kH2Up0owQaq'
    expect(current_user).to be_valid
  end

  it 'has array of posts' do
    current_user = User.new(
      name: 'MbxZw7LmzdoCqPPehYjDhOpIFaK5RVMmWT3sJs4kH2Up0owQaqw', # 51 characters
      email: 'qwerty@qwerty.com',
      password: '123456',
      password_confirmation: '123456'
    )

    expect(current_user.posts).to_not be_nil
    expect { current_user.post }.to raise_error(NoMethodError)
  end

  it 'has array of comments' do
    current_user = User.new(
      name: 'MbxZw7LmzdoCqPPehYjDhOpIFaK5RVMmWT3sJs4kH2Up0owQaqw', # 51 characters
      email: 'qwerty@qwerty.com',
      password: '123456',
      password_confirmation: '123456'
    )

    expect(current_user.comments).to_not be_nil
    expect { current_user.comment }.to raise_error(NoMethodError)
  end
end
