// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/class/fail_base_repeated.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/class/fail_base_repeated.carbon

base class B1 {}
base class B2 {}

class C {
  extend base: B1;
  // CHECK:STDERR: fail_base_repeated.carbon:[[@LINE+7]]:3: error: multiple `base` declarations in class; multiple inheritance is not permitted [BaseDeclRepeated]
  // CHECK:STDERR:   extend base: B2;
  // CHECK:STDERR:   ^~~~~~~~~~~~~~~~
  // CHECK:STDERR: fail_base_repeated.carbon:[[@LINE-4]]:3: note: previous `base` declaration is here [ClassSpecificDeclPrevious]
  // CHECK:STDERR:   extend base: B1;
  // CHECK:STDERR:   ^~~~~~~~~~~~~~~~
  // CHECK:STDERR:
  extend base: B2;
}

class D {
  // TODO: Consider adding a custom diagnostic for this case.
  extend base: B1;
  // CHECK:STDERR: fail_base_repeated.carbon:[[@LINE+7]]:3: error: multiple `base` declarations in class; multiple inheritance is not permitted [BaseDeclRepeated]
  // CHECK:STDERR:   extend base: B1;
  // CHECK:STDERR:   ^~~~~~~~~~~~~~~~
  // CHECK:STDERR: fail_base_repeated.carbon:[[@LINE-4]]:3: note: previous `base` declaration is here [ClassSpecificDeclPrevious]
  // CHECK:STDERR:   extend base: B1;
  // CHECK:STDERR:   ^~~~~~~~~~~~~~~~
  // CHECK:STDERR:
  extend base: B1;
}

// CHECK:STDOUT: --- fail_base_repeated.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %B1: type = class_type @B1 [template]
// CHECK:STDOUT:   %empty_struct_type: type = struct_type {} [template]
// CHECK:STDOUT:   %complete_type.357: <witness> = complete_type_witness %empty_struct_type [template]
// CHECK:STDOUT:   %B2: type = class_type @B2 [template]
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %C.elem: type = unbound_element_type %C, %B1 [template]
// CHECK:STDOUT:   %struct_type.base: type = struct_type {.base: %B1} [template]
// CHECK:STDOUT:   %complete_type.5ac: <witness> = complete_type_witness %struct_type.base [template]
// CHECK:STDOUT:   %D: type = class_type @D [template]
// CHECK:STDOUT:   %D.elem: type = unbound_element_type %D, %B1 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/...
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .B1 = %B1.decl
// CHECK:STDOUT:     .B2 = %B2.decl
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:     .D = %D.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %B1.decl: type = class_decl @B1 [template = constants.%B1] {} {}
// CHECK:STDOUT:   %B2.decl: type = class_decl @B2 [template = constants.%B2] {} {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {} {}
// CHECK:STDOUT:   %D.decl: type = class_decl @D [template = constants.%D] {} {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @B1 {
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %empty_struct_type [template = constants.%complete_type.357]
// CHECK:STDOUT:   complete_type_witness = %complete_type
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%B1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @B2 {
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %empty_struct_type [template = constants.%complete_type.357]
// CHECK:STDOUT:   complete_type_witness = %complete_type
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%B2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT:   %B1.ref: type = name_ref B1, file.%B1.decl [template = constants.%B1]
// CHECK:STDOUT:   %.loc15: %C.elem = base_decl %B1.ref, element0 [template]
// CHECK:STDOUT:   %B2.ref: type = name_ref B2, file.%B2.decl [template = constants.%B2]
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %struct_type.base [template = constants.%complete_type.5ac]
// CHECK:STDOUT:   complete_type_witness = %complete_type
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%C
// CHECK:STDOUT:   .base = %.loc15
// CHECK:STDOUT:   extend %B1.ref
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @D {
// CHECK:STDOUT:   %B1.ref.loc28: type = name_ref B1, file.%B1.decl [template = constants.%B1]
// CHECK:STDOUT:   %.loc28: %D.elem = base_decl %B1.ref.loc28, element0 [template]
// CHECK:STDOUT:   %B1.ref.loc36: type = name_ref B1, file.%B1.decl [template = constants.%B1]
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %struct_type.base [template = constants.%complete_type.5ac]
// CHECK:STDOUT:   complete_type_witness = %complete_type
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%D
// CHECK:STDOUT:   .base = %.loc28
// CHECK:STDOUT:   extend %B1.ref.loc28
// CHECK:STDOUT: }
// CHECK:STDOUT:
