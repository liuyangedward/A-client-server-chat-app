# define the C compiler to use
CC = g++

# define any compile-time flags
CFLAGS = -Wall -g -std=c++11

# define any directories containing header files other than /usr/include
#
INCLUDES =-I ./include -I ../share/include -I /usr/include -I /usr/local/include -I /usr/include/c++/5 -I /usr/include/c++/5/backward \
-I /usr/include/x86_64-linux-gnu -I /usr/include/x86_64-linux-gnu/c++/5 -I /usr/include/x86_64-linux-gnu/c++/5/include -I /usr/include/x86_64-linux-gnu/c++/5/include-fixed

# define library paths in addition to /usr/lib
#   if I wanted to include libraries not in /usr/lib I'd specify
#   their path using -Lpath, something like:
LFLAGS = -L /usr/lib/x86_64-linux-gnu -L /usr/lib/

# define any libraries to link into executable:
#   if I want to link in libraries (libx.so or libx.a) I use the -llibname 
#   option, something like (this will link in libmylib.so and libm.so:
LIBS = -lboost_system -lboost_thread -lpthread -ljsoncpp

# define the C source files
SRCS = chat_client.cpp chat_server.cpp

# define the C object files 
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#         For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macro SRCS
# with the .o suffix
#
OBJS = $(SRCS:.c=.o)

#
# The following part of the makefile is generic; it can be used to 
# build any executable just by changing the definitions above and by
# deleting dependencies appended to the file from 'make depend'
#

all:    Server Client 

Client: 
	$(CC) $(CFLAGS) $(INCLUDES) -o Client $(LFLAGS) $(LIBS)

Server:
	$(CC) $(CFLAGS) $(INCLUDES) -o Server $(LFLAGS) $(LIBS)

# this is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $<: the name of the prerequisite of
# the rule(a .c file) and $@: the name of the target of the rule (a .o file) 
# (see the gnu make manual section about automatic variables)


clean:
	$(RM) *.o *~ Client Server

