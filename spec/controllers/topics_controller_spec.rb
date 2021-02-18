require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:admin_user) { create(:user, admin: true) }
  let(:moderator_user) { create(:user, moderator: true) }
  let(:user) { create(:user, user_role: true) }
  let(:guest) { nil }

  let(:valid_topic_params) do
    {
      title: 'hello',
      description: 'qwertyuq qwerty qwert'
    }
  end

  describe 'GET #index' do
    it 'index returns a success response' do
      get :index

      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:topic) { create(:topic) }

    before(:each) do
      topic.save
    end

    it 'admin role returns a success response' do
      login admin_user

      get :show, params: { id: topic.id }

      expect(response).to be_successful
    end

    it 'moderator returns a success response' do
      login moderator_user

      get :show, params: { id: topic.id }

      expect(response).to be_successful
    end

    it 'user role returns a success response' do
      login user

      get :show, params: { id: topic.id }

      expect(response).to be_successful
    end

    it 'guest role returns a success response' do
      get :show, params: { id: topic.id }

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'admin role redirect to another page response' do
      login admin_user

      post :create, params: { topic: valid_topic_params }

      expect(Topic.first.title).to eq(valid_topic_params[:title])
      expect(Topic.first.description).to eq(valid_topic_params[:description])

      expect(response.code).to eq('302')
    end

    it 'moderator role page not found' do
      login moderator_user

      post :create, params: { topic: valid_topic_params }

      expect(response.code).to eq('404')
    end

    it 'user role page not found' do
      login user

      post :create, params: { topic: valid_topic_params }

      expect(response.code).to eq('404')
    end

    it 'guest role page not found' do
      post :create, params: { topic: valid_topic_params }

      expect(response.code).to eq('404')
    end
  end

  describe 'PUT #update' do
    let(:topic) { create(:topic) }

    it 'admin role redirect to another page response' do
      login admin_user
      topic.save

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      put :update, params: { id: topic.id, topic: valid_topic_params }

      expect(Topic.first.title).to eq(valid_topic_params[:title])
      expect(Topic.first.description).to eq(valid_topic_params[:description])

      expect(response.code).to eq('302')
    end

    it 'moderator role page not found' do
      login moderator_user
      topic.save

      put :update, params: { id: topic.id, topic: valid_topic_params }

      expect(response.code).to eq('404')
    end

    it 'user role page not found' do
      login user
      topic.save

      put :update, params: { id: topic.id, topic: valid_topic_params }

      expect(response.code).to eq('404')
    end

    it 'guest role page not found' do
      topic.save

      put :update, params: { id: topic.id, topic: valid_topic_params }

      expect(response.code).to eq('404')
    end
  end

  describe 'PUT #destroy' do
    let(:topic) { create(:topic) }

    it 'admin role redirect to another page response' do
      login admin_user
      topic.save

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      delete :destroy, params: { id: topic.id }

      expect { Topic.find(topic.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response.code).to eq('302')
    end

    it 'moderator role page not found' do
      login moderator_user
      topic.save

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      delete :destroy, params: { id: topic.id }

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      expect(response.code).to eq('404')
    end

    it 'user role page not found' do
      login user
      topic.save

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      delete :destroy, params: { id: topic.id }

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      expect(response.code).to eq('404')
    end

    it 'guest role page not found' do
      topic.save

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      delete :destroy, params: { id: topic.id }

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      expect(response.code).to eq('404')
    end
  end
end
