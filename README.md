# MATLAB TMeasy Tire Model

A MATLAB implementation of a **steady-state tire friction model based on the TMeasy approach**.

The model calculates the friction coefficients for longitudinal and lateral slip and considers the effect of wheel load.

## Model

**Inputs:**

* Wheel load: `Fz`
* Longitudinal slip: `lambda_x`
* Lateral slip: `lambda_y`

**Outputs:**

* Total friction coefficient: `mu`
* Longitudinal friction coefficient: `mu_x`
* Lateral friction coefficient: `mu_y`

The combined slip is calculated as:

```text
lambda = sqrt(lambda_x² + lambda_y²)
```

The tire forces can then be calculated from:

```text
Fx = mu_x · Fz
Fy = mu_y · Fz
```

## Results

The following plots show the calculated friction behavior for a constant wheel load of **Fz = 5000 N**.

### Total Friction Coefficient

<img width="1920" height="926" alt="mu_x_y" src="https://github.com/user-attachments/assets/6f45c246-2423-48e7-bffe-93661b3773e7" />


### Longitudinal Friction Coefficient

<img width="1920" height="926" alt="mu_x" src="https://github.com/user-attachments/assets/ef3d059d-3fa6-4998-9b3b-998b1e990b8e" />

### Lateral Friction Coefficient

<img width="1920" height="926" alt="mu_y" src="https://github.com/user-attachments/assets/597fd1aa-2387-4201-b90c-52968fe68e76" />

## Files

```text
FrictionCoeff_Steady.m          % TMeasy steady-state tire model
main_steady_state_tire_model.m  % Main script and visualization
results/                        % Generated result plots
```

## Requirements

* MATLAB
* No additional toolboxes required




