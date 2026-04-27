; ModuleID = 'tests/test_nested.c'
source_filename = "tests/test_nested.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink = dso_local global i32 0, align 4, !dbg !0

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @matrix_mul(ptr nocapture noundef readonly %0, ptr nocapture noundef readonly %1, ptr nocapture noundef writeonly %2, i32 noundef %3) local_unnamed_addr #0 !dbg !15 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !23, metadata !DIExpression()), !dbg !37
  tail call void @llvm.dbg.value(metadata ptr %1, metadata !24, metadata !DIExpression()), !dbg !37
  tail call void @llvm.dbg.value(metadata ptr %2, metadata !25, metadata !DIExpression()), !dbg !37
  tail call void @llvm.dbg.value(metadata i32 %3, metadata !26, metadata !DIExpression()), !dbg !37
  tail call void @llvm.dbg.value(metadata i32 0, metadata !27, metadata !DIExpression()), !dbg !38
  %5 = icmp sgt i32 %3, 0, !dbg !39
  br i1 %5, label %6, label %12, !dbg !40

6:                                                ; preds = %4
  %7 = zext nneg i32 %3 to i64, !dbg !39
  %8 = zext nneg i32 %3 to i64
  %9 = zext nneg i32 %3 to i64
  br label %10, !dbg !40

10:                                               ; preds = %6, %15
  %11 = phi i64 [ 0, %6 ], [ %16, %15 ]
  tail call void @llvm.dbg.value(metadata i64 %11, metadata !27, metadata !DIExpression()), !dbg !38
  tail call void @llvm.dbg.value(metadata i32 0, metadata !29, metadata !DIExpression()), !dbg !41
  br label %13, !dbg !42

12:                                               ; preds = %15, %4
  ret void, !dbg !43

13:                                               ; preds = %10, %18
  %14 = phi i64 [ 0, %10 ], [ %20, %18 ]
  tail call void @llvm.dbg.value(metadata i64 %14, metadata !29, metadata !DIExpression()), !dbg !41
  tail call void @llvm.dbg.value(metadata i32 0, metadata !35, metadata !DIExpression()), !dbg !44
  tail call void @llvm.dbg.value(metadata i32 0, metadata !32, metadata !DIExpression()), !dbg !45
  br label %22, !dbg !46

15:                                               ; preds = %18
  %16 = add nuw nsw i64 %11, 1, !dbg !47
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !27, metadata !DIExpression()), !dbg !38
  %17 = icmp eq i64 %16, %7, !dbg !39
  br i1 %17, label %12, label %10, !dbg !40, !llvm.loop !48

18:                                               ; preds = %22
  %19 = getelementptr inbounds [64 x i32], ptr %2, i64 %11, i64 %14, !dbg !52
  store i32 %30, ptr %19, align 4, !dbg !53, !tbaa !54
  %20 = add nuw nsw i64 %14, 1, !dbg !58
  tail call void @llvm.dbg.value(metadata i64 %20, metadata !29, metadata !DIExpression()), !dbg !41
  %21 = icmp eq i64 %20, %8, !dbg !59
  br i1 %21, label %15, label %13, !dbg !42, !llvm.loop !60

