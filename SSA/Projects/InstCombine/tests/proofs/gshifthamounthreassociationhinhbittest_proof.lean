
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthamounthreassociationhinhbittest_proof
theorem t0_const_lshr_shl_ne_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (shl e_1 (const? 1)) (lshr e (const? 1))) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e (const? 2)) e_1) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_const_shl_lshr_ne_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr e_1 (const? 1)) (shl e (const? 1))) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e_1 (const? 2)) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_const_lshr_shl_eq_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e_1 (const? 1)) (lshr e (const? 1))) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and (lshr e (const? 2)) e_1) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t3_const_after_fold_lshr_shl_ne_thm (e e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr e_2 (sub (const? 32) e_1)) (shl e (add e_1 (const? (-1))))) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e_2 (const? 31)) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t4_const_after_fold_lshr_shl_ne_thm (e e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (shl e_2 (sub (const? 32) e_1)) (lshr e (add e_1 (const? (-1))))) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e (const? 31)) e_2) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


