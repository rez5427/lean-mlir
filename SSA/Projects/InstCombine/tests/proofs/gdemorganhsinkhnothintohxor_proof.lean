
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gdemorganhsinkhnothintohxor_proof
theorem positive_easyinvert_thm (e : IntW 16) (e_1 : IntW 8) :
  LLVM.xor (LLVM.xor (icmp IntPredicate.slt e_1 (const? 0)) (icmp IntPredicate.slt e (const? 0))) (const? 1) ⊑
    LLVM.xor (icmp IntPredicate.slt e_1 (const? 0)) (icmp IntPredicate.sgt e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


