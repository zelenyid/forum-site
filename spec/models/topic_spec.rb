require 'rails_helper'

RSpec.describe Topic, type: :model do
  it 'has a title' do
    topic = Topic.new(
      title: '',
      description: 'The description for new test post'
    )

    expect(topic).to_not be_valid
    topic.title = 'A valid title'

    expect(topic).to be_valid
  end

  it 'has a description' do
    topic = Topic.new(
      title: 'A valid title',
      description: ''
    )

    expect(topic).to_not be_valid

    topic.description = 'Has a valid test description'
    expect(topic).to be_valid
  end

  it 'has a description at least 10 characters long' do
    topic = Topic.new(
      title: 'A valid title',
      description: 'qwertyuio' # 9 characters
    )

    expect(topic).to_not be_valid

    topic.description = 'qwertyuiop' # 10 characters
    expect(topic).to be_valid
  end

  it 'has array of posts' do
    topic = Topic.new(
      title: 'A valid title',
      description: 'qwertyuioq'
    )

    expect(topic.posts).to_not be_nil
    expect { topic.post }.to raise_error(NoMethodError)
  end
end
