require 'rails_helper'

RSpec.describe "HabitLogs", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/habit_logs/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/habit_logs/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
