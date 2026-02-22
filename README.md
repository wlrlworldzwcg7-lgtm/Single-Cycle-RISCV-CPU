# My first RISC-V Single-cycle CPU

## Description
基于SystemVerilog实现的单周期RISC-V处理器核心

## Supported Instructions
目前实现了基础指令包括add, addi, jal, beq, lw, sw等

## Architecture/Design
核心控制逻辑与数据通路基于Harvey Mudd College的计算机体系结构相关课程的真值表设计
![datapath](e72918191499f2f9303075003c282dd4.png)
<img src="6aa7facf5d113bd11f6a14be6a19b834.jpg" width = "400" alt = "control structure" />
![main decoder](ba1879f81b5b9d8aeb354db519c878d3-2.jpg)
![ALU decoder](dd3dd08b48be7a458d0f515db76ee7d2-1.jpg)
![ImmSrc](30011af71a470681af9f51ba63f81c8e-2.jpg)

## File Structure
- top_module.sv: 顶层连线模块
- control.sv: 控制单元
- alu.sv: 算术逻辑单元
- regfile.sv/imem.sv/dmem.sv: 寄存器堆与指令/数据内存
- mux2.sv/mux4.sv：2选1/4选1的多路选择器
- pc.sv: PC程序计数器
- tb_top.sv: testbench
- memfile.dat: 包含十六进制机器码的测试程序

## How to run
依赖工具：Icarus Verilog, GTKWave

```
iverilog -g2012 -o cpu.out *.sv
vvp cpu.out
gtkwave cpu_wave.vcd
```

## Result
![wave](6c33a633e621db44f0640aaea3b12c31.png)
测试程序成功执行了加法运算并将结果写入数据内存
