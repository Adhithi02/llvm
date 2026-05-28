; ModuleID = '/home/adhithi__iyer/loop-advisor/tests/test_variable.c'
source_filename = "/home/adhithi__iyer/loop-advisor/tests/test_variable.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink = dso_local global i32 0, align 4, !dbg !0
@__const.main.arr = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5], align 16

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local void @loop_param(i32 noundef %0) local_unnamed_addr #0 !dbg !16 {
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !20, metadata !DIExpression()), !dbg !24
  tail call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !24
  tail call void @llvm.dbg.value(metadata i32 0, metadata !22, metadata !DIExpression()), !dbg !25
  %2 = icmp sgt i32 %0, 0, !dbg !26
  br i1 %2, label %3, label %13, !dbg !28

3:                                                ; preds = %1
  %4 = add nsw i32 %0, -1, !dbg !28
  %5 = zext i32 %4 to i33, !dbg !28
  %6 = add nsw i32 %0, -2, !dbg !28
  %7 = zext i32 %6 to i33, !dbg !28
  %8 = mul i33 %5, %7, !dbg !28
  %9 = lshr i33 %8, 1, !dbg !28
  %10 = trunc i33 %9 to i32, !dbg !28
  %11 = add i32 %10, %0, !dbg !28
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !22, metadata !DIExpression()), !dbg !25
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !21, metadata !DIExpression()), !dbg !24
  %12 = add i32 %11, -1, !dbg !28
  br label %13, !dbg !29

13:                                               ; preds = %3, %1
  %14 = phi i32 [ 0, %1 ], [ %12, %3 ], !dbg !24
  store volatile i32 %14, ptr @sink, align 4, !dbg !29, !tbaa !30
  ret void, !dbg !34
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local void @loop_array(ptr nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #1 !dbg !35 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !40, metadata !DIExpression()), !dbg !45
  tail call void @llvm.dbg.value(metadata i32 %1, metadata !41, metadata !DIExpression()), !dbg !45
  tail call void @llvm.dbg.value(metadata i32 0, metadata !42, metadata !DIExpression()), !dbg !45
  tail call void @llvm.dbg.value(metadata i32 0, metadata !43, metadata !DIExpression()), !dbg !46
  %3 = icmp sgt i32 %1, 0, !dbg !47
  br i1 %3, label %4, label %6, !dbg !49

4:                                                ; preds = %2
  %5 = zext nneg i32 %1 to i64, !dbg !47
  br label %8, !dbg !49

6:                                                ; preds = %8, %2
  %7 = phi i32 [ 0, %2 ], [ %13, %8 ], !dbg !45
  store volatile i32 %7, ptr @sink, align 4, !dbg !50, !tbaa !30
  ret void, !dbg !51

8:                                                ; preds = %4, %8
  %9 = phi i64 [ 0, %4 ], [ %14, %8 ]
  %10 = phi i32 [ 0, %4 ], [ %13, %8 ]
  tail call void @llvm.dbg.value(metadata i64 %9, metadata !43, metadata !DIExpression()), !dbg !46
  tail call void @llvm.dbg.value(metadata i32 %10, metadata !42, metadata !DIExpression()), !dbg !45
  %11 = getelementptr inbounds i32, ptr %0, i64 %9, !dbg !52
  %12 = load i32, ptr %11, align 4, !dbg !52, !tbaa !30
  %13 = add nsw i32 %12, %10, !dbg !53
  tail call void @llvm.dbg.value(metadata i32 %13, metadata !42, metadata !DIExpression()), !dbg !45
  %14 = add nuw nsw i64 %9, 1, !dbg !54
  tail call void @llvm.dbg.value(metadata i64 %14, metadata !43, metadata !DIExpression()), !dbg !46
  %15 = icmp eq i64 %14, %5, !dbg !47
  br i1 %15, label %6, label %8, !dbg !49, !llvm.loop !55
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local void @loop_stride(i32 noundef %0) local_unnamed_addr #0 !dbg !59 {
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !61, metadata !DIExpression()), !dbg !65
  tail call void @llvm.dbg.value(metadata i32 0, metadata !62, metadata !DIExpression()), !dbg !65
  tail call void @llvm.dbg.value(metadata i32 0, metadata !63, metadata !DIExpression()), !dbg !66
  %2 = icmp sgt i32 %0, 0, !dbg !67
  br i1 %2, label %3, label %12, !dbg !69

