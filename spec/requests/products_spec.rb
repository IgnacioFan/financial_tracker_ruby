require 'rails_helper'

RSpec.describe "/products", type: :request do
  
  let(:valid_attributes) {
    {
      name: "product name",
      description: "product desc",
      price: 10
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      description: "product desc",
      price: 10
    }
  }

  let!(:user) { create(:user) }

  before { sign_in(user) }

  describe "GET /index" do
    before { create_list(:product, 3, user: user) }

    it "renders a successful response" do
      get products_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_product_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "GET /edit" do
    let(:product) { create(:product, user: user) }

    it "renders a successful response" do
      get edit_product_url(product)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Product" do
        expect {
          post products_url, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it "redirects to the products list" do
        post products_url, params: { product: valid_attributes }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Product" do
        expect {
          post products_url, params: { product: invalid_attributes }
        }.to change(Product, :count).by(0)
      end

      it "display the 'new' template" do
        post products_url, params: { product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH /update" do
    let(:product) { create(:product, user: user) }

    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "new product name",
          description: "new product desc",
          price: 100
        }
      }

      it "updates the requested product" do
        patch product_url(product), params: { product: new_attributes }
        product.reload
        expect(product.reload).to have_attributes(new_attributes)
      end

      it "redirects to the products list" do
        patch product_url(product), params: { product: new_attributes }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_url)
      end
    end

    context "with invalid parameters" do
      it "display the 'edit' template" do
        patch product_url(product), params: { product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:product) { create(:product, user: user) }

    it "destroys the requested product" do
      expect {
        delete product_url(product)
      }.to change(Product, :count).from(1).to(0)
    end

    it "redirects to the products list" do
      delete product_url(product)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(products_url)
    end
  end
end
