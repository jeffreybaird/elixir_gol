defmodule GridTest do
  use ExUnit.Case
  doctest Grid

  test "Grid" do
    assert Grid.new(3,3) == [[0,0,0],
                                              [0,0,0],
                                              [0,0,0]]
  end

  test "step" do
    g = [[0,0,0],
            [1,0,0],
            [0,0,0]]
    assert Grid.step(g) == [[0,0,0],
                                            [0,0,0],
                                            [0,0,0]]
  end

  test "step 2" do
    g = [[0,0,0],
            [1,1,1],
            [0,0,0]]

    assert Grid.step(g) == [[0,1,0],
                                            [0,1,0],
                                            [0,0,0]]
  end

  test "step 3" do

    g =  [[0,1,0],
              [1,1,1],
              [0,0,0]]
    assert Grid.step(g) ==  [[1, 1,1],
                                            [1, 1, 1],
                                            [0, 0, 0]]
  end

  test "step 4" do
    g =   [[1,1,1],
              [1,1,1],
              [0,0,0]]
    assert Grid.step(g) == [[1,0,1],
                                            [1,0,1],
                                            [0,0,0]]
  end


  test "update grid die" do
    grid = [[0,0,0],
                 [1,0,0],
                 [0,0,0]]

    expected = [[0,0,0],
                          [0,0,0],
                          [0,0,0]]

    assert Grid.update_grid(:die, grid,{0,1}) == expected
  end

  test "update grid spawn" do
    grid = [[0,0,0],
                 [1,0,0],
                 [0,0,0]]

    expected = [[0,0,0],
                          [1,1,0],
                          [0,0,0]]

    assert Grid.update_grid(:spawn, grid,{1,1}) == expected
  end

  test "update grid live" do
    grid = [[0,0,0],
                 [1,0,0],
                 [0,0,0]]

    expected = [[0,0,0],
                          [1,0,0],
                          [0,0,0]]

    assert Grid.update_grid(:live, grid,{0,1}) == expected
  end

  test "update grid stay" do
    grid = [[1,1,0],
                 [1,1,0],
                 [0,0,0]]

    expected = [[1,1,0],
                          [1,1,0],
                          [0,0,0]]

    assert Grid.update_grid(:stay, grid,{0,0}) == expected
  end

end
