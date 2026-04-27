; ModuleID = 'tests/test_fixed.c'
source_filename = "tests/test_fixed.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@result = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 16, !dbg !0

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @loop_tiny() local_unnamed_addr #0 !dbg !17 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !23
  br label %2, !dbg !24

1:                                                ; preds = %2
  ret void, !dbg !25

2:                                                ; preds = %0, %2
  %3 = phi i64 [ 0, %0 ], [ %9, %2 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !21, metadata !DIExpression()), !dbg !23
  %4 = mul nuw nsw i64 %3, %3, !dbg !26
  %5 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %3, !dbg !28
  %6 = load i32, ptr %5, align 4, !dbg !29, !tbaa !30
  %7 = trunc i64 %4 to i32, !dbg !29
  %8 = add nsw i32 %6, %7, !dbg !29
  store i32 %8, ptr %5, align 4, !dbg !29, !tbaa !30
  %9 = add nuw nsw i64 %3, 1, !dbg !34
  tail call void @llvm.dbg.value(metadata i64 %9, metadata !21, metadata !DIExpression()), !dbg !23
  %10 = icmp eq i64 %9, 4, !dbg !35
  br i1 %10, label %1, label %2, !dbg !24, !llvm.loop !36
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @loop_small() local_unnamed_addr #0 !dbg !40 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !42, metadata !DIExpression()), !dbg !44
  br label %2, !dbg !45

1:                                                ; preds = %2
  ret void, !dbg !46

2:                                                ; preds = %0, %2
  %3 = phi i64 [ 0, %0 ], [ %8, %2 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !42, metadata !DIExpression()), !dbg !44
  %4 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %3, !dbg !47
  %5 = load i32, ptr %4, align 4, !dbg !49, !tbaa !30
  %6 = trunc i64 %3 to i32, !dbg !49
  %7 = add nsw i32 %5, %6, !dbg !49
  store i32 %7, ptr %4, align 4, !dbg !49, !tbaa !30
  %8 = add nuw nsw i64 %3, 1, !dbg !50
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !42, metadata !DIExpression()), !dbg !44
  %9 = icmp eq i64 %8, 16, !dbg !51
  br i1 %9, label %1, label %2, !dbg !45, !llvm.loop !52
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @loop_large() local_unnamed_addr #0 !dbg !54 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !56, metadata !DIExpression()), !dbg !58
  br label %2, !dbg !59

1:                                                ; preds = %2
  ret void, !dbg !60

2:                                                ; preds = %0, %2
  %3 = phi i64 [ 0, %0 ], [ %8, %2 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !56, metadata !DIExpression()), !dbg !58
  %4 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %3, !dbg !61
  %5 = load i32, ptr %4, align 4, !dbg !63, !tbaa !30
  %6 = trunc i64 %3 to i32, !dbg !63
  %7 = add nsw i32 %5, %6, !dbg !63
  store i32 %7, ptr %4, align 4, !dbg !63, !tbaa !30
  %8 = add nuw nsw i64 %3, 1, !dbg !64
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !56, metadata !DIExpression()), !dbg !58
  %9 = icmp eq i64 %8, 1000, !dbg !65
  br i1 %9, label %1, label %2, !dbg !59, !llvm.loop !66
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @loop_boundary() local_unnamed_addr #0 !dbg !68 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !70, metadata !DIExpression()), !dbg !72
  br label %2, !dbg !73

1:                                                ; preds = %2
  ret void, !dbg !74

2:                                                ; preds = %0, %2
  %3 = phi i64 [ 0, %0 ], [ %8, %2 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !70, metadata !DIExpression()), !dbg !72
  %4 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %3, !dbg !75
  %5 = load i32, ptr %4, align 4, !dbg !77, !tbaa !30
  %6 = trunc i64 %3 to i32, !dbg !77
  %7 = add nsw i32 %5, %6, !dbg !77
  store i32 %7, ptr %4, align 4, !dbg !77, !tbaa !30
  %8 = add nuw nsw i64 %3, 1, !dbg !78
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !70, metadata !DIExpression()), !dbg !72
  %9 = icmp eq i64 %8, 8, !dbg !79
  br i1 %9, label %1, label %2, !dbg !73, !llvm.loop !80
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local i32 @main() local_unnamed_addr #0 !dbg !82 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !85
  br label %1, !dbg !87

