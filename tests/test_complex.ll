; ModuleID = '/home/adhithi__iyer/loop-advisor/tests/test_complex.c'
source_filename = "/home/adhithi__iyer/loop-advisor/tests/test_complex.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@dsink = dso_local global double 0.000000e+00, align 8, !dbg !0
@isink = dso_local global i32 0, align 4, !dbg !19
@.str = private unnamed_addr constant [4 x i8] c"%d \00", align 1, !dbg !7
@__const.main.arr = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 0, i32 5], align 16

; Function Attrs: nofree nounwind memory(readwrite, argmem: write) uwtable
define dso_local void @loop_with_call(i32 noundef %0) local_unnamed_addr #0 !dbg !32 {
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !36, metadata !DIExpression()), !dbg !40
  tail call void @llvm.dbg.value(metadata double 0.000000e+00, metadata !37, metadata !DIExpression()), !dbg !40
  tail call void @llvm.dbg.value(metadata i32 0, metadata !38, metadata !DIExpression()), !dbg !41
  %2 = icmp sgt i32 %0, 0, !dbg !42
  br i1 %2, label %5, label %3, !dbg !44

3:                                                ; preds = %5, %1
  %4 = phi double [ 0.000000e+00, %1 ], [ %10, %5 ], !dbg !40
  store volatile double %4, ptr @dsink, align 8, !dbg !45, !tbaa !46
  ret void, !dbg !50

5:                                                ; preds = %1, %5
  %6 = phi i32 [ %11, %5 ], [ 0, %1 ]
  %7 = phi double [ %10, %5 ], [ 0.000000e+00, %1 ]
  tail call void @llvm.dbg.value(metadata i32 %6, metadata !38, metadata !DIExpression()), !dbg !41
  tail call void @llvm.dbg.value(metadata double %7, metadata !37, metadata !DIExpression()), !dbg !40
  %8 = sitofp i32 %6 to double, !dbg !51
  %9 = tail call double @sqrt(double noundef %8) #9, !dbg !52
  %10 = fadd double %7, %9, !dbg !53
  tail call void @llvm.dbg.value(metadata double %10, metadata !37, metadata !DIExpression()), !dbg !40
  %11 = add nuw nsw i32 %6, 1, !dbg !54
  tail call void @llvm.dbg.value(metadata i32 %11, metadata !38, metadata !DIExpression()), !dbg !41
  %12 = icmp eq i32 %11, %0, !dbg !42
  br i1 %12, label %3, label %5, !dbg !44, !llvm.loop !55
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare !dbg !59 double @sqrt(double noundef) local_unnamed_addr #1

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local void @loop_early_exit(ptr nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #2 !dbg !63 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !68, metadata !DIExpression()), !dbg !72
  tail call void @llvm.dbg.value(metadata i32 %1, metadata !69, metadata !DIExpression()), !dbg !72
  tail call void @llvm.dbg.value(metadata i32 0, metadata !70, metadata !DIExpression()), !dbg !73
  %3 = icmp sgt i32 %1, 0, !dbg !74
  br i1 %3, label %4, label %16, !dbg !76

4:                                                ; preds = %2
  %5 = zext nneg i32 %1 to i64, !dbg !74
  br label %6, !dbg !76

6:                                                ; preds = %4, %11
  %7 = phi i64 [ 0, %4 ], [ %14, %11 ]
  tail call void @llvm.dbg.value(metadata i64 %7, metadata !70, metadata !DIExpression()), !dbg !73
  %8 = getelementptr inbounds i32, ptr %0, i64 %7, !dbg !77
  %9 = load i32, ptr %8, align 4, !dbg !77, !tbaa !80
  %10 = icmp eq i32 %9, 0, !dbg !82
  br i1 %10, label %16, label %11, !dbg !83

11:                                               ; preds = %6
  %12 = load volatile i32, ptr @isink, align 4, !dbg !84, !tbaa !80
  %13 = add nsw i32 %12, %9, !dbg !84
  store volatile i32 %13, ptr @isink, align 4, !dbg !84, !tbaa !80
  %14 = add nuw nsw i64 %7, 1, !dbg !85
  tail call void @llvm.dbg.value(metadata i64 %14, metadata !70, metadata !DIExpression()), !dbg !73
  %15 = icmp eq i64 %14, %5, !dbg !74
  br i1 %15, label %16, label %6, !dbg !76, !llvm.loop !86

16:                                               ; preds = %11, %6, %2
  ret void, !dbg !88
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local void @loop_exp_stride() local_unnamed_addr #3 !dbg !89 {
  tail call void @llvm.dbg.value(metadata i32 1, metadata !93, metadata !DIExpression()), !dbg !96
  tail call void @llvm.dbg.value(metadata i32 1, metadata !94, metadata !DIExpression()), !dbg !97
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !94, metadata !DIExpression()), !dbg !97
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !93, metadata !DIExpression()), !dbg !96
  store volatile i32 0, ptr @isink, align 4, !dbg !98, !tbaa !80
  ret void, !dbg !99
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @small_loop_call() local_unnamed_addr #4 !dbg !100 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !102, metadata !DIExpression()), !dbg !104
  br label %3, !dbg !105

