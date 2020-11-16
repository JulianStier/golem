[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 5
  ny = 5
  nz = 6
  xmin = 0
  xmax = 1
  ymin = 0
  ymax = 1
  zmin = 0
  zmax = 1
[]

[Variables]
  [./pore_pressure]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./HKernel]
    type = GolemKernelH
    variable = pore_pressure
  [../]
[]

[Functions]
  [./p_left_func]
    type = ParsedFunction
    value = 'p0*(0+y/L+z/L)'
    vars = 'p0 L'
    vals = '1.0e+06 1.0'
  [../]
  [./p_right_func]
    type = ParsedFunction
    value = 'p0*(1+y/L+z/L)'
    vars = 'p0 L'
    vals = '1.0e+06 1.0'
  [../]
  [./p_bottom_func]
    type = ParsedFunction
    value = 'p0*(x/L+0+z/L)'
    vars = 'p0 L'
    vals = '1.0e+06 1.0'
  [../]
  [./p_top_func]
    type = ParsedFunction
    value = 'p0*(x/L+1+z/L)'
    vars = 'p0 L'
    vals = '1.0e+06 1.0'
  [../]
  [./p_back_func]
    type = ParsedFunction
    value = 'p0*(x/L+y/L+0)'
    vars = 'p0 L'
    vals = '1.0e+06 1.0'
  [../]
  [./p_front_func]
    type = ParsedFunction
    value = 'p0*(x/L+y/L+1)'
    vars = 'p0 L'
    vals = '1.0e+06 1.0'
  [../]
[]

[BCs]
  [./p_left]
    type = FunctionDirichletBC
    variable = pore_pressure
    boundary = left
    function = p_left_func
    preset = true
  [../]
  [./p_right]
    type = FunctionDirichletBC
    variable = pore_pressure
    boundary = right
    function = p_right_func
    preset = true
  [../]
  [./p_bottom]
    type = FunctionDirichletBC
    variable = pore_pressure
    boundary = bottom
    function = p_bottom_func
    preset = true
  [../]
  [./p_top]
    type = FunctionDirichletBC
    variable = pore_pressure
    boundary = top
    function = p_top_func
    preset = true
  [../]
  [./p_back]
    type = FunctionDirichletBC
    variable = pore_pressure
    boundary = back
    function = p_back_func
    preset = true
  [../]
  [./p_front]
    type = FunctionDirichletBC
    variable = pore_pressure
    boundary = front
    function = p_front_func
    preset = true
  [../]
[]

[Materials]
  [./hydro]
    type = GolemMaterialH
    block = 0
    permeability_initial = 1.0e-10
    fluid_viscosity_initial = 1.0e-03
    porosity_uo = porosity
    fluid_density_uo = fluid_density
    fluid_viscosity_uo = fluid_viscosity
    permeability_uo = permeability
  [../]
[]

[UserObjects]
  [./porosity]
    type = GolemPorosityConstant
  [../]
  [./fluid_density]
    type = GolemFluidDensityConstant
  [../]
  [./fluid_viscosity]
    type = GolemFluidViscosityConstant
  [../]
  [./permeability]
    type = GolemPermeabilityConstant
  [../]
[]

[Preconditioning]
  [./hypre]
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
  [../]
[]

[Executioner]
  type = Steady
  solve_type = 'NEWTON'
  automatic_scaling = true
[]

[Outputs]
  print_linear_residuals = true
  perf_graph = true
  exodus = true
[]
