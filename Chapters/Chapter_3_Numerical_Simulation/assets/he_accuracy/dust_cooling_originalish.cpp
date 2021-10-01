// Compile: g++ -Wno-deprecated -o dust_cooling.exe dust_cooling.cpp
//
// Calculate the cooling function due to dust cooling. See Dwek & Werner (1981, ApJ, 248, 138)
// for some of the equations. The dust is assumed to be heated by collisions with electrons and
// ions. This transfers energy from the plasma to the dust grain, which subsequently radiates it
// away. Thus the heating rate is also the cooling rate.
//
// At high temperatures, the grains start to become transparent to the incident electrons
// and ions (i.e. the latter are unable to transfer all their energy to the grain). Currently
// I set the efficiency to 1.0, but it still seems to give the correct results!
// 
// The heating/cooling due to electron collisions dominates over that due to proton collisions.
// 
// See also Tenorio-Tagle et al. (2013, ApJ, 778, 159), but note the typo in Eq. 7, which is
// missing exp(-z) cf. Eq. A11 in DW81.
//
// Note that the cooling function is strongly dependent on the grain radius. It is the
// user's task to make sure that if the cooling function is used by an external code (e.g. a
// hydrocode), that the grain radius specified in the external code is consistent with the
// value used to calculate the cooling function!
// 
// JMP 17/11/17 - Original version copied from dustcooling.f
// JMP 19/11/17 - Correctly working!
//


// Includes
#include <cmath>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>

#include <chrono>

// Constants
const double massh=1.6726e-24;
const double masse=9.1093897e-28;
const double kboltz=1.380658e-16;
const double eV_to_erg=1.602e-12;
const double pi=3.141592654;
     
// Function declarations
double func_h_e(double x_e);
double func_zxe(double z, double xe);
double func_zxeDW81(double z, double xe);
void quit();
void write_func_zxe();

using namespace std;

