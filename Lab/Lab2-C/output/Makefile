RAW2PNG=../../part-1/raw2img.py

RAW=$(wildcard *.raw)
PNG=$(RAW:%.raw=%.png)

all: $(PNG)

%.png: %.raw
	@$(RAW2PNG) $^

clean:
	@rm -f *.png
