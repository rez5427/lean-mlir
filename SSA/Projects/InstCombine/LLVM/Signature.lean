import Lean
import Qq
import SSA.Projects.InstCombine.AliveHandwrittenExamples

open AliveAutoGenerated
open Qq Lean Elab Command Meta Elab Term

inductive CliType
| varw -- variable width
| width (n : Nat) -- concrete width given by n

instance : ToString CliType where
 toString
 | .varw => "w"
 | .width (n : Nat) => s!"{n}"

opaque k : Nat
opaque m : Nat
opaque e : Expr


def concrete? (e : Expr) : Option (Nat → ConcreteOrMVar ℕ 0) := do
  guard <| e.isAppOfArity ``ConcreteOrMVar.concrete 3
  -- It should be possible to ensure the array accesses from the guard above
  let args := e.getAppArgs

  -- first argument sholud be Nat
  let mvarsExpr ← args[0]?
  guard (mvarsExpr.isConstOf `Nat)

  -- second argument sholud be 0
  let mvarsExpr ← args[1]?
  guard (mvarsExpr.isNatLit)
  guard (mvarsExpr.natLit! = 0)

  -- third argument is value, either literal or bound variable
  let widthExpr ← args[2]?
  if widthExpr.isBVar then
    some <| fun w => .concrete w
  else if widthExpr.isNatLit then
    some <| fun _ => .concrete (widthExpr.natLit!)
  else
    none

def concrete!  (e : Expr) : Nat → ConcreteOrMVar ℕ 0 := concrete? e |>.get!

def mty? (e : Expr) : Option (Nat → InstCombine.MTy 0) := do
  guard <| e.isAppOfArity ``InstCombine.MTy.bitvec 2
  -- It should be possible to ensure the array accesses from the guard above
  let args := e.getAppArgs

  -- first argument sholud be 0, otherwise it still has metavars
  let mvarsExpr ← args[0]?
  guard (mvarsExpr.isNatLit)
  guard (mvarsExpr.natLit! = 0)

  -- second argument should be a concrete value, extract it
  let widthExpr ← args[1]?
  let width ← concrete? widthExpr
  pure <| fun w => .bitvec <| width w

def mty! (e : Expr) : Nat → InstCombine.MTy 0 := mty? e |>.get!

/-


def concreteOrMVarToCliType (e : Expr) : MetaM CliType := do
  match e with
  | .app (.const ``ConcreteOrMVar.concrete _) kexp => do
    match kexp : Q(Nat) with
      | ~q($k) => pure <| CliType.width k
      | _ => throw <| Exception.error default "Unexpected expression (ill-formed signature): {e}"
    pure <| CliType.width 42
  | _ => throw <| Exception.error default "Unexpected expression (ill-formed signature): {e}"
-/

-- pattern match on an `e` to get a list of lean expressions
def exprToList (e : Expr) : MetaM (List Lean.Expr) := do --sorry
 logInfo m!"exprToList {e}"
 return []


def ExprToCliType (e : Expr) : MetaM CliType := do
 match e with
 | com@(.app x e) =>
    logInfo m!"toCliType App {x} {e}"
    return CliType.varw
  | _ => pure CliType.varw
/-
  match (e : Q(InstCombine.MTy 0)) with
  | ~q(InstCombine.MTy.bitvec (ConcreteOrMVar.concrete $cw)) => sorry
  | ~q(InstCombine.MTy.bitvec (ConcreteOrMVar.concrete $cw)) => sorry
-/

def printSignature (ty0 : Expr) := do
  match ty0 with
  | .forallE x t ty1 ty1i =>
     logInfo m!"x: {x} | t: {t}"
     -- TODO: verify you `t : Nat`
     match ty1 with
     | .forallE x t ty2 ty2i =>
        logInfo m!"forall"
     | com@(.app x e) =>
       -- TODO: verify that 'x' is `Com`
       let args := (Expr.getAppArgs com)
       let llvmArgTys := args[3]!
       let llvmRetTy := args[4]!
       logInfo m!"argTys: {llvmArgTys}"
       let (_,llvmArgs) := llvmArgTys.listLit?.get!
       logInfo m!"argTys: {llvmArgs.map mty! |>.map (fun f : Nat → InstCombine.MTy 0 => f 42)}"
       logInfo m!"retTy.mty!: {mty! llvmRetTy 42}"
       let llvmArgTys : List CliType ← liftM <| (← exprToList llvmArgTys).mapM ExprToCliType
       logInfo m!"argTys (as Cli type): {llvmArgTys}"
       let llvmRetTy ← ExprToCliType llvmRetTy
       logInfo m!"retTy (as Cli type): {llvmRetTy}"
     | _ => pure ()
  | _ => pure ()

elab "foo" : command => liftTermElabM do
  let e : Environment ← getEnv
  let defn :=
    Option.get! <| Environment.find? e ``alive_simplifyDivRemOfSelect_lhs
  let value := defn.value!
  let ty0 ← reduceAll (← inferType defn.value!)
  -- let ty' : Q(Type) := ty
  -- let (ctx, typ) ←
  --   match ty with
  --   | ~q(Com $phi $ctx $typ) => ($ctx, $typ)
  logInfo m!"isLam: {Lean.Expr.isForall ty0} | ty0: {ty0}"
  logInfo m!"isLam: {Lean.Expr.isForall ty0} | ty0: {ty0}"
  -- | forallE (binderName : Name) (binderType : Expr) (body : Expr) (binderInfo : BinderInfo)
  let _ ← printSignature ty0
  return ()

foo

-- Q (α : type witness) =defeq= Expr
