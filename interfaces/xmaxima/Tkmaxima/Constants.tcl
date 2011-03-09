# -*-mode: tcl; fill-column: 75; tab-width: 8; coding: iso-latin-1-unix -*-
#
#       $Id: Constants.tcl,v 1.25 2011-03-09 11:29:38 villate Exp $
#

proc cMAXINITBeforeIni {} {
    global maxima_default
    set maxima_default(plotwindow) multiple

    # from Send-some.tcl
    set maxima_default(sMathServerHost) genie1.ma.utexas.edu
    set maxima_default(iMathServerPort) 4443

    # from Browser.tcl
    set maxima_default(sMathServerHost) localhost
    set maxima_default(iMathServerPort) 4443

    #mike turn these off by default
    set maxima_default(iShowBalloons) 0

    set maxima_default(fontAdjust) 0

    set maxima_default(iConsoleWidth) 80
    set maxima_default(iConsoleHeight) 24

    set maxima_default(iLocalPort) 4008

    set maxima_default(bDebugParse) 0

    # from FileDlg.tcl
    set maxima_default(OpenDir) "~/"
    set maxima_default(OpenFile) "~/.xmaximrc"
    set maxima_default(SaveFile) "~/.xmaximrc"

    # From Browser.tcl
    set maxima_default(defaultservers) {
	nmtp://genie1.ma.utexas.edu/
	nmtp://linux51.ma.utexas.edu/
	nmtp://linux52.ma.utexas.edu/
    }

    global embed_args
    if { "[info var embed_args]" != "" } {
	# the following will be defined only in the plugin
	set maxima_default(defaultservers) nmtp://genie1.ma.utexas.edu/
    }


    # maxima_default(lProxyHttp)
}

proc cMAXINITReadIni {} {
    if {[file isfile ~/.xmaximarc]} {
	if {[catch {uplevel "#0" [list source ~/.xmaximarc] } err]} {
	    tide_failure [M [mc "Error sourcing %s\n%s"] \
			      [file native ~/.xmaximarc] \
			      $err]
	}
    }
}

proc cMAXINITAfterIni {} {
    global maxima_default maxima_priv MathServer
    lMaxInitSetOpts
    set MathServer [list $maxima_default(sMathServerHost) \
			$maxima_default(iMathServerPort) ]

    # from plot3d.tcl
    set maxima_priv(speed) [expr {(9700.0 / (1 + [lindex [time {set i 0 ; while { [incr i] < 1000} {}} 1] 0]))}]

    # from Wmenu.tcl
    global show_balloons
    set show_balloons $maxima_default(iShowBalloons)

    # From Browser.tcl
    global debugParse
    set debugParse $maxima_default(bDebugParse)

    if {[info exists maxima_default(lProxyHttp)] && \
	    [llength $maxima_default(lProxyHttp)] == "2"} {
	#mike FIXME: make this a _default
	set maxima_priv(proxy,http) $maxima_default(lProxyHttp)
    }

}

# Constants
global maxima_priv
set maxima_priv(date) 29/07/2006

# from
if { ![info exists maxima_priv(date)] } {
    set maxima_priv(date) [clock  format [clock seconds] -format {%m/%d/%Y} ]
}

# from Preamble.tcl
set maxima_priv(clicks_per_second) 1000000

# from Getdata1.tcl
set maxima_priv(cachedir) ~/.netmath/cache

# from Plotconf.tcl
global ftpInfo
set ftpInfo(host) genie1.ma.utexas.edu
set ftpInfo(viahost) genie1.ma.utexas.edu

# from Plot2d.tcl
array set maxima_priv { bitmap,disc4 {#define disc4_width 4
#define disc4_height 4
static unsigned char disc4_bits[] = {
    0x06, 0x0f, 0x0f, 0x06};}
    bitmap,disc6 {#define disc_width 6
#define disc_height 6
static unsigned char disc_bits[] = {
    0xde, 0xff, 0xff, 0xff, 0xff, 0xde};}
}

# from xmaxima.tcl
set maxima_priv(options,maxima) {{doinsert 0 "Do an insertion" boolean}}

