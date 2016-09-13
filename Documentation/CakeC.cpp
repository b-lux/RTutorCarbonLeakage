// To get RcppArmadillo running on Mac OS.X some changes have to be made.
// Check therefore http://thecoatlessprofessor.com/programming/rcpp-rcpparmadillo-and-os-x-mavericks-lgfortran-and-lquadmath-error/


// This script is a subrutine for solving a standard    
// dynamic "cake eating" problem. It implements a       
// dynamic programming algorithm to solve programs (4)  
// and (6) from the Paper. In this case, the "cake" is  
// not distributed over time but across firms.          


#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
// [[Rcpp::plugins(cpp11)]]
using namespace Rcpp;
using namespace arma;

#if !defined(ARMA_64BIT_WORD)
 #define ARMA_64BIT_WORD
//// Uncomment the above line if you require matrices/vectors capable of holding more than 4 billion elements.
//// Your machine and compiler must have support for 64 bit integers (eg. via "long" or "long long")
#endif


// [[Rcpp::export]]
List CakeC(mat x) {
  int p = x.n_rows;
  int N = x.n_cols;
  vec vPrime(p);
  vec vnew(p);
  vec y(p);
  vec v(p);
  vec policy(N);
  vec value(N);
  mat A(p,N);
  mat V(p,p);
  mat Q(p,p);

  vPrime = x.col(N-1);
  A.fill(0);
  A.col(N-1) = linspace(0,p-1,p);
  y.fill(1.0E+20);
  
  
  for(int j = 0; j < N-1; ++j) {
    V = toeplitz(vPrime, y);
    v = x.col(N-2-j);
    Q = trimatl(ones(p,p)*diagmat(v));
    V = V+Q;
    vnew = min(V,1);
    
    for(int i = 0; i < p; ++i){
      uword index;
      V.row(i).min(index) ;
      A(i, N-j-2) = index;
    }
    vPrime = vnew;
  }

  int piecesleft = p-1;
  int vopt = vnew(p-1);
  
  for (int k = 0; k < N; ++k){
    policy(k) = A(piecesleft, k);
    value(k) = x(policy(k), k);
    piecesleft = piecesleft - policy(k);
  }
  
  return List::create(Named("policy") = policy, 
                      Named("value") = value, 
                      Named("vopt") = vopt);
}

