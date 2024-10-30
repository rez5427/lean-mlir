
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
section gmaskedhmergehor_statements

def p_before := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg60, %arg62 : i32
  %2 = llvm.xor %arg62, %0 : i32
  %3 = llvm.and %2, %arg61 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_after := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg60, %arg62 : i32
  %2 = llvm.xor %arg62, %0 : i32
  %3 = llvm.and %arg61, %2 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_proof : p_before ⊑ p_after := by
  unfold p_before p_after
  simp_alive_peephole
  ---BEGIN p
  all_goals (try extract_goal ; sorry)
  ---END p



def p_commutative0_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32, %arg34 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg34, %arg32 : i32
  %2 = llvm.xor %arg34, %0 : i32
  %3 = llvm.and %2, %arg33 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative0_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32, %arg34 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg34, %arg32 : i32
  %2 = llvm.xor %arg34, %0 : i32
  %3 = llvm.and %arg33, %2 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative0_proof : p_commutative0_before ⊑ p_commutative0_after := by
  unfold p_commutative0_before p_commutative0_after
  simp_alive_peephole
  ---BEGIN p_commutative0
  all_goals (try extract_goal ; sorry)
  ---END p_commutative0



def p_commutative2_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg27, %arg29 : i32
  %2 = llvm.xor %arg29, %0 : i32
  %3 = llvm.and %2, %arg28 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative2_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg27, %arg29 : i32
  %2 = llvm.xor %arg29, %0 : i32
  %3 = llvm.and %arg28, %2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative2_proof : p_commutative2_before ⊑ p_commutative2_after := by
  unfold p_commutative2_before p_commutative2_after
  simp_alive_peephole
  ---BEGIN p_commutative2
  all_goals (try extract_goal ; sorry)
  ---END p_commutative2



def p_commutative4_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg24, %arg22 : i32
  %2 = llvm.xor %arg24, %0 : i32
  %3 = llvm.and %2, %arg23 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative4_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg24, %arg22 : i32
  %2 = llvm.xor %arg24, %0 : i32
  %3 = llvm.and %arg23, %2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative4_proof : p_commutative4_before ⊑ p_commutative4_after := by
  unfold p_commutative4_before p_commutative4_after
  simp_alive_peephole
  ---BEGIN p_commutative4
  all_goals (try extract_goal ; sorry)
  ---END p_commutative4



def n2_badmask_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg6, %arg4 : i32
  %2 = llvm.xor %arg7, %0 : i32
  %3 = llvm.and %2, %arg5 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n2_badmask_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg6, %arg4 : i32
  %2 = llvm.xor %arg7, %0 : i32
  %3 = llvm.and %arg5, %2 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem n2_badmask_proof : n2_badmask_before ⊑ n2_badmask_after := by
  unfold n2_badmask_before n2_badmask_after
  simp_alive_peephole
  ---BEGIN n2_badmask
  all_goals (try extract_goal ; sorry)
  ---END n2_badmask



def n3_constmask_samemask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(65280 : i32) : i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = llvm.or %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def n3_constmask_samemask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(65280 : i32) : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem n3_constmask_samemask_proof : n3_constmask_samemask_before ⊑ n3_constmask_samemask_after := by
  unfold n3_constmask_samemask_before n3_constmask_samemask_after
  simp_alive_peephole
  ---BEGIN n3_constmask_samemask
  all_goals (try extract_goal ; sorry)
  ---END n3_constmask_samemask


