SVGS=$(wildcard *.svg)
EPSS=$(patsubst %.svg,%.eps,$(SVGS))
DXFS=$(patsubst %.svg,%.dxf,$(SVGS))

all: $(DXFS)

$(DXFS) : %.dxf : %.eps
	mkdir -p output
	pstoedit -dt -f 'dxf:-polyaslines -mm' "$<" "$@"

$(EPSS) : %.eps : %.svg
	inkscape -f "$<" -E "$@" 

clean:
	rm -fr *.eps *.dxf
