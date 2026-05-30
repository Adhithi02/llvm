; ModuleID = '/home/akshatha/cdlab/llvm/tests/test_fixed.c'
source_filename = "/home/akshatha/cdlab/llvm/tests/test_fixed.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@result = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 16, !dbg !0

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @loop_tiny() local_unnamed_addr #0 !dbg !18 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !22, metadata !DIExpression()), !dbg !24
  br label %2, !dbg !25

1:                                                ; preds = %2
  ret void, !dbg !26

2:                                                ; preds = %0, %2
  %3 = phi i64 [ 0, %0 ], [ %9, %2 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !22, metadata !DIExpression()), !dbg !24
  %4 = mul nuw nsw i64 %3, %3, !dbg !27
  %5 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %3, !dbg !29
  %6 = load i32, ptr %5, align 4, !dbg !30, !tbaa !31
  %7 = trunc i64 %4 to i32, !dbg !30
  %8 = add nsw i32 %6, %7, !dbg !30
  store i32 %8, ptr %5, align 4, !dbg !30, !tbaa !31
  %9 = add nuw nsw i64 %3, 1, !dbg !35
  tail call void @llvm.dbg.value(metadata i64 %9, metadata !22, metadata !DIExpression()), !dbg !24
  %10 = icmp eq i64 %9, 4, !dbg !36
  br i1 %10, label %1, label %2, !dbg !25, !llvm.loop !37
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @loop_small() local_unnamed_addr #0 !dbg !41 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !43, metadata !DIExpression()), !dbg !45
  br label %2, !dbg !46

1:                                                ; preds = %2
  ret void, !dbg !47

2:                                                ; preds = %0, %2
  %3 = phi i64 [ 0, %0 ], [ %8, %2 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !43, metadata !DIExpression()), !dbg !45
  %4 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %3, !dbg !48
  %5 = load i32, ptr %4, align 4, !dbg !50, !tbaa !31
  %6 = trunc i64 %3 to i32, !dbg !50
  %7 = add nsw i32 %5, %6, !dbg !50
  store i32 %7, ptr %4, align 4, !dbg !50, !tbaa !31
  %8 = add nuw nsw i64 %3, 1, !dbg !51
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !43, metadata !DIExpression()), !dbg !45
  %9 = icmp eq i64 %8, 16, !dbg !52
  br i1 %9, label %1, label %2, !dbg !46, !llvm.loop !53
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @loop_large() local_unnamed_addr #0 !dbg !55 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !57, metadata !DIExpression()), !dbg !59
  br label %2, !dbg !60

1:                                                ; preds = %2
  ret void, !dbg !61

2:                                                ; preds = %0, %2
  %3 = phi i64 [ 0, %0 ], [ %8, %2 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !57, metadata !DIExpression()), !dbg !59
  %4 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %3, !dbg !62
  %5 = load i32, ptr %4, align 4, !dbg !64, !tbaa !31
  %6 = trunc i64 %3 to i32, !dbg !64
  %7 = add nsw i32 %5, %6, !dbg !64
  store i32 %7, ptr %4, align 4, !dbg !64, !tbaa !31
  %8 = add nuw nsw i64 %3, 1, !dbg !65
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !57, metadata !DIExpression()), !dbg !59
  %9 = icmp eq i64 %8, 1000, !dbg !66
  br i1 %9, label %1, label %2, !dbg !60, !llvm.loop !67
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @loop_boundary() local_unnamed_addr #0 !dbg !69 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !71, metadata !DIExpression()), !dbg !73
  br label %2, !dbg !74

1:                                                ; preds = %2
  ret void, !dbg !75

2:                                                ; preds = %0, %2
  %3 = phi i64 [ 0, %0 ], [ %8, %2 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !71, metadata !DIExpression()), !dbg !73
  %4 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %3, !dbg !76
  %5 = load i32, ptr %4, align 4, !dbg !78, !tbaa !31
  %6 = trunc i64 %3 to i32, !dbg !78
  %7 = add nsw i32 %5, %6, !dbg !78
  store i32 %7, ptr %4, align 4, !dbg !78, !tbaa !31
  %8 = add nuw nsw i64 %3, 1, !dbg !79
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !71, metadata !DIExpression()), !dbg !73
  %9 = icmp eq i64 %8, 8, !dbg !80
  br i1 %9, label %1, label %2, !dbg !74, !llvm.loop !81
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local i32 @main() local_unnamed_addr #0 !dbg !83 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !22, metadata !DIExpression()), !dbg !86
  br label %1, !dbg !88

