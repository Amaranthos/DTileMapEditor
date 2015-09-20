module rect;

import std.algorithm;

import derelict.sdl2.sdl;

public SDL_Rect BuildRect (ref SDL_Rect rect) {
	int x1 = rect.x;
	int y1 = rect.y;
	int x2 = rect.w;
	int y2 = rect.h;

	rect.x = min(x1, x2);
	rect.y = min(y1, y2);

	rect.w = max(x1, x2) - rect.x;
	rect.h = max(y1, y2) - rect.y;

	return rect;
}