# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lbc C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

include_directories ( ${CMAKE_CURRENT_SOURCE_DIR} )

install_lua_module ( bc number.c lbc.c bc.def )
install_data ( README )
install_test ( test.lua )

add_lua_test ( test.lua )

