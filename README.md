# Cardiac Electrophysiology and Extracellular Vesicle Release Model

## Overview

This project implements a comprehensive mathematical model of cardiac electrophysiology with a focus on calcium dynamics and extracellular vesicle (EV) release mechanisms. The model simulates the complex interplay between action potentials, calcium cycling, and EV release rates in cardiac cells under various physiological conditions, with and without external control signals.

## Scientific Background

The model is based on established cardiac electrophysiology principles and incorporates:

- **Action Potential Generation**: Simulation of cardiac cell electrical activity across physiological heart rates
- **Multi-compartment Calcium Dynamics**: Detailed modeling of intracellular calcium cycling including:
  - Sub-membrane calcium space
  - Bulk cytoplasmic calcium
  - Sarcoplasmic reticulum (SR) calcium storage and release
  - Junctional SR calcium dynamics
  - Local calcium microdomains near L-type channels
- **Ion Channel and Transporter Modeling**:
  - L-type calcium channels (LTCC) with voltage and calcium-dependent gating
  - Sodium-calcium exchanger (NCX)
  - Sarcoplasmic reticulum calcium uptake pumps
- **Calcium Buffering Systems**:
  - Troponin C binding in both sub-membrane and bulk spaces
  - SR membrane and calmodulin binding sites
- **Extracellular Vesicle Release**: Novel modeling of EV release rates from:
  - Sub-membrane calcium microdomains
  - L-type calcium channel microdomains
  - Control signal modulation capabilities
- **Heart Rate Variability**: Comprehensive analysis across physiological heart rates (60-120 bpm)

## Key Features

- **8-compartment calcium model** with explicit troponin C dynamics
- **Voltage-dependent and calcium-dependent** ion channel kinetics
- **Calcium-induced calcium release (CICR)** mechanisms with spark dynamics
- **Dual-source EV release** modeling (sub-membrane + LTCC microdomains)
- **Control signal modulation** capabilities for therapeutic applications
- **Comprehensive heart rate analysis** (60, 80, 100, 120 bpm)
- **Multiple simulation modes** (with/without control signals)

## File Structure

### Main Simulation Scripts

- **`CalciumSignaling.m`** - Primary analysis of calcium signaling across heart rates
  - Action potential simulation
  - Sub-membrane calcium concentration analysis
  - Calcium current (JCa) analysis
  - Sodium-calcium exchange current (JNaCa) analysis

- **`CalciumInBulkMyoplasmSpace.m`** - Analysis of bulk myoplasm calcium dynamics
  - Long-term calcium concentration trends
  - Heart rate effects on bulk calcium

- **`EVReleaseWithControlSignals.m`** - EV release analysis with external control
  - Control signal generation and modulation
  - EV release rate calculations with control inputs
  - Comparative analysis across heart rates

- **`EVReleaseWithoutControlSignal.m`** - Natural EV release analysis
  - Baseline EV release mechanisms
  - Sub-membrane vs LTCC microdomain contributions
  - Cumulative EV release profiles

### Core Model Components

- **`diff_ca_eqs.m`** - Main differential equation system (8 state variables)
- **`AP.m`** - Action potential waveform generation

### Ion Channels and Transporters

- **`I_ca.m`** - L-type calcium current (primary formulation)
- **`I_ca_L.m`** - Alternative L-type calcium current formulation
- **`M_I_ca.m`** - Baseline calcium current calculation
- **`I_naca.m`** - Sodium-calcium exchanger current
- **`I_up.m`** - Sarcoplasmic reticulum calcium uptake

### Calcium Handling and Buffering

- **`R_ca_L.m`** - EV release rate from L-type calcium channel microdomains
- **`R_ca_m.m`** - EV release rate from sub-membrane calcium
- **`I_trpn_s.m`** - Calcium binding to troponin C (sub-membrane)
- **`Betta.m`** - Calcium buffering to SR membrane and calmodulin sites

### Utility Functions

- **`f_h.m`** - Hill function for cooperative binding
- **`QQ.m`** - Release function with threshold and saturation behavior
- **`control.m`** - Control signal generation

## Requirements

- MATLAB R2016b or later
- No additional toolboxes required (uses base MATLAB functions)

## Usage

### 1. Basic Calcium Signaling Analysis

```matlab
% Run comprehensive calcium signaling analysis
CalciumSignaling
```

This generates a 2×2 subplot figure showing:
- Action potentials across heart rates
- Sub-membrane calcium concentration
- Calcium current (JCa)
- Sodium-calcium exchange current (JNaCa)

### 2. Bulk Calcium Analysis

```matlab
% Analyze long-term bulk calcium dynamics
CalciumInBulkMyoplasmSpace
```

Shows bulk myoplasm calcium concentration over extended time periods.

### 3. EV Release Analysis (Natural)

```matlab
% Study natural EV release without control signals
EVReleaseWithoutControlSignal
```

Generates comprehensive analysis of:
- EV release rates from sub-membrane and LTCC microdomains
- Cumulative EV release profiles
- Heart rate dependencies

### 4. EV Release Analysis (With Control)

