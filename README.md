APB Protocol Development

📘 Overview
The Advanced Peripheral Bus (APB) protocol is optimized for low-power, low-latency, and simple communication between system-on-chip (SoC) peripherals such as GPIO, UART, SPI, and timers. It acts as a bridge between high-speed buses like AHB/AXI and low-performance peripherals.

🚀 Key Features
Single-Clock Cycle Transfers
Transfers complete in one clock cycle, ensuring minimal latency.

No Pipeline Stages
The non-pipelined structure offers reduced complexity.

Low Power Consumption
Perfectly suited for low-power peripheral communication.

Simple Control Signals
A minimal signal set enables easy integration and debugging.

📶 APB Signal Description
🔹 Clock and Reset Signals
PCLK: Clock signal for synchronization.

PRESETn: Active-low reset signal for peripheral initialization.

🔹 Address and Control Signals
PADDR: Address for register or memory access.

PWRITE: High = Write, Low = Read.

PSELx: Select signal to enable the target peripheral.

PENABLE: Indicates the access phase of the transaction.

🔹 Data Signals
PWDATA: Data from master to peripheral (write).

PRDATA: Data from peripheral to master (read).

🔹 Handshake and Status Signals
PREADY: Indicates if the slave is ready.

PSLVERR: Error signal for failed or invalid transfers.

🧪 Example Transactions
✅ Write Transaction
Setup Phase:

Assert PSELx

Set address on PADDR

Set PWRITE = 1

Access Phase:

Assert PENABLE

Provide data on PWDATA

Wait for PREADY = 1

Deassert PENABLE


✅ Read Transaction
Setup Phase:

Assert PSELx

Set read address on PADDR

Set PWRITE = 0

Access Phase:

Assert PENABLE

Wait for data on PRDATA and PREADY = 1

Deassert PENABLE



⚙️ Modules Overview
🔸 APB Master
FSM-based controller.

Initiates read/write based on start_trans and start_write.

Operates in 3 states: IDLE, SETUP, ACCESS.

🔸 APB Slave
Responds to valid transfers using PSELx, PENABLE, and PWRITE.

Asserts PREADY when done.

Returns data via PRDATA.

🔸 Top Module
Instantiates both Master and Slave modules.
![image15](https://github.com/user-attachments/assets/6fee7dea-4121-4579-8f8c-c950e782cfdd)


✅ Simulation and Hardware Testing
Verified with Icarus Verilog + GTKWave.

Validated on Vaaman FPGA Board.

🔹 Waveform Results
Write Transaction:
![image8](https://github.com/user-attachments/assets/f5e6af0e-8f6c-417b-afec-02a9f7eb4d8f)


Read Transaction & Logic Timing:
![image7](https://github.com/user-attachments/assets/1f8a98f1-f69c-4ecd-8cef-b18853d0388a)

📚 References
ARM AMBA APB Protocol Guide

ARM APB Specification
