#
# File:   ipadb.coffee
# Author: Karolin Varner
# Date:   17.11.2012
#
# This File implements a tiny (unreal) DB for querying the IPA.
#
##########################################################
#
# This file is part of IPADB.
#
# PinkText is free software: you can redistribute it and/or modify
# it under the terms of the Lesser GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# IPADB is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# Lesser GNU General Public License for more details.
#
# You should have received a copy of the Lesser GNU General Public License
# along with IPADB. If not, see <http://www.gnu.org/licenses/>.
#

A = (a...) -> a
scope = (T, args..., f) ->
    f.apply T, args

#################################################################
# PROP DEFINITION

class proptype
    constructor: (@name, @props) ->

class property
    constructor: (@name, @type) ->

propset = (n, ps) ->
    R = new Object

    __type = R[n] = new proptype n, []
    for p in ps
        __type.props.push (R[p] = new property p, __type)
    return R


defprops = (D) ->
    R = new Object
    for type, ps of D
        for k, v of (propset type, ps)
            R[k] = v
    return R

##################################################################
# DATA DEFINITION

class datum
    constructor:(@name, @props...) ->

defdata = (D) ->
    R = new Object
    for k, v of D
        R[k] = new datum k, v...
    return R

###################################################################
# DATA MINING

query_ = (data, conds) ->
    d for k,d of data when do ->
        for c in conds
            if c not in d.props
                return false
        return true

query = (a...) ->
    for d in query_ a...
        d.name

qset = (P, data, f) ->
    f.call P, (a...)->
        console.log "| #{c.name for c in a}\n==> #{query data, a}\n"
        

###################################################################
# DATA SET
#
P = defprops
    voice: A "voic", "nvoic"
    loc:   A "bil", "den", "labden", "alv", "palv",\
             "retro", "vel", "uvl", "phrg", "gl"
    mod:   A "pl", "ns", "tr", "tafl", "fr", "latfr", "app", "latpp"


data = scope P, -> defdata
    b:A   @voic, @bil, @pl
    xyx:A @nvoic, @alv, @palv, @pl, @fr, @voic

##################################################################
# Query

qset P, data, ($)->
    $ @pl, @fr
    $ @voic
    $ @nvoic
