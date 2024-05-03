# Σ-Δ ADC 数模混合电路模型

## 介绍
1. 工程基于lattice提供的方案。  
[lattice提供的方案](https://www.latticesemi.com/products/designsoftwareandip/intellectualproperty/referencedesigns/referencedesign03/simplesigmadeltaadc)  
2. 本工程致力于以下两个目标：  
- 使用实例帮助初学者理解Σ-Δ(Sigma-Delta)ADC的原理  
- 在FPGA上使用简单的外围电路，实现AD转换  
3. 实现所需的器件
- 一个运放或比较器  
- 电容电阻  
- 一个FPGA  

## 系统架构
#### 逻辑结构
![输入图片说明](https://images.gitee.com/uploads/images/2021/1118/170202_e0e31bd5_8241888.png "流程图.png")  
Σ-Δ ADC一眼看上去，都看不出能AD转换，给人一种“这真的是ADC吗”的感觉。  
本人才疏学浅，大神讲解得更深入：[B站链接](https://www.bilibili.com/video/BV1PV41127QD)  
#### 外围电路
![外围电路](https://images.gitee.com/uploads/images/2021/1117/171950_f872b79a_8241888.jpeg "批注 2021-11-17 17120.jpg")  
显而易见，这是一个比较器，或者是一个工作在比较器状态的运放。  
模拟信号连接至正相输入端，反馈信号经过RC滤波连接至反相输入端，比较器输出连接至FPGA。  
RC滤波器是一个低通滤波器，截止频率与ADC的采样速率和FPGA工作频率有关。
#### 数字设计
外围电路将模拟信号转换为1位的01序列，这样我们就能用数字逻辑去处理模拟信号。  
1. 使用一个累加器，统计一段固定长度序列中1的个数。通过这种方法，可以将01序列转换为一段序列的占空比。累加器宽度由ACCUM_BITS决定。  
2. 占空比信号是有波动的，后端使用一个均值滤波器去除毛刺，滤波器越深，信号速率越低，精度越高。滤波器深度由LPF_DEPTH_BITS决定。  
3. ADC_WIDTH参数贯穿始终，它是ADC的位宽。  
## 使用教程
#### 逻辑仿真
windows环境，需要安装iverilog。  
clone项目，进入`RTL/tb`，运行`make.bat`  
#### 制作实物
k7_fpga.rar是vivado 2019.2的工程，配合`硬件电路/`提供的原理图，可以实现Σ-Δ ADC。  
#### 输出时序
![输入图片说明](https://images.gitee.com/uploads/images/2021/1122/140002_857d6d84_8241888.jpeg "时序图.jpg")  
## 演示
使用7k325连接外围电路，采集电压，8bit输出。内置逻辑分析仪查看情况。  
sample_rdy高电平脉冲表示一次转换结束，输出结果为0x6d。  
实验的ADC位宽为8bit，量程是0-3.3V，那么实际电压为`0x6d/0xff*3.3=1.41v`，与万用表测量结果吻合。
![ILA界面](https://images.gitee.com/uploads/images/2021/1117/185120_6323f1ee_8241888.jpeg "批注 2021-11-17 184927.jpg")


