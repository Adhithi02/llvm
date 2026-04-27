; ModuleID = 'tests/test_variable.c'
source_filename = "tests/test_variable.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink = dso_local global i32 0, align 4, !dbg !0
@__const.main.arr = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5], align 16

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local void @loop_param(i32 noundef %0) local_unnamed_addr #0 !dbg !15 {
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !19, metadata !DIExpression()), !dbg !23
  tail call void @llvm.dbg.value(metadata i32 0, metadata !20, metadata !DIExpression()), !dbg !23
  tail call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !24
  %2 = icmp sgt i32 %0, 0, !dbg !25
  br i1 %2, label %3, label %13, !dbg !27

3:                                                ; preds = %1
  %4 = add nsw i32 %0, -1, !dbg !27
  %5 = zext i32 %4 to i33, !dbg !27
  %6 = add nsw i32 %0, -2, !dbg !27
  %7 = zext i32 %6 to i33, !dbg !27
  %8 = mul i33 %5, %7, !dbg !27
  %9 = lshr i33 %8, 1, !dbg !27
  %10 = trunc i33 %9 to i32, !dbg !27
  %11 = add i32 %10, %0, !dbg !27
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !21, metadata !DIExpression()), !dbg !24
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !20, metadata !DIExpression()), !dbg !23
  %12 = add i32 %11, -1, !dbg !27
  br label %13, !dbg !28

13:                                               ; preds = %3, %1
  %14 = phi i32 [ 0, %1 ], [ %12, %3 ], !dbg !23
  store volatile i32 %14, ptr @sink, align 4, !dbg !28, !tbaa !29
  ret void, !dbg !33
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local void @loop_array(ptr nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #1 !dbg !34 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !39, metadata !DIExpression()), !dbg !44
  tail call void @llvm.dbg.value(metadata i32 %1, metadata !40, metadata !DIExpression()), !dbg !44
  tail call void @llvm.dbg.value(metadata i32 0, metadata !41, metadata !DIExpression()), !dbg !44
  tail call void @llvm.dbg.value(metadata i32 0, metadata !42, metadata !DIExpression()), !dbg !45
  %3 = icmp sgt i32 %1, 0, !dbg !46
  br i1 %3, label %4, label %6, !dbg !48

4:                                                ; preds = %2
  %5 = zext nneg i32 %1 to i64, !dbg !46
  br label %8, !dbg !48

6:                                                ; preds = %8, %2
  %7 = phi i32 [ 0, %2 ], [ %13, %8 ], !dbg !44
  store volatile i32 %7, ptr @sink, align 4, !dbg !49, !tbaa !29
  ret void, !dbg !50

8:                                                ; preds = %4, %8
  %9 = phi i64 [ 0, %4 ], [ %14, %8 ]
  %10 = phi i32 [ 0, %4 ], [ %13, %8 ]
  tail call void @llvm.dbg.value(metadata i64 %9, metadata !42, metadata !DIExpression()), !dbg !45
  tail call void @llvm.dbg.value(metadata i32 %10, metadata !41, metadata !DIExpression()), !dbg !44
  %11 = getelementptr inbounds i32, ptr %0, i64 %9, !dbg !51
  %12 = load i32, ptr %11, align 4, !dbg !51, !tbaa !29
  %13 = add nsw i32 %12, %10, !dbg !52
  tail call void @llvm.dbg.value(metadata i32 %13, metadata !41, metadata !DIExpression()), !dbg !44
  %14 = add nuw nsw i64 %9, 1, !dbg !53
  tail call void @llvm.dbg.value(metadata i64 %14, metadata !42, metadata !DIExpression()), !dbg !45
  %15 = icmp eq i64 %14, %5, !dbg !46
  br i1 %15, label %6, label %8, !dbg !48, !llvm.loop !54
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local void @loop_stride(i32 noundef %0) local_unnamed_addr #0 !dbg !58 {
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !60, metadata !DIExpression()), !dbg !64
  tail call void @llvm.dbg.value(metadata i32 0, metadata !61, metadata !DIExpression()), !dbg !64
  tail call void @llvm.dbg.value(metadata i32 0, metadata !62, metadata !DIExpression()), !dbg !65
  %2 = icmp sgt i32 %0, 0, !dbg !66
  br i1 %2, label %3, label %12, !dbg !68