int main(){
  const int ntmax = 10001;
  const int nmax  = 10000;
  
  double logtmin,logtmax,dlogt,logt,logtl,logth,t,z;
  double rho_g,rho_d,nden,a,ne,nH,nd,ntot,massd,dens_g,vol_d;
  double temp;
  double lambda[ntmax],lambda_d[ntmax],tlow[ntmax];
  double xstar,kt,h_n,H_el,H_coll,H_colle,Eh,Ee,x_e,h_e;

  // Specify the initial conditions

  rho_g = 1e-20;  // gas mass density (g/cm^3)
  z = 1e-4;       // dust to gass mass ratio
  a = 0.005;          // grain radius (micrometers)
  dens_g = 3.0;     // density of grain material (g/cm^3) - taken to be 3.0 - see Tenorio-Tagle et al. (2013, ApJ, 778, 159) - 3.3 g/cm^3 is appropriate for silicates (see Draine & Lee 1984) and 1.8 gcm^-3 for amorphous carbon (see Gall et al. 2014, Nature, 511, 326). Graphite has dens_g = 2.2 g/cm^3 (see Serra Diaz-Cano & Jones 2008)

  // For solar with 10 H per 1 He, avg nucleon mass mu_nu = 14/11. 
  // nH = (10/11) ntot
  // rho_g = n_tot * mu_nu * massH = (11/10) * nH * mu_nu * massH = (14/10) * nH * massH

  nH = rho_g*(10.0/14.0)/massh;
  ntot = 1.1*nH;  // total nucelon number density

  // Assume plasma is fully ionized (eletron number density is dominated by H and He) - for
  // 10 H and 1 He there are 12 electrons

  ne = 1.2*nH;

  // Calculate the grain mass, mass density and number density

  rho_d = rho_g*z;                    // dust mass density (g/cm^3)
  vol_d = 4.0*pi*pow(a*1.0e-4,3)/3.0; // grain volume (cm^3)
  massd = dens_g*vol_d;               // average grain mass (g)
  nd = rho_d/massd;                   // grain number density (cm^-3)

  // Write out info
  cout << " Dust cooling calculation:\n";
  cout << "  Grain size           = " << a << " (micrometers)\n";
  cout << "  Avg. grain mass      = " << massd << " (g)\n";
  cout << "  H     number density = "<<nH<<" (cm^-3)\n";
  cout << "  grain number density = "<<nd<<" (cm^-3)\n";

  // Open file to store results
  string outfile = "h_e-2.csv";
  ofstream file(outfile.c_str()); 
  if (!file) {
    cerr << "Failed to open output file: " << outfile;
    quit();
  }
  file << scientific << setprecision(3);
  //file << "#logT_low      logT_centre      logT_high       Incident H     Incident e-    Lambda_dust  \n";
  file << "#logT, h_e \n";
  
  // Loop over temperature

  logtmin = 0.0;
  logtmax = 9.0;
  dlogt = (logtmax - logtmin)/float(ntmax-1);
 
  float kbt[ntmax];
  for (int n = 0; n < ntmax; n++) {
    logtl = logtmin + float(n)*dlogt;        // low T edge of bin
    //t = pow(10,logt);                        // central log temperature of bin
    t = pow(10,logtl);                        // left edge log temperature of bin
    kbt[n] = kboltz*t;
  }  

  float h_e_a[ntmax];

  using std::chrono::high_resolution_clock;
  using std::chrono::duration_cast;
  using std::chrono::duration;
  using std::chrono::milliseconds;
  auto t1 = high_resolution_clock::now();

  for (int n=0; n < ntmax; ++n){
    kt = kbt[n];
    // Now determine the heating rate due to incident electrons.
    // Instead of using the approximation in Eq. A13 of DW1981, we will
    // calculate the function properly.
    Ee = 23.0*pow(a,2.0/3.0); // keV
    Ee = Ee*1.0e3*eV_to_erg;  // ergs
    x_e = Ee/kt;
    h_e_a[n] = func_h_e(x_e); // efficiency (due to grain transparency) of the electron
    

    //file << logtl << "\t" << logt << "\t" << logth << "\t" << nd*H_coll/(ntot*ntot) << "\t" << nd*H_el/(ntot*ntot) << "\t" << lambda[n] << "\n";
    // file << logtl << "\t" << lambda[n] << "\n"; // DW81 lambda
    // file << logtl << ", " << lambda_d[n] << ", " << h_e << "\n";    // JMP lambda_d
  }

  auto t2 = high_resolution_clock::now();
  duration<double, std::milli> ms_double = t2 - t1;
  std::cout << ms_double.count() << "" << "\n";

  for (int n=0; n < ntmax; ++n){
    float T = kbt[n] / kboltz;
    float logT = log10(T);
    file << logT << ", " << h_e_a[n] << "\n";
  }
  file.close();

  // Print out zxe func
  // write_func_zxe();
  
  return 0;
}


// Return the value of the function inside the integral in Eq 7 of TT13
double func_zxe(double z, double xe){
  double zpxe = z + xe;
  double f1 = pow(zpxe,1.5) - pow(xe,1.5);
  return zpxe*f1;
}


// Return the value of the function inside the integral in Eq A11 of DW81.
// Because of the added exponential, this is a much better behaved
// function that the one in Eq7 of TT13.
double func_zxeDW81(double z, double xe){
  double zpxe = z + xe;
  double f1 = pow(zpxe,1.5) - pow(xe,1.5);
  return zpxe*f1*exp(-z);
}


