--
-- Premake5 file for build OpenALSoft project.
-- Copyright (c) 2023-present by Danil (Kenny) Dukhovenko, All rights reserved.
--
-- Requirement:
--  - ForceEngine.lua
--  - vcpkg installed with 'vcpkg install openal-soft'
--
-- NOTE: This is thunk library, only with linkage .lib. All source code contains in
-- vcpkg\packages\openal-soft_x64-windows.
-- Read more in ForceEngine.lua::About __NULL_IMPORT_DESCRIPTOR why i made this dicision.
--

-- Curl C++ Project
project "OpenAL"
	kind          "StaticLib"
	language      "C++"
	cppdialect    "C++17"
	staticruntime "On"
	targetdir     ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Lib")
	objdir        ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Obj")

	files {
		"%{IncludeDir.OpenAL}/AL/**.h",
		"src/**.cpp"
	}
	
	includedirs {
		"%{IncludeDir.OpenAL}"
	}

	filter "system:windows"
		systemversion "latest"
	
	filter "system:linux"
		pic "On"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
		links ( "%{Library.Dbg.OpenAL}" )

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
		links ( "%{Library.Rel.OpenAL}" )