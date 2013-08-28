# Pipe

Defines two macros, *pipe* and *defpipe* in the module Macros.Pipes.

Basically, instead of using |> multiple times, you just say you are creating a pipe,
and then list the operations as follows.

## Usage

```elixir
defmodule Macros.Pipes.Examples
    import Macros.Pipes

    def double(n), do: n * 2
    def square(n), do: n * n

    @doc "Without using the macros."
    def quadruple(n) do
        n |> double |> double
    end

    @doc "Just using the pipe macro"
    def double_then_square(n) do
        pipe n do
            double
            square
        end
    end

    @doc "Using defpipe when your entire function is a pipeline."
    defpipe square_then_double(n) do
        square
        double
    end
end
```

There are similar contrived functions in the test module.