// Write out the function zxe, varying z and xe logarithmically.
// We see that the function peaks at z=1.0, and is relatively tiny
// by z = 1/20 and z = 20.0. Therefore set logzmin = -2.0 and logzmax = 2.0.
void write_func_zxe(){

  const int nzmax = 40;
  double logzmin = -2.0;
  double logzmax = 2.0;
  double dlogz = (logzmax - logzmin)/float(nzmax);
  double z[nzmax+1];

  const int nxemax = 50;
  double logxemin = -2.0;
  double logxemax = 3.0;
  double dlogxe = (logxemax - logxemin)/float(nxemax);
  double xe[nxemax+1];

  // Create bins
  for (int n = 0; n <= nzmax; ++n){
    z[n] = pow(10,logzmin+float(n)*dlogz);
  }
  for (int n = 0; n <= nxemax; ++n){
    xe[n] = pow(10,logxemin+float(n)*dlogxe);
  }

  // Write out
  string outfile = "func_zxeDW81.txt";
  ofstream file(outfile.c_str()); 
  if (!file) {
    cerr << "Failed to open output file: " << outfile;
    quit();
  }
  file << scientific << setprecision(3);
  file << "#func values for various values of z and xe\n";
  
  for (int m = 0; m < nxemax; ++m){
    for (int n = 0; n < nzmax; ++n){
      file << xe[m] << "\t" << z[n] << "\t" << func_zxeDW81(z[n],xe[m]) << "\n"; 
    }
    //file << "\n";
  }
  file.close();
  return;
}


// Perform an integration to find h_e, the effective grain heating efficiency due to electrons
// NOTE: This efficiency is strongly dependent on the grain charge. In most of the equations
// noted here it is assumed that the grains are uncharged. So the calculation results should be
// treated with a large grain of salt! However, it is not uncommon to just assume that the
// grains are uncharged (see TT2013).
// NOTE: write_func_zxe has revealed that the function peaks at z=1.0, and is much smaller by z=1/20 and z=20.
// Therefore set logzmin = -2 and logzmax = +2. Further testing reveals that setting nzmax=400
// with these limits gives accurate results.
// Other notes: phi = qU/kT, U is the electrostatic potential of the grain, q is the charge of the
// colliding particle (e- or H). Grains are positively charged at higher temperatures.
// According to p 140 of Dwek and Werner, phi = 0.15 for T=1e6K, and that it decreases at
// higher temperatures. For uncharged grains, h(a,T) is unity for T < 1e6 K, because all 
// the incident projectiles are stopped in the grains. h(a,T) decreases at higher T.
// I will adopt phi = 0.0 in my calculation... 
double func_h_e(double x_e){
  double intf,zpxe,phi,Ixstar,hat;
  double f1;

  const double x_ep1p5 = pow(x_e,1.5);

  const int nzmax = 2;
  double logzmin = -2.0;
  double logzmax = 2.0;
  double dlogz = (logzmax - logzmin)/float(nzmax);
  double f[nzmax+1];

  static bool first = true;
  static double z[nzmax+1];
  static double expmz[nzmax+1];
  static double dz[nzmax];

  // Create z bins
  if (first){
    for (int n = 0; n <= nzmax; ++n){
      z[n] = pow(10,logzmin+float(n)*dlogz);
      expmz[n] = exp(-z[n]);
    }
    for (int n = 0; n < nzmax; ++n){
      dz[n] = z[n+1] - z[n];
    }
    // first = false;
  }
  
  // Evaluate the function at each z position, and integrate using the
  // trapezium rule
  for (int n = 0; n <= nzmax; ++n){
    zpxe = z[n] + x_e;
    f1 = pow(zpxe,1.5) - x_ep1p5;
    f[n] = zpxe*pow(f1,2.0/3.0)*expmz[n]; //integral in Dwek and Werner Eq A11 (note typo in TT2013)
  }
  intf = 0.0;
  for (int n = 0; n < nzmax; ++n){
    intf += 0.5*(f[n+1] + f[n])*dz[n];
  }
  
  Ixstar = 0.5*exp(-x_e)*intf;  // Eq A11 in Dwek & Werner
  return 1.0 - Ixstar;          // Eq A10 in DW81
  

  phi = 0.15;
  hat = exp(-phi)*(1.0 - Ixstar); // Eq A10 in DW1981

  // CURRENT STATUS - neither of these return the "correct" result - the resulting curve is
  // different to the approximation of Eq A13 in DW1981

  //return 1.0 - intf;  // Eq 7 in TT13
  //return hat;

  return 0.0;
}

      

void quit(){
  exit(EXIT_SUCCESS);
}