1:                                                ; preds = %1, %0
  %2 = phi i64 [ 0, %0 ], [ %8, %1 ]
  tail call void @llvm.dbg.value(metadata i64 %2, metadata !21, metadata !DIExpression()), !dbg !85
  %3 = mul nuw nsw i64 %2, %2, !dbg !88
  %4 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %2, !dbg !89
  %5 = load i32, ptr %4, align 4, !dbg !90, !tbaa !30
  %6 = trunc i64 %3 to i32, !dbg !90
  %7 = add nsw i32 %5, %6, !dbg !90
  store i32 %7, ptr %4, align 4, !dbg !90, !tbaa !30
  %8 = add nuw nsw i64 %2, 1, !dbg !91
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !21, metadata !DIExpression()), !dbg !85
  %9 = icmp eq i64 %8, 4, !dbg !92
  br i1 %9, label %10, label %1, !dbg !87, !llvm.loop !93

10:                                               ; preds = %1, %10
  %11 = phi i64 [ %16, %10 ], [ 0, %1 ]
  tail call void @llvm.dbg.value(metadata i64 %11, metadata !42, metadata !DIExpression()), !dbg !95
  %12 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %11, !dbg !97
  %13 = load i32, ptr %12, align 4, !dbg !98, !tbaa !30
  %14 = trunc i64 %11 to i32, !dbg !98
  %15 = add nsw i32 %13, %14, !dbg !98
  store i32 %15, ptr %12, align 4, !dbg !98, !tbaa !30
  %16 = add nuw nsw i64 %11, 1, !dbg !99
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !42, metadata !DIExpression()), !dbg !95
  %17 = icmp eq i64 %16, 16, !dbg !100
  br i1 %17, label %18, label %10, !dbg !101, !llvm.loop !102

18:                                               ; preds = %10, %18
  %19 = phi i64 [ %24, %18 ], [ 0, %10 ]
  tail call void @llvm.dbg.value(metadata i64 %19, metadata !56, metadata !DIExpression()), !dbg !104
  %20 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %19, !dbg !106
  %21 = load i32, ptr %20, align 4, !dbg !107, !tbaa !30
  %22 = trunc i64 %19 to i32, !dbg !107
  %23 = add nsw i32 %21, %22, !dbg !107
  store i32 %23, ptr %20, align 4, !dbg !107, !tbaa !30
  %24 = add nuw nsw i64 %19, 1, !dbg !108
  tail call void @llvm.dbg.value(metadata i64 %24, metadata !56, metadata !DIExpression()), !dbg !104
  %25 = icmp eq i64 %24, 1000, !dbg !109
  br i1 %25, label %26, label %18, !dbg !110, !llvm.loop !111

26:                                               ; preds = %18, %26
  %27 = phi i64 [ %32, %26 ], [ 0, %18 ]
  tail call void @llvm.dbg.value(metadata i64 %27, metadata !70, metadata !DIExpression()), !dbg !113
  %28 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %27, !dbg !115
  %29 = load i32, ptr %28, align 4, !dbg !116, !tbaa !30
  %30 = trunc i64 %27 to i32, !dbg !116
  %31 = add nsw i32 %29, %30, !dbg !116
  store i32 %31, ptr %28, align 4, !dbg !116, !tbaa !30
  %32 = add nuw nsw i64 %27, 1, !dbg !117
  tail call void @llvm.dbg.value(metadata i64 %32, metadata !70, metadata !DIExpression()), !dbg !113
  %33 = icmp eq i64 %32, 8, !dbg !118
  br i1 %33, label %34, label %26, !dbg !119, !llvm.loop !120

