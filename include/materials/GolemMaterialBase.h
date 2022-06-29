/******************************************************************************/
/*           GOLEM - Multiphysics of faulted geothermal reservoirs            */
/*                                                                            */
/*          Copyright (C) 2017 by Antoine B. Jacquey and Mauro Cacace         */
/*             GFZ Potsdam, German Research Centre for Geosciences            */
/*                                                                            */
/*    This program is free software: you can redistribute it and/or modify    */
/*    it under the terms of the GNU General Public License as published by    */
/*      the Free Software Foundation, either version 3 of the License, or     */
/*                     (at your option) any later version.                    */
/*                                                                            */
/*       This program is distributed in the hope that it will be useful,      */
/*       but WITHOUT ANY WARRANTY; without even the implied warranty of       */
/*        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       */
/*                GNU General Public License for more details.                */
/*                                                                            */
/*      You should have received a copy of the GNU General Public License     */
/*    along with this program.  If not, see <http://www.gnu.org/licenses/>    */
/******************************************************************************/

#pragma once

#include "Material.h"
#include "RankTwoTensor.h"
#include "UserObjectInterface.h"
#include "Function.h"
#include "GolemFluidDensity.h"
#include "GolemFluidViscosity.h"
#include "GolemPermeability.h"
#include "GolemPorosity.h"
#include "GolemScaling.h"

class GolemMaterialBase : public Material
{
public:
  static InputParameters validParams();
  GolemMaterialBase(const InputParameters & parameters);
  static MooseEnum materialType();

protected:
  virtual void initQpStatefulProperties();
  void computeGravity();
  void computeRotationMatrix();
  Real computeQpScaling();
  bool _has_scaled_properties;
  Real _rho0_f;
  Real _rho0_s;
  Real _phi0;
  bool _has_gravity;
  Real _g;
  Real _scaling_factor0;
  const Function * _function_scaling;
  Real _alpha_T_f;
  Real _alpha_T_s;
  const GolemFluidDensity * _fluid_density_uo;
  const GolemFluidViscosity * _fluid_viscosity_uo;
  const GolemPermeability * _permeability_uo;
  const GolemPorosity * _porosity_uo;
  const GolemScaling * _scaling_uo;
  MooseEnum _material_type;
  MaterialProperty<Real> & _scaling_factor;
  MaterialProperty<Real> & _porosity;
  MaterialProperty<Real> & _fluid_density;
  MaterialProperty<Real> & _fluid_viscosity;
  RealVectorValue _gravity;
  RankTwoTensor _rotation_matrix;
};