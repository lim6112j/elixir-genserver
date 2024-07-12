defmodule MyGenServer do
	use Application
  @moduledoc """
  Documentation for `MyGenServer`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MyGenServer.hello()
      :world

  """
  def hello do
    :world
  end
	def start(_type, _args) do
		IO.puts "starting"
		{:ok, pid} = GenServer.start_link(Stack, [:hello])
		IO.puts(GenServer.call(pid, :pop))
		IO.puts(GenServer.cast(pid, {:push, :world}))
		IO.puts(GenServer.call(pid, :pop))
		{:ok, self()}
	end


end

defmodule Stack do
	use GenServer
	@impl true
	def init(stack) do
		{:ok, stack}
	end
	@impl true
	def handle_call(:pop, _from, [head | tail]) do
		{:reply, head, tail}
	end
	@impl true
	def handle_cast({:push, element}, state) do
		{:noreply, [element | state]}
	end
end
