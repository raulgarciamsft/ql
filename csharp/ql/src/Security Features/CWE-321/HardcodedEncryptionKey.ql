/**
 * @name Do not use hard-coded encryption keys.
 * @description The .Key property or rgbKey parameter of a SymmetricAlgorithm should never be a hardcoded value.
 * @kind problem
 * @id cs/do-not-use-hardcoded-keys
 * @problem.severity error
 * @precision high
 * @tags security
 */

import csharp
import semmle.code.csharp.security.cryptography.EncryptionKeyDataFlow::EncryptionKeyDataFlow

/**
 * The creation of a literal byte array.
 */
class ByteArrayLiteralSource extends KeySource {
 ByteArrayLiteralSource() {
    this.asExpr() = any(ArrayCreation ac |
      ac.getArrayType().getElementType() instanceof ByteType and
      ac.hasInitializer())
  }
}

/**
 * Any string literal as a source
 */
class StringLiteralSource extends KeySource {
  StringLiteralSource() {
    this.asExpr() instanceof StringLiteral
  }
}

from SymmetricKeyTaintTrackingConfiguration keyFlow, KeySource src, SymmetricEncryptionKeySink sink
where keyFlow.hasFlow(src, sink)
select sink, "Hard-coded symmetric $@ is used in symmetric algorithm in " + sink.getDescription(), src, "key"
