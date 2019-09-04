#!/usr/bin/ruby

require 'mkmf'

if RUBY_PLATFORM =~ /darwin/ || RUBY_PLATFORM =~ /linux/
  $CFLAGS += " -std=gnu90 -O0 -DNDEBUG -fsanitize=address -g -Wall -Wdeclaration-after-statement -Wsign-compare"
else
  $CFLAGS += " -std=gnu90 -O0 -DNDEBUG"
end


if RUBY_PLATFORM =~ /linux/
  # Instruct the linker to point memcpy calls at our __wrap_memcpy wrapper.
  $LDFLAGS += " -Wl,-wrap,memcpy -fsanitize=address"
end

$objs = ["protobuf.o", "defs.o", "storage.o", "message.o",
         "repeated_field.o", "map.o", "encode_decode.o", "upb.o",
         "wrap_memcpy.o"]

create_makefile("google/protobuf_c")
