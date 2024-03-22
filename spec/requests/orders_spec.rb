require 'rails_helper'

RSpec.describe "/orders", type: :request do
  
  let(:valid_attributes) {
    {
      status: "pending"
    }
  }

  let(:invalid_attributes) {
    {
      status: "nothing"
    }
  }

  let!(:user) { create(:user) }

  before { sign_in(user) }

  describe "GET /index" do
    before { create_list(:order, 3, creator: user) }

    it "renders a successful response" do
      get orders_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_order_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "GET /edit" do
    let(:order) { create(:order, creator: user) }

    it "renders a successful response" do
      get edit_order_url(order)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Order" do
        expect {
          post orders_url, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
      end

      it "redirects to the created order" do
        post orders_url, params: { order: valid_attributes }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(orders_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Order" do
        expect {
          post orders_url, params: { order: invalid_attributes }
        }.to change(Order, :count).by(0)
      end

      it "display the 'new' template" do
        post orders_url, params: { order: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)      
      end
    end
  end

  describe "PATCH /update" do
    let(:order) { create(:order, creator: user) }

    context "with valid parameters" do
      let(:new_attributes) {
        {
          status: "paid"
        }
      }

      it "updates the requested order" do
        patch order_url(order), params: { order: new_attributes }
        order.reload
        expect(order).to have_attributes(new_attributes)
      end

      it "redirects to the order" do
        patch order_url(order), params: { order: new_attributes }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(orders_url)
      end
    end

    context "with invalid parameters" do
      it "display the 'edit' template" do
        patch order_url(order), params: { order: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:order) { create(:order, creator: user) }

    it "destroys the requested order" do
      expect {
        delete order_url(order)
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      delete order_url(order)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(orders_url)
    end
  end
end