1:                                                ; preds = %3
  %2 = tail call i32 @putchar(i32 10), !dbg !106
  ret void, !dbg !107

3:                                                ; preds = %0, %3
  %4 = phi i32 [ 0, %0 ], [ %6, %3 ]
  tail call void @llvm.dbg.value(metadata i32 %4, metadata !102, metadata !DIExpression()), !dbg !104
  %5 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %4), !dbg !108
  %6 = add nuw nsw i32 %4, 1, !dbg !110
  tail call void @llvm.dbg.value(metadata i32 %6, metadata !102, metadata !DIExpression()), !dbg !104
  %7 = icmp eq i32 %6, 4, !dbg !111
  br i1 %7, label %1, label %3, !dbg !105, !llvm.loop !112
}

; Function Attrs: nofree nounwind
declare !dbg !114 noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #4 !dbg !121 {
  call void @llvm.dbg.assign(metadata i1 undef, metadata !125, metadata !DIExpression(), metadata !129, metadata ptr @__const.main.arr, metadata !DIExpression()), !dbg !130
  call void @llvm.dbg.value(metadata i32 100, metadata !36, metadata !DIExpression()), !dbg !131
  call void @llvm.dbg.value(metadata double 0.000000e+00, metadata !37, metadata !DIExpression()), !dbg !131
  call void @llvm.dbg.value(metadata i32 0, metadata !38, metadata !DIExpression()), !dbg !133
  br label %1

1:                                                ; preds = %1, %0
  %2 = phi i32 [ %7, %1 ], [ 0, %0 ]
  %3 = phi double [ %6, %1 ], [ 0.000000e+00, %0 ]
  call void @llvm.dbg.value(metadata i32 %2, metadata !38, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata double %3, metadata !37, metadata !DIExpression()), !dbg !131
  %4 = sitofp i32 %2 to double, !dbg !134
  %5 = tail call double @sqrt(double noundef %4) #9, !dbg !135
  %6 = fadd double %3, %5, !dbg !136
  call void @llvm.dbg.value(metadata double %6, metadata !37, metadata !DIExpression()), !dbg !131
  %7 = add nuw nsw i32 %2, 1, !dbg !137
  call void @llvm.dbg.value(metadata i32 %7, metadata !38, metadata !DIExpression()), !dbg !133
  %8 = icmp eq i32 %7, 100, !dbg !138
  br i1 %8, label %9, label %1, !dbg !139, !llvm.loop !140

9:                                                ; preds = %1
  store volatile double %6, ptr @dsink, align 8, !dbg !142, !tbaa !46
  call void @llvm.dbg.assign(metadata i1 undef, metadata !125, metadata !DIExpression(), metadata !143, metadata ptr @__const.main.arr, metadata !DIExpression()), !dbg !130
  tail call void @llvm.dbg.value(metadata ptr @__const.main.arr, metadata !68, metadata !DIExpression()), !dbg !144
  tail call void @llvm.dbg.value(metadata i32 5, metadata !69, metadata !DIExpression()), !dbg !144
  tail call void @llvm.dbg.value(metadata i32 0, metadata !70, metadata !DIExpression()), !dbg !146
  tail call void @llvm.dbg.value(metadata i64 0, metadata !70, metadata !DIExpression()), !dbg !146
  br label %10, !dbg !147

10:                                               ; preds = %9, %10
  %11 = phi i64 [ 0, %9 ], [ %16, %10 ]
  tail call void @llvm.dbg.value(metadata i64 %11, metadata !70, metadata !DIExpression()), !dbg !146
  %12 = getelementptr inbounds i32, ptr @__const.main.arr, i64 %11, !dbg !148
  %13 = load i32, ptr %12, align 4, !dbg !148, !tbaa !80
  %14 = load volatile i32, ptr @isink, align 4, !dbg !149, !tbaa !80
  %15 = add nsw i32 %14, %13, !dbg !149
  store volatile i32 %15, ptr @isink, align 4, !dbg !149, !tbaa !80
  %16 = add nuw nsw i64 %11, 1, !dbg !150
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !70, metadata !DIExpression()), !dbg !146
  %17 = icmp eq i64 %16, 3, !dbg !151
  br i1 %17, label %18, label %10, !dbg !147

