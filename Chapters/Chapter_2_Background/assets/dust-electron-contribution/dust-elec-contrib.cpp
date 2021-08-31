// Includes
#include <cmath>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

#define EV_TO_ERG    1.602e-12
#define MICRON_TO_CM 1e-4
#define K_B          1.380658e-16
#define MASS_E       9.1093897e-28
#define MASS_H       1.6726e-24
#define PI           3.141592654

#define LOGTMIN 4.0
#define LOGTMAX 9.0
#define NTBINS   101

#define SQR(x) ( (x)*(x) )

using namespace std;

// Functions
float calcNT(float rho_G,vector<float> massfrac);
float calcHel(float a,float T,float el_ion_ratio,float nT);
float calcHColl(float rho_G,float a,float z,vector<float> massfrac) ;
vector<float> readElectronCurve(const char* filename);
double func_h_e(double x_e);

int main(int argc, char **argv) {
  // Check initial system parameters
  float rho_G,a,z;
  if (argc > 2) {
    rho_G = atof(argv[1]);
    a     = atof(argv[2]);
  }
  else {
    cerr << "Programme needs the following arguments:\n";
    cerr << "rho_G a \n";
  }
  cout << "Simulation parameters:\n";
  cout << "rho_G = " << rho_G << " g cm^-3\n";
  cout << "a     = " << a << " micron \n";

  // Read in free electron curves, files are space delimited with 101 bins from 1e4 to 1e9K
  vector<float> electron_WC = readElectronCurve("electron_WC");
  vector<float> electron_OB = readElectronCurve("electron_solar");
  // HHeCNO abundances for each stellar type
  vector<float> massfrac_WC = {0.000,0.546,0.400,0.000,0.050};
  vector<float> massfrac_OB = {0.705,0.275,0.003,0.001,0.009};

  // Write out
  string outfile = "dust_elec_ion_contribution.csv";
  ofstream file(outfile.c_str()); 
  if (!file) {
    cerr << "Failed to open output file: " << outfile;
    exit(1);
  }
  file << scientific << setprecision(4);
  file << "#T,        H_coll_WC, H_el_WC,   H_coll_OB, H_el_OB\n";

  float dlogt = (LOGTMAX - LOGTMIN)/float(NTBINS-1);
  for (int n = 0; n < NTBINS; n++)
  {
    float logT = LOGTMIN + float(n)*dlogt;
    float T    = pow(10.0,logT);
    float n_T_WC = calcNT(rho_G,massfrac_WC);
    float n_T_OB = calcNT(rho_G,massfrac_OB);
    float H_coll_WC = calcHColl(rho_G,a,T,massfrac_WC);
    float H_coll_OB = calcHColl(rho_G,a,T,massfrac_OB);
    float H_el_WC = calcHel(a,T,electron_WC[n],n_T_WC);
    float H_el_OB = calcHel(a,T,electron_OB[n],n_T_OB);
    float nH = rho_G * (10./14.)/MASS_H;
    file << T << "," << H_coll_WC << "," << H_el_WC << "," << H_coll_OB << "," << H_el_OB << "\n";
  }
  file.close();
  return 0;
}

float calcNT(float rho_G,vector<float> massfrac) {
  float n_T = 0.0;
  float m_E[] = {1.6737736e-24,6.6464737e-24,1.9944735e-23,2.3258673e-23,2.6567629e-23};
  float n_E[] = {0.0,0.0,0.0,0.0,0.0};  // Elemental number density, cm^-3
  for (int n = 0; n < 5; n++) {
    n_E[n] = rho_G * massfrac[n] / m_E[n];
    // Calculate total number density
    n_T += n_E[n];
  }
  return n_T;
}

float calcHColl(float rho_G,float a, float T,vector<float> massfrac) {
  float H_coll = 0.0;  // Heating rate for grains, erg s^-1 
  float n_T    = 0.0;  // Total number density, cm^-3
  // - Precalculated arrays for critical energy constant and atomic mass
  //   in CGS units for each type of element are declared:
  //   - For H atoms:   Ec = 133keV, m = 1.00797 AMU
  //   - For He atoms:  Ec = 222keV, m = 4.00260 AMU
  //   - For CNO atoms: Ec = 665keV, m = 12.011,14.0067,15.9994 AMU
  // - This assumes that carbon is dominant in CNO bin
  float E_E[] = {2.1308949e-07,3.5568321e-07,1.0654475e-06,1.0654475e-06,1.0654475e-06};
  float m_E[] = {1.6737736e-24,6.6464737e-24,1.9944735e-23,2.3258673e-23,2.6567629e-23};
  float n_E[] = {0.0,0.0,0.0,0.0,0.0};  // Elemental number density, cm^-3
  float H_E[] = {0.0,0.0,0.0,0.0,0.0};  // Heating for each element, erg s^-1
  // Calculate collisional heating due to ionic species
  for (int n = 0; n < 5; n++) {
    n_E[n] = rho_G * massfrac[n] / m_E[n];
    // Calculate total number density
    n_T += n_E[n];
    // Calculate critical energy
    float EC = E_E[n] * a;
    // Calculate grain heating efficiency due to atoms, h_n
    float h_n = 1.0 - (1.0 + EC / (2.0 * (K_B*T))) * exp(-EC/(K_B*T));
    // Calculate heating rate of element
    H_E[n] = 1.26e-19 * SQR(a) * pow(T,1.5) * n_E[n] * h_n;
    H_E[n] /= sqrt(m_E[n]/MASS_H);
    H_coll += H_E[n]; // Add to total heating rate
  }
  return H_coll;
}

float calcHel(float a,float T,float el_ion_ratio,float nT) {
  float ne = nT * el_ion_ratio;
  // Calculate the critical energy for electron to penetrate grain
  // This makes the assumption of an uncharged dust grain, Ee = Ec
  float Ee  = 3.6850063e-08 * pow(a,2.0/3.0);  // DW81 Eq A6
  float x_e = Ee/(K_B*T);                          // DW81 Eq A11
  // Approximate electron-grain "transparency"
  float h_e = func_h_e(x_e);
  // Calculate heating rate of electrons, using DW81 Eq 2
  float H_el  = 1.26e-19 * SQR(a) * pow(T,1.5) * ne * h_e;
        H_el /= sqrt(MASS_E/MASS_H);
  return H_el;
}

vector<float> readElectronCurve(const char* filename) {
  vector<float> ion_frac;

  ifstream file(filename);
  if (!file) {
    exit(1);
  }
  else {
    float tbuf,ebuf;
    string line;
    file.seekg(0);
    while (true) {
      file >> tbuf >> ebuf;
      if(file.eof()) break;
      ion_frac.push_back(ebuf);
    }
  }
  return ion_frac;
}


double func_h_e(double x_e){
  double intf,zpxe,phi,Ixstar,hat;
  double f1;
  const double x_ep1p5 = pow(x_e,1.5);
  const int nzmax = 1000;
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
    first = false;
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
  return 0.0;
}