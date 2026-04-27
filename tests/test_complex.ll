; ModuleID = 'tests/test_complex.c'
source_filename = "tests/test_complex.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@dsink = dso_local global double 0.000000e+00, align 8, !dbg !0
@isink = dso_local global i32 0, align 4, !dbg !18
@.str = private unnamed_addr constant [4 x i8] c"%d \00", align 1, !dbg !7
@__const.main.arr = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 0, i32 5], align 16

; Function Attrs: nofree nounwind memory(readwrite, argmem: write) uwtable
define dso_local void @loop_with_call(i32 noundef %0) local_unnamed_addr #0 !dbg !31 {
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !35, metadata !DIExpression()), !dbg !39
  tail call void @llvm.dbg.value(metadata double 0.000000e+00, metadata !36, metadata !DIExpression()), !dbg !39
  tail call void @llvm.dbg.value(metadata i32 0, metadata !37, metadata !DIExpression()), !dbg !40
  %2 = icmp sgt i32 %0, 0, !dbg !41
  br i1 %2, label %5, label %3, !dbg !43

3:                                                ; preds = %5, %1
  %4 = phi double [ 0.000000e+00, %1 ], [ %10, %5 ], !dbg !39
  store volatile double %4, ptr @dsink, align 8, !dbg !44, !tbaa !45
  ret void, !dbg !49

5:                                                ; preds = %1, %5
  %6 = phi i32 [ %11, %5 ], [ 0, %1 ]
  %7 = phi double [ %10, %5 ], [ 0.000000e+00, %1 ]
  tail call void @llvm.dbg.value(metadata i32 %6, metadata !37, metadata !DIExpression()), !dbg !40
  tail call void @llvm.dbg.value(metadata double %7, metadata !36, metadata !DIExpression()), !dbg !39
  %8 = sitofp i32 %6 to double, !dbg !50
  %9 = tail call double @sqrt(double noundef %8) #9, !dbg !51
  %10 = fadd double %7, %9, !dbg !52
  tail call void @llvm.dbg.value(metadata double %10, metadata !36, metadata !DIExpression()), !dbg !39
  %11 = add nuw nsw i32 %6, 1, !dbg !53
  tail call void @llvm.dbg.value(metadata i32 %11, metadata !37, metadata !DIExpression()), !dbg !40
  %12 = icmp eq i32 %11, %0, !dbg !41
  br i1 %12, label %3, label %5, !dbg !43, !llvm.loop !54
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare !dbg !58 double @sqrt(double noundef) local_unnamed_addr #1

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local void @loop_early_exit(ptr nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #2 !dbg !62 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !67, metadata !DIExpression()), !dbg !71
  tail call void @llvm.dbg.value(metadata i32 %1, metadata !68, metadata !DIExpression()), !dbg !71
  tail call void @llvm.dbg.value(metadata i32 0, metadata !69, metadata !DIExpression()), !dbg !72
  %3 = icmp sgt i32 %1, 0, !dbg !73
  br i1 %3, label %4, label %16, !dbg !75

4:                                                ; preds = %2
  %5 = zext nneg i32 %1 to i64, !dbg !73
  br label %6, !dbg !75

6:                                                ; preds = %4, %11
  %7 = phi i64 [ 0, %4 ], [ %14, %11 ]
  tail call void @llvm.dbg.value(metadata i64 %7, metadata !69, metadata !DIExpression()), !dbg !72
  %8 = getelementptr inbounds i32, ptr %0, i64 %7, !dbg !76
  %9 = load i32, ptr %8, align 4, !dbg !76, !tbaa !79
  %10 = icmp eq i32 %9, 0, !dbg !81
  br i1 %10, label %16, label %11, !dbg !82

11:                                               ; preds = %6
  %12 = load volatile i32, ptr @isink, align 4, !dbg !83, !tbaa !79
  %13 = add nsw i32 %12, %9, !dbg !83
  store volatile i32 %13, ptr @isink, align 4, !dbg !83, !tbaa !79
  %14 = add nuw nsw i64 %7, 1, !dbg !84
  tail call void @llvm.dbg.value(metadata i64 %14, metadata !69, metadata !DIExpression()), !dbg !72
  %15 = icmp eq i64 %14, %5, !dbg !73
  br i1 %15, label %16, label %6, !dbg !75, !llvm.loop !85

16:                                               ; preds = %11, %6, %2
  ret void, !dbg !87
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local void @loop_exp_stride() local_unnamed_addr #3 !dbg !88 {
  tail call void @llvm.dbg.value(metadata i32 1, metadata !92, metadata !DIExpression()), !dbg !95
  tail call void @llvm.dbg.value(metadata i32 1, metadata !93, metadata !DIExpression()), !dbg !96
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !93, metadata !DIExpression()), !dbg !96
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !92, metadata !DIExpression()), !dbg !95
  store volatile i32 0, ptr @isink, align 4, !dbg !97, !tbaa !79
  ret void, !dbg !98
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @small_loop_call() local_unnamed_addr #4 !dbg !99 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !101, metadata !DIExpression()), !dbg !103
  br label %3, !dbg !104