18:                                               ; preds = %10
  tail call void @llvm.dbg.value(metadata i32 1, metadata !93, metadata !DIExpression()), !dbg !152
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !93, metadata !DIExpression()), !dbg !152
  store volatile i32 0, ptr @isink, align 4, !dbg !154, !tbaa !80
  call void @llvm.dbg.value(metadata i32 0, metadata !102, metadata !DIExpression()), !dbg !155
  br label %19, !dbg !157

19:                                               ; preds = %19, %18
  %20 = phi i32 [ 0, %18 ], [ %22, %19 ]
  call void @llvm.dbg.value(metadata i32 %20, metadata !102, metadata !DIExpression()), !dbg !155
  %21 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %20), !dbg !158
  %22 = add nuw nsw i32 %20, 1, !dbg !159
  call void @llvm.dbg.value(metadata i32 %22, metadata !102, metadata !DIExpression()), !dbg !155
  %23 = icmp eq i32 %22, 4, !dbg !160
  br i1 %23, label %24, label %19, !dbg !157, !llvm.loop !161

24:                                               ; preds = %19
  %25 = tail call i32 @putchar(i32 10), !dbg !163
  ret i32 0, !dbg !164
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.assign(metadata, metadata, metadata, metadata, metadata, metadata) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #7

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #8