# from EOctave.tcl
set maxima_priv(options,octave) {{doinsert 1 "Do an insertion" boolean}}

# from EOpenplot.tcl
set maxima_priv(options,openplot) {{doinsert 0 "Do an insertion" boolean}}

# from EHref.tcl
set maxima_priv(options,href) {
    {src "" [mc "A URL (universal resource locator) such as http://www.ma.utexas.edu/foo.om"]}
    {search "" [mc "A string to search for, to get an initial position"]}
    {searchregexp "" [mc "A regexp to search for, to get an initial position"]}
}

# from Preamle.tcl
set maxima_priv(counter) 0
	
# the linelength should be long enough to display formatted mathematical
# output from things like maxima, without adjustment, and to allow
# for a margin.
set maxima_priv(linelength) 90

# From Browser.tcl
set maxima_priv(sticky) "^Teval$|^program:"
set maxima_priv(richTextCommands) {Tins TinsSlashEnd}
set maxima_priv(urlHandlers) {
    text/html  netmath
    text/plain netmath
    image/gif  netmath
    image/png  netmath
    image/jpeg netmath
    application/postscript "ghostview -safer %s"
    application/pdf "acroread %s"
    application/x-dvi "xdvi %s"
}
set maxima_priv(imagecounter) 0

set maxima_priv(brokenimage,data) R0lGODlhHQAgAMIAAAAAAP9jMcbGxoSEhP///zExY/9jzgCEACH5BAEAAAIALAAAAAAdACAAAAPOOLrcLjDCQaq9+CoZaf7YIIicx50nNZYV6k4tCRPuYduSR8vmef+dy2rU4vyOM8uqJzkCBYCoNEqkGZ04SGHLBSiKTewhx/AyI+LxqWIGh5Eo9pdm8D3jhDa9/nrJTQaBfS5/LYGCgxyFe4cnAY+Qj1oFegKHjRKRkpMbgJeIEJqTBTyGnxybAlwbQYygKFusOaavo5SkJ5WYErELKAO6fBy4LxS6vFzEv4snpLIpIszIMiWKeXMWvS7RGXoVsX0g11NR1Bzk6F4jCn0ODgkAOwAA

global evalPrograms
set evalPrograms {  gp gap gb }
#set maxima_priv(options,maxima) {{doinsert 1 "Do an insertion" boolean}}
#set maxima_priv(options,gp) {{doinsert 1 "Do an insertion" boolean}}
#set maxima_priv(options,openplot) {{doinsert 0 "Do an insertion" boolean}}

# Icons from the Tango Desktop Project (http://tango.freedesktop.org)
# "The Tango base icon theme is released to the Public Domain.
# "The palette is in public domain. Developers, feel free to ship it
# "along with your application."

image create photo ::img::play -format GIF -data {
    R0lGODlhFgAWAPZZAEpMSVJUUVRWU1dZVVdaVVhaVVhaVlhbVllbVllaV1lbV1lbWFpbWFl
    cWFteWVxeW11eW11fW19hXF5gXV9iXWBiXmFiXmNkYGRlYmRmYmdoZW9wbnN2cnV3c3x9e5
    KTkJGUkJKUkaChn7K0sLO2srq7ur/AvcDCv8/Rz9jZ2OPk4+Tl4+Xm4+fp5Ofp5ejq5unq5
    +nr5+ns5+rs6Ovs6evt6uzt6uzu6uzu6+zt7O7v7O7w7e/w7e/w7u/x7vDx7vDx7/Hy7/Hy
    8PLz8vP08fP08vT08/T18/X19fX29PX29fb39ff39/f49vf49/j5+Pr6+vr7+vv8+/z8+/z
    8/Pz9/P39/P39/f7+/v///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAFoALAAAAAAWABYAAAejgFqCg4SFhoeI
    iYqLhAQRAoyHBE4jCwCRjVlSQiALmIIEWS9CWSscBJihL6tEWSgWAYyqqzMzTlIjDosIWTM
    2v78/UUggD4mhPsnKNi8+USocxoa8tbWrLy0tSFknCIfUODvKPq0qGxSIvD4/REZI20YfEo
    q87EhPWVkl0vRZOz9OsqTAoCFSvSk5PFz4tCALEhHoPmlBcCKiRC0WMFzcyNFQIAA7
}

