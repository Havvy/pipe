defmodule Macros.Pipes do
    defmacro pipe(expr, [do: pipeline]) do
        case pipeline do
            {:__block__, _, do_block} ->
                Enum.reduce(do_block, expr, &{:|>, [], [&2, &1]})
            non_block_form ->
                {:|>, [], [expr, non_block_form]}
        end
    end

    defmacro defpipe({_fn_name, _, [input]} = header, body) do
        quote do
            def unquote(header) do
                pipe unquote(input), unquote(body)
            end
        end
    end
end