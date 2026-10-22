workspace("StarsProject")
do
	configurations({ "Debug", "Release" })
	platforms({ "x64" })
	location("build")
end

project("stars")
do
	kind("WindowedApp")
	language("C")
	cdialect("C17")

	targetdir("bin/%{cfg.buildcfg}-%{cfg.system}")
	objdir("build/%{cfg.buildcfg}-%{cfg.system}")
	includedirs({ "include" })

	files({
		"src/**.c",
		"include/**.h",
	})

	filter({ "system:linux", "action:gmake*" })
	do
		toolset("gcc")
	end

	filter({ "system:linux", "options:mxe" })
	do
		system("windows")
		toolset("gcc")
		gccprefix("x86_64-w64-mingw32.static-")
	end

	filter({ "system:windows", "action:gmake*" })
	do
		system("windows")
		toolset("gcc")
                premake.modules.gmake.shell = "sh"

                postbuildcommands {
                  "rm -rf %{cfg.targetdir}/resources",
                  "cp -r %{path.getabsolute('resources')} %{cfg.targetdir}/resources"
                }

                local handle = io.popen("pkg-config --cflags gtk+-3.0")
                local result = handle:read("*a")
                handle:close()

		buildoptions {(result)}

                local handle = io.popen("pkg-config --libs gtk+-3.0")
                local result = handle:read("*a")
                handle:close()

		linkoptions {(result)}
	end

	filter({ "system:windows", "action:vs2022" })
	do
		system("windows")
		toolset("msc")
		-- buildoptions {()}
		-- linkoptions {()}
	end

	filter("configurations:Debug")
	do
		symbols("On")
		defines({ "DEBUG" })
	end

	filter("configurations:Release")
	do
		optimize("On")
		defines({ "NDEBUG" })
	end
  newaction {
    trigger     = "distclean",
    description = "Remove all binaries, intermediate files, and generated project files",
    execute     = function ()
      print("Cleaning build artifacts...")

      os.execute("rm -rf bin")
      os.execute("rm -rf obj")

      print("Done.")
    end
  }
end
