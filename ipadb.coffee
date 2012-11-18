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
#         VOIC,   LOC,   MOD
    b:  A @voic,  @bil,  @pl
    c:  A @voic,  @bil,  @pl
    "ʃ":A @nvoic, @palv, @fr

##################################################################
# Query

console.log data

qset P, data, ($)->
    $ @nvoic
    $ @voic
