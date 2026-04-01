COMPILER := iverilog
SOURCE := src
SIMULATION := sim
DESTINY := vvp

all: vvp

vvp: simulacao
	$(DESTINY) $(DESTINY)/simulacao

simulacao:
	$(COMPILER) -o $(DESTINY)/simulacao $(SOURCE)/*.v $(SIMULATION)/*.v


clean:
	rm vvp/*
	rm simulacao.vcd

init: vvp
	gtkwave simulacao.vcd