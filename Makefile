test: test-simple test-complex-1 test-complex-2 test-complex-3

test-simple: 
	rm -f test/simple-is.html
	pandoc -F pandoc-citeproc --lua-filter pandoc-refheadstyle.lua \
		-o test/simple-is.html test/simple.md
	cmp test/simple-is.html test/simple-should.html

test-complex-1:
	rm -f test/complex-1-is.html
	pandoc -F pandoc-citeproc --lua-filter pandoc-refheadstyle.lua \
		-o test/complex-1-is.html test/complex-1.md
	cmp test/complex-1-is.html test/complex-1-should.html

test-complex-2:
	rm -f test/complex-2-is.html
	pandoc -F pandoc-citeproc --lua-filter pandoc-refheadstyle.lua \
		-o test/complex-2-is.html test/complex-2.md
	cmp test/complex-2-is.html test/complex-2-should.html

test-complex-3:
	rm -f test/complex-3-is.html
	pandoc -F pandoc-citeproc --lua-filter pandoc-refheadstyle.lua \
		-o test/complex-3-is.html test/complex-3.md
	cmp test/complex-3-is.html test/complex-3-should.html

.PHONY: test test-simple test-complex-1 test-complex-2 test-complex-3