image create photo ::img::pause -format GIF -data {
    R0lGODlhFgAWAPUxAFJUUFRWUlVXU1ZYVFdZVVhaVltdWV5hXGVmYmVmY2VnZGZoZW1va9j
    b1Nve2d7g29/h3OHj3+Lk3+Lk4OPl4OPl4eTl4uTm4uXm4uXm4+Xn4+bn4+fp5ujp5ujq5+
    rr6Ovs6e7u7e/w7vj5+Pn5+Pr6+fr7+vv7+/v8+/z8+/z8/Pz9/P39/P39/f3+/f7+/v///
    v///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAADIA
    LAAAAAAWABYAAAaNQJlwSCwaj8ikcslsOpGAQWAwKAyn0sHhGFB5VYyh4atacFWRSyksLKg
    ol1PiHJGQ2DL3hVJSnCV2eG4UFClzRgMqFxd3YooXhkeJHh5rQ24ODSqHRV0XEZZtaBCbki
    oecYKPKn5GXSAeKXhjlGWmIiBglyohuWaIZKpfv0VUVQUGQ1VUBcRPz9DR0kRBADs=
}

image create photo ::img::start -format GIF -data {
    R0lGODlhFgAWAPZZAElLR0tNSk1OS01QTE5QTVFTT1JTT1NVUVVXU1ZYVFdZVVhZVVhaVVh
    bV1lcV1lbWFpdWFtdWVtdWlxdWV1eW19hXGJkYGRlYmtsaW1wbHBxbYKGgISHhIiKho6Pi5
    SWk6Cin6Kjn6utqrGyr7/AvsLEwMjJx8rMydLT0NfY1dnd1trc2d7h2+Lj4ePm4ebo5Ofp5
    efo5ujq5ejq5unq5ujq5+nr5+rs6Ovt6ezt6uzu6uzu6+3u6+3v7O7v7O/w7e/w7/Dy7/Lz
    8fP08vT19PX29Pb39fb29vb39vf39vf49vf49/j59/n5+Pn6+fr7+vv7+/v8+/z8+/z8/Pz
    9/P39/P39/f7+/f7+/v///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAFoALAAAAAAWABYAAAe7gFqCg4SFhoeI
    iYqLjI2OhgqRiAGHAoIINgiGBBuahAcengoqCoUUKVaeWgIaMKmXLKoFIUpDVqUAFChSQFY
    JggoupQIYNk83N6kHI09CNja+wDaRJc0511YdRUrXyK9aCj0KECtWQj3oVi1WQTAwz98KQq
    UOHEpWRUWpH/pFQkLRwBUpBcyElYOaGIg4+CQggycEBVXA0EsVAxIIBTEYCCmEKkEQTniCk
    ADCoQsmC1l48Kily5cwYxoKBAA7
}

image create photo ::img::end -format GIF -data {
    R0lGODlhFgAWAPZyAEZIRUtNSUxOSkxOS01OS01PTFBRT1BSTlJUUFRWUlVXU1ZXU1ZYVFd
    ZVFdZVVdaVVdbVlhZVlhaVllbVllaV1lbV1pbWFlcWF5gXF9gXV5hXWBiXmFiX2JjYGJkYG
    NkYGNkYWRmYmZnY2ZoZGdoZmxtaW5xbG9wbW9wbnBxbnBybnByb3FzcHJzcHN0cXN1cnR1c
    XR1cnZ5dXl6d4GDf4iJhpGSj5CSkJOUkJ6enKOkoa+xrrW3s7q8ur6/vMbIxczNytHS0N/h
    3uDh3+Lj4OTm4+fp5Ofp5ejp5ejq5unr5ujp6Onq6Onr6Ovt6ezt6uzt6+zu6u3u6+3t7e3
    v7O7v7e/v7u/w7vDx7vDy7/Dx8PHy8PHz8PLz8PLz8fPz8/P08fT18/X19PX19fT29PX29f
    b29ff39vj4+Pn6+fr6+vv7+vv7+/v8+/z8+/z8/P39/f7+/v///wAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAHMALAAAAAAWABYAAAfLgHOCg4SFhoeI
    iYqLjI2OhgWHAogQFxCCGDQHhRgyk4UvYQ6CJ3FDJJ9zKXFAEYUnUK6qbllrPwoAc6VkZDi
    bgilXsiVrR0lhaDoIJ2tJUGtEIgFzJUuyLG1V2rVaN21QTklbazwKG0LXbWBb62SmbUlHR1
    tvQQsbRReCMHFaWe5farCIs8UdmRn6OizRN4efuzU5LMx5EWdNnB6y5nSowpDfmh0Z+S358
    IHQRoYjfIwi9MGGxEIbZVkQYShjoQgMMDzaybOnz5+GAgEAOw==
}