3:                                                ; preds = %1
  %4 = add nsw i32 %0, -1, !dbg !68
  %5 = lshr i32 %4, 1, !dbg !68
  %6 = lshr i32 %4, 1, !dbg !68
  %7 = add nsw i32 %6, -1, !dbg !68
  %8 = mul i32 %5, %7, !dbg !68
  %9 = and i32 %8, -2, !dbg !68
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !62, metadata !DIExpression()), !dbg !65
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !61, metadata !DIExpression()), !dbg !64
  %10 = and i32 %4, -2, !dbg !68
  %11 = add i32 %10, %9, !dbg !68
  br label %12, !dbg !69

12:                                               ; preds = %3, %1
  %13 = phi i32 [ 0, %1 ], [ %11, %3 ], !dbg !64
  store volatile i32 %13, ptr @sink, align 4, !dbg !69, !tbaa !29
  ret void, !dbg !70
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local void @loop_ptr(ptr nocapture noundef readonly %0) local_unnamed_addr #1 !dbg !71 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !78, metadata !DIExpression()), !dbg !80
  tail call void @llvm.dbg.value(metadata i32 0, metadata !79, metadata !DIExpression()), !dbg !80
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !78, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !80
  %2 = load i8, ptr %0, align 1, !dbg !81, !tbaa !82
  %3 = icmp eq i8 %2, 0, !dbg !83
  br i1 %3, label %11, label %4, !dbg !83

4:                                                ; preds = %1, %4
  %5 = phi i32 [ %8, %4 ], [ 0, %1 ]
  %6 = phi ptr [ %7, %4 ], [ %0, %1 ]
  tail call void @llvm.dbg.value(metadata i32 %5, metadata !79, metadata !DIExpression()), !dbg !80
  tail call void @llvm.dbg.value(metadata ptr %6, metadata !78, metadata !DIExpression()), !dbg !80
  %7 = getelementptr inbounds i8, ptr %6, i64 1, !dbg !84
  tail call void @llvm.dbg.value(metadata ptr %7, metadata !78, metadata !DIExpression()), !dbg !80
  %8 = add nuw nsw i32 %5, 1, !dbg !85
  tail call void @llvm.dbg.value(metadata i32 %8, metadata !79, metadata !DIExpression()), !dbg !80
  tail call void @llvm.dbg.value(metadata ptr %7, metadata !78, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !80
  %9 = load i8, ptr %7, align 1, !dbg !81, !tbaa !82
  %10 = icmp eq i8 %9, 0, !dbg !83
  br i1 %10, label %11, label %4, !dbg !83, !llvm.loop !86

11:                                               ; preds = %4, %1
  %12 = phi i32 [ 0, %1 ], [ %8, %4 ], !dbg !80
  store volatile i32 %12, ptr @sink, align 4, !dbg !87, !tbaa !29
  ret void, !dbg !88
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #1 !dbg !89 {
  call void @llvm.dbg.assign(metadata i1 undef, metadata !97, metadata !DIExpression(), metadata !101, metadata ptr @__const.main.arr, metadata !DIExpression()), !dbg !102
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !95, metadata !DIExpression()), !dbg !102
  tail call void @llvm.dbg.value(metadata ptr %1, metadata !96, metadata !DIExpression()), !dbg !102
  call void @llvm.dbg.assign(metadata i1 undef, metadata !97, metadata !DIExpression(), metadata !103, metadata ptr @__const.main.arr, metadata !DIExpression()), !dbg !102
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !19, metadata !DIExpression()), !dbg !104
  tail call void @llvm.dbg.value(metadata i32 0, metadata !20, metadata !DIExpression()), !dbg !104
  tail call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !106
  %3 = icmp sgt i32 %0, 0, !dbg !107
  br i1 %3, label %4, label %23, !dbg !108