3:                                                ; preds = %1
  %4 = add nsw i32 %0, -1, !dbg !69
  %5 = lshr i32 %4, 1, !dbg !69
  %6 = lshr i32 %4, 1, !dbg !69
  %7 = add nsw i32 %6, -1, !dbg !69
  %8 = mul i32 %5, %7, !dbg !69
  %9 = and i32 %8, -2, !dbg !69
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !63, metadata !DIExpression()), !dbg !66
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !62, metadata !DIExpression()), !dbg !65
  %10 = and i32 %4, -2, !dbg !69
  %11 = add i32 %10, %9, !dbg !69
  br label %12, !dbg !70

12:                                               ; preds = %3, %1
  %13 = phi i32 [ 0, %1 ], [ %11, %3 ], !dbg !65
  store volatile i32 %13, ptr @sink, align 4, !dbg !70, !tbaa !30
  ret void, !dbg !71
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local void @loop_ptr(ptr nocapture noundef readonly %0) local_unnamed_addr #1 !dbg !72 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !79, metadata !DIExpression()), !dbg !81
  tail call void @llvm.dbg.value(metadata i32 0, metadata !80, metadata !DIExpression()), !dbg !81
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !79, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !81
  %2 = load i8, ptr %0, align 1, !dbg !82, !tbaa !83
  %3 = icmp eq i8 %2, 0, !dbg !84
  br i1 %3, label %11, label %4, !dbg !84

4:                                                ; preds = %1, %4
  %5 = phi i32 [ %8, %4 ], [ 0, %1 ]
  %6 = phi ptr [ %7, %4 ], [ %0, %1 ]
  tail call void @llvm.dbg.value(metadata i32 %5, metadata !80, metadata !DIExpression()), !dbg !81
  tail call void @llvm.dbg.value(metadata ptr %6, metadata !79, metadata !DIExpression()), !dbg !81
  %7 = getelementptr inbounds i8, ptr %6, i64 1, !dbg !85
  tail call void @llvm.dbg.value(metadata ptr %7, metadata !79, metadata !DIExpression()), !dbg !81
  %8 = add nuw nsw i32 %5, 1, !dbg !86
  tail call void @llvm.dbg.value(metadata i32 %8, metadata !80, metadata !DIExpression()), !dbg !81
  tail call void @llvm.dbg.value(metadata ptr %7, metadata !79, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !81
  %9 = load i8, ptr %7, align 1, !dbg !82, !tbaa !83
  %10 = icmp eq i8 %9, 0, !dbg !84
  br i1 %10, label %11, label %4, !dbg !84, !llvm.loop !87

11:                                               ; preds = %4, %1
  %12 = phi i32 [ 0, %1 ], [ %8, %4 ], !dbg !81
  store volatile i32 %12, ptr @sink, align 4, !dbg !88, !tbaa !30
  ret void, !dbg !89
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #1 !dbg !90 {
  call void @llvm.dbg.assign(metadata i1 undef, metadata !98, metadata !DIExpression(), metadata !102, metadata ptr @__const.main.arr, metadata !DIExpression()), !dbg !103
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !96, metadata !DIExpression()), !dbg !103
  tail call void @llvm.dbg.value(metadata ptr %1, metadata !97, metadata !DIExpression()), !dbg !103
  call void @llvm.dbg.assign(metadata i1 undef, metadata !98, metadata !DIExpression(), metadata !104, metadata ptr @__const.main.arr, metadata !DIExpression()), !dbg !103
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !20, metadata !DIExpression()), !dbg !105
  tail call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !105
  tail call void @llvm.dbg.value(metadata i32 0, metadata !22, metadata !DIExpression()), !dbg !107
  %3 = icmp sgt i32 %0, 0, !dbg !108
  br i1 %3, label %4, label %23, !dbg !109