1:                                                ; preds = %3
  %2 = tail call i32 @putchar(i32 10), !dbg !105
  ret void, !dbg !106

3:                                                ; preds = %0, %3
  %4 = phi i32 [ 0, %0 ], [ %6, %3 ]
  tail call void @llvm.dbg.value(metadata i32 %4, metadata !101, metadata !DIExpression()), !dbg !103
  %5 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %4), !dbg !107
  %6 = add nuw nsw i32 %4, 1, !dbg !109
  tail call void @llvm.dbg.value(metadata i32 %6, metadata !101, metadata !DIExpression()), !dbg !103
  %7 = icmp eq i32 %6, 4, !dbg !110
  br i1 %7, label %1, label %3, !dbg !104, !llvm.loop !111
}

; Function Attrs: nofree nounwind
declare !dbg !113 noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #4 !dbg !120 {
  call void @llvm.dbg.assign(metadata i1 undef, metadata !124, metadata !DIExpression(), metadata !128, metadata ptr @__const.main.arr, metadata !DIExpression()), !dbg !129
  call void @llvm.dbg.value(metadata i32 100, metadata !35, metadata !DIExpression()), !dbg !130
  call void @llvm.dbg.value(metadata double 0.000000e+00, metadata !36, metadata !DIExpression()), !dbg !130
  call void @llvm.dbg.value(metadata i32 0, metadata !37, metadata !DIExpression()), !dbg !132
  br label %1

1:                                                ; preds = %1, %0
  %2 = phi i32 [ %7, %1 ], [ 0, %0 ]
  %3 = phi double [ %6, %1 ], [ 0.000000e+00, %0 ]
  call void @llvm.dbg.value(metadata i32 %2, metadata !37, metadata !DIExpression()), !dbg !132
  call void @llvm.dbg.value(metadata double %3, metadata !36, metadata !DIExpression()), !dbg !130
  %4 = sitofp i32 %2 to double, !dbg !133
  %5 = tail call double @sqrt(double noundef %4) #9, !dbg !134
  %6 = fadd double %3, %5, !dbg !135
  call void @llvm.dbg.value(metadata double %6, metadata !36, metadata !DIExpression()), !dbg !130
  %7 = add nuw nsw i32 %2, 1, !dbg !136
  call void @llvm.dbg.value(metadata i32 %7, metadata !37, metadata !DIExpression()), !dbg !132
  %8 = icmp eq i32 %7, 100, !dbg !137
  br i1 %8, label %9, label %1, !dbg !138, !llvm.loop !139

9:                                                ; preds = %1
  store volatile double %6, ptr @dsink, align 8, !dbg !141, !tbaa !45
  call void @llvm.dbg.assign(metadata i1 undef, metadata !124, metadata !DIExpression(), metadata !142, metadata ptr @__const.main.arr, metadata !DIExpression()), !dbg !129
  tail call void @llvm.dbg.value(metadata ptr @__const.main.arr, metadata !67, metadata !DIExpression()), !dbg !143
  tail call void @llvm.dbg.value(metadata i32 5, metadata !68, metadata !DIExpression()), !dbg !143
  tail call void @llvm.dbg.value(metadata i32 0, metadata !69, metadata !DIExpression()), !dbg !145
  tail call void @llvm.dbg.value(metadata i64 0, metadata !69, metadata !DIExpression()), !dbg !145
  br label %10, !dbg !146

