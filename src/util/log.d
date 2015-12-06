module util.log;

import std.stdio;
import std.file;
import std.string;
import std.datetime;
import std.format;

private {
	__gshared File log;
	__gshared bool isLogging = true;
}

public:

enum Level {
	success = "success",
	event = "event",
	warning = "warning",
	error = "error",
	update = "update",
	user = "user",
}

static this() {
	log.open("log/log.html", "w");
	WriteHtmlHeader();
}

static ~this() {
	WriteHtmlFooter;
	Flush();
	log.close();
}

void SetLogFilename(string filename) {
	log.close();
	log.open(filename, "w");
	WriteHtmlHeader();
}

string GetFilename() {
	return log.name;
}

void Log()() {
	writeln();
	if(isLogging) log.writeln();
}

void Log(Level, T...)(Level level, T t) {
	writeln(t);
	if(isLogging) log.writeln("<p class=", level, ">", CurrentTime(),t,"</p>");
}

void LogTag(Level, Fmt, T...)(Level level, Fmt fmt, T t){
	writeln(t);
	if(isLogging) log.writeln("<",fmt," class=", level, ">",t,"</",fmt,">");
}

void EnableLogging(bool logging) {
	isLogging = logging;
}

bool IsLogging() {
	return isLogging;
}

void Flush() {
	std.stdio.stdout.flush();
	log.flush();
}

void WriteHtmlHeader(){
	log.writeln("<!DOCTYPE html>");
	log.writeln("<html>");
	log.writeln("<head>");
	log.writeln("<title>Log</title>");
	log.writeln("<style>");
	log.writeln("body{background-color: black;} p{margin-top: 5px; margin-bottom: 5px;} .success {color: lime;} .warning {color: orange;} .error {color: red;} .event {color: yellow;} .user{color: aqua;} .update {color: white;}");
	log.writeln("</style>");
	log.writeln("</head>");
	log.writeln("<body>");	
}

void WriteHtmlFooter() {
	log.writeln("</body>");
	log.writeln("</html>");
}

string CurrentTime() {
	auto time = Clock.currTime;
	return format("(%s/%s/%s %s:%s:%s) - ", time.day, cast(int)time.month, time.year, time.hour, time.minute, time.second);
}