image create photo ::img::config -format GIF -data {
    R0lGODlhFgAWAPZaAF9fXnl4dHx8fH19fX9/fyBKhzRlpFhthFtxiWB2j2B3kWN7lU50pEV
    xqVR8rll9q2yFoWWErHWQroaGhoeHh4GKlZGRkZmZmZ6enp+fno2YpYGTqYKXsoSctpeltp
    CmvpGmvqenpq2tra+vr6SttqKuvKexvbW1tbu7u5mtw52wyp22zp240qG0yKS60LvByLDG2
    8HBwc/NyszMzNjY19zc3N/f38DR4tPf6tfi7d/n8OPi4ePj4uTj4efm5Ojn5Ojn5uvp5+rp
    6Orq6uzq6O3r6e3r6vLx7+3y9u7z9vDw8PPy8fPz8vD09/T09Pb29fj39vj49/n49/n59/j
    4+Pn5+Pr6+fr6+vv7+/7+/v///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAFsALAAAAAAWABYAAAfxgFuCggQEg4eI
    iVsERVY0hoqRhFJLj5EcBpEERFaQiAZZDJlbAgIQgiicnoOgMyMRggJBQgQjPZwBiQY2I6N
    bF0JLRURBxVKrBlYGvoIUMlLQU8aQoMyHGAITAidWxU4ZydaSBFY/Lw1O4pKLKrsPIeuHBf
    MGTg4kWQLxWwUSLiAFDJiI0SPLqkT9cJRYsaCAgCxCiBiMVKBDDg0LWCgosCgLEU4TEKbQs
    eEACwkIOHb8aIWCvBZINiQ4mfIQgSw9AGQ5xQ9EEw8zUaq0mWXJklz8YCCpQHMoIgsE9Akq
    AIHFDRA19w2iCqGhVkTznO4LBAA7
}

image create photo ::img::close -format GIF -data {
    R0lGODlhFgAWAPYAAEhKR09STVBSTVBTT1NUUFRVUVRWUlVWUlZXU1VXVFVYVFZYVFZZVFZ
    ZVVdZVVdaVVdZVlhZVFhaVFhaVVhZVlhaVllaVlhaV36BfYCCfYGDfoKDgIKEgIOEgIWGg4
    aHhIaIhYeJhYeJhoiJhYiKhomKhomLhomKh4mLh4mLiIqLiIuNiIuMiY6Qi46QjY+RjZCRj
    ZCSjZCSjpGSjpGSj5GTj5GTkJKUkJSWkZWWkpWXkpaYk5eZlJialZqbl5qcl52fmqWnoqan
    pKaopKeppaeppqippqiqpqmqp6mrp6qrp6qsqKusqKutqaytqqyuqq2uq62vq66vq66wrK+
    wra+xrbCxrrCyrrGyrrGzr7K0sLO0sbS1sQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAF0ALAAAAAAWABYAAAfNgF2Cg4SFhoeI
    iYqLhBYODoiPFocWHEQckIUOGkQbk4UWQTlLJJ+CDiBLPESZjRpLMUspnxYgVDdLmIcOJE4
    5VCwOFixZO1QrrYaoWTxaMTZcPlkgyZQkWT9TVEBcs4xdFi9LPT9SMaaLDi9KPDxO59/DVD
    tKSj1U3oq8SzdSLy9ZcjjJtwuEkhakLFjohQsEukGbhqxQUkpQBBBOWijZUK2LAyExiFAjZ
    OCDkhtKFhgioEEIBwOGDGAI4gGmIQEOACASkIDAt59AgzIKBAA7
}

