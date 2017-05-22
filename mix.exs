defmodule ExQueue.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_queue,
     version: "0.4.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger],
     mod: {ExQueue.Application, []}]
  end

  defp description do
    """
    A FIFO queue wrapped around GenServer.
    """
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    # These are the default files included in the package
    [
      name: :ex_queue,
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Erik Nilsen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/enilsen16/ex_queue"}
    ]
  end
end
