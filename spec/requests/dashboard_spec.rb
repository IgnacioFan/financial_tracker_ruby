require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  let!(:user) { create(:user) }

  before { sign_in(user) }

  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end
end
