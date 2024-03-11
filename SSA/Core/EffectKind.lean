/- Kinds of effects, either pure or impure -/
inductive EffectKind
| pure -- pure effects.
| impure -- impure, lives in IO.
deriving Repr, DecidableEq

namespace EffectKind

@[reducible]
def toMonad (e : EffectKind) (m : Type → Type) : Type → Type :=
  match e with
  | pure => Id
  | impure => m

section Instances
variable {e : EffectKind} {m : Type → Type}

instance [Functor m] : Functor (e.toMonad m) := by cases e <;> infer_instance
instance [Functor m] [LawfulFunctor m] : LawfulFunctor (e.toMonad m) := by
  cases e <;> infer_instance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Functor m] [LawfulFunctor m] : LawfulFunctor (toMonad .impure m) := inferInstance
instance [Functor m] [LawfulFunctor m] : LawfulFunctor (toMonad .pure m) := inferInstance

instance [SeqLeft m]  : SeqLeft (e.toMonad m)  := by cases e <;> infer_instance
instance [SeqRight m] : SeqRight (e.toMonad m) := by cases e <;> infer_instance
instance [Seq m]      : Seq (e.toMonad m)      := by cases e <;> infer_instance

instance [Applicative m] : Applicative (e.toMonad m) := by cases e <;> infer_instance
instance [Applicative m] [LawfulApplicative m] : LawfulApplicative (e.toMonad m) := by
  cases e <;> infer_instance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Applicative m] [LawfulApplicative m] : LawfulApplicative (toMonad .impure m) := inferInstance
instance [Applicative m] [LawfulApplicative m] : LawfulApplicative (toMonad .pure m) := inferInstance

instance [Bind m] : Bind (e.toMonad m)   := by cases e <;> infer_instance
instance [Monad m] : Monad (e.toMonad m) := by cases e <;> infer_instance
instance [Monad m] [LawfulMonad m] : LawfulMonad (e.toMonad m) := by cases e <;> infer_instance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Monad m] : Monad (toMonad .pure m)   := inferInstance
instance [Monad m] : Monad (toMonad .impure m) := inferInstance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Monad m] [LawfulMonad m] : LawfulMonad (toMonad .impure m) := inferInstance
instance [Monad m] [LawfulMonad m] : LawfulMonad (EffectKind.toMonad .pure m) := inferInstance

end Instances

def «return» [Monad m] (e : EffectKind) (a : α) : e.toMonad m α := return a

@[simp] -- return is normal form.
def return_eq [Monad m] (e : EffectKind) (a : α) : e.return a = (return a : e.toMonad m α) := by rfl

@[simp]
def return_pure_toMonad_eq (a : α) : (return a : pure.toMonad m α) = a := rfl

@[simp]
def return_impure_toMonad_eq [Monad m] (a : α) : (return a : impure.toMonad m α) = (return a : m α) := rfl

inductive le : EffectKind → EffectKind → Prop
  | pure_le (e) : le .pure e
  | le_impure (e) : le e .impure

@[simp]
def decLe (e e' : EffectKind) : Decidable (le e e') :=
  match e with
  | .pure => match e' with
    | .pure => isTrue (by constructor)
    | .impure => isTrue (by constructor)
  | .impure => match e' with
    | .pure => isFalse (by intro; contradiction)
    | .impure => isTrue (by constructor)


instance : LE EffectKind where le := le
instance : DecidableRel (LE.le (α := EffectKind)) := decLe

@[simp]
theorem eq_of_le_pure {e : EffectKind}
    (he : e ≤ pure) : e = pure := by
  cases he; rfl


@[simp] theorem not_impure_le_pure : ¬(impure ≤ pure) := by
  intro; contradiction

@[simp] theorem pure_le (e : EffectKind) : pure ≤ e := le.pure_le e
@[simp] theorem le_impure (e : EffectKind) : e ≤ impure := le.le_impure e

@[simp] theorem le_refl (e : EffectKind) : e ≤ e := by cases e <;> constructor

@[simp]
theorem le_trans {e1 e2 e3 : EffectKind} (h12: e1 ≤ e2) (h23: e2 ≤ e3) : e1 ≤ e3 := by
  cases e1 <;> cases e2 <;> cases e3 <;> simp_all

