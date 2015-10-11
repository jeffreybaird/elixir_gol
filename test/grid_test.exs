defmodule GridTest do
  use ExUnit.Case
  doctest Grid

  test "Grid" do
    assert Grid.new(3,3) == [[:dead,:dead,:dead],
                                              [:dead,:dead,:dead],
                                              [:dead,:dead,:dead]]
  end

  test "step" do
    g = [[:dead,:dead,:dead],
            [:live,:dead,:dead],
            [:dead,:dead,:dead]]
    assert Grid.step(g) == [[:dead,:dead,:dead],
                                            [:dead,:dead,:dead],
                                            [:dead,:dead,:dead]]
  end

  test "step 2" do
    g = [[:dead,:dead,:dead],
            [:live,:live,:live],
            [:dead,:dead,:dead]]

    assert Grid.step(g) == [[:dead,:live,:dead],
                                            [:dead,:live,:dead],
                                            [:dead,:live,:dead]]
  end

  test "step 3" do

    g =  [[:dead,:live,:dead],
              [:live,:live,:live],
              [:dead,:dead,:dead]]
    assert Grid.step(g) ==  [[:live, :live,:live],
                                            [:live, :live, :live],
                                            [:dead, :live, :dead]]
  end

  test "step 4" do
    g =   [[:live,:live,:live],
              [:live,:live,:live],
              [:dead,:dead,:dead]]
    assert Grid.step(g) == [[:live,:dead,:live],
                                            [:live,:dead,:live],
                                            [:dead,:live,:dead]]
  end

  test "step with large grid" do
    g = [[:dead, :dead, :dead, :dead, :dead],
            [:dead, :dead, :live, :dead, :dead],
            [:live, :dead, :live, :dead, :dead],
            [:dead, :live, :dead, :dead, :dead],
            [:dead, :dead, :dead, :dead, :live]]

  expected = [[:dead, :dead, :dead, :dead, :dead],
                        [:dead, :live, :dead, :dead, :dead],
                        [:dead, :dead, :live, :dead, :dead],
                        [:dead, :live, :dead, :dead, :dead],
                       [:dead, :dead, :dead, :dead, :dead]]
    assert Grid.step(g) == expected
  end


  test "update grid die" do
    grid = [[:dead,:dead,:dead],
                 [:live,:dead,:dead],
                 [:dead,:dead,:dead]]

    expected = [[:dead,:dead,:dead],
                          [:dead,:dead,:dead],
                          [:dead,:dead,:dead]]

    assert Grid.update_grid(:die, grid,{0,1}) == expected
  end

  test "update grid spawn" do
    grid = [[:dead,:dead,:dead],
                 [:live,:dead,:dead],
                 [:dead,:dead,:dead]]

    expected = [[:dead,:dead,:dead],
                          [:live,:live,:dead],
                          [:dead,:dead,:dead]]

    assert Grid.update_grid(:spawn, grid,{1,1}) == expected
  end

  test "update grid live" do
    grid = [[:dead,:dead,:dead],
                 [:live,:dead,:dead],
                 [:dead,:dead,:dead]]

    expected = [[:dead,:dead,:dead],
                          [:live,:dead,:dead],
                          [:dead,:dead,:dead]]

    assert Grid.update_grid(:live, grid,{0,1}) == expected
  end

  test "update grid stay" do
    grid = [[:live,:live,:dead],
                 [:live,:live,:dead],
                 [:dead,:dead,:dead]]

    expected = [[:live,:live,:dead],
                          [:live,:live,:dead],
                          [:dead,:dead,:dead]]

    assert Grid.update_grid(:stay, grid,{0,0}) == expected
  end

end
