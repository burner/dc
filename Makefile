DC=dmd
CFLAGS=-c -Isrc
TARGET=dc
BUILD_NUMBER_FILE=CompilerInfo.d

all: $(TARGET)

OBJS=dlist.o identifer.o lexer.o stringbuffer.o token.o stacktrace.o source.o 

$(TARGET): $(OBJS) Makefile src/main.d
	sh IncreBuildId.sh
	$(DC) $(CFLAGS) compilerinfo.d
	$(DC) $(CFLAGS) src/main.d
	$(DC) *.o -ofdc

run: $(TARGET)
	./dc

count:
	wc -l `find -name "*.d"`

clean:
	rm -f objs/*.o $(TARGET)
	rm -f *.o $(TARGET)

identifer.o: Makefile src/lex/identifer.d
	$(DC) $(CFLAGS) src/lex/identifer.d 

dlist.o: Makefile src/container/dlst.d 
	$(DC) $(CFLAGS) src/container/dlst.d 

lexer.o: Makefile src/lex/lexer.d
	$(DC) $(CFLAGS) src/lex/lexer.d 

source.o: Makefile src/lex/source.d
	$(DC) $(CFLAGS) src/lex/source.d 

stacktrace.o: Makefile src/util/stacktrace.d
	$(DC) $(CFLAGS) src/util/stacktrace.d 

stringbuffer.o: Makefile src/util/stringbuffer.d
	$(DC) $(CFLAGS) src/util/stringbuffer.d 

token.o: Makefile src/lex/token.d
	$(DC) $(CFLAGS) src/lex/token.d 