22:                                               ; preds = %13, %22
  %23 = phi i64 [ 0, %13 ], [ %31, %22 ]
  %24 = phi i32 [ 0, %13 ], [ %30, %22 ]
  tail call void @llvm.dbg.value(metadata i64 %23, metadata !35, metadata !DIExpression()), !dbg !44
  tail call void @llvm.dbg.value(metadata i32 %24, metadata !32, metadata !DIExpression()), !dbg !45
  %25 = getelementptr inbounds [64 x i32], ptr %0, i64 %11, i64 %23, !dbg !62
  %26 = load i32, ptr %25, align 4, !dbg !62, !tbaa !54
  %27 = getelementptr inbounds [64 x i32], ptr %1, i64 %23, i64 %14, !dbg !64
  %28 = load i32, ptr %27, align 4, !dbg !64, !tbaa !54
  %29 = mul nsw i32 %28, %26, !dbg !65
  %30 = add nsw i32 %29, %24, !dbg !66
  tail call void @llvm.dbg.value(metadata i32 %30, metadata !32, metadata !DIExpression()), !dbg !45
  %31 = add nuw nsw i64 %23, 1, !dbg !67
  tail call void @llvm.dbg.value(metadata i64 %31, metadata !35, metadata !DIExpression()), !dbg !44
  %32 = icmp eq i64 %31, %9, !dbg !68
  br i1 %32, label %18, label %22, !dbg !46, !llvm.loop !69
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local void @unroll_candidate(ptr nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #2 !dbg !71 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !76, metadata !DIExpression()), !dbg !85
  tail call void @llvm.dbg.value(metadata i32 %1, metadata !77, metadata !DIExpression()), !dbg !85
  tail call void @llvm.dbg.value(metadata i32 0, metadata !78, metadata !DIExpression()), !dbg !86
  %3 = icmp sgt i32 %1, 0, !dbg !87
  br i1 %3, label %4, label %9, !dbg !88

4:                                                ; preds = %2
  %5 = zext nneg i32 %1 to i64, !dbg !87
  br label %6, !dbg !88

6:                                                ; preds = %4, %10
  %7 = phi i64 [ 0, %4 ], [ %13, %10 ]
  tail call void @llvm.dbg.value(metadata i64 %7, metadata !78, metadata !DIExpression()), !dbg !86
  tail call void @llvm.dbg.value(metadata i32 0, metadata !83, metadata !DIExpression()), !dbg !89
  tail call void @llvm.dbg.value(metadata i32 0, metadata !80, metadata !DIExpression()), !dbg !90
  %8 = getelementptr i32, ptr %0, i64 %7, !dbg !91
  br label %15, !dbg !91

9:                                                ; preds = %10, %2
  ret void, !dbg !92

10:                                               ; preds = %15
  %11 = load volatile i32, ptr @sink, align 4, !dbg !93, !tbaa !54
  %12 = add nsw i32 %11, %20, !dbg !93
  store volatile i32 %12, ptr @sink, align 4, !dbg !93, !tbaa !54
  %13 = add nuw nsw i64 %7, 1, !dbg !94
  tail call void @llvm.dbg.value(metadata i64 %13, metadata !78, metadata !DIExpression()), !dbg !86
  %14 = icmp eq i64 %13, %5, !dbg !87
  br i1 %14, label %9, label %6, !dbg !88, !llvm.loop !95

15:                                               ; preds = %6, %15
  %16 = phi i64 [ 0, %6 ], [ %21, %15 ]
  %17 = phi i32 [ 0, %6 ], [ %20, %15 ]
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !83, metadata !DIExpression()), !dbg !89
  tail call void @llvm.dbg.value(metadata i32 %17, metadata !80, metadata !DIExpression()), !dbg !90
  %18 = getelementptr i32, ptr %8, i64 %16, !dbg !97
  %19 = load i32, ptr %18, align 4, !dbg !97, !tbaa !54
  %20 = add nsw i32 %19, %17, !dbg !99
  tail call void @llvm.dbg.value(metadata i32 %20, metadata !80, metadata !DIExpression()), !dbg !90
  %21 = add nuw nsw i64 %16, 1, !dbg !100
  tail call void @llvm.dbg.value(metadata i64 %21, metadata !83, metadata !DIExpression()), !dbg !89
  %22 = icmp eq i64 %21, 4, !dbg !101
  br i1 %22, label %10, label %15, !dbg !91, !llvm.loop !102
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local void @double_fixed() local_unnamed_addr #3 !dbg !104 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !108, metadata !DIExpression()), !dbg !114
  tail call void @llvm.dbg.value(metadata i32 0, metadata !109, metadata !DIExpression()), !dbg !115
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !109, metadata !DIExpression()), !dbg !115
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !108, metadata !DIExpression()), !dbg !114
  store volatile i32 784, ptr @sink, align 4, !dbg !116, !tbaa !54
  ret void, !dbg !117
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local noundef i32 @main() local_unnamed_addr #3 !dbg !118 {
  call void @llvm.dbg.assign(metadata i1 poison, metadata !122, metadata !DIExpression(), metadata !128, metadata ptr undef, metadata !DIExpression()), !dbg !129
  call void @llvm.dbg.assign(metadata i1 poison, metadata !125, metadata !DIExpression(), metadata !130, metadata ptr undef, metadata !DIExpression()), !dbg !129
  call void @llvm.dbg.assign(metadata i1 poison, metadata !126, metadata !DIExpression(), metadata !131, metadata ptr undef, metadata !DIExpression()), !dbg !129
  %1 = alloca [64 x i32], align 16, !DIAssignID !132
  call void @llvm.dbg.assign(metadata i1 undef, metadata !127, metadata !DIExpression(), metadata !132, metadata ptr %1, metadata !DIExpression()), !dbg !129
  tail call void @llvm.dbg.value(metadata ptr poison, metadata !23, metadata !DIExpression()), !dbg !133
  tail call void @llvm.dbg.value(metadata ptr poison, metadata !24, metadata !DIExpression()), !dbg !133
  tail call void @llvm.dbg.value(metadata ptr poison, metadata !25, metadata !DIExpression()), !dbg !133
  tail call void @llvm.dbg.value(metadata i32 64, metadata !26, metadata !DIExpression()), !dbg !133
  tail call void @llvm.dbg.value(metadata i32 0, metadata !27, metadata !DIExpression()), !dbg !135
  tail call void @llvm.dbg.value(metadata i64 poison, metadata !27, metadata !DIExpression()), !dbg !135
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %1) #7, !dbg !136
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(256) %1, i8 0, i64 256, i1 false), !dbg !137, !DIAssignID !138
  call void @llvm.dbg.assign(metadata i8 0, metadata !127, metadata !DIExpression(), metadata !138, metadata ptr %1, metadata !DIExpression()), !dbg !129
  tail call void @llvm.dbg.value(metadata ptr %1, metadata !76, metadata !DIExpression()), !dbg !139
  tail call void @llvm.dbg.value(metadata i32 60, metadata !77, metadata !DIExpression()), !dbg !139
  tail call void @llvm.dbg.value(metadata i32 0, metadata !78, metadata !DIExpression()), !dbg !141
  br label %2, !dbg !142

