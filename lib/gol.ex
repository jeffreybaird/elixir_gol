defmodule Gol do

  def simulate(grid, [], 0) do
    IO.inspect grid
  end

  def simulate(grid, [], number_of_steps) do
    IO.inspect(grid)
    Grid.step(grid)
      |> simulate([],number_of_steps-1)
  end

  def simulate({width, height},[starting_position_tuple | tail], number_of_steps) do
    g = Grid.new(width, height)
    Grid.update_grid(:spawn, g, starting_position_tuple)
      |> simulate(tail,number_of_steps)
  end

  def simulate(grid,[starting_position_tuple | tail], number_of_steps) do
    Grid.update_grid(:spawn, grid, starting_position_tuple)
      |> simulate(tail,number_of_steps)
  end

end
