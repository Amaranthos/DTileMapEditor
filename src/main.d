module main;

pragma(lib, "lib\\DerelictUtil.lib");
pragma(lib, "lib\\DerelictSDL2.lib");

import std.stdio;

import derelict.sdl2.sdl;
import derelict.sdl2.image;
import derelict.util.exception;

import app;
import util.log;

void main() {
	EnableLogging(true);

	try{
		DerelictSDL2.missingSymbolCallback = (string) => ShouldThrow.No;
		DerelictSDL2Image.missingSymbolCallback = (string) => ShouldThrow.No;

		DerelictSDL2.load();
		DerelictSDL2Image.load();

		if(!App.Inst.Init()) {
			Log(Level.warning, "App failed to init!");
		}
		else {
			Log(Level.success, "Initialisation successful");
			App.Inst.Update();
		}

		App.Inst.Close();
	}
	catch(Exception e) {
		Log(Level.error, "Exception: ", e.msg);
		throw(e);
	}
}