2:                                                ; preds = %5, %0
  %3 = phi i64 [ 0, %0 ], [ %8, %5 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !78, metadata !DIExpression()), !dbg !141
  tail call void @llvm.dbg.value(metadata i32 0, metadata !83, metadata !DIExpression()), !dbg !143
  tail call void @llvm.dbg.value(metadata i32 0, metadata !80, metadata !DIExpression()), !dbg !144
  %4 = getelementptr i32, ptr %1, i64 %3, !dbg !145
  br label %10, !dbg !145

5:                                                ; preds = %10
  %6 = load volatile i32, ptr @sink, align 4, !dbg !146, !tbaa !54
  %7 = add nsw i32 %6, %15, !dbg !146
  store volatile i32 %7, ptr @sink, align 4, !dbg !146, !tbaa !54
  %8 = add nuw nsw i64 %3, 1, !dbg !147
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !78, metadata !DIExpression()), !dbg !141
  %9 = icmp eq i64 %8, 60, !dbg !148
  br i1 %9, label %18, label %2, !dbg !142, !llvm.loop !149

10:                                               ; preds = %10, %2
  %11 = phi i64 [ 0, %2 ], [ %16, %10 ]
  %12 = phi i32 [ 0, %2 ], [ %15, %10 ]
  tail call void @llvm.dbg.value(metadata i64 %11, metadata !83, metadata !DIExpression()), !dbg !143
  tail call void @llvm.dbg.value(metadata i32 %12, metadata !80, metadata !DIExpression()), !dbg !144
  %13 = getelementptr i32, ptr %4, i64 %11, !dbg !151
  %14 = load i32, ptr %13, align 4, !dbg !151, !tbaa !54
  %15 = add nsw i32 %14, %12, !dbg !152
  tail call void @llvm.dbg.value(metadata i32 %15, metadata !80, metadata !DIExpression()), !dbg !144
  %16 = add nuw nsw i64 %11, 1, !dbg !153
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !83, metadata !DIExpression()), !dbg !143
  %17 = icmp eq i64 %16, 4, !dbg !154
  br i1 %17, label %5, label %10, !dbg !145, !llvm.loop !155