4:                                                ; preds = %2
  %5 = add nsw i32 %0, -1, !dbg !109
  %6 = zext i32 %5 to i33, !dbg !109
  %7 = add nsw i32 %0, -2, !dbg !109
  %8 = zext i32 %7 to i33, !dbg !109
  %9 = mul i33 %6, %8, !dbg !109
  %10 = lshr i33 %9, 1, !dbg !109
  %11 = trunc i33 %10 to i32, !dbg !109
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !22, metadata !DIExpression()), !dbg !107
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !21, metadata !DIExpression()), !dbg !105
  %12 = add nsw i32 %0, -1, !dbg !109
  %13 = add i32 %12, %11, !dbg !109
  store volatile i32 %13, ptr @sink, align 4, !dbg !110, !tbaa !30
  tail call void @llvm.dbg.value(metadata ptr @__const.main.arr, metadata !40, metadata !DIExpression()), !dbg !111
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !41, metadata !DIExpression()), !dbg !111
  tail call void @llvm.dbg.value(metadata i32 0, metadata !42, metadata !DIExpression()), !dbg !111
  tail call void @llvm.dbg.value(metadata i32 0, metadata !43, metadata !DIExpression()), !dbg !113
  %14 = zext nneg i32 %0 to i64, !dbg !114
  br label %15, !dbg !115

15:                                               ; preds = %15, %4
  %16 = phi i64 [ 0, %4 ], [ %21, %15 ]
  %17 = phi i32 [ 0, %4 ], [ %20, %15 ]
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !43, metadata !DIExpression()), !dbg !113
  tail call void @llvm.dbg.value(metadata i32 %17, metadata !42, metadata !DIExpression()), !dbg !111
  %18 = getelementptr inbounds i32, ptr @__const.main.arr, i64 %16, !dbg !116
  %19 = load i32, ptr %18, align 4, !dbg !116, !tbaa !30
  %20 = add nsw i32 %19, %17, !dbg !117
  tail call void @llvm.dbg.value(metadata i32 %20, metadata !42, metadata !DIExpression()), !dbg !111
  %21 = add nuw nsw i64 %16, 1, !dbg !118
  tail call void @llvm.dbg.value(metadata i64 %21, metadata !43, metadata !DIExpression()), !dbg !113
  %22 = icmp eq i64 %21, %14, !dbg !114
  br i1 %22, label %24, label %15, !dbg !115, !llvm.loop !119

23:                                               ; preds = %2
  store volatile i32 0, ptr @sink, align 4, !dbg !110, !tbaa !30
  tail call void @llvm.dbg.value(metadata ptr @__const.main.arr, metadata !40, metadata !DIExpression()), !dbg !111
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !41, metadata !DIExpression()), !dbg !111
  tail call void @llvm.dbg.value(metadata i32 0, metadata !42, metadata !DIExpression()), !dbg !111
  tail call void @llvm.dbg.value(metadata i32 0, metadata !43, metadata !DIExpression()), !dbg !113
  br label %24, !dbg !115

24:                                               ; preds = %15, %23
  %25 = phi i32 [ 0, %23 ], [ %20, %15 ], !dbg !111
  store volatile i32 %25, ptr @sink, align 4, !dbg !121, !tbaa !30
  tail call void @llvm.dbg.value(metadata i32 %0, metadata !61, metadata !DIExpression(DW_OP_constu, 1, DW_OP_shl, DW_OP_stack_value)), !dbg !122
  tail call void @llvm.dbg.value(metadata i32 0, metadata !62, metadata !DIExpression()), !dbg !122
  tail call void @llvm.dbg.value(metadata i32 0, metadata !63, metadata !DIExpression()), !dbg !124
  %26 = icmp sgt i32 %0, 0, !dbg !125
  br i1 %26, label %27, label %36, !dbg !126

27:                                               ; preds = %24
  %28 = shl nuw nsw i32 %0, 1, !dbg !127
  tail call void @llvm.dbg.value(metadata i32 %28, metadata !61, metadata !DIExpression()), !dbg !122
  %29 = add nsw i32 %28, -1, !dbg !126
  %30 = lshr i32 %29, 1, !dbg !126
  %31 = add nsw i32 %30, -1, !dbg !126
  %32 = mul i32 %31, %30, !dbg !126
  %33 = and i32 %32, -2, !dbg !126
  tail call void @llvm.dbg.value(metadata i32 undef, metadata !63, metadata !DIExpression()), !dbg !124
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !62, metadata !DIExpression()), !dbg !122
  %34 = and i32 %29, -2, !dbg !126
  %35 = add i32 %33, %34, !dbg !126
  br label %36, !dbg !128

