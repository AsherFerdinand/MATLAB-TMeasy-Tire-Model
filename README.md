
# MATLAB TMeasy Tire Model

A MATLAB implementation of a **steady-state tire friction model based on the TMeasy approach**. The model describes tire-road friction behavior as a function of longitudinal and lateral slip while accounting for variations in vertical wheel load.

## Overview

The purpose of this project is to model and visualize the friction characteristics of a tire under:

* Longitudinal slip (`λx`)
* Lateral slip (`λy`)
* Combined slip
* Different vertical wheel loads (`Fz`)

The model calculates the friction coefficients:

* **μ** — combined friction coefficient
* **μx** — longitudinal friction coefficient
* **μy** — lateral friction coefficient

These friction coefficients can subsequently be used to calculate the corresponding tire forces:

$$
F_x = \mu_x F_z
$$

$$
F_y = \mu_y F_z
$$

where `Fz` is the vertical wheel load.

## Model Structure

The project consists of two main parts.

### 1. `FrictionCoeff_Steady.m`

This function calculates the steady-state friction coefficients for a given:

```text
Fz
λx
λy
```

The combined slip is calculated as:

$$
\lambda = \sqrt{\lambda_x^2+\lambda_y^2}
$$

The model then determines the longitudinal and lateral friction characteristics using the specified tire parameters.

The tire parameters include:

* Slip at maximum friction
* Maximum friction coefficient
* Slip at transition to complete sliding
* Sliding friction coefficient
* Tire longitudinal stiffness
* Tire lateral stiffness

The parameters are interpolated according to the vertical wheel load.

### 2. Main MATLAB Script

The main script evaluates the tire model over a range of longitudinal and lateral slip values:

```matlab
lambda_x = -0.5:0.02:0.5;
lambda_y = -0.5:0.02:0.5;
```

For every combination of `λx` and `λy`, the model calculates:

```text
μ
μx
μy
```

The results are then visualized using 3D surface plots.

## Outputs

The script generates three 3D plots:

### Combined friction coefficient

$$
\mu(\lambda_x,\lambda_y)
$$

This represents the overall tire-road friction under combined longitudinal and lateral slip.

### Longitudinal friction coefficient

$$
\mu_x(\lambda_x,\lambda_y)
$$

This represents the longitudinal component of the tire friction.

### Lateral friction coefficient

$$
\mu_y(\lambda_x,\lambda_y)
$$

This represents the lateral component of the tire friction.

## Example

The example uses a constant vertical wheel load of:

```matlab
Fz = 5000; % N
```

and evaluates the tire behavior for:

```matlab
-0.5 ≤ λx ≤ 0.5
-0.5 ≤ λy ≤ 0.5
```

The resulting surfaces show how tire grip changes when braking/acceleration and cornering occur simultaneously.

## Tire Force Calculation

The current implementation calculates **friction coefficients**, not tire forces directly.

For a known vertical wheel load, the corresponding forces can be calculated as:

```matlab
Fx = mu_x * Fz;
Fy = mu_y * Fz;
```

For example, with:

```matlab
Fz = 5000; % N
mu_x = 0.8;
```

the longitudinal tire force would be:

```matlab
Fx = 0.8 * 5000;
```

resulting in:

```text
Fx = 4000 N
```

Since `Fz` is constant, the force surfaces have the same general shape as the corresponding friction-coefficient surfaces, but are scaled by `Fz`.

## Repository Structure

```text
MATLAB-TMeasy-Tire-Model/
│
├── FrictionCoeff_Steady.m
├── Exercise_1.m
├── README.md
│
└── figures/
    ├── mu_surface.png
    ├── mux_surface.png
    └── muy_surface.png
```

## Requirements

* MATLAB
* No additional MATLAB toolboxes are required for the basic implementation.

## How to Run

1. Clone or download the repository.
2. Open MATLAB.
3. Add the project folder to the MATLAB path.
4. Make sure `FrictionCoeff_Steady.m` and the main script are in the same directory.
5. Run the main script.

The script will calculate the friction coefficients over the specified slip range and generate the corresponding 3D surface plots.

## Model Parameters

The model contains separate parameters for longitudinal and lateral tire behavior.

| Parameter      | Description                               |
| -------------- | ----------------------------------------- |
| `Fz_1`, `Fz_2` | Reference wheel loads                     |
| `lambdaM_x`    | Longitudinal slip at maximum friction     |
| `lambdaM_y`    | Lateral slip at maximum friction          |
| `muM_x`        | Maximum longitudinal friction coefficient |
| `muM_y`        | Maximum lateral friction coefficient      |
| `lambdaG_x`    | Longitudinal slip at complete sliding     |
| `lambdaG_y`    | Lateral slip at complete sliding          |
| `muG_x`        | Longitudinal sliding friction coefficient |
| `muG_y`        | Lateral sliding friction coefficient      |
| `dF0_x`        | Longitudinal tire stiffness               |
| `dF0_y`        | Lateral tire stiffness                    |

## Concept

The overall calculation can be summarized as:

```text
             λx
              │
              │
              ▼
        ┌─────────────┐
λy ────►│ TMeasy-based │
        │ tire model  │
Fz ────►│             │
        └──────┬──────┘
               │
       ┌───────┼────────┐
       ▼       ▼        ▼
       μ       μx       μy
               │        │
               ▼        ▼
              Fx       Fy
```

The model therefore provides a relationship between **tire slip, vertical load, friction coefficient, and tire force**.

## Future Improvements

Possible extensions of this project include:

* Direct calculation of `Fx` and `Fy`
* Visualization of tire forces instead of only friction coefficients
* Variable vertical wheel load
* Comparison with experimental tire data
* Implementation of transient tire behavior
* Vehicle-level simulation using the tire model
* Comparison with other tire models such as Pacejka/Magic Formula
* Interactive parameter visualization




That makes the repository look much more like a proper engineering/software project rather than just a university exercise.

