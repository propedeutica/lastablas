require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  context "When user logged in" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
    end

    it "#GET index" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "#GET new" do
      get :new
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#POST create" do
      expect do
        post :create, room: {name: "Aula 666", capacity: 666}
      end.to change(Room.all, :count).by(0)
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#GET show" do
      room = FactoryGirl.build_stubbed(:room)
      get :show, id: room.id
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#GET edit" do
      room = FactoryGirl.build_stubbed(:room)
      get :edit, id: room.id
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#PUT update" do
      room = FactoryGirl.create(:room)
      put :update, id: room.id, room: {name: "Aula 666", capacity: 666}
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#DELETE destroy" do
      room = FactoryGirl.build_stubbed(:room)
      expect { delete :destroy, id: room.id }.to change(Room.all, :count).by(0)
      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  context "When admin logged in" do
    let(:admin) { FactoryGirl.create(:admin) }
    before(:each) do
      sign_in admin
    end

    it "#GET index" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "#GET new" do
      get :new
      expect(response).to have_http_status(:success)
    end

    describe "#POST create" do
      it "succesfully" do
        expect do
          post :create, room: {name: "Aula 666", capacity: 666}
        end.to change(Room.all, :count).by(1)
        expect(response).to have_http_status(:success)
      end
      it "without name" do
        expect do
          post :create, room: {name: nil, capacity: -0}
        end.to change(Room.all, :count).by(0)
        expect(response).to redirect_to(new_room_path)
      end
      it "with negative capacity" do
        expect do
          post :create, room: {name: "Aula 666", capacity: -0}
        end.to change(Room.all, :count).by(0)
        expect(response).to redirect_to(new_room_path)
      end
      it "without capacity" do
        expect do
          post :create, room: {name: "Aula 666"}
        end.to change(Room.all, :count).by(0)
        expect(response).to redirect_to(new_room_path)
      end
    end

    describe "#GET show" do
      it "existing room" do
        room = FactoryGirl.create(:room)
        get :show, id: room.id
        expect(response).to have_http_status(:success)
      end
      it "non-existing room" do
        get :show, id: -1
        expect(response).to redirect_to(home_path)
      end
    end

    describe "#GET edit" do
      it "existing room" do
        room = FactoryGirl.create(:room)
        get :edit, id: room.id
        expect(response).to have_http_status(:success)
      end
      it "non-existing room" do
        get :edit, id: -1
        expect(response).to redirect_to(home_path)
      end
    end

    describe "#PUT update" do
      it "succesfully" do
        room = FactoryGirl.create(:room)
        put :update, id: room.id, room: {name: "Aula 666", capacity: 666}
        expect(response).to have_http_status(:success)
      end
      it "non-existing room" do
        put :update, id: -1, room: {name: "Aula 666", capacity: 666}
        expect(response).to redirect_to(rooms_path)
      end
    end

    describe "#DELETE destroy" do
      it "succesfully" do
        room = FactoryGirl.create(:room)
        expect { delete :destroy, id: room.id }.to change(Room.all, :count).by(-1)
        expect(response).to redirect_to(rooms_path)
      end
      it "non-existing room" do
        expect { delete :destroy, id: -1 }.to change(Room.all, :count).by(0)
        expect(response).to redirect_to(rooms_path)
      end
    end
  end

  context "When NOT logged in" do
    it "#GET index" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "#GET new" do
      get :new
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#POST create" do
      expect do
        post :create, room: {name: "Aula 666", capacity: 666}
      end.to change(Room.all, :count).by(0)
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#GET show" do
      room = FactoryGirl.build_stubbed(:room)
      get :show, id: room.id
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#GET edit" do
      room = FactoryGirl.build_stubbed(:room)
      get :edit, id: room.id
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#PUT update" do
      room = FactoryGirl.create(:room)
      put :update, id: room.id, room: {name: "Aula 666", capacity: 666}
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#DELETE destroy" do
      room = FactoryGirl.build_stubbed(:room)
      expect { delete :destroy, id: room.id }.to change(Room.all, :count).by(0)
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