34:                                               ; preds = %26
  %35 = load i32, ptr @result, align 16, !dbg !122, !tbaa !30
  ret i32 %35, !dbg !123
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!9, !10, !11, !12, !13, !14, !15}
!llvm.ident = !{!16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "result", scope: !2, file: !3, line: 14, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/test_fixed.c", directory: "/home/adhithi__iyer/loop-advisor", checksumkind: CSK_MD5, checksum: "0678d37e4a66f26c4b3a148c74017c75")
!4 = !{!0}
!5 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 32768, elements: !7)
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{!8}
!8 = !DISubrange(count: 1024)
!9 = !{i32 7, !"Dwarf Version", i32 5}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{i32 8, !"PIC Level", i32 2}
!13 = !{i32 7, !"PIE Level", i32 2}
!14 = !{i32 7, !"uwtable", i32 2}
!15 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!16 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!17 = distinct !DISubprogram(name: "loop_tiny", scope: !3, file: !3, line: 16, type: !18, scopeLine: 16, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !20)
!18 = !DISubroutineType(types: !19)
!19 = !{null}
!20 = !{!21}
!21 = !DILocalVariable(name: "i", scope: !22, file: !3, line: 18, type: !6)
!22 = distinct !DILexicalBlock(scope: !17, file: !3, line: 18, column: 5)
!23 = !DILocation(line: 0, scope: !22)
!24 = !DILocation(line: 18, column: 5, scope: !22)
!25 = !DILocation(line: 20, column: 1, scope: !17)
!26 = !DILocation(line: 19, column: 24, scope: !27)
!27 = distinct !DILexicalBlock(scope: !22, file: !3, line: 18, column: 5)
!28 = !DILocation(line: 19, column: 9, scope: !27)
!29 = !DILocation(line: 19, column: 19, scope: !27)
!30 = !{!31, !31, i64 0}
!31 = !{!"int", !32, i64 0}
!32 = !{!"omnipotent char", !33, i64 0}
!33 = !{!"Simple C/C++ TBAA"}
!34 = !DILocation(line: 18, column: 29, scope: !27)
!35 = !DILocation(line: 18, column: 23, scope: !27)
!36 = distinct !{!36, !24, !37, !38, !39}
!37 = !DILocation(line: 19, column: 26, scope: !22)
!38 = !{!"llvm.loop.mustprogress"}
!39 = !{!"llvm.loop.unroll.disable"}
!40 = distinct !DISubprogram(name: "loop_small", scope: !3, file: !3, line: 22, type: !18, scopeLine: 22, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !41)
!41 = !{!42}
!42 = !DILocalVariable(name: "i", scope: !43, file: !3, line: 24, type: !6)
!43 = distinct !DILexicalBlock(scope: !40, file: !3, line: 24, column: 5)
!44 = !DILocation(line: 0, scope: !43)
!45 = !DILocation(line: 24, column: 5, scope: !43)
!46 = !DILocation(line: 26, column: 1, scope: !40)
!47 = !DILocation(line: 25, column: 9, scope: !48)
!48 = distinct !DILexicalBlock(scope: !43, file: !3, line: 24, column: 5)
!49 = !DILocation(line: 25, column: 19, scope: !48)
!50 = !DILocation(line: 24, column: 30, scope: !48)
!51 = !DILocation(line: 24, column: 23, scope: !48)
!52 = distinct !{!52, !45, !53, !38, !39}
!53 = !DILocation(line: 25, column: 22, scope: !43)
!54 = distinct !DISubprogram(name: "loop_large", scope: !3, file: !3, line: 28, type: !18, scopeLine: 28, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !55)
!55 = !{!56}
!56 = !DILocalVariable(name: "i", scope: !57, file: !3, line: 30, type: !6)
!57 = distinct !DILexicalBlock(scope: !54, file: !3, line: 30, column: 5)
!58 = !DILocation(line: 0, scope: !57)
!59 = !DILocation(line: 30, column: 5, scope: !57)
!60 = !DILocation(line: 32, column: 1, scope: !54)
!61 = !DILocation(line: 31, column: 9, scope: !62)
!62 = distinct !DILexicalBlock(scope: !57, file: !3, line: 30, column: 5)
!63 = !DILocation(line: 31, column: 19, scope: !62)
!64 = !DILocation(line: 30, column: 32, scope: !62)
!65 = !DILocation(line: 30, column: 23, scope: !62)
!66 = distinct !{!66, !59, !67, !38, !39}
!67 = !DILocation(line: 31, column: 22, scope: !57)
!68 = distinct !DISubprogram(name: "loop_boundary", scope: !3, file: !3, line: 35, type: !18, scopeLine: 35, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !69)
!69 = !{!70}
!70 = !DILocalVariable(name: "i", scope: !71, file: !3, line: 36, type: !6)
!71 = distinct !DILexicalBlock(scope: !68, file: !3, line: 36, column: 5)
!72 = !DILocation(line: 0, scope: !71)
!73 = !DILocation(line: 36, column: 5, scope: !71)
!74 = !DILocation(line: 38, column: 1, scope: !68)
!75 = !DILocation(line: 37, column: 9, scope: !76)
!76 = distinct !DILexicalBlock(scope: !71, file: !3, line: 36, column: 5)
!77 = !DILocation(line: 37, column: 19, scope: !76)
!78 = !DILocation(line: 36, column: 29, scope: !76)
!79 = !DILocation(line: 36, column: 23, scope: !76)
!80 = distinct !{!80, !73, !81, !38, !39}
!81 = !DILocation(line: 37, column: 22, scope: !71)
!82 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 40, type: !83, scopeLine: 40, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2)
!83 = !DISubroutineType(types: !84)
!84 = !{!6}
!85 = !DILocation(line: 0, scope: !22, inlinedAt: !86)
!86 = distinct !DILocation(line: 41, column: 5, scope: !82)
!87 = !DILocation(line: 18, column: 5, scope: !22, inlinedAt: !86)
!88 = !DILocation(line: 19, column: 24, scope: !27, inlinedAt: !86)
!89 = !DILocation(line: 19, column: 9, scope: !27, inlinedAt: !86)
!90 = !DILocation(line: 19, column: 19, scope: !27, inlinedAt: !86)
!91 = !DILocation(line: 18, column: 29, scope: !27, inlinedAt: !86)
!92 = !DILocation(line: 18, column: 23, scope: !27, inlinedAt: !86)
!93 = distinct !{!93, !87, !94, !38, !39}
!94 = !DILocation(line: 19, column: 26, scope: !22, inlinedAt: !86)
!95 = !DILocation(line: 0, scope: !43, inlinedAt: !96)
!96 = distinct !DILocation(line: 42, column: 5, scope: !82)
!97 = !DILocation(line: 25, column: 9, scope: !48, inlinedAt: !96)
!98 = !DILocation(line: 25, column: 19, scope: !48, inlinedAt: !96)
!99 = !DILocation(line: 24, column: 30, scope: !48, inlinedAt: !96)
!100 = !DILocation(line: 24, column: 23, scope: !48, inlinedAt: !96)
!101 = !DILocation(line: 24, column: 5, scope: !43, inlinedAt: !96)
!102 = distinct !{!102, !101, !103, !38, !39}
!103 = !DILocation(line: 25, column: 22, scope: !43, inlinedAt: !96)
!104 = !DILocation(line: 0, scope: !57, inlinedAt: !105)
!105 = distinct !DILocation(line: 43, column: 5, scope: !82)
!106 = !DILocation(line: 31, column: 9, scope: !62, inlinedAt: !105)
!107 = !DILocation(line: 31, column: 19, scope: !62, inlinedAt: !105)
!108 = !DILocation(line: 30, column: 32, scope: !62, inlinedAt: !105)
!109 = !DILocation(line: 30, column: 23, scope: !62, inlinedAt: !105)
!110 = !DILocation(line: 30, column: 5, scope: !57, inlinedAt: !105)
!111 = distinct !{!111, !110, !112, !38, !39}
!112 = !DILocation(line: 31, column: 22, scope: !57, inlinedAt: !105)
!113 = !DILocation(line: 0, scope: !71, inlinedAt: !114)
!114 = distinct !DILocation(line: 44, column: 5, scope: !82)
!115 = !DILocation(line: 37, column: 9, scope: !76, inlinedAt: !114)
!116 = !DILocation(line: 37, column: 19, scope: !76, inlinedAt: !114)
!117 = !DILocation(line: 36, column: 29, scope: !76, inlinedAt: !114)
!118 = !DILocation(line: 36, column: 23, scope: !76, inlinedAt: !114)
!119 = !DILocation(line: 36, column: 5, scope: !71, inlinedAt: !114)
!120 = distinct !{!120, !119, !121, !38, !39}
!121 = !DILocation(line: 37, column: 22, scope: !71, inlinedAt: !114)
!122 = !DILocation(line: 45, column: 12, scope: !82)
!123 = !DILocation(line: 45, column: 5, scope: !82)