attributes #0 = { nofree nounwind memory(readwrite, argmem: write) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn memory(write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree norecurse nounwind memory(readwrite, argmem: read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree norecurse nounwind memory(readwrite, argmem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nofree nounwind }
attributes #9 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!24, !25, !26, !27, !28, !29, !30}
!llvm.ident = !{!31}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "dsink", scope: !2, file: !9, line: 8, type: !23, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !6, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/adhithi__iyer/loop-advisor/tests/test_complex.c", directory: "/home/adhithi__iyer/loop-advisor", checksumkind: CSK_MD5, checksum: "d17897b04c623354c961f4c4b00566f8")
!4 = !{!5}
!5 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!6 = !{!7, !14, !0, !19}
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !9, line: 39, type: !10, isLocal: true, isDefinition: true)
!9 = !DIFile(filename: "tests/test_complex.c", directory: "/home/adhithi__iyer/loop-advisor", checksumkind: CSK_MD5, checksum: "d17897b04c623354c961f4c4b00566f8")
!10 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 32, elements: !12)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !{!13}
!13 = !DISubrange(count: 4)
!14 = !DIGlobalVariableExpression(var: !15, expr: !DIExpression())
!15 = distinct !DIGlobalVariable(scope: null, file: !9, line: 40, type: !16, isLocal: true, isDefinition: true)
!16 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 16, elements: !17)
!17 = !{!18}
!18 = !DISubrange(count: 2)
!19 = !DIGlobalVariableExpression(var: !20, expr: !DIExpression())
!20 = distinct !DIGlobalVariable(name: "isink", scope: !2, file: !9, line: 9, type: !21, isLocal: false, isDefinition: true)
!21 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !22)
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !5)
!24 = !{i32 7, !"Dwarf Version", i32 5}
!25 = !{i32 2, !"Debug Info Version", i32 3}
!26 = !{i32 1, !"wchar_size", i32 4}
!27 = !{i32 8, !"PIC Level", i32 2}
!28 = !{i32 7, !"PIE Level", i32 2}
!29 = !{i32 7, !"uwtable", i32 2}
!30 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!31 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!32 = distinct !DISubprogram(name: "loop_with_call", scope: !9, file: !9, line: 12, type: !33, scopeLine: 12, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !35)
!33 = !DISubroutineType(types: !34)
!34 = !{null, !22}
!35 = !{!36, !37, !38}
!36 = !DILocalVariable(name: "n", arg: 1, scope: !32, file: !9, line: 12, type: !22)
!37 = !DILocalVariable(name: "acc", scope: !32, file: !9, line: 13, type: !5)
!38 = !DILocalVariable(name: "i", scope: !39, file: !9, line: 14, type: !22)
!39 = distinct !DILexicalBlock(scope: !32, file: !9, line: 14, column: 5)
!40 = !DILocation(line: 0, scope: !32)
!41 = !DILocation(line: 0, scope: !39)
!42 = !DILocation(line: 14, column: 23, scope: !43)
!43 = distinct !DILexicalBlock(scope: !39, file: !9, line: 14, column: 5)
!44 = !DILocation(line: 14, column: 5, scope: !39)
!45 = !DILocation(line: 16, column: 11, scope: !32)
!46 = !{!47, !47, i64 0}
!47 = !{!"double", !48, i64 0}
!48 = !{!"omnipotent char", !49, i64 0}
!49 = !{!"Simple C/C++ TBAA"}
!50 = !DILocation(line: 17, column: 1, scope: !32)
!51 = !DILocation(line: 15, column: 21, scope: !43)
!52 = !DILocation(line: 15, column: 16, scope: !43)
!53 = !DILocation(line: 15, column: 13, scope: !43)
!54 = !DILocation(line: 14, column: 29, scope: !43)
!55 = distinct !{!55, !44, !56, !57, !58}
!56 = !DILocation(line: 15, column: 30, scope: !39)
!57 = !{!"llvm.loop.mustprogress"}
!58 = !{!"llvm.loop.unroll.disable"}
!59 = !DISubprogram(name: "sqrt", scope: !60, file: !60, line: 143, type: !61, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!60 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/mathcalls.h", directory: "", checksumkind: CSK_MD5, checksum: "12f0a7cb98f2ec572091728ebaf4a161")
!61 = !DISubroutineType(types: !62)
!62 = !{!5, !5}
!63 = distinct !DISubprogram(name: "loop_early_exit", scope: !9, file: !9, line: 20, type: !64, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !67)
!64 = !DISubroutineType(types: !65)
!65 = !{null, !66, !22}
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!67 = !{!68, !69, !70}
!68 = !DILocalVariable(name: "arr", arg: 1, scope: !63, file: !9, line: 20, type: !66)
!69 = !DILocalVariable(name: "n", arg: 2, scope: !63, file: !9, line: 20, type: !22)
!70 = !DILocalVariable(name: "i", scope: !71, file: !9, line: 21, type: !22)
!71 = distinct !DILexicalBlock(scope: !63, file: !9, line: 21, column: 5)
!72 = !DILocation(line: 0, scope: !63)
!73 = !DILocation(line: 0, scope: !71)
!74 = !DILocation(line: 21, column: 23, scope: !75)
!75 = distinct !DILexicalBlock(scope: !71, file: !9, line: 21, column: 5)
!76 = !DILocation(line: 21, column: 5, scope: !71)
!77 = !DILocation(line: 22, column: 13, scope: !78)
!78 = distinct !DILexicalBlock(scope: !79, file: !9, line: 22, column: 13)
!79 = distinct !DILexicalBlock(scope: !75, file: !9, line: 21, column: 33)
!80 = !{!81, !81, i64 0}
!81 = !{!"int", !48, i64 0}
!82 = !DILocation(line: 22, column: 20, scope: !78)
!83 = !DILocation(line: 22, column: 13, scope: !79)
!84 = !DILocation(line: 23, column: 15, scope: !79)
!85 = !DILocation(line: 21, column: 29, scope: !75)
!86 = distinct !{!86, !76, !87, !57, !58}
!87 = !DILocation(line: 24, column: 5, scope: !71)
!88 = !DILocation(line: 25, column: 1, scope: !63)
!89 = distinct !DISubprogram(name: "loop_exp_stride", scope: !9, file: !9, line: 29, type: !90, scopeLine: 29, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !92)
!90 = !DISubroutineType(types: !91)
!91 = !{null}
!92 = !{!93, !94}
!93 = !DILocalVariable(name: "product", scope: !89, file: !9, line: 30, type: !22)
!94 = !DILocalVariable(name: "i", scope: !95, file: !9, line: 31, type: !22)
!95 = distinct !DILexicalBlock(scope: !89, file: !9, line: 31, column: 5)
!96 = !DILocation(line: 0, scope: !89)
!97 = !DILocation(line: 0, scope: !95)
!98 = !DILocation(line: 33, column: 11, scope: !89)
!99 = !DILocation(line: 34, column: 1, scope: !89)
!100 = distinct !DISubprogram(name: "small_loop_call", scope: !9, file: !9, line: 37, type: !90, scopeLine: 37, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !101)
!101 = !{!102}
!102 = !DILocalVariable(name: "i", scope: !103, file: !9, line: 38, type: !22)
!103 = distinct !DILexicalBlock(scope: !100, file: !9, line: 38, column: 5)
!104 = !DILocation(line: 0, scope: !103)
!105 = !DILocation(line: 38, column: 5, scope: !103)
!106 = !DILocation(line: 40, column: 5, scope: !100)
!107 = !DILocation(line: 41, column: 1, scope: !100)
!108 = !DILocation(line: 39, column: 9, scope: !109)
!109 = distinct !DILexicalBlock(scope: !103, file: !9, line: 38, column: 5)
!110 = !DILocation(line: 38, column: 29, scope: !109)
!111 = !DILocation(line: 38, column: 23, scope: !109)
!112 = distinct !{!112, !105, !113, !57, !58}
!113 = !DILocation(line: 39, column: 24, scope: !103)
!114 = !DISubprogram(name: "printf", scope: !115, file: !115, line: 363, type: !116, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!115 = !DIFile(filename: "/usr/include/stdio.h", directory: "", checksumkind: CSK_MD5, checksum: "1e435c46987a169d9f9186f63a512303")
!116 = !DISubroutineType(types: !117)
!117 = !{!22, !118, null}
!118 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !119)
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !11)
!121 = distinct !DISubprogram(name: "main", scope: !9, file: !9, line: 43, type: !122, scopeLine: 43, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !124)
!122 = !DISubroutineType(types: !123)
!123 = !{!22}
!124 = !{!125}
!125 = !DILocalVariable(name: "arr", scope: !121, file: !9, line: 45, type: !126)
!126 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 160, elements: !127)
!127 = !{!128}
!128 = !DISubrange(count: 5)
!129 = distinct !DIAssignID()
!130 = !DILocation(line: 0, scope: !121)
!131 = !DILocation(line: 0, scope: !32, inlinedAt: !132)
!132 = distinct !DILocation(line: 44, column: 5, scope: !121)
!133 = !DILocation(line: 0, scope: !39, inlinedAt: !132)
!134 = !DILocation(line: 15, column: 21, scope: !43, inlinedAt: !132)
!135 = !DILocation(line: 15, column: 16, scope: !43, inlinedAt: !132)
!136 = !DILocation(line: 15, column: 13, scope: !43, inlinedAt: !132)
!137 = !DILocation(line: 14, column: 29, scope: !43, inlinedAt: !132)
!138 = !DILocation(line: 14, column: 23, scope: !43, inlinedAt: !132)
!139 = !DILocation(line: 14, column: 5, scope: !39, inlinedAt: !132)
!140 = distinct !{!140, !139, !141, !57, !58}
!141 = !DILocation(line: 15, column: 30, scope: !39, inlinedAt: !132)
!142 = !DILocation(line: 16, column: 11, scope: !32, inlinedAt: !132)
!143 = distinct !DIAssignID()
!144 = !DILocation(line: 0, scope: !63, inlinedAt: !145)
!145 = distinct !DILocation(line: 46, column: 5, scope: !121)
!146 = !DILocation(line: 0, scope: !71, inlinedAt: !145)
!147 = !DILocation(line: 22, column: 13, scope: !79, inlinedAt: !145)
!148 = !DILocation(line: 22, column: 13, scope: !78, inlinedAt: !145)
!149 = !DILocation(line: 23, column: 15, scope: !79, inlinedAt: !145)
!150 = !DILocation(line: 21, column: 29, scope: !75, inlinedAt: !145)
!151 = !DILocation(line: 22, column: 20, scope: !78, inlinedAt: !145)
!152 = !DILocation(line: 0, scope: !89, inlinedAt: !153)
!153 = distinct !DILocation(line: 47, column: 5, scope: !121)
!154 = !DILocation(line: 33, column: 11, scope: !89, inlinedAt: !153)
!155 = !DILocation(line: 0, scope: !103, inlinedAt: !156)
!156 = distinct !DILocation(line: 48, column: 5, scope: !121)
!157 = !DILocation(line: 38, column: 5, scope: !103, inlinedAt: !156)
!158 = !DILocation(line: 39, column: 9, scope: !109, inlinedAt: !156)
!159 = !DILocation(line: 38, column: 29, scope: !109, inlinedAt: !156)
!160 = !DILocation(line: 38, column: 23, scope: !109, inlinedAt: !156)
!161 = distinct !{!161, !157, !162, !57, !58}
!162 = !DILocation(line: 39, column: 24, scope: !103, inlinedAt: !156)
!163 = !DILocation(line: 40, column: 5, scope: !100, inlinedAt: !156)
!164 = !DILocation(line: 49, column: 5, scope: !121)