1:                                                ; preds = %1, %0
  %2 = phi i64 [ 0, %0 ], [ %8, %1 ]
  tail call void @llvm.dbg.value(metadata i64 %2, metadata !22, metadata !DIExpression()), !dbg !86
  %3 = mul nuw nsw i64 %2, %2, !dbg !89
  %4 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %2, !dbg !90
  %5 = load i32, ptr %4, align 4, !dbg !91, !tbaa !31
  %6 = trunc i64 %3 to i32, !dbg !91
  %7 = add nsw i32 %5, %6, !dbg !91
  store i32 %7, ptr %4, align 4, !dbg !91, !tbaa !31
  %8 = add nuw nsw i64 %2, 1, !dbg !92
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !22, metadata !DIExpression()), !dbg !86
  %9 = icmp eq i64 %8, 4, !dbg !93
  br i1 %9, label %10, label %1, !dbg !88, !llvm.loop !94

10:                                               ; preds = %1, %10
  %11 = phi i64 [ %16, %10 ], [ 0, %1 ]
  tail call void @llvm.dbg.value(metadata i64 %11, metadata !43, metadata !DIExpression()), !dbg !96
  %12 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %11, !dbg !98
  %13 = load i32, ptr %12, align 4, !dbg !99, !tbaa !31
  %14 = trunc i64 %11 to i32, !dbg !99
  %15 = add nsw i32 %13, %14, !dbg !99
  store i32 %15, ptr %12, align 4, !dbg !99, !tbaa !31
  %16 = add nuw nsw i64 %11, 1, !dbg !100
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !43, metadata !DIExpression()), !dbg !96
  %17 = icmp eq i64 %16, 16, !dbg !101
  br i1 %17, label %18, label %10, !dbg !102, !llvm.loop !103

18:                                               ; preds = %10, %18
  %19 = phi i64 [ %24, %18 ], [ 0, %10 ]
  tail call void @llvm.dbg.value(metadata i64 %19, metadata !57, metadata !DIExpression()), !dbg !105
  %20 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %19, !dbg !107
  %21 = load i32, ptr %20, align 4, !dbg !108, !tbaa !31
  %22 = trunc i64 %19 to i32, !dbg !108
  %23 = add nsw i32 %21, %22, !dbg !108
  store i32 %23, ptr %20, align 4, !dbg !108, !tbaa !31
  %24 = add nuw nsw i64 %19, 1, !dbg !109
  tail call void @llvm.dbg.value(metadata i64 %24, metadata !57, metadata !DIExpression()), !dbg !105
  %25 = icmp eq i64 %24, 1000, !dbg !110
  br i1 %25, label %26, label %18, !dbg !111, !llvm.loop !112

26:                                               ; preds = %18, %26
  %27 = phi i64 [ %32, %26 ], [ 0, %18 ]
  tail call void @llvm.dbg.value(metadata i64 %27, metadata !71, metadata !DIExpression()), !dbg !114
  %28 = getelementptr inbounds [1024 x i32], ptr @result, i64 0, i64 %27, !dbg !116
  %29 = load i32, ptr %28, align 4, !dbg !117, !tbaa !31
  %30 = trunc i64 %27 to i32, !dbg !117
  %31 = add nsw i32 %29, %30, !dbg !117
  store i32 %31, ptr %28, align 4, !dbg !117, !tbaa !31
  %32 = add nuw nsw i64 %27, 1, !dbg !118
  tail call void @llvm.dbg.value(metadata i64 %32, metadata !71, metadata !DIExpression()), !dbg !114
  %33 = icmp eq i64 %32, 8, !dbg !119
  br i1 %33, label %34, label %26, !dbg !120, !llvm.loop !121

