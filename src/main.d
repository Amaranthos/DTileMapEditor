module main;

pragma(lib, "lib\\DerelictUtil.lib");
pragma(lib, "lib\\DerelictSDL2.lib");

import std.stdio;

import derelict.sdl2.sdl;
import derelict.sdl2.image;

import app;

void main() {
	try{
		DerelictSDL2.load();
		DerelictSDL2Image.load();

		if(!App.Inst.Init()) writeln("Warning: App failed to init!");
		else App.Inst.Update();

		App.Inst.Close();
	}
	catch(Exception e) {
		writeln("Exception %s", e.msg);
		throw(e);
	}
}