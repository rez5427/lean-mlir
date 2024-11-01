
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphandhshift_proof
theorem icmp_eq_and_pow2_shl1_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (shl (const? 1) e) (const? 16)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ne e (const? 4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ne_and_pow2_shl1_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.ne (LLVM.and (shl (const? 1) e) (const? 16)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.eq e (const? 4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and_pow2_shl_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (shl (const? 2) e) (const? 16)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ne e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ne_and_pow2_shl_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.ne (LLVM.and (shl (const? 2) e) (const? 16)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.eq e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and_pow2_shl_pow2_negative1_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (shl (const? 11) e) (const? 16)) (const? 0)) ⊑
    LLVM.xor (LLVM.and (lshr (shl (const? 11) e) (const? 4)) (const? 1)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and_pow2_shl_pow2_negative2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (shl (const? 2) e) (const? 14)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ugt e (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and_pow2_shl_pow2_negative3_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (shl (const? 32) e) (const? 16)) (const? 0)) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and_pow2_minus1_shl1_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (shl (const? 1) e) (const? 15)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ugt e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ne_and_pow2_minus1_shl1_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.ne (LLVM.and (shl (const? 1) e) (const? 15)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ult e (const? 4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and_pow2_minus1_shl_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (shl (const? 2) e) (const? 15)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ugt e (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ne_and_pow2_minus1_shl_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.ne (LLVM.and (shl (const? 2) e) (const? 15)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ult e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and_pow2_minus1_shl1_negative2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (shl (const? 32) e) (const? 15)) (const? 0)) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and1_lshr_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (lshr (const? 8) e) (const? 1)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ne e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ne_and1_lshr_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (lshr (const? 8) e) (const? 1)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ne e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and_pow2_lshr_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (lshr (const? 8) e) (const? 4)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ne e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and_pow2_lshr_pow2_case2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (lshr (const? 4) e) (const? 8)) (const? 0)) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ne_and_pow2_lshr_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (lshr (const? 8) e) (const? 4)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ne e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ne_and_pow2_lshr_pow2_case2_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (lshr (const? 4) e) (const? 8)) (const? 0)) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_and1_lshr_pow2_minus_one_thm (e : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (lshr (const? 7) e) (const? 1)) (const? 0)) ⊑
    zext 32 (icmp IntPredicate.ugt e (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem eq_and_shl_one_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (shl (const? 1) e_1) e) (shl (const? 1) e_1) ⊑
    icmp IntPredicate.ne (LLVM.and (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ne_and_lshr_minval_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (mul e_1 e_1) (lshr (const? (-128)) e)) (lshr (const? (-128)) e) ⊑
    icmp IntPredicate.eq (LLVM.and (mul e_1 e_1) (lshr (const? (-128)) e)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem slt_and_shl_one_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (LLVM.and e_1 (shl (const? 1) e)) (shl (const? 1) e) ⊑
    icmp IntPredicate.slt (LLVM.and e_1 (shl (const? 1) e { «nsw» := false, «nuw» := true }))
      (shl (const? 1) e { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_eq_lhs_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (shl (const? (-1)) e_1) e) (const? 0) ⊑
    icmp IntPredicate.eq (lshr e e_1) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_eq_lhs_fail_eq_nonzero_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (shl (const? (-1)) e_1) e) (const? 1) ⊑
    icmp IntPredicate.eq (LLVM.and (shl (const? (-1)) e_1 { «nsw» := true, «nuw» := false }) e) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_ne_rhs_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor e_1 (const? 123)) (shl (const? (-1)) e)) (const? 0) ⊑
    icmp IntPredicate.ne (lshr (LLVM.xor e_1 (const? 123)) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_ne_rhs_fail_shift_not_1s_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor e_1 (const? 123)) (shl (const? (-2)) e)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (LLVM.xor e_1 (const? 122)) (shl (const? (-2)) e)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shr_and_1_ne_0_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr e_1 e) (const? 1)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shr_and_1_ne_0_samesign_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr e_1 e) (const? 1)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_const_shr_and_1_ne_0_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr (const? 42) e) (const? 1)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_not_const_shr_and_1_ne_0_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 42) e) (const? 1)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_const_shr_exact_and_1_ne_0_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr (const? 42) e) (const? 1)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_const_shr_and_1_ne_0_i1_negative_thm (e : IntW 1) :
  icmp IntPredicate.ne (LLVM.and (lshr (const? 1) e) (const? 1)) (const? 0) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


