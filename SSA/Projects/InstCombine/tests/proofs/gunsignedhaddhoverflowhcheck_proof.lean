
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gunsignedhaddhoverflowhcheck_proof
theorem t0_basic_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (add e_1 e) e ⊑ icmp IntPredicate.ugt e_1 (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_symmetry_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (add e_1 e) e_1 ⊑ icmp IntPredicate.ugt e (LLVM.xor e_1 (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t4_commutative_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ugt e_1 (add e e_1) ⊑ icmp IntPredicate.ugt e (LLVM.xor e_1 (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n10_wrong_pred2_thm (e e_1 : IntW 8) : icmp IntPredicate.eq (add e_1 e) e ⊑ icmp IntPredicate.eq e_1 (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n11_wrong_pred3_thm (e e_1 : IntW 8) : icmp IntPredicate.ne (add e_1 e) e ⊑ icmp IntPredicate.ne e_1 (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


