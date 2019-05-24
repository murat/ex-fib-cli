defmodule Fib.CLI do
  @moduledoc """
  This application writes fibonacci numbers
  """

  @args [
    [order: [type: :integer, short: :n, required: true, default: 1, max: 1000]],
    [color: [type: :string, short: :c, default: "white"]]
  ]

  def main(args \\ []) do
    {opts, _, _} =
      args
      |> OptionParser.parse(options())

    opts
    |> validate
    |> run
  end

  defp options do
    @args
    |> Enum.reduce([strict: [], aliases: []], fn arg, acc ->
      name = hd(Keyword.keys(arg))
      options = arg[name]

      [
        strict: Keyword.merge(acc[:strict], [{name, options[:type]}]),
        aliases: Keyword.merge(acc[:aliases], [{options[:short], name}])
      ]
    end)
  end

  defp validate(opts) do
    @args
    |> Enum.map(fn arg ->
      name = hd(Keyword.keys(arg))
      given = opts[name]
      options = arg[name]

      # required olup default değeri belirtilmemiş bir argüman ise RuntimeError fırlat
      given =
        case Keyword.get(options, :required, false) && Keyword.get(options, :default, false) &&
               is_nil(given) do
          true ->
            raise "#{String.capitalize(Atom.to_string(name))} attribute is required!"

          _ ->
            given
        end

      # default değeri belirtilmiş ve dışarıdan verilmemiş bir argüman ise defaultu yerleştir
      given =
        case Keyword.get(options, :default, false) && is_nil(given) do
          true ->
            options[:default]

          _ ->
            given
        end

      # type integer ve max değeri belirtilmiş ise
      case options[:type] == :integer && !is_nil(Keyword.get(options, :max, nil)) do
        true ->
          if given > options[:max] do
            raise "#{String.capitalize(Atom.to_string(name))} attribute could not be greater than #{
                    options[:max]
                  }"
          end

          {name, given}

        _ ->
          {name, given}
      end
    end)
  end

  defp run(args) do
    if Keyword.has_key?(IO.ANSI.__info__(:functions), String.to_atom(args[:color])) do
      color = apply(IO.ANSI, String.to_atom(args[:color]), [])
      IO.puts(color <> Integer.to_string(fib(1, 1, args[:order])))
    else
      raise "Color #{args[:color]} is invalid ANSI color!"
    end
  end

  defp fib(a, _, 0), do: a
  defp fib(a, b, n), do: fib(b, a + b, n - 1)
end