```matlab
% Study controlled EV release modulation
EVReleaseWithControlSignals
```

Shows:
- Control signal profiles with different amplitudes and timing
- Modulated EV release rates
- Heart rate and control signal interactions

### 5. Custom Parameter Studies

```matlab
% Set simulation parameters
global T;
T = 1.0;  % Pacing period (seconds, for 60 bpm)

% Run calcium dynamics
dx = 1/3000;  % High resolution time step
c0 = [0.17; 0.09; 10; 2.5e-5; 5; 0; 0; 0.17];  % Initial conditions
[t,c] = ode45(@diff_ca_eqs, linspace(0,3,1/dx), c0);

% Extract and plot specific variables
cs = c(:,1);    % Sub-membrane calcium
cb = c(:,2);    % Bulk calcium
cSR = c(:,3);   % SR calcium
Jr = c(:,4);    % Release flux
cJSR = c(:,5);  % Junctional SR calcium
TrpnI = c(:,6); % Troponin C (bulk)
TrpnS = c(:,7); % Troponin C (sub-membrane)
cL = c(:,8);    % Local LTCC calcium

figure;
subplot(2,2,1); plot(t*1000, cs); title('Sub-membrane Ca^{2+}');
subplot(2,2,2); plot(t*1000, cb); title('Bulk Ca^{2+}');
subplot(2,2,3); plot(t*1000, cSR); title('SR Ca^{2+}');
subplot(2,2,4); plot(t*1000, Jr); title('Release Flux');
```

## Model Variables

### State Variables (in `diff_ca_eqs.m`)
- `c(1)` - Sub-membrane calcium concentration (μM)
- `c(2)` - Bulk cytosolic calcium concentration (μM)
- `c(3)` - Sarcoplasmic reticulum calcium concentration (μM)
- `c(4)` - Calcium release flux from SR (μM/s)
- `c(5)` - Junctional SR calcium concentration (μM)
- `c(6)` - Calcium-bound troponin C in bulk cytoplasm (μM)
- `c(7)` - Calcium-bound troponin C in sub-membrane space (μM)
- `c(8)` - Local calcium concentration near L-type channels (μM)

### Key Parameters

**Physiological Parameters:**
- Heart rates: 60, 80, 100, 120 bpm
- Temperature: 308 K (35°C)
- External calcium: 1.8 mM
- External sodium: 140 mM

**Control Signal Parameters:**
- Amplitudes: 10, 15, 20, 25 μM/s
- Timing: Variable start/stop times
- Duration: Typically 1000 ms

**Calcium Dynamics:**
- Sub-membrane diffusion time: 10 ms
- Spark lifetime: 20 ms
- SR relaxation time: 50 ms

## Model Outputs and Interpretation

### 1. Calcium Signaling Analysis
- **Action Potential**: Shows voltage waveforms with heart rate-dependent morphology
- **Sub-membrane Calcium**: Rapid transients following each action potential
- **Calcium Current**: Inward calcium flux during action potential plateau
- **NCX Current**: Bidirectional sodium-calcium exchange

### 2. EV Release Mechanisms
- **Sub-membrane Release (γs)**: Continuous, calcium-dependent release
- **LTCC Release (γLTCC)**: Spike-triggered release from calcium channel microdomains
- **Total Release (γ)**: Combined release showing complex temporal patterns

### 3. Heart Rate Dependencies
- Higher heart rates show:
  - Increased baseline calcium levels
  - Enhanced EV release rates
  - Modified calcium transient kinetics
  - Altered NCX current patterns

## Technical Details

### Numerical Methods
- **ODE Solver**: ode45 (adaptive Runge-Kutta)
- **Time Resolution**: 1/3000 s for high-fidelity calcium dynamics
- **Simulation Duration**: 1-3 seconds (up to 120 seconds for bulk analysis)

### Model Validation
The model incorporates validated formulations from:
- Luo-Rudy dynamic model for ionic currents
- Established calcium cycling mechanisms
- Physiologically realistic parameter ranges

## Applications

This model is suitable for:
- **Cardiac electrophysiology research**
- **Drug effect simulation** (via control signals)
- **Heart failure mechanism studies**
- **Extracellular vesicle release research**
- **Bio-nanocommunication studies**
- **Therapeutic intervention design**

## Extending the Model

To add new features:

1. **New ionic currents**: Add functions similar to `I_ca.m` and include in `diff_ca_eqs.m`
2. **Additional compartments**: Expand state vector and add equations in `diff_ca_eqs.m`
3. **Drug effects**: Modify existing currents or add control signal modulation
4. **Disease conditions**: Adjust parameters in relevant function files

## References

The model incorporates elements from:
- Luo-Rudy dynamic model for cardiac ionic currents
- Standard calcium-induced calcium release mechanisms
- Established troponin C binding kinetics
- Novel extracellular vesicle release formulations


## Contact

Created by Hamid Khoshfekr Rudsari
khoshfekr1994@gmail.com

---

*This comprehensive model provides insights into cardiac calcium dynamics, electrophysiology, and extracellular vesicle release mechanisms for research and therapeutic applications.*