34:                                               ; preds = %26
  %35 = load i32, ptr @result, align 16, !dbg !123, !tbaa !31
  ret i32 %35, !dbg !124
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!10, !11, !12, !13, !14, !15, !16}
!llvm.ident = !{!17}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "result", scope: !2, file: !5, line: 14, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.8 (11~20.04.2)", isOptimized: true, flags: "/usr/lib/llvm-18/bin/clang -O1 -g -S -emit-llvm -fno-vectorize -fno-unroll-loops -o /home/akshatha/cdlab/llvm/tests/test_fixed.ll /home/akshatha/cdlab/llvm/tests/test_fixed.c", runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/akshatha/cdlab/llvm/tests/test_fixed.c", directory: "/home/akshatha/cdlab/llvm", checksumkind: CSK_MD5, checksum: "0678d37e4a66f26c4b3a148c74017c75")
!4 = !{!0}
!5 = !DIFile(filename: "tests/test_fixed.c", directory: "/home/akshatha/cdlab/llvm", checksumkind: CSK_MD5, checksum: "0678d37e4a66f26c4b3a148c74017c75")
!6 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 32768, elements: !8)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !{!9}
!9 = !DISubrange(count: 1024)
!10 = !{i32 7, !"Dwarf Version", i32 5}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{i32 8, !"PIC Level", i32 2}
!14 = !{i32 7, !"PIE Level", i32 2}
!15 = !{i32 7, !"uwtable", i32 2}
!16 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!17 = !{!"Ubuntu clang version 18.1.8 (11~20.04.2)"}
!18 = distinct !DISubprogram(name: "loop_tiny", scope: !5, file: !5, line: 16, type: !19, scopeLine: 16, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !21)
!19 = !DISubroutineType(types: !20)
!20 = !{null}
!21 = !{!22}
!22 = !DILocalVariable(name: "i", scope: !23, file: !5, line: 18, type: !7)
!23 = distinct !DILexicalBlock(scope: !18, file: !5, line: 18, column: 5)
!24 = !DILocation(line: 0, scope: !23)
!25 = !DILocation(line: 18, column: 5, scope: !23)
!26 = !DILocation(line: 20, column: 1, scope: !18)
!27 = !DILocation(line: 19, column: 24, scope: !28)
!28 = distinct !DILexicalBlock(scope: !23, file: !5, line: 18, column: 5)
!29 = !DILocation(line: 19, column: 9, scope: !28)
!30 = !DILocation(line: 19, column: 19, scope: !28)
!31 = !{!32, !32, i64 0}
!32 = !{!"int", !33, i64 0}
!33 = !{!"omnipotent char", !34, i64 0}
!34 = !{!"Simple C/C++ TBAA"}
!35 = !DILocation(line: 18, column: 29, scope: !28)
!36 = !DILocation(line: 18, column: 23, scope: !28)
!37 = distinct !{!37, !25, !38, !39, !40}
!38 = !DILocation(line: 19, column: 26, scope: !23)
!39 = !{!"llvm.loop.mustprogress"}
!40 = !{!"llvm.loop.unroll.disable"}
!41 = distinct !DISubprogram(name: "loop_small", scope: !5, file: !5, line: 22, type: !19, scopeLine: 22, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !42)
!42 = !{!43}
!43 = !DILocalVariable(name: "i", scope: !44, file: !5, line: 24, type: !7)
!44 = distinct !DILexicalBlock(scope: !41, file: !5, line: 24, column: 5)
!45 = !DILocation(line: 0, scope: !44)
!46 = !DILocation(line: 24, column: 5, scope: !44)
!47 = !DILocation(line: 26, column: 1, scope: !41)
!48 = !DILocation(line: 25, column: 9, scope: !49)
!49 = distinct !DILexicalBlock(scope: !44, file: !5, line: 24, column: 5)
!50 = !DILocation(line: 25, column: 19, scope: !49)
!51 = !DILocation(line: 24, column: 30, scope: !49)
!52 = !DILocation(line: 24, column: 23, scope: !49)
!53 = distinct !{!53, !46, !54, !39, !40}
!54 = !DILocation(line: 25, column: 22, scope: !44)
!55 = distinct !DISubprogram(name: "loop_large", scope: !5, file: !5, line: 28, type: !19, scopeLine: 28, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !56)
!56 = !{!57}
!57 = !DILocalVariable(name: "i", scope: !58, file: !5, line: 30, type: !7)
!58 = distinct !DILexicalBlock(scope: !55, file: !5, line: 30, column: 5)
!59 = !DILocation(line: 0, scope: !58)
!60 = !DILocation(line: 30, column: 5, scope: !58)
!61 = !DILocation(line: 32, column: 1, scope: !55)
!62 = !DILocation(line: 31, column: 9, scope: !63)
!63 = distinct !DILexicalBlock(scope: !58, file: !5, line: 30, column: 5)
!64 = !DILocation(line: 31, column: 19, scope: !63)
!65 = !DILocation(line: 30, column: 32, scope: !63)
!66 = !DILocation(line: 30, column: 23, scope: !63)
!67 = distinct !{!67, !60, !68, !39, !40}
!68 = !DILocation(line: 31, column: 22, scope: !58)
!69 = distinct !DISubprogram(name: "loop_boundary", scope: !5, file: !5, line: 35, type: !19, scopeLine: 35, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !70)
!70 = !{!71}
!71 = !DILocalVariable(name: "i", scope: !72, file: !5, line: 36, type: !7)
!72 = distinct !DILexicalBlock(scope: !69, file: !5, line: 36, column: 5)
!73 = !DILocation(line: 0, scope: !72)
!74 = !DILocation(line: 36, column: 5, scope: !72)
!75 = !DILocation(line: 38, column: 1, scope: !69)
!76 = !DILocation(line: 37, column: 9, scope: !77)
!77 = distinct !DILexicalBlock(scope: !72, file: !5, line: 36, column: 5)
!78 = !DILocation(line: 37, column: 19, scope: !77)
!79 = !DILocation(line: 36, column: 29, scope: !77)
!80 = !DILocation(line: 36, column: 23, scope: !77)
!81 = distinct !{!81, !74, !82, !39, !40}
!82 = !DILocation(line: 37, column: 22, scope: !72)
!83 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 40, type: !84, scopeLine: 40, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2)
!84 = !DISubroutineType(types: !85)
!85 = !{!7}
!86 = !DILocation(line: 0, scope: !23, inlinedAt: !87)
!87 = distinct !DILocation(line: 41, column: 5, scope: !83)
!88 = !DILocation(line: 18, column: 5, scope: !23, inlinedAt: !87)
!89 = !DILocation(line: 19, column: 24, scope: !28, inlinedAt: !87)
!90 = !DILocation(line: 19, column: 9, scope: !28, inlinedAt: !87)
!91 = !DILocation(line: 19, column: 19, scope: !28, inlinedAt: !87)
!92 = !DILocation(line: 18, column: 29, scope: !28, inlinedAt: !87)
!93 = !DILocation(line: 18, column: 23, scope: !28, inlinedAt: !87)
!94 = distinct !{!94, !88, !95, !39, !40}
!95 = !DILocation(line: 19, column: 26, scope: !23, inlinedAt: !87)
!96 = !DILocation(line: 0, scope: !44, inlinedAt: !97)
!97 = distinct !DILocation(line: 42, column: 5, scope: !83)
!98 = !DILocation(line: 25, column: 9, scope: !49, inlinedAt: !97)
!99 = !DILocation(line: 25, column: 19, scope: !49, inlinedAt: !97)
!100 = !DILocation(line: 24, column: 30, scope: !49, inlinedAt: !97)
!101 = !DILocation(line: 24, column: 23, scope: !49, inlinedAt: !97)
!102 = !DILocation(line: 24, column: 5, scope: !44, inlinedAt: !97)
!103 = distinct !{!103, !102, !104, !39, !40}
!104 = !DILocation(line: 25, column: 22, scope: !44, inlinedAt: !97)
!105 = !DILocation(line: 0, scope: !58, inlinedAt: !106)
!106 = distinct !DILocation(line: 43, column: 5, scope: !83)
!107 = !DILocation(line: 31, column: 9, scope: !63, inlinedAt: !106)
!108 = !DILocation(line: 31, column: 19, scope: !63, inlinedAt: !106)
!109 = !DILocation(line: 30, column: 32, scope: !63, inlinedAt: !106)
!110 = !DILocation(line: 30, column: 23, scope: !63, inlinedAt: !106)
!111 = !DILocation(line: 30, column: 5, scope: !58, inlinedAt: !106)
!112 = distinct !{!112, !111, !113, !39, !40}
!113 = !DILocation(line: 31, column: 22, scope: !58, inlinedAt: !106)
!114 = !DILocation(line: 0, scope: !72, inlinedAt: !115)
!115 = distinct !DILocation(line: 44, column: 5, scope: !83)
!116 = !DILocation(line: 37, column: 9, scope: !77, inlinedAt: !115)
!117 = !DILocation(line: 37, column: 19, scope: !77, inlinedAt: !115)
!118 = !DILocation(line: 36, column: 29, scope: !77, inlinedAt: !115)
!119 = !DILocation(line: 36, column: 23, scope: !77, inlinedAt: !115)
!120 = !DILocation(line: 36, column: 5, scope: !72, inlinedAt: !115)
!121 = distinct !{!121, !120, !122, !39, !40}
!122 = !DILocation(line: 37, column: 22, scope: !72, inlinedAt: !115)
!123 = !DILocation(line: 45, column: 12, scope: !83)
!124 = !DILocation(line: 45, column: 5, scope: !83)
