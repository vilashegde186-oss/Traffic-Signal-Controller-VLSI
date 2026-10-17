Density-Adaptive Traffic Signal Controller (Verilog / VLSI)

A traffic light controller built from small Verilog blocks, one layer at a time:
gates -> counter -> FSM -> density logic -> timer + FSM integration with a pedestrian crossing.

The "AI" in the project title is rule-based adaptive control: vehicle count is
bucketed into low / medium / high density, and the green time (5 / 10 / 20 time units)
is chosen from that. There is no machine learning.

Source: course codebook "Mastering Digital Design with Verilog - RTL, FSM, ModelSim"
(Elevance Skills & Technology internship, project 1).

How it works

The FSM decides the state and how long to stay in it (`timer_limit`).
The timer counts clock cycles and pulses `timer_expired` when time is up.

State order: GREEN -> YELLOW -> RED -> (PEDESTRIAN if a button press is latched) -> GREEN.

Repo layout
src/
  common/                        traffic_timer.v  (shared by Module 2 and Module 4)
  module1_foundations/           and / or / not gates + testbenches
  module2_building_blocks/       counter, fixed-time light controller, top, testbenches
  module3_hardware_intelligence/ junction_fsm, density_logic, traffic_fsm + testbenches
  module4_system_integration/    traffic_fsm_final (with pedestrian), top_final, tb_final
  module5_rtl_verification/      blocking vs non-blocking demos, shift register
scripts/
  run_sim.tcl                    batch-mode Vivado simulation for any testbench

Every file starts with `` `timescale 1ns/1ps `` so Vivado never complains about mixed timescales.

Testbench -> what to look at

| Testbench (set as simulation top) | Watch these signals |
|---|---|
| `and_gate_tb`, `or_gate_tb`, `not_gate_tb` | `a`, `b`, `y` |
| `traffic_counter_tb` | `count` only increments while `enable=1` |
| `traffic_system_tb` | `red`, `yellow`, `green` cycle with an 8-cycle timer |
| `junction_tb` | `ns_*` and `ew_*` take turns |
| `density_tb` | `vehicle_density` = 0, 1, 2 for counts 0, 15, 45 |
| `traffic_fsm_tb` | `timer_limit` changes with `vehicle_density` while green |
| `traffic_system_tb_final` | full system; `$monitor` prints every change to the Tcl console |
| `traffic_system_tb_ped` | extra testbench: button pressed in green, then `GREEN -> YELLOW -> RED -> PEDESTRIAN -> GREEN` (the course tb resets before the pedestrian phase is reached) |
| `blocking_tb` vs `nonblocking_tb` | `b` follows `a` immediately vs one clock later |
| `shift_register_tb` | `stages` shifts left one bit per clock |

Simulate in Vivado (GUI)

1. Create Project -> RTL Project -> tick "Do not specify sources at this time" -> pick any part (e.g. `xc7a35tcpg236-1`).
2. Add Sources -> Add or create **simulation** sources -> add every `.v` file under `src/` (Add Files, select all, untick "Copy sources into project" if you want the repo to stay the single source of truth).
3. In the Sources panel, open *Simulation Sources -> sim_1*, right-click the testbench you want -> **Set as Top**.
4. Flow Navigator -> **Run Simulation -> Run Behavioral Simulation**.
5. In the Tcl console type `run all` (the testbenches stop themselves with `$finish`), then use *Zoom Fit* on the waveform window.