image create photo ::img::replot -format GIF -data {
    R0lGODlhFgAWAPcAAC9ZjzFbkTRflzZlojZnozNlpDRlpDVlpDRlpTVlpTRmpDVmpDVmpTZ
    mpDZnpDdnpDZmpTdmpTZnpTdnpTZnpjdnpjdopTdopjdopzxpozhopjlopjhppjlppjhopz
    lppztppjpppzpqpztqpztrpzpqqDtqqDprqDtrqDpqqT1rqDxsqD1sqD1sqT5tqT9vqT5tq
    z5uqz9uq0FuqEBuqUBuqkBvq0RxqkFwrENxrEVyrEZ0rkd0rkx4r0d2sEx4sE16sE56sU56
    tFB7slB8slN+s1V+s1eBtVqDt2qOvGqQv2KNw2WOxG+VwWyWynKXw3OYxXeaxXKfz3Sfz3+
    gx36hyn+iy3+kzIKjy4elyoSkzIWmzZSx05Oy1pG02ZS22pa325q42p252Z+52Zu63KC726
    C82qG+3aK+3aO/3aC+3qbA3afA3ajC3qbC4KrE4arG4q3G4a/H4azG4q7I4q7I46/J47DI4
    rHJ47LJ4rTJ4rDJ5LHK5LPK5LTM5bXM5bbN5bfN5bbN5rfN5rjN5brP5rvQ57vR57vR6L3S
    6MDS5sDU6cHV6sPW6sXV6MjY6cja7Mna7Mrb7M3d7c3d7tHf7tTi8NXi8Njj8dnk8Nrl8dv
    m8tzm8tzn8+Dp8+Dp9OHq9OLr9ePs9eTs9eXt9gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAKUALAAAAAAWABYAA
    Aj+AEsJHEiwoMGDCBMWRIFiwYIRKEYYXGCQYZQyc+ywGVPlB0WBFwoUHIEE0B0zcwAVOoQI
    0ZwmIxZA4VFQxxiPIyZc+LEFECA3d85UYaSD4IgiI2DY+FhqxIkqfMB4ARQJhtEFQpZIHNm
    jjZ0plKwORGHDSSkUB2Ho+SLFEtqBTA+OYBOJkqVOFRQSLPAQosO4Ff4K1gt306fDmYwojL
    vg05kzmrBcqCgQx1uBFT6RSaQJqcELTHgUECtwASlJcxh1kjy5NAwYOYoSNJ0IU6U3iwphS
    TJEhQ0kWLhshetoxIgsj3z+4cN8zpswpOHKLpUhCZc7iUymeTICwESDAQgMELAxYYIAwujT
    6w0IADs=
}

