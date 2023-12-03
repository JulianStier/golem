[Mesh]
  type = FileMesh
  file = H_1D_bc_steady.msh
  boundary_id = '0 1 2 3 4 5'
  boundary_name = 'left right bottom top front back'
[]

[Variables]
  [pore_pressure]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.0
  []
[]

[Kernels]
  [H_time]
    type = GolemKernelTimeH
    variable = pore_pressure
  []
  [HKernel]
    type = GolemKernelH
    variable = pore_pressure
  []
[]

[Functions]
  [q_func]
    type = ParsedFunction
    expression = 'q1*t'
    symbol_names = 'q1'
    symbol_values = '4.46530093e-11'
  []
[]

[BCs]
  [q_right]
    type = FunctionNeumannBC
    variable = pore_pressure
    boundary = right
    function = q_func
  []
[]

[Materials]
  [hydro_1]
    type = GolemMaterialH
    block = 0
    permeability_initial = 1.0e-14
    fluid_viscosity_initial = 0.864e-03
    porosity_initial = 1.0
    fluid_modulus = 5.0e+09
    porosity_uo = porosity
    fluid_density_uo = fluid_density
    fluid_viscosity_uo = fluid_viscosity
    permeability_uo = permeability
  []
  [hydro_2]
    type = GolemMaterialH
    block = 1
    permeability_initial = 1.0e-14
    fluid_viscosity_initial = 0.864e-03
    porosity_initial = 1.0
    fluid_modulus = 2.5e+09
    porosity_uo = porosity
    fluid_density_uo = fluid_density
    fluid_viscosity_uo = fluid_viscosity
    permeability_uo = permeability
  []
[]

[UserObjects]
  [porosity]
    type = GolemPorosityConstant
  []
  [fluid_density]
    type = GolemFluidDensityConstant
  []
  [fluid_viscosity]
    type = GolemFluidViscosityConstant
  []
  [permeability]
    type = GolemPermeabilityConstant
  []
[]

[Preconditioning]
  [hypre]
    type = SMP
    full = true
    petsc_options_iname = '-pc_type -pc_hypre_type
                           -ksp_type -ksp_rtol -ksp_max_it
                           -snes_type -snes_atol -snes_rtol -snes_max_it
                           -ksp_gmres_restart'
    petsc_options_value = 'hypre boomeramg
                           fgmres 1e-10 100
                           newtonls 1e-05 1e-10 100
                           201'
  []
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'
  automatic_scaling = true
  start_time = 0.0
  end_time = 7776
  dt = 777.6
  num_steps = 10
[]

[Outputs]
  interval = 5
  print_linear_residuals = true
  perf_graph = true
  exodus = true
[]