4:                                                ; preds = %2
  %5 = add nsw i32 %0, -1, !dbg !108
  %6 = zext i32 %5 to i33, !dbg !108
  %7 = add nsw i32 %0, -2, !dbg !108
  %8 = zext i32 %7 to i33, !dbg !108
  %9 = mul i33 %6, %8, !dbg !108
  %10 = lshr i33 %9, 1, !dbg !108
  %11 = trunc i33 %10 to i32, !dbg !108
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !21, metadata !DIExpression()), !dbg !106
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !20, metadata !DIExpression()), !dbg !104
  %12 = add nsw i32 %0, -1, !dbg !108
  %13 = add i32 %12, %11, !dbg !108
  store volatile i32 %13, ptr @sink, align 4, !dbg !109, !tbaa !29
  tail call void @llvm.dbg.value(metadata ptr @__const.main.arr, metadata !39, metadata !DIExpression()), !dbg !110
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !40, metadata !DIExpression()), !dbg !110
  tail call void @llvm.dbg.value(metadata i32 0, metadata !41, metadata !DIExpression()), !dbg !110
  tail call void @llvm.dbg.value(metadata i32 0, metadata !42, metadata !DIExpression()), !dbg !112
  %14 = zext nneg i32 %0 to i64, !dbg !113
  br label %15, !dbg !114

15:                                               ; preds = %15, %4
  %16 = phi i64 [ 0, %4 ], [ %21, %15 ]
  %17 = phi i32 [ 0, %4 ], [ %20, %15 ]
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !42, metadata !DIExpression()), !dbg !112
  tail call void @llvm.dbg.value(metadata i32 %17, metadata !41, metadata !DIExpression()), !dbg !110
  %18 = getelementptr inbounds i32, ptr @__const.main.arr, i64 %16, !dbg !115
  %19 = load i32, ptr %18, align 4, !dbg !115, !tbaa !29
  %20 = add nsw i32 %19, %17, !dbg !116
  tail call void @llvm.dbg.value(metadata i32 %20, metadata !41, metadata !DIExpression()), !dbg !110
  %21 = add nuw nsw i64 %16, 1, !dbg !117
  tail call void @llvm.dbg.value(metadata i64 %21, metadata !42, metadata !DIExpression()), !dbg !112
  %22 = icmp eq i64 %21, %14, !dbg !113
  br i1 %22, label %24, label %15, !dbg !114, !llvm.loop !118

23:                                               ; preds = %2
  store volatile i32 0, ptr @sink, align 4, !dbg !109, !tbaa !29
  tail call void @llvm.dbg.value(metadata ptr @__const.main.arr, metadata !39, metadata !DIExpression()), !dbg !110
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !40, metadata !DIExpression()), !dbg !110
  tail call void @llvm.dbg.value(metadata i32 0, metadata !41, metadata !DIExpression()), !dbg !110
  tail call void @llvm.dbg.value(metadata i32 0, metadata !42, metadata !DIExpression()), !dbg !112
  br label %24, !dbg !114

24:                                               ; preds = %15, %23
  %25 = phi i32 [ 0, %23 ], [ %20, %15 ], !dbg !110
  store volatile i32 %25, ptr @sink, align 4, !dbg !120, !tbaa !29
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !60, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shl, DW_OP_stack_value)), !dbg !121
  tail call void @llvm.dbg.value(metadata i32 0, metadata !61, metadata !DIExpression()), !dbg !121
  tail call void @llvm.dbg.value(metadata i32 0, metadata !62, metadata !DIExpression()), !dbg !123
  %26 = icmp sgt i32 %0, 0, !dbg !124
  br i1 %26, label %27, label %36, !dbg !125

27:                                               ; preds = %24
  %28 = shl nuw nsw i32 %0, 1, !dbg !126
  tail call void @llvm.dbg.value(metadata i32 %28, metadata !60, metadata !DIExpression()), !dbg !121
  %29 = add nsw i32 %28, -1, !dbg !125
  %30 = lshr i32 %29, 1, !dbg !125
  %31 = add nsw i32 %30, -1, !dbg !125
  %32 = mul i32 %31, %30, !dbg !125
  %33 = and i32 %32, -2, !dbg !125
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !62, metadata !DIExpression()), !dbg !123
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !61, metadata !DIExpression()), !dbg !121
  %34 = and i32 %29, -2, !dbg !125
  %35 = add i32 %33, %34, !dbg !125
  br label %36, !dbg !127