image create photo ::img::zoom -format GIF -data {
    R0lGODlhFgAWAPcAAFhaV15gXV9gXmRmYmZoZGdpZWhpZmhqZmlrZmhqZ2lqaGpraGtra2p
    saGtsaWttaWxuaWxtamxuam1vamxua21ua21vbG5wa29wbG9xbHBxbXZ4dXp8eH+AfVmArV
    yFs2GKuWaQv2iTwmmUxW2XxW6ayW6aym+czXKdz3GeznKfznOfznKez3Kfz3Ofz3Sfznagz
    XWhz3ihzXihzoOFgIKEgYSGgoiKhYmKiY+Qj5GSkZaWlpmZmZubm6GhoaOkoaeopqioqKip
    qK2trb6+voqmxY6oxYKkyoWmyompy5apwZutwp6vxIWr1o+x2Zaz0pe005e42626yrnK3L7
    O3qnE4q7I47TM5rbN5rnO58LCwsTExMnJyMrKycvMyszMzNHR0dLS0tXV1dHV2dTW2dbY2t
    fY2tjY2NnZ2Nra2dja29ra2trb29vb29rb3Nzc3Nzd3t7e3t/f38DT6cTW6sfY68fZ7MjZ7
    Mvb7NHZ4dLZ4NXc5NLg79vi6dHg8NPg8NPh8Nbi8dbj8dfk8dnk8tnl8trl8tvm8tvm893o
    897o9OHh4eLi4ufn5+zs7ODq9OHq9eLr9eTs9eTs9ufu9+zy+AAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAJYALAAAAAAWABYAA
    Aj+AC0JHEiwoEGDGzJoyJBhAoeDBzN4eUNmjBkzXiZAJJghjRISMVi0ELEEzoWNliakKcKi
    DiRIgazEMJJGI0QgTFoEolRJEqI/UVpI+QERQZoQVQpBkgSpEJ4mLY6kQXBwAhwTdP4UUqS
    oUJYWLUwwilA1TQsseP4MKnRHoEhGJw1ajeEEi505BF2YqHmQxpYjI1oYBJHECw2INfS0OG
    GwhZ4CGyMAodLiw0APL6h8GUIV4gQdfZ7MaDEDyh4EjILsgAwxAoccWuAQwTEgJZkdPDpDv
    DGh9w2BDCaE4cGDNUq5YHwEYXD8IAMwW8QAQOmokcEAcBjpbk4QgE3u4MMDCwwIADs=
}

image create photo ::img::save -format GIF -data {
    R0lGODlhFgAWAPYAAFt6clRye1d4fV58eWZoZGdpZG5wa2B9bnJ1a3V5bHd5dXyBbWyFd3+
    Bfj9shjhniz9qiTtskTxtkT9ylklugkJuiEFsik1yglR3gFF5ilN5ilt+iEJwkk15kUR4nE
    d9okd9o22NjnCKgmiJk0qApkqAqE6HsFCIsVCJslGLtVOMtViSvWKWu1uWwVyXw16Zxl6ax
    2CcymCdy2KfzmOgzmeizmOh0Gej0mul03So03So1HWp1YOFgI6PjZGRkZSWkZSUlJeXl5iY
    mJudmaOkoqWlpampqaysrLCwsLGxsLKysri4uLq6uru7u7y8vIGt0Y+228DAwMHBwcTExMX
    FxMXFxcfHx8bMwMnOw8jIyMnJycvLy8zMy8zMzM3Nzc/Pzc7OzsrQxMzRxdLWzNPYzNDQ0N
    HR0dbW1tfX19ja2Nvb2+Dg4OHh4eHi4eLi4eLj4ePj4+Xl5ebm5ufn5+np6Orr6uvr6+zs7
    O3t7fHx8fPz8/b29gAAAAAAAAAAAAAAACH5BAEAAHwALAAAAAAWABYAAAf+gHyCDB0Phg8V
    GIKLjI0cLE85UDszGhSNmHwZNR4TESAzOzggFpmLAyEbixUgMDAtIBWmfBcijREqKy0zAge
    mAAsGwgYJDyvHKyMBwwaNCHvQ0MbIMQ/Re82LPHd7dt7GKMc2D95pdjyMQ3d2e4cr4SszDx
    EPbHU/iwZccN8xMTcoUuhyAYPcHS4IBBmIw8/OmAgxTKCQaMJFBDF27tzJpoCbNztiHkSU6
    OJBGG977jQQ1ONOHGgasYhEUfIktDh3evAxsCSOnTkvoZERGYHMzThs2CgxQGCMnjhQo8a5
    8gCL1KR5wBAwcK2r167C2IAZS5bsFjBn0W45yyZsFjVBPoQUQaLESRMrZqKc0cu3rQE2WdA
    AkWvkyBIpU/LuXRzFL2AwU6JEjhLFShbFfPf63ZK0s+fPnrM0Y0a6NGk+gQAAOw==
}
