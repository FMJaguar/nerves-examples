defmodule Neopixel.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :neopixel,
     version: "0.2.0",
     elixir: "~> 1.4.0",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.2.1"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Neopixel, []},
     extra_applications: [:logger]]
  end

  def deps do
    [{:nerves, "~> 0.4.7"},
     {:nerves_neopixel, github: "GregMefford/nerves_neopixel", branch: "rgbw", submodules: true}]
  end

  def system(target) do
    [{:"nerves_system_#{target}", "~> 0.10.0", runtime: false}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