36:                                               ; preds = %24, %27
  %37 = phi i32 [ 0, %24 ], [ %35, %27 ], !dbg !122
  store volatile i32 %37, ptr @sink, align 4, !dbg !128, !tbaa !30
  %38 = load ptr, ptr %1, align 8, !dbg !129, !tbaa !130
  tail call void @llvm.dbg.value(metadata ptr %38, metadata !79, metadata !DIExpression()), !dbg !132
  tail call void @llvm.dbg.value(metadata i32 0, metadata !80, metadata !DIExpression()), !dbg !132
  tail call void @llvm.dbg.value(metadata ptr %38, metadata !79, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !132
  %39 = load i8, ptr %38, align 1, !dbg !134, !tbaa !83
  %40 = icmp eq i8 %39, 0, !dbg !135
  br i1 %40, label %48, label %41, !dbg !135

41:                                               ; preds = %36, %41
  %42 = phi i32 [ %45, %41 ], [ 0, %36 ]
  %43 = phi ptr [ %44, %41 ], [ %38, %36 ]
  tail call void @llvm.dbg.value(metadata i32 %42, metadata !80, metadata !DIExpression()), !dbg !132
  tail call void @llvm.dbg.value(metadata ptr %43, metadata !79, metadata !DIExpression()), !dbg !132
  %44 = getelementptr inbounds i8, ptr %43, i64 1, !dbg !136
  tail call void @llvm.dbg.value(metadata ptr %44, metadata !79, metadata !DIExpression()), !dbg !132
  %45 = add nuw nsw i32 %42, 1, !dbg !137
  tail call void @llvm.dbg.value(metadata i32 %45, metadata !80, metadata !DIExpression()), !dbg !132
  tail call void @llvm.dbg.value(metadata ptr %44, metadata !79, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !132
  %46 = load i8, ptr %44, align 1, !dbg !134, !tbaa !83
  %47 = icmp eq i8 %46, 0, !dbg !135
  br i1 %47, label %48, label %41, !dbg !135, !llvm.loop !138

48:                                               ; preds = %41, %36
  %49 = phi i32 [ 0, %36 ], [ %45, %41 ], !dbg !132
  store volatile i32 %49, ptr @sink, align 4, !dbg !139, !tbaa !30
  ret i32 0, !dbg !140
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
!llvm.module.flags = !{!8, !9, !10, !11, !12, !13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sink", scope: !2, file: !5, line: 12, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/adhithi__iyer/loop-advisor/tests/test_variable.c", directory: "/home/adhithi__iyer/loop-advisor/scripts", checksumkind: CSK_MD5, checksum: "1cb814fd047a593997af31cf597b7128")
!4 = !{!0}
!5 = !DIFile(filename: "tests/test_variable.c", directory: "/home/adhithi__iyer/loop-advisor", checksumkind: CSK_MD5, checksum: "1cb814fd047a593997af31cf597b7128")
!6 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !7)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !{i32 7, !"Dwarf Version", i32 5}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{i32 8, !"PIC Level", i32 2}
!12 = !{i32 7, !"PIE Level", i32 2}
!13 = !{i32 7, !"uwtable", i32 2}
!14 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!15 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!16 = distinct !DISubprogram(name: "loop_param", scope: !5, file: !5, line: 15, type: !17, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !19)
!17 = !DISubroutineType(types: !18)
!18 = !{null, !7}
!19 = !{!20, !21, !22}
!20 = !DILocalVariable(name: "n", arg: 1, scope: !16, file: !5, line: 15, type: !7)
!21 = !DILocalVariable(name: "sum", scope: !16, file: !5, line: 16, type: !7)
!22 = !DILocalVariable(name: "i", scope: !23, file: !5, line: 17, type: !7)
!23 = distinct !DILexicalBlock(scope: !16, file: !5, line: 17, column: 5)
!24 = !DILocation(line: 0, scope: !16)
!25 = !DILocation(line: 0, scope: !23)
!26 = !DILocation(line: 17, column: 23, scope: !27)
!27 = distinct !DILexicalBlock(scope: !23, file: !5, line: 17, column: 5)
!28 = !DILocation(line: 17, column: 5, scope: !23)
!29 = !DILocation(line: 19, column: 10, scope: !16)
!30 = !{!31, !31, i64 0}
!31 = !{!"int", !32, i64 0}
!32 = !{!"omnipotent char", !33, i64 0}
!33 = !{!"Simple C/C++ TBAA"}
!34 = !DILocation(line: 20, column: 1, scope: !16)
!35 = distinct !DISubprogram(name: "loop_array", scope: !5, file: !5, line: 23, type: !36, scopeLine: 23, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !39)
!36 = !DISubroutineType(types: !37)
!37 = !{null, !38, !7}
!38 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!39 = !{!40, !41, !42, !43}
!40 = !DILocalVariable(name: "arr", arg: 1, scope: !35, file: !5, line: 23, type: !38)
!41 = !DILocalVariable(name: "len", arg: 2, scope: !35, file: !5, line: 23, type: !7)
!42 = !DILocalVariable(name: "sum", scope: !35, file: !5, line: 24, type: !7)
!43 = !DILocalVariable(name: "i", scope: !44, file: !5, line: 25, type: !7)
!44 = distinct !DILexicalBlock(scope: !35, file: !5, line: 25, column: 5)
!45 = !DILocation(line: 0, scope: !35)
!46 = !DILocation(line: 0, scope: !44)
!47 = !DILocation(line: 25, column: 23, scope: !48)
!48 = distinct !DILexicalBlock(scope: !44, file: !5, line: 25, column: 5)
!49 = !DILocation(line: 25, column: 5, scope: !44)
!50 = !DILocation(line: 27, column: 10, scope: !35)
!51 = !DILocation(line: 28, column: 1, scope: !35)
!52 = !DILocation(line: 26, column: 16, scope: !48)
!53 = !DILocation(line: 26, column: 13, scope: !48)
!54 = !DILocation(line: 25, column: 31, scope: !48)
!55 = distinct !{!55, !49, !56, !57, !58}
!56 = !DILocation(line: 26, column: 21, scope: !44)
!57 = !{!"llvm.loop.mustprogress"}
!58 = !{!"llvm.loop.unroll.disable"}
!59 = distinct !DISubprogram(name: "loop_stride", scope: !5, file: !5, line: 31, type: !17, scopeLine: 31, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !60)
!60 = !{!61, !62, !63}
!61 = !DILocalVariable(name: "n", arg: 1, scope: !59, file: !5, line: 31, type: !7)
!62 = !DILocalVariable(name: "sum", scope: !59, file: !5, line: 32, type: !7)
!63 = !DILocalVariable(name: "i", scope: !64, file: !5, line: 33, type: !7)
!64 = distinct !DILexicalBlock(scope: !59, file: !5, line: 33, column: 5)
!65 = !DILocation(line: 0, scope: !59)
!66 = !DILocation(line: 0, scope: !64)
!67 = !DILocation(line: 33, column: 23, scope: !68)
!68 = distinct !DILexicalBlock(scope: !64, file: !5, line: 33, column: 5)
!69 = !DILocation(line: 33, column: 5, scope: !64)
!70 = !DILocation(line: 35, column: 10, scope: !59)
!71 = !DILocation(line: 36, column: 1, scope: !59)
!72 = distinct !DISubprogram(name: "loop_ptr", scope: !5, file: !5, line: 39, type: !73, scopeLine: 39, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !78)
!73 = !DISubroutineType(types: !74)
!74 = !{null, !75}
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!76 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !77)
!77 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!78 = !{!79, !80}
!79 = !DILocalVariable(name: "s", arg: 1, scope: !72, file: !5, line: 39, type: !75)
!80 = !DILocalVariable(name: "len", scope: !72, file: !5, line: 40, type: !7)
!81 = !DILocation(line: 0, scope: !72)
!82 = !DILocation(line: 41, column: 12, scope: !72)
!83 = !{!32, !32, i64 0}
!84 = !DILocation(line: 41, column: 5, scope: !72)
!85 = !DILocation(line: 41, column: 14, scope: !72)
!86 = !DILocation(line: 41, column: 21, scope: !72)
!87 = distinct !{!87, !84, !86, !57, !58}
!88 = !DILocation(line: 42, column: 10, scope: !72)
!89 = !DILocation(line: 43, column: 1, scope: !72)
!90 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 45, type: !91, scopeLine: 45, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !95)
!91 = !DISubroutineType(types: !92)
!92 = !{!7, !7, !93}
!93 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !94, size: 64)
!94 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!95 = !{!96, !97, !98}
!96 = !DILocalVariable(name: "argc", arg: 1, scope: !90, file: !5, line: 45, type: !7)
!97 = !DILocalVariable(name: "argv", arg: 2, scope: !90, file: !5, line: 45, type: !93)
!98 = !DILocalVariable(name: "arr", scope: !90, file: !5, line: 46, type: !99)
!99 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 160, elements: !100)
!100 = !{!101}
!101 = !DISubrange(count: 5)
!102 = distinct !DIAssignID()
!103 = !DILocation(line: 0, scope: !90)
!104 = distinct !DIAssignID()
!105 = !DILocation(line: 0, scope: !16, inlinedAt: !106)
!106 = distinct !DILocation(line: 47, column: 5, scope: !90)
!107 = !DILocation(line: 0, scope: !23, inlinedAt: !106)
!108 = !DILocation(line: 17, column: 23, scope: !27, inlinedAt: !106)
!109 = !DILocation(line: 17, column: 5, scope: !23, inlinedAt: !106)
!110 = !DILocation(line: 19, column: 10, scope: !16, inlinedAt: !106)
!111 = !DILocation(line: 0, scope: !35, inlinedAt: !112)
!112 = distinct !DILocation(line: 48, column: 5, scope: !90)
!113 = !DILocation(line: 0, scope: !44, inlinedAt: !112)
!114 = !DILocation(line: 25, column: 23, scope: !48, inlinedAt: !112)
!115 = !DILocation(line: 25, column: 5, scope: !44, inlinedAt: !112)
!116 = !DILocation(line: 26, column: 16, scope: !48, inlinedAt: !112)
!117 = !DILocation(line: 26, column: 13, scope: !48, inlinedAt: !112)
!118 = !DILocation(line: 25, column: 31, scope: !48, inlinedAt: !112)
!119 = distinct !{!119, !115, !120, !57, !58}
!120 = !DILocation(line: 26, column: 21, scope: !44, inlinedAt: !112)
!121 = !DILocation(line: 27, column: 10, scope: !35, inlinedAt: !112)
!122 = !DILocation(line: 0, scope: !59, inlinedAt: !123)
!123 = distinct !DILocation(line: 49, column: 5, scope: !90)
!124 = !DILocation(line: 0, scope: !64, inlinedAt: !123)
!125 = !DILocation(line: 33, column: 23, scope: !68, inlinedAt: !123)
!126 = !DILocation(line: 33, column: 5, scope: !64, inlinedAt: !123)
!127 = !DILocation(line: 49, column: 22, scope: !90)
!128 = !DILocation(line: 35, column: 10, scope: !59, inlinedAt: !123)
!129 = !DILocation(line: 50, column: 14, scope: !90)
!130 = !{!131, !131, i64 0}
!131 = !{!"any pointer", !32, i64 0}
!132 = !DILocation(line: 0, scope: !72, inlinedAt: !133)
!133 = distinct !DILocation(line: 50, column: 5, scope: !90)
!134 = !DILocation(line: 41, column: 12, scope: !72, inlinedAt: !133)
!135 = !DILocation(line: 41, column: 5, scope: !72, inlinedAt: !133)
!136 = !DILocation(line: 41, column: 14, scope: !72, inlinedAt: !133)
!137 = !DILocation(line: 41, column: 21, scope: !72, inlinedAt: !133)
!138 = distinct !{!138, !135, !137, !57, !58}
!139 = !DILocation(line: 42, column: 10, scope: !72, inlinedAt: !133)
!140 = !DILocation(line: 51, column: 5, scope: !90)
