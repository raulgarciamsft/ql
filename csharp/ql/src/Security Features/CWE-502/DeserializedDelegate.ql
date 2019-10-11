/**
 * @name Deserialized delegate
 * @description Deserializing a delegate allows an attacker to take arbitrary actions if they
 *              control the deserialized data.
 * @kind problem
 * @id cs/deserialized-delegate
 * @problem.severity warning
 * @tags security
 *       external/cwe/cwe-502
 */

/*
 * consider: @precision medium
 */

import semmle.code.csharp.security.serialization.Deserializers

from Call deserialization, Expr conversion
where
  deserialization.getTarget() instanceof UnsafeDeserializer and
  conversion = deserialization.getParent() and
  (conversion instanceof CastExpr or conversion instanceof AsExpr) and
  conversion.getType().(RefType).getABaseType*().hasName("Delegate")
select deserialization, "Deserialization of delegate type."
