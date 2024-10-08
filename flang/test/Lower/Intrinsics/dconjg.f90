! RUN: bbc -emit-fir -hlfir=false %s -o - | FileCheck %s

subroutine test_dconjg(r, c)
  complex(8), intent(out) :: r
  complex(8), intent(in) :: c

! CHECK-LABEL: func @_QPtest_dconjg(
! CHECK-SAME: %[[ARG_0:.*]]: !fir.ref<complex<f64>> {fir.bindc_name = "r"},
! CHECK-SAME: %[[ARG_1:.*]]: !fir.ref<complex<f64>> {fir.bindc_name = "c"}) {
! CHECK:   %[[VAL_0:.*]] = fir.load %[[ARG_1]] : !fir.ref<complex<f64>>
! CHECK:   %[[VAL_1:.*]] = fir.extract_value %[[VAL_0]], [1 : index] : (complex<f64>) -> f64
! CHECK:   %[[VAL_2:.*]] = arith.negf %[[VAL_1]] {{.*}}: f64
! CHECK:   %[[VAL_3:.*]] = fir.insert_value %[[VAL_0]], %[[VAL_2]], [1 : index] : (complex<f64>, f64) -> complex<f64>
! CHECK:   fir.store %[[VAL_3]] to %[[ARG_0]] : !fir.ref<complex<f64>>
! CHECK:   return
! CHECK: }

  r = dconjg(c)
end
