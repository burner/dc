DC=dmd
CFLAGS=-c -Isrc -debug
TARGET=dc
BUILD_NUMBER_FILE=CompilerInfo.d

all: $(TARGET)

OBJS=dlst.o identifer.o lexer.o main.o stringbuffer.o token.o stacktrace.o source.o token.o tokensymbols.o

$(TARGET): $(OBJS) Makefile
	sh IncreBuildId.sh
	$(DC) $(CFLAGS) compilerinfo.d
	$(DC) *.o -ofdc

run: $(TARGET)
	./dc

count:
	wc -l `find src -name "*.d"`

clean:
	rm -f objs/*.o $(TARGET)
	rm -f *.o $(TARGET)

identifer.o: Makefile src/lex/identifer.d
	$(DC) $(CFLAGS) src/lex/identifer.d 

dlst.o: Makefile src/container/dlst.d 
	$(DC) $(CFLAGS) src/container/dlst.d 

lexer.o: Makefile src/lex/lexer.d
	$(DC) $(CFLAGS) src/lex/lexer.d 

main.o: Makefile src/main.d
	$(DC) $(CFLAGS) src/main.d 

source.o: Makefile src/lex/source.d
	$(DC) $(CFLAGS) src/lex/source.d 

stacktrace.o: Makefile src/util/stacktrace.d
	$(DC) $(CFLAGS) src/util/stacktrace.d 

stringbuffer.o: Makefile src/util/stringbuffer.d
	$(DC) $(CFLAGS) src/util/stringbuffer.d 

token.o: Makefile src/lex/token.d
	$(DC) $(CFLAGS) src/lex/token.d 

tokensymbols.o: Makefile src/lex/tokensymbols.d
	$(DC) $(CFLAGS) src/lex/tokensymbols.d 