36:                                               ; preds = %24, %27
  %37 = phi i32 [ 0, %24 ], [ %35, %27 ], !dbg !121
  store volatile i32 %37, ptr @sink, align 4, !dbg !127, !tbaa !29
  %38 = load ptr, ptr %1, align 8, !dbg !128, !tbaa !129
  tail call void @llvm.dbg.value(metadata ptr %38, metadata !78, metadata !DIExpression()), !dbg !131
  tail call void @llvm.dbg.value(metadata i32 0, metadata !79, metadata !DIExpression()), !dbg !131
  tail call void @llvm.dbg.value(metadata ptr %38, metadata !78, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !131
  %39 = load i8, ptr %38, align 1, !dbg !133, !tbaa !82
  %40 = icmp eq i8 %39, 0, !dbg !134
  br i1 %40, label %48, label %41, !dbg !134

41:                                               ; preds = %36, %41
  %42 = phi i32 [ %45, %41 ], [ 0, %36 ]
  %43 = phi ptr [ %44, %41 ], [ %38, %36 ]
  tail call void @llvm.dbg.value(metadata i32 %42, metadata !79, metadata !DIExpression()), !dbg !131
  tail call void @llvm.dbg.value(metadata ptr %43, metadata !78, metadata !DIExpression()), !dbg !131
  %44 = getelementptr inbounds i8, ptr %43, i64 1, !dbg !135
  tail call void @llvm.dbg.value(metadata ptr %44, metadata !78, metadata !DIExpression()), !dbg !131
  %45 = add nuw nsw i32 %42, 1, !dbg !136
  tail call void @llvm.dbg.value(metadata i32 %45, metadata !79, metadata !DIExpression()), !dbg !131
  tail call void @llvm.dbg.value(metadata ptr %44, metadata !78, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !131
  %46 = load i8, ptr %44, align 1, !dbg !133, !tbaa !82
  %47 = icmp eq i8 %46, 0, !dbg !134
  br i1 %47, label %48, label %41, !dbg !134, !llvm.loop !137

48:                                               ; preds = %41, %36
  %49 = phi i32 [ 0, %36 ], [ %45, %41 ], !dbg !131
  store volatile i32 %49, ptr @sink, align 4, !dbg !138, !tbaa !29
  ret i32 0, !dbg !139
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.assign(metadata, metadata, metadata, metadata, metadata, metadata) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

attributes #0 = { nofree norecurse nounwind memory(readwrite, argmem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree norecurse nounwind memory(readwrite, argmem: read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9, !10, !11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sink", scope: !2, file: !3, line: 12, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/test_variable.c", directory: "/home/adhithi__iyer/loop-advisor", checksumkind: CSK_MD5, checksum: "1cb814fd047a593997af31cf597b7128")
!4 = !{!0}
!5 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !6)
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 7, !"Dwarf Version", i32 5}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{i32 8, !"PIC Level", i32 2}
!11 = !{i32 7, !"PIE Level", i32 2}
!12 = !{i32 7, !"uwtable", i32 2}
!13 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!14 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!15 = distinct !DISubprogram(name: "loop_param", scope: !3, file: !3, line: 15, type: !16, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !18)
!16 = !DISubroutineType(types: !17)
!17 = !{null, !6}
!18 = !{!19, !20, !21}
!19 = !DILocalVariable(name: "n", arg: 1, scope: !15, file: !3, line: 15, type: !6)
!20 = !DILocalVariable(name: "sum", scope: !15, file: !3, line: 16, type: !6)
!21 = !DILocalVariable(name: "i", scope: !22, file: !3, line: 17, type: !6)
!22 = distinct !DILexicalBlock(scope: !15, file: !3, line: 17, column: 5)
!23 = !DILocation(line: 0, scope: !15)
!24 = !DILocation(line: 0, scope: !22)
!25 = !DILocation(line: 17, column: 23, scope: !26)
!26 = distinct !DILexicalBlock(scope: !22, file: !3, line: 17, column: 5)
!27 = !DILocation(line: 17, column: 5, scope: !22)
!28 = !DILocation(line: 19, column: 10, scope: !15)
!29 = !{!30, !30, i64 0}
!30 = !{!"int", !31, i64 0}
!31 = !{!"omnipotent char", !32, i64 0}
!32 = !{!"Simple C/C++ TBAA"}
!33 = !DILocation(line: 20, column: 1, scope: !15)
!34 = distinct !DISubprogram(name: "loop_array", scope: !3, file: !3, line: 23, type: !35, scopeLine: 23, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !38)
!35 = !DISubroutineType(types: !36)
!36 = !{null, !37, !6}
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!38 = !{!39, !40, !41, !42}
!39 = !DILocalVariable(name: "arr", arg: 1, scope: !34, file: !3, line: 23, type: !37)
!40 = !DILocalVariable(name: "len", arg: 2, scope: !34, file: !3, line: 23, type: !6)
!41 = !DILocalVariable(name: "sum", scope: !34, file: !3, line: 24, type: !6)
!42 = !DILocalVariable(name: "i", scope: !43, file: !3, line: 25, type: !6)
!43 = distinct !DILexicalBlock(scope: !34, file: !3, line: 25, column: 5)
!44 = !DILocation(line: 0, scope: !34)
!45 = !DILocation(line: 0, scope: !43)
!46 = !DILocation(line: 25, column: 23, scope: !47)
!47 = distinct !DILexicalBlock(scope: !43, file: !3, line: 25, column: 5)
!48 = !DILocation(line: 25, column: 5, scope: !43)
!49 = !DILocation(line: 27, column: 10, scope: !34)
!50 = !DILocation(line: 28, column: 1, scope: !34)
!51 = !DILocation(line: 26, column: 16, scope: !47)
!52 = !DILocation(line: 26, column: 13, scope: !47)
!53 = !DILocation(line: 25, column: 31, scope: !47)
!54 = distinct !{!54, !48, !55, !56, !57}
!55 = !DILocation(line: 26, column: 21, scope: !43)
!56 = !{!"llvm.loop.mustprogress"}
!57 = !{!"llvm.loop.unroll.disable"}
!58 = distinct !DISubprogram(name: "loop_stride", scope: !3, file: !3, line: 31, type: !16, scopeLine: 31, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !59)
!59 = !{!60, !61, !62}
!60 = !DILocalVariable(name: "n", arg: 1, scope: !58, file: !3, line: 31, type: !6)
!61 = !DILocalVariable(name: "sum", scope: !58, file: !3, line: 32, type: !6)
!62 = !DILocalVariable(name: "i", scope: !63, file: !3, line: 33, type: !6)
!63 = distinct !DILexicalBlock(scope: !58, file: !3, line: 33, column: 5)
!64 = !DILocation(line: 0, scope: !58)
!65 = !DILocation(line: 0, scope: !63)
!66 = !DILocation(line: 33, column: 23, scope: !67)
!67 = distinct !DILexicalBlock(scope: !63, file: !3, line: 33, column: 5)
!68 = !DILocation(line: 33, column: 5, scope: !63)
!69 = !DILocation(line: 35, column: 10, scope: !58)
!70 = !DILocation(line: 36, column: 1, scope: !58)
!71 = distinct !DISubprogram(name: "loop_ptr", scope: !3, file: !3, line: 39, type: !72, scopeLine: 39, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !77)
!72 = !DISubroutineType(types: !73)
!73 = !{null, !74}
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !76)
!76 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!77 = !{!78, !79}
!78 = !DILocalVariable(name: "s", arg: 1, scope: !71, file: !3, line: 39, type: !74)
!79 = !DILocalVariable(name: "len", scope: !71, file: !3, line: 40, type: !6)
!80 = !DILocation(line: 0, scope: !71)
!81 = !DILocation(line: 41, column: 12, scope: !71)
!82 = !{!31, !31, i64 0}
!83 = !DILocation(line: 41, column: 5, scope: !71)
!84 = !DILocation(line: 41, column: 14, scope: !71)
!85 = !DILocation(line: 41, column: 21, scope: !71)
!86 = distinct !{!86, !83, !85, !56, !57}
!87 = !DILocation(line: 42, column: 10, scope: !71)
!88 = !DILocation(line: 43, column: 1, scope: !71)
!89 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 45, type: !90, scopeLine: 45, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !94)
!90 = !DISubroutineType(types: !91)
!91 = !{!6, !6, !92}
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !93, size: 64)
!93 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!94 = !{!95, !96, !97}
!95 = !DILocalVariable(name: "argc", arg: 1, scope: !89, file: !3, line: 45, type: !6)
!96 = !DILocalVariable(name: "argv", arg: 2, scope: !89, file: !3, line: 45, type: !92)
!97 = !DILocalVariable(name: "arr", scope: !89, file: !3, line: 46, type: !98)
!98 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 160, elements: !99)
!99 = !{!100}
!100 = !DISubrange(count: 5)
!101 = distinct !DIAssignID()
!102 = !DILocation(line: 0, scope: !89)
!103 = distinct !DIAssignID()
!104 = !DILocation(line: 0, scope: !15, inlinedAt: !105)
!105 = distinct !DILocation(line: 47, column: 5, scope: !89)
!106 = !DILocation(line: 0, scope: !22, inlinedAt: !105)
!107 = !DILocation(line: 17, column: 23, scope: !26, inlinedAt: !105)
!108 = !DILocation(line: 17, column: 5, scope: !22, inlinedAt: !105)
!109 = !DILocation(line: 19, column: 10, scope: !15, inlinedAt: !105)
!110 = !DILocation(line: 0, scope: !34, inlinedAt: !111)
!111 = distinct !DILocation(line: 48, column: 5, scope: !89)
!112 = !DILocation(line: 0, scope: !43, inlinedAt: !111)
!113 = !DILocation(line: 25, column: 23, scope: !47, inlinedAt: !111)
!114 = !DILocation(line: 25, column: 5, scope: !43, inlinedAt: !111)
!115 = !DILocation(line: 26, column: 16, scope: !47, inlinedAt: !111)
!116 = !DILocation(line: 26, column: 13, scope: !47, inlinedAt: !111)
!117 = !DILocation(line: 25, column: 31, scope: !47, inlinedAt: !111)
!118 = distinct !{!118, !114, !119, !56, !57}
!119 = !DILocation(line: 26, column: 21, scope: !43, inlinedAt: !111)
!120 = !DILocation(line: 27, column: 10, scope: !34, inlinedAt: !111)
!121 = !DILocation(line: 0, scope: !58, inlinedAt: !122)
!122 = distinct !DILocation(line: 49, column: 5, scope: !89)
!123 = !DILocation(line: 0, scope: !63, inlinedAt: !122)
!124 = !DILocation(line: 33, column: 23, scope: !67, inlinedAt: !122)
!125 = !DILocation(line: 33, column: 5, scope: !63, inlinedAt: !122)
!126 = !DILocation(line: 49, column: 22, scope: !89)
!127 = !DILocation(line: 35, column: 10, scope: !58, inlinedAt: !122)
!128 = !DILocation(line: 50, column: 14, scope: !89)
!129 = !{!130, !130, i64 0}
!130 = !{!"any pointer", !31, i64 0}
!131 = !DILocation(line: 0, scope: !71, inlinedAt: !132)
!132 = distinct !DILocation(line: 50, column: 5, scope: !89)
!133 = !DILocation(line: 41, column: 12, scope: !71, inlinedAt: !132)
!134 = !DILocation(line: 41, column: 5, scope: !71, inlinedAt: !132)
!135 = !DILocation(line: 41, column: 14, scope: !71, inlinedAt: !132)
!136 = !DILocation(line: 41, column: 21, scope: !71, inlinedAt: !132)
!137 = distinct !{!137, !134, !136, !56, !57}
!138 = !DILocation(line: 42, column: 10, scope: !71, inlinedAt: !132)
!139 = !DILocation(line: 51, column: 5, scope: !89)
