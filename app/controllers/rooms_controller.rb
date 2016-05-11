# Contoller for Rooms, where the user can see and assing shifts
class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end
end
