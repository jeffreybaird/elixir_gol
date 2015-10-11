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

    assert Grid.step(g) == [[0, 1, 1], [1, 0, 1], [0, 0, 0]]
  end

  test "step 3" do

    g =  [[0,1,0],
              [1,1,1],
              [0,0,0]]
    assert Grid.step(g) ==  [[1, 0, 0],
                                            [1, 1, 0],
                                            [0, 0, 0]]
  end

  test "step 4" do
    g =   [[1,1,1],
              [1,1,1],
              [0,0,0]]
    assert Grid.step(g) == [[1, 0, 1],
                                            [1, 0, 0],
                                             [0, 0, 0]]
  end

end
