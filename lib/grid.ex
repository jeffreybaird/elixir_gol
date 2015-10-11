defmodule Grid do

  @type grid :: [[any()]]
  @type cell :: {integer(),integer()}
  @type fate :: atom

  def new(width, height) do
    build_grid([], width, height-1)
  end

  @spec step(grid,grid,tuple) :: grid
  def step(new_grid,_,{-1,-1}) do
    new_grid
  end

  def step(new_grid,old_grid,{x,y}) do
    {new_x, new_y} = next_coord({x,y}, old_grid)
    check_cell({x,y},new_grid,old_grid)
      |> step(old_grid,{new_x,new_y})
  end

  @spec step(grid) :: no_return
  def step(old_grid) do
    {new_x, new_y} = next_coord({0,0}, old_grid)
    check_cell({0,0},old_grid,old_grid)
      |> step(old_grid,{new_x,new_y})
  end


  @spec check_cell(cell,grid,grid) :: no_return
  def check_cell({x,y}, new_grid,old_grid) do
    cell = access_grid(old_grid,{x,y})
    neighbor_state([],old_grid, filter_for_bounds(eight_neighbors({x,y}),old_grid))
      |> adjacent_count(0)
      |> cell_fate(cell)
      |> update_grid(new_grid,{x,y})
  end

  @spec update_grid(atom,list,cell) :: list
  def update_grid(fate,grid,{x,y}) do
    case fate do
      :spawn ->
        update_grid_value({x,y},grid,1)
      :die ->
        update_grid_value({x,y},grid,0)
      :live ->
        grid
      :stay ->
        grid
      true ->
        grid
    end
  end

  @spec width(grid) :: pos_integer
  def width(grid) do
    length(Enum.fetch!(grid,0))
  end

  @spec height(grid) :: pos_integer
  def height(grid) do
    length(grid)
  end

  @spec next_coord(cell,list) :: cell
  def next_coord({x,y},grid) do
    cond do
      x == width(grid) -1 ->
        {0,y+1}
      y == height(grid) - 1 ->
        {-1, -1}
      true ->
        {x+1,y}
    end
  end


  @spec update_grid_value(tuple,list,integer) :: list
  def update_grid_value({x,y},grid,val) do
    updated_row = List.replace_at(Enum.fetch!(grid,y), x, val)
    List.replace_at(grid,y,updated_row)
  end

  @spec cell_fate(integer,cell) :: fate
  def cell_fate(count,cell) do
    cond do
       count == 3 and cell == 0 ->
         :spawn
       count > 3 and cell == 1 ->
         :die
      count < 2 and cell == 1 ->
        :die
      count > 1 and count < 4 and cell == 1 ->
        :live
      true ->
        :stay
      end
  end

  @spec add(integer, integer) :: integer
  def add(val, inc) do
    val + inc
  end

  @spec adjacent_count(grid,integer) :: no_return
  def adjacent_count([head| tail],n) do
    adjacent_count(tail,add(n, head))
  end

  def adjacent_count([],n) do
    n
  end

  @spec eight_neighbors({number(),number()}) :: [{number(),number()},...]
  def eight_neighbors({x,y}) do
    [{x-1,y-1},{x-1,y},{x-1,y+1},{x,y+1},
    {x+1,y+1},{x+1,y}, {x+1,y-1},{x,y-1}]
  end

  @spec filter_for_bounds(list,any,list) :: list
  def filter_for_bounds([], _, list) do
    list
  end

  def filter_for_bounds([{x,y}|tail], grid, list) do
    unless x > width(grid) - 1 or y > height(grid) - 1 or x < 0 or y < 0 do
      filter_for_bounds(tail, grid, list ++ [{x,y}])
    else
      filter_for_bounds(tail, grid, list)
    end
  end

  def filter_for_bounds([{x,y}|tail], grid) do
    unless x > width(grid) or y > height(grid) or x < 0 or y < 0 do
      filter_for_bounds(tail, grid, [{x,y}])
    else
      filter_for_bounds(tail, grid, [])
    end
  end


  @spec neighbor_state(list,grid,list) :: list
  def neighbor_state([],grid,[{x,y}|tail]) do
    neighbor_state([access_grid(grid,{x,y})],grid,tail)
  end

  def neighbor_state(list, grid, [{x,y}|tail]) do
    list ++ [access_grid(grid,{x,y})]
      |> neighbor_state(grid,tail)
  end

  def neighbor_state(list,_,[]) do
    list
  end

  @spec access_grid(grid, cell) :: integer
  def access_grid(grid,{x,y}) do
    Enum.fetch!(grid,y)
      |> Enum.fetch!(x)
  end

  @spec build_grid([0],non_neg_integer(),pos_integer()) :: [[0],...]
  defp build_grid(grid, _, 0, 0) do
    grid
  end

  defp build_grid(grid, list, 0, height_remaining) do
    grid ++ [list]
      |> build_grid(list,0,height_remaining - 1)
  end

  defp build_grid(list, 0, height_remaining) do
    [list] ++ [list]
      |> build_grid(list,0,height_remaining - 1)
  end

  defp build_grid(list, width_remaining, height_remaining) do
    list ++ [0]
      |> build_grid(width_remaining - 1, height_remaining)
  end

end