10:                                               ; preds = %9, %10
  %11 = phi i64 [ 0, %9 ], [ %16, %10 ]
  tail call void @llvm.dbg.value(metadata i64 %11, metadata !69, metadata !DIExpression()), !dbg !145
  %12 = getelementptr inbounds i32, ptr @__const.main.arr, i64 %11, !dbg !147
  %13 = load i32, ptr %12, align 4, !dbg !147, !tbaa !79
  %14 = load volatile i32, ptr @isink, align 4, !dbg !148, !tbaa !79
  %15 = add nsw i32 %14, %13, !dbg !148
  store volatile i32 %15, ptr @isink, align 4, !dbg !148, !tbaa !79
  %16 = add nuw nsw i64 %11, 1, !dbg !149
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !69, metadata !DIExpression()), !dbg !145
  %17 = icmp eq i64 %16, 3, !dbg !150
  br i1 %17, label %18, label %10, !dbg !146

18:                                               ; preds = %10
  tail call void @llvm.dbg.value(metadata i32 1, metadata !92, metadata !DIExpression()), !dbg !151
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !92, metadata !DIExpression()), !dbg !151
  store volatile i32 0, ptr @isink, align 4, !dbg !153, !tbaa !79
  call void @llvm.dbg.value(metadata i32 0, metadata !101, metadata !DIExpression()), !dbg !154
  br label %19, !dbg !156

19:                                               ; preds = %19, %18
  %20 = phi i32 [ 0, %18 ], [ %22, %19 ]
  call void @llvm.dbg.value(metadata i32 %20, metadata !101, metadata !DIExpression()), !dbg !154
  %21 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %20), !dbg !157
  %22 = add nuw nsw i32 %20, 1, !dbg !158
  call void @llvm.dbg.value(metadata i32 %22, metadata !101, metadata !DIExpression()), !dbg !154
  %23 = icmp eq i32 %22, 4, !dbg !159
  br i1 %23, label %24, label %19, !dbg !156, !llvm.loop !160