@[simp]
theorem le_antisym {e1 e2 : EffectKind} (h12: e1 ≤ e2) (h21: e2 ≤ e1) : e1 ≤ e2 := by
  cases e1 <;> cases e2 <;> simp_all

theorem le_of_eq {e1 e2 : EffectKind} (h : e1 = e2) : e1 ≤ e2 := by
  subst h
  cases e1 <;> simp

def union : EffectKind → EffectKind → EffectKind
| .pure, .pure => .pure
| _, _ => .impure

@[simp] def pure_union_pure_eq : union .pure .pure = .pure := rfl
@[simp] def impure_union_eq : union .impure e = .impure := rfl
@[simp] def union_impure_eq : union e .impure = .impure := by cases e <;> rfl


/-- Given (e1 ≤ e2), we can get a morphism from e1.toMonad x → e2.toMonad x.
Said differently, this is a functor from the skeletal category of EffectKind to Lean. -/
def toMonad_hom [Monad m] {e1 e2 : EffectKind} {α : Type}
    (hle : e1 ≤ e2) (v1 : e1.toMonad m α) : e2.toMonad m α :=
  match e1, e2, hle with
    | .pure, .pure, _ | .impure, .impure, _ => v1
    | .pure, .impure, _ => return v1

-- /-- Any value `v : e.toMonad ..` with effect `e` can be transformed to have the `impure` effect -/
-- def promoteToImpure [Monad m] {α : Type} :
--     (e : EffectKind) → e.toMonad m α → impure.toMonad m α
--   | .pure, v => return v
--   | .impure, v => v

@[simp] theorem toMonad_hom_pure_pure [Monad m] (hle : pure ≤ pure) :
    toMonad_hom hle (α := α) (m := m) = id :=
  rfl

@[simp] theorem toMonad_hom_pure_impure [Monad m] (hle : pure ≤ impure) :
    toMonad_hom hle (α := α) (m := m) = Pure.pure :=
  rfl

/-- Forded version of `toMonad_hom_pure_impure` -/
theorem toMonad_hom_eq_pure_cast {m : Type → Type} [Monad m]
    {eff : EffectKind} (eff_eq : eff = .pure) (eff_le : eff ≤ .impure) :
    toMonad_hom eff_le = fun (x : eff.toMonad m α) =>
      Pure.pure (cast (by rw [eff_eq]; rfl) x) := by
  subst eff_eq; rfl

@[simp] theorem toMonad_hom_impure_impure [Monad m] (hle : impure ≤ impure) :
    toMonad_hom hle (α := α) (m := m) = id :=
  rfl

@[simp] theorem toMonad_hom_pure [Monad m] {e} (hle : e ≤ pure) :
    toMonad_hom hle (α := α) (m := m) = cast (by rw [eq_of_le_pure hle]) := by
  cases hle; rfl

@[simp] theorem toMonad_hom_impure [Monad m] {e} (hle : e ≤ impure) :
    toMonad_hom hle (α := α) (m := m) = match e with
      | .pure => fun v => return v
      | .impure => id := by
  cases e <;> rfl

/-- toMonad is functorial: it preserves identity. -/
@[simp]
theorem toMonad_hom_eq_id (hle : eff ≤ eff) [Monad m] :
    toMonad_hom hle (α := α) (m := m) = id  := by
  cases eff <;> rfl

/-- toMonad is functorial: it preserves composition. -/
def toMonad_hom_compose {e1 e2 e3 : EffectKind} {α : Type} [Monad m]
    (h12 : e1 ≤ e2)
    (h23: e2 ≤ e3)
    (h13: e1 ≤ e3 := le_trans h12 h23) :
    ((toMonad_hom (α := α) h23) ∘ (toMonad_hom h12)) = toMonad_hom (m := m) h13 := by
  cases e1 <;> cases e2 <;> cases e3 <;> (solve | rfl | contradiction)

instance (eff : EffectKind) {m} [Monad m] : MonadLiftT (eff.toMonad m) m where
  monadLift x := match eff with
    | .pure   => return x
    | .impure => x
