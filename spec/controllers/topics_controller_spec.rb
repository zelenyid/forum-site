require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Article. As you add validations to Article, be sure to adjust the attributes here as well.
  # describe 'Guest user on topic page' do
  #   let(:valid_attributes) do
  #     { title: 'New test topic', description: 'This is a test description' }
  #   end

  #   let(:valid_session) { {} }

  #   describe 'GET #index' do
  #     it 'returns a success response' do
  #       Topic.create! valid_attributes
  #       get :index, params: {}, session: valid_session
  #       expect(response).to be_successful
  #     end
  #   end
  # end

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

  describe 'POST #create' do
    it 'redirect to another page response' do
      login admin_user

      post :create, params: { topic: valid_topic_params }

      expect(Topic.first.title).to eq(valid_topic_params[:title])
      expect(Topic.first.description).to eq(valid_topic_params[:description])

      expect(response.code).to eq('302')
    end
  end
end
