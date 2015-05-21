Red [
	Title:   "Red series test script"
	Author:  "Peter W A Wood"
	File: 	 %vector-test.red
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include  %../../../quick-test/quick-test.red

~~~start-file~~~ "vector"

===start-group=== "make"

	vector-make-test: func [
		name [string!]
		type [datatype!]
		spec [block!]
		len [integer!] 
		test-value [char! float! integer!]
		/local
			vm-v
	][
		--test-- name
		vm-v: make vector! spec
		--assert len = length? vm-v
		foreach v vm-v [
			test-value: test-value + 1
			--assert test-value = v
			--assert type = type? v
		]
		--assert none = vm-v/0
		--assert none = vm-v/(len + 1)
	]

	--test-- "vector-make-1"
		vm1-v: make vector! 10
		--assert 10 = length? vm1-v
		foreach v vm1-v [
			--assert v = 0
			--assert integer! = type? v
		]
		--assert none = vm1-v/0
		--assert none = vm1-v/11
		
	vector-make-test "vector-make-2" integer! [1 2 3 4 5] 5 0
		
	vector-make-test "vector-make-3" char! [#"b" #"c" #"d" #"e"] 4 #"a"
	
	vector-make-test "vector-make-4" float! [1.0 2.0 3.0 4.0 5.0] 5 0.0

	vector-make-test "vector-make-5" integer! [integer! 8 [1 2 3 4 5]] 5 0

	vector-make-test "vector-make-6" integer! [integer! 16 [1 2 3 4 5]] 5 0
	
	vector-make-test "vector-make-7" integer! [integer! 32 [1 2 3 4 5]] 5 0
	
	vector-make-test "vector-make-8" float! [float! 64 [1.0 2.0 3.0 4.0 5.0]] 5 0.0
	
	vector-make-test "vector-make-9" float! [float! 32 [1.0 2.0 3.0 4.0 5.0]] 5 0.0
		
===end-group===

===start-group=== "vector-truncate"

	--test-- "vector-trunc-1"
		vt1-v: make vector! [char! 8 [#"^(00)" #"^(01)" #"^(02)"]]
		append vt1-v #"^(0100)"
		--assert 4 = length? vt1-v
		--assert #"^(00)" = vt1-v/4
		--assert none = vt1-v/5
		
	--test-- "vector-trunc-2"
		vt2-v: make vector! [char! 16 [#"^(00)" #"^(01)" #"^(02)"]]
		append vt2-v #"^(100100)"
		--assert 4 = length? vt2-v
		--assert #"^(0100)" = vt2-v/4
		--assert none = vt2-v/5
		
	--test-- "vector-trunc-3"
		vt3-v: make vector! [integer! 8 [0 1 2]]
		append vt3-v 256
		--assert 4 = length? vt3-v
		--assert 0 = vt3-v/4
		--assert none = vt3-v/5
	
	--test-- "vector-trunc-4"
		vt4-v: make vector! [integer! 16 [0 1 2]]
		append vt4-v 65536
		--assert 4 = length? vt4-v
		--assert 0 = vt4-v/4
		--assert none = vt4-v/5
		
	--test-- "vector-trunc-6"
		vt5-v: make vector! [float! 32 [0.0 1.0 2.0]]
		append vt5-v 1.23456789012345678901234567
		--assert 1.2345679 = round/to vt5-v/4 0.0000001 
		
===end-group===

===start-group=== "vector path notation"
	
	--test-- "vector-path-1"
		vp1-v: [0 1 2 3 4]
		--assert none = vp1-v/0
		--assert 0 = vp1-v/1
		--assert 1 = vp1-v/2
		--assert 2 = vp1-v/3
		--assert 3 = vp1-v/4
		--assert 4 = vp1-v/5
		--assert none = vp1-v/6
		--assert none = vp1-v/-1
		
===end-group===

~~~end-file~~~