24:                                               ; preds = %19
  %25 = tail call i32 @putchar(i32 10), !dbg !162
  ret i32 0, !dbg !163
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
!llvm.module.flags = !{!23, !24, !25, !26, !27, !28, !29}
!llvm.ident = !{!30}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "dsink", scope: !2, file: !3, line: 8, type: !22, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !6, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/test_complex.c", directory: "/home/adhithi__iyer/loop-advisor", checksumkind: CSK_MD5, checksum: "d17897b04c623354c961f4c4b00566f8")
!4 = !{!5}
!5 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!6 = !{!7, !13, !0, !18}
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !3, line: 39, type: !9, isLocal: true, isDefinition: true)
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 32, elements: !11)
!10 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!11 = !{!12}
!12 = !DISubrange(count: 4)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(scope: null, file: !3, line: 40, type: !15, isLocal: true, isDefinition: true)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 16, elements: !16)
!16 = !{!17}
!17 = !DISubrange(count: 2)
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(name: "isink", scope: !2, file: !3, line: 9, type: !20, isLocal: false, isDefinition: true)
!20 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !21)
!21 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!22 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !5)
!23 = !{i32 7, !"Dwarf Version", i32 5}
!24 = !{i32 2, !"Debug Info Version", i32 3}
!25 = !{i32 1, !"wchar_size", i32 4}
!26 = !{i32 8, !"PIC Level", i32 2}
!27 = !{i32 7, !"PIE Level", i32 2}
!28 = !{i32 7, !"uwtable", i32 2}
!29 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!30 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!31 = distinct !DISubprogram(name: "loop_with_call", scope: !3, file: !3, line: 12, type: !32, scopeLine: 12, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !34)
!32 = !DISubroutineType(types: !33)
!33 = !{null, !21}
!34 = !{!35, !36, !37}
!35 = !DILocalVariable(name: "n", arg: 1, scope: !31, file: !3, line: 12, type: !21)
!36 = !DILocalVariable(name: "acc", scope: !31, file: !3, line: 13, type: !5)
!37 = !DILocalVariable(name: "i", scope: !38, file: !3, line: 14, type: !21)
!38 = distinct !DILexicalBlock(scope: !31, file: !3, line: 14, column: 5)
!39 = !DILocation(line: 0, scope: !31)
!40 = !DILocation(line: 0, scope: !38)
!41 = !DILocation(line: 14, column: 23, scope: !42)
!42 = distinct !DILexicalBlock(scope: !38, file: !3, line: 14, column: 5)
!43 = !DILocation(line: 14, column: 5, scope: !38)
!44 = !DILocation(line: 16, column: 11, scope: !31)
!45 = !{!46, !46, i64 0}
!46 = !{!"double", !47, i64 0}
!47 = !{!"omnipotent char", !48, i64 0}
!48 = !{!"Simple C/C++ TBAA"}
!49 = !DILocation(line: 17, column: 1, scope: !31)
!50 = !DILocation(line: 15, column: 21, scope: !42)
!51 = !DILocation(line: 15, column: 16, scope: !42)
!52 = !DILocation(line: 15, column: 13, scope: !42)
!53 = !DILocation(line: 14, column: 29, scope: !42)
!54 = distinct !{!54, !43, !55, !56, !57}
!55 = !DILocation(line: 15, column: 30, scope: !38)
!56 = !{!"llvm.loop.mustprogress"}
!57 = !{!"llvm.loop.unroll.disable"}
!58 = !DISubprogram(name: "sqrt", scope: !59, file: !59, line: 143, type: !60, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!59 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/mathcalls.h", directory: "", checksumkind: CSK_MD5, checksum: "12f0a7cb98f2ec572091728ebaf4a161")
!60 = !DISubroutineType(types: !61)
!61 = !{!5, !5}
!62 = distinct !DISubprogram(name: "loop_early_exit", scope: !3, file: !3, line: 20, type: !63, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !66)
!63 = !DISubroutineType(types: !64)
!64 = !{null, !65, !21}
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!66 = !{!67, !68, !69}
!67 = !DILocalVariable(name: "arr", arg: 1, scope: !62, file: !3, line: 20, type: !65)
!68 = !DILocalVariable(name: "n", arg: 2, scope: !62, file: !3, line: 20, type: !21)
!69 = !DILocalVariable(name: "i", scope: !70, file: !3, line: 21, type: !21)
!70 = distinct !DILexicalBlock(scope: !62, file: !3, line: 21, column: 5)
!71 = !DILocation(line: 0, scope: !62)
!72 = !DILocation(line: 0, scope: !70)
!73 = !DILocation(line: 21, column: 23, scope: !74)
!74 = distinct !DILexicalBlock(scope: !70, file: !3, line: 21, column: 5)
!75 = !DILocation(line: 21, column: 5, scope: !70)
!76 = !DILocation(line: 22, column: 13, scope: !77)
!77 = distinct !DILexicalBlock(scope: !78, file: !3, line: 22, column: 13)
!78 = distinct !DILexicalBlock(scope: !74, file: !3, line: 21, column: 33)
!79 = !{!80, !80, i64 0}
!80 = !{!"int", !47, i64 0}
!81 = !DILocation(line: 22, column: 20, scope: !77)
!82 = !DILocation(line: 22, column: 13, scope: !78)
!83 = !DILocation(line: 23, column: 15, scope: !78)
!84 = !DILocation(line: 21, column: 29, scope: !74)
!85 = distinct !{!85, !75, !86, !56, !57}
!86 = !DILocation(line: 24, column: 5, scope: !70)
!87 = !DILocation(line: 25, column: 1, scope: !62)
!88 = distinct !DISubprogram(name: "loop_exp_stride", scope: !3, file: !3, line: 29, type: !89, scopeLine: 29, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !91)
!89 = !DISubroutineType(types: !90)
!90 = !{null}
!91 = !{!92, !93}
!92 = !DILocalVariable(name: "product", scope: !88, file: !3, line: 30, type: !21)
!93 = !DILocalVariable(name: "i", scope: !94, file: !3, line: 31, type: !21)
!94 = distinct !DILexicalBlock(scope: !88, file: !3, line: 31, column: 5)
!95 = !DILocation(line: 0, scope: !88)
!96 = !DILocation(line: 0, scope: !94)
!97 = !DILocation(line: 33, column: 11, scope: !88)
!98 = !DILocation(line: 34, column: 1, scope: !88)
!99 = distinct !DISubprogram(name: "small_loop_call", scope: !3, file: !3, line: 37, type: !89, scopeLine: 37, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !100)
!100 = !{!101}
!101 = !DILocalVariable(name: "i", scope: !102, file: !3, line: 38, type: !21)
!102 = distinct !DILexicalBlock(scope: !99, file: !3, line: 38, column: 5)
!103 = !DILocation(line: 0, scope: !102)
!104 = !DILocation(line: 38, column: 5, scope: !102)
!105 = !DILocation(line: 40, column: 5, scope: !99)
!106 = !DILocation(line: 41, column: 1, scope: !99)
!107 = !DILocation(line: 39, column: 9, scope: !108)
!108 = distinct !DILexicalBlock(scope: !102, file: !3, line: 38, column: 5)
!109 = !DILocation(line: 38, column: 29, scope: !108)
!110 = !DILocation(line: 38, column: 23, scope: !108)
!111 = distinct !{!111, !104, !112, !56, !57}
!112 = !DILocation(line: 39, column: 24, scope: !102)
!113 = !DISubprogram(name: "printf", scope: !114, file: !114, line: 363, type: !115, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!114 = !DIFile(filename: "/usr/include/stdio.h", directory: "", checksumkind: CSK_MD5, checksum: "1e435c46987a169d9f9186f63a512303")
!115 = !DISubroutineType(types: !116)
!116 = !{!21, !117, null}
!117 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !118)
!118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !119, size: 64)
!119 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!120 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 43, type: !121, scopeLine: 43, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !123)
!121 = !DISubroutineType(types: !122)
!122 = !{!21}
!123 = !{!124}
!124 = !DILocalVariable(name: "arr", scope: !120, file: !3, line: 45, type: !125)
!125 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 160, elements: !126)
!126 = !{!127}
!127 = !DISubrange(count: 5)
!128 = distinct !DIAssignID()
!129 = !DILocation(line: 0, scope: !120)
!130 = !DILocation(line: 0, scope: !31, inlinedAt: !131)
!131 = distinct !DILocation(line: 44, column: 5, scope: !120)
!132 = !DILocation(line: 0, scope: !38, inlinedAt: !131)
!133 = !DILocation(line: 15, column: 21, scope: !42, inlinedAt: !131)
!134 = !DILocation(line: 15, column: 16, scope: !42, inlinedAt: !131)
!135 = !DILocation(line: 15, column: 13, scope: !42, inlinedAt: !131)
!136 = !DILocation(line: 14, column: 29, scope: !42, inlinedAt: !131)
!137 = !DILocation(line: 14, column: 23, scope: !42, inlinedAt: !131)
!138 = !DILocation(line: 14, column: 5, scope: !38, inlinedAt: !131)
!139 = distinct !{!139, !138, !140, !56, !57}
!140 = !DILocation(line: 15, column: 30, scope: !38, inlinedAt: !131)
!141 = !DILocation(line: 16, column: 11, scope: !31, inlinedAt: !131)
!142 = distinct !DIAssignID()
!143 = !DILocation(line: 0, scope: !62, inlinedAt: !144)
!144 = distinct !DILocation(line: 46, column: 5, scope: !120)
!145 = !DILocation(line: 0, scope: !70, inlinedAt: !144)
!146 = !DILocation(line: 22, column: 13, scope: !78, inlinedAt: !144)
!147 = !DILocation(line: 22, column: 13, scope: !77, inlinedAt: !144)
!148 = !DILocation(line: 23, column: 15, scope: !78, inlinedAt: !144)
!149 = !DILocation(line: 21, column: 29, scope: !74, inlinedAt: !144)
!150 = !DILocation(line: 22, column: 20, scope: !77, inlinedAt: !144)
!151 = !DILocation(line: 0, scope: !88, inlinedAt: !152)
!152 = distinct !DILocation(line: 47, column: 5, scope: !120)
!153 = !DILocation(line: 33, column: 11, scope: !88, inlinedAt: !152)
!154 = !DILocation(line: 0, scope: !102, inlinedAt: !155)
!155 = distinct !DILocation(line: 48, column: 5, scope: !120)
!156 = !DILocation(line: 38, column: 5, scope: !102, inlinedAt: !155)
!157 = !DILocation(line: 39, column: 9, scope: !108, inlinedAt: !155)
!158 = !DILocation(line: 38, column: 29, scope: !108, inlinedAt: !155)
!159 = !DILocation(line: 38, column: 23, scope: !108, inlinedAt: !155)
!160 = distinct !{!160, !156, !161, !56, !57}
!161 = !DILocation(line: 39, column: 24, scope: !102, inlinedAt: !155)
!162 = !DILocation(line: 40, column: 5, scope: !99, inlinedAt: !155)
!163 = !DILocation(line: 49, column: 5, scope: !120)
