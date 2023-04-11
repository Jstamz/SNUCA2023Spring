RESOLUTION=256 512 1024
PNG=$(foreach res, $(RESOLUTION),$(wildcard *_$(res).png))
RAW=$(PNG:%.png=%.raw)


clean:
	@rm -f images/*.raw images/*int.png images/*float.png


blur:
	for res in 256 512 1024 ; do \
		for k in 3x3 5x5 7x7 ; do \
			for type in int float ; do \
				for name in 301_ cat_ Gong_ Sha_ SNU_ ; do \
					python blur_driver.py images/$$name$$res.raw -p --kernel $$k -t $$type ; done \
			done \
		done \
	done

blend:
	for res in 256 512 1024 ; do \
		for type in int float ; do \
			for a in 0.5 0.1 0.9 ; do \
				for name1 in cat_ Gong_ Sha_ SNU_ 301_ ; do \
					for name2 in 301_ cat_ Gong_ Sha_ SNU_ ; do \
						for m in merge overlay ; do \
							python blend_driver.py images/$$name1$$res.raw images/$$name2$$res.raw -p -m $$m -a $$a -t $$type ; done \
					done \
				done \
			done \
		done \
	done

all:
	make clean
	make blur
	make blend