18:                                               ; preds = %5
  tail call void @llvm.dbg.value(metadata i32 0, metadata !108, metadata !DIExpression()), !dbg !157
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !108, metadata !DIExpression()), !dbg !157
  store volatile i32 784, ptr @sink, align 4, !dbg !159, !tbaa !54
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %1) #7, !dbg !160
  ret i32 0, !dbg !161
}

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.assign(metadata, metadata, metadata, metadata, metadata, metadata) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #6

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nofree norecurse nounwind memory(readwrite, argmem: read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree norecurse nounwind memory(readwrite, argmem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #5 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9, !10, !11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sink", scope: !2, file: !3, line: 10, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/test_nested.c", directory: "/home/adhithi__iyer/loop-advisor", checksumkind: CSK_MD5, checksum: "020c97147aa5e81263fffaae5861753d")
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
!15 = distinct !DISubprogram(name: "matrix_mul", scope: !3, file: !3, line: 15, type: !16, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !22)
!16 = !DISubroutineType(types: !17)
!17 = !{null, !18, !18, !18, !6}
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 2048, elements: !20)
!20 = !{!21}
!21 = !DISubrange(count: 64)
!22 = !{!23, !24, !25, !26, !27, !29, !32, !35}
!23 = !DILocalVariable(name: "a", arg: 1, scope: !15, file: !3, line: 15, type: !18)
!24 = !DILocalVariable(name: "b", arg: 2, scope: !15, file: !3, line: 15, type: !18)
!25 = !DILocalVariable(name: "c", arg: 3, scope: !15, file: !3, line: 15, type: !18)
!26 = !DILocalVariable(name: "n", arg: 4, scope: !15, file: !3, line: 15, type: !6)
!27 = !DILocalVariable(name: "i", scope: !28, file: !3, line: 16, type: !6)
!28 = distinct !DILexicalBlock(scope: !15, file: !3, line: 16, column: 5)
!29 = !DILocalVariable(name: "j", scope: !30, file: !3, line: 17, type: !6)
!30 = distinct !DILexicalBlock(scope: !31, file: !3, line: 17, column: 9)
!31 = distinct !DILexicalBlock(scope: !28, file: !3, line: 16, column: 5)
!32 = !DILocalVariable(name: "acc", scope: !33, file: !3, line: 18, type: !6)
!33 = distinct !DILexicalBlock(scope: !34, file: !3, line: 17, column: 37)
!34 = distinct !DILexicalBlock(scope: !30, file: !3, line: 17, column: 9)
!35 = !DILocalVariable(name: "k", scope: !36, file: !3, line: 19, type: !6)
!36 = distinct !DILexicalBlock(scope: !33, file: !3, line: 19, column: 13)
!37 = !DILocation(line: 0, scope: !15)
!38 = !DILocation(line: 0, scope: !28)
!39 = !DILocation(line: 16, column: 23, scope: !31)
!40 = !DILocation(line: 16, column: 5, scope: !28)
!41 = !DILocation(line: 0, scope: !30)
!42 = !DILocation(line: 17, column: 9, scope: !30)
!43 = !DILocation(line: 23, column: 1, scope: !15)
!44 = !DILocation(line: 0, scope: !36)
!45 = !DILocation(line: 0, scope: !33)
!46 = !DILocation(line: 19, column: 13, scope: !36)
!47 = !DILocation(line: 16, column: 29, scope: !31)
!48 = distinct !{!48, !40, !49, !50, !51}
!49 = !DILocation(line: 22, column: 9, scope: !28)
!50 = !{!"llvm.loop.mustprogress"}
!51 = !{!"llvm.loop.unroll.disable"}
!52 = !DILocation(line: 21, column: 13, scope: !33)
!53 = !DILocation(line: 21, column: 21, scope: !33)
!54 = !{!55, !55, i64 0}
!55 = !{!"int", !56, i64 0}
!56 = !{!"omnipotent char", !57, i64 0}
!57 = !{!"Simple C/C++ TBAA"}
!58 = !DILocation(line: 17, column: 33, scope: !34)
!59 = !DILocation(line: 17, column: 27, scope: !34)
!60 = distinct !{!60, !42, !61, !50, !51}
!61 = !DILocation(line: 22, column: 9, scope: !30)
!62 = !DILocation(line: 20, column: 24, scope: !63)
!63 = distinct !DILexicalBlock(scope: !36, file: !3, line: 19, column: 13)
!64 = !DILocation(line: 20, column: 34, scope: !63)
!65 = !DILocation(line: 20, column: 32, scope: !63)
!66 = !DILocation(line: 20, column: 21, scope: !63)
!67 = !DILocation(line: 19, column: 37, scope: !63)
!68 = !DILocation(line: 19, column: 31, scope: !63)
!69 = distinct !{!69, !46, !70, !50, !51}
!70 = !DILocation(line: 20, column: 40, scope: !36)
!71 = distinct !DISubprogram(name: "unroll_candidate", scope: !3, file: !3, line: 26, type: !72, scopeLine: 26, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !75)
!72 = !DISubroutineType(types: !73)
!73 = !{null, !74, !6}
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!75 = !{!76, !77, !78, !80, !83}
!76 = !DILocalVariable(name: "arr", arg: 1, scope: !71, file: !3, line: 26, type: !74)
!77 = !DILocalVariable(name: "n", arg: 2, scope: !71, file: !3, line: 26, type: !6)
!78 = !DILocalVariable(name: "i", scope: !79, file: !3, line: 27, type: !6)
!79 = distinct !DILexicalBlock(scope: !71, file: !3, line: 27, column: 5)
!80 = !DILocalVariable(name: "sub", scope: !81, file: !3, line: 28, type: !6)
!81 = distinct !DILexicalBlock(scope: !82, file: !3, line: 27, column: 33)
!82 = distinct !DILexicalBlock(scope: !79, file: !3, line: 27, column: 5)
!83 = !DILocalVariable(name: "j", scope: !84, file: !3, line: 29, type: !6)
!84 = distinct !DILexicalBlock(scope: !81, file: !3, line: 29, column: 9)
!85 = !DILocation(line: 0, scope: !71)
!86 = !DILocation(line: 0, scope: !79)
!87 = !DILocation(line: 27, column: 23, scope: !82)
!88 = !DILocation(line: 27, column: 5, scope: !79)
!89 = !DILocation(line: 0, scope: !84)
!90 = !DILocation(line: 0, scope: !81)
!91 = !DILocation(line: 29, column: 9, scope: !84)
!92 = !DILocation(line: 33, column: 1, scope: !71)
!93 = !DILocation(line: 31, column: 14, scope: !81)
!94 = !DILocation(line: 27, column: 29, scope: !82)
!95 = distinct !{!95, !88, !96, !50, !51}
!96 = !DILocation(line: 32, column: 5, scope: !79)
!97 = !DILocation(line: 30, column: 20, scope: !98)
!98 = distinct !DILexicalBlock(scope: !84, file: !3, line: 29, column: 9)
!99 = !DILocation(line: 30, column: 17, scope: !98)
!100 = !DILocation(line: 29, column: 33, scope: !98)
!101 = !DILocation(line: 29, column: 27, scope: !98)
!102 = distinct !{!102, !91, !103, !50, !51}
!103 = !DILocation(line: 30, column: 29, scope: !84)
!104 = distinct !DISubprogram(name: "double_fixed", scope: !3, file: !3, line: 36, type: !105, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !107)
!105 = !DISubroutineType(types: !106)
!106 = !{null}
!107 = !{!108, !109, !111}
!108 = !DILocalVariable(name: "sum", scope: !104, file: !3, line: 37, type: !6)
!109 = !DILocalVariable(name: "i", scope: !110, file: !3, line: 38, type: !6)
!110 = distinct !DILexicalBlock(scope: !104, file: !3, line: 38, column: 5)
!111 = !DILocalVariable(name: "j", scope: !112, file: !3, line: 39, type: !6)
!112 = distinct !DILexicalBlock(scope: !113, file: !3, line: 39, column: 9)
!113 = distinct !DILexicalBlock(scope: !110, file: !3, line: 38, column: 5)
!114 = !DILocation(line: 0, scope: !104)
!115 = !DILocation(line: 0, scope: !110)
!116 = !DILocation(line: 41, column: 10, scope: !104)
!117 = !DILocation(line: 42, column: 1, scope: !104)
!118 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 44, type: !119, scopeLine: 44, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !121)
!119 = !DISubroutineType(types: !120)
!120 = !{!6}
!121 = !{!122, !125, !126, !127}
!122 = !DILocalVariable(name: "a", scope: !118, file: !3, line: 45, type: !123)
!123 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 131072, elements: !124)
!124 = !{!21, !21}
!125 = !DILocalVariable(name: "b", scope: !118, file: !3, line: 45, type: !123)
!126 = !DILocalVariable(name: "c", scope: !118, file: !3, line: 45, type: !123)
!127 = !DILocalVariable(name: "arr", scope: !118, file: !3, line: 47, type: !19)
!128 = distinct !DIAssignID()
!129 = !DILocation(line: 0, scope: !118)
!130 = distinct !DIAssignID()
!131 = distinct !DIAssignID()
!132 = distinct !DIAssignID()
!133 = !DILocation(line: 0, scope: !15, inlinedAt: !134)
!134 = distinct !DILocation(line: 46, column: 5, scope: !118)
!135 = !DILocation(line: 0, scope: !28, inlinedAt: !134)
!136 = !DILocation(line: 47, column: 5, scope: !118)
!137 = !DILocation(line: 47, column: 9, scope: !118)
!138 = distinct !DIAssignID()
!139 = !DILocation(line: 0, scope: !71, inlinedAt: !140)
!140 = distinct !DILocation(line: 48, column: 5, scope: !118)
!141 = !DILocation(line: 0, scope: !79, inlinedAt: !140)
!142 = !DILocation(line: 27, column: 5, scope: !79, inlinedAt: !140)
!143 = !DILocation(line: 0, scope: !84, inlinedAt: !140)
!144 = !DILocation(line: 0, scope: !81, inlinedAt: !140)
!145 = !DILocation(line: 29, column: 9, scope: !84, inlinedAt: !140)
!146 = !DILocation(line: 31, column: 14, scope: !81, inlinedAt: !140)
!147 = !DILocation(line: 27, column: 29, scope: !82, inlinedAt: !140)
!148 = !DILocation(line: 27, column: 23, scope: !82, inlinedAt: !140)
!149 = distinct !{!149, !142, !150, !50, !51}
!150 = !DILocation(line: 32, column: 5, scope: !79, inlinedAt: !140)
!151 = !DILocation(line: 30, column: 20, scope: !98, inlinedAt: !140)
!152 = !DILocation(line: 30, column: 17, scope: !98, inlinedAt: !140)
!153 = !DILocation(line: 29, column: 33, scope: !98, inlinedAt: !140)
!154 = !DILocation(line: 29, column: 27, scope: !98, inlinedAt: !140)
!155 = distinct !{!155, !145, !156, !50, !51}
!156 = !DILocation(line: 30, column: 29, scope: !84, inlinedAt: !140)
!157 = !DILocation(line: 0, scope: !104, inlinedAt: !158)
!158 = distinct !DILocation(line: 49, column: 5, scope: !118)
!159 = !DILocation(line: 41, column: 10, scope: !104, inlinedAt: !158)
!160 = !DILocation(line: 51, column: 1, scope: !118)
!161 = !DILocation(line: 50, column: 5, scope: !118)
