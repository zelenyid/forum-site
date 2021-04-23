require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:current_user) do
    User.create!(
      name: 'current_user',
      email: 'currentuser@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  topic = Topic.create!(
    title: 'A valid title',
    description: 'qwertyuioq'
  )

  it 'has a title' do
    post = Post.new(
      title: '',
      body: 'A valid test body',
      user: current_user,
      topic: topic
    )

    expect(post).to_not be_valid

    post.title = 'Has a valid test title'
    expect(post).to be_valid
  end

  it 'has a body' do
    post = Post.new(
      title: 'Has a valid test title',
      body: '',
      user: current_user,
      topic: topic
    )

    expect(post).to_not be_valid

    post.body = 'Has a valid test body'
    expect(post).to be_valid
  end

  it 'title length between 5 and 50' do
    post = Post.new(
      title: 'qwer', # 4 characters
      body: 'Has a valid test body',
      user: current_user,
      topic: topic
    )

    expect(post).to_not be_valid

    post.title = 'qwert' # 5 characters
    expect(post).to be_valid

    post.title = 'MbxZw7LmzdoCqPPehYjDhOpIFaK5RVMmWT3sJs4kH2Up0owQaqw' # 51 characters
    expect(post).to_not be_valid

    post.title = 'MbxZw7LmzdoCqPPehYjDhOpIFaK5RVMmWT3sJs4kH2Up0owQaq' # 50 characters
    expect(post).to be_valid

    post.title = 'qwertfasdfas' # 5 characters
    expect(post).to be_valid
  end

  it 'has a body at least 10 characters long' do
    post = Post.new(
      title: 'qwert',
      body: 'qwertyuio', # 9 characters
      user: current_user,
      topic: topic
    )

    expect(post).to_not be_valid

    post.body = 'Has a valid test body'
    expect(post).to be_valid
  end

  it 'has an opportunity to get id of user, who created' do
    post = Post.new(
      title: 'qwert',
      body: 'Has a valid test body',
      user: current_user,
      topic: topic
    )

    expect(post.user_id).to eq(current_user.id)
  end

  it 'has an opportunity to get topic id of this post' do
    post = Post.new(
      title: 'qwert',
      body: 'Has a valid test body',
      user: current_user,
      topic: topic
    )

    expect(post.topic_id).to eq(topic.id)
  end
  it 'has array of comments' do
    post = Post.new(
      title: 'qwert',
      body: 'Has a valid test body',
      user: current_user,
      topic: topic
    )

    expect(post.comments).to_not be_nil
    expect { topic.comment }.to raise_error(NoMethodError)
  end
end
