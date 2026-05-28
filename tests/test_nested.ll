; ModuleID = '/home/adhithi__iyer/loop-advisor/tests/test_nested.c'
source_filename = "/home/adhithi__iyer/loop-advisor/tests/test_nested.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sink = dso_local global i32 0, align 4, !dbg !0

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @matrix_mul(ptr nocapture noundef readonly %0, ptr nocapture noundef readonly %1, ptr nocapture noundef writeonly %2, i32 noundef %3) local_unnamed_addr #0 !dbg !16 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !24, metadata !DIExpression()), !dbg !38
  tail call void @llvm.dbg.value(metadata ptr %1, metadata !25, metadata !DIExpression()), !dbg !38
  tail call void @llvm.dbg.value(metadata ptr %2, metadata !26, metadata !DIExpression()), !dbg !38
  tail call void @llvm.dbg.value(metadata i32 %3, metadata !27, metadata !DIExpression()), !dbg !38
  tail call void @llvm.dbg.value(metadata i32 0, metadata !28, metadata !DIExpression()), !dbg !39
  %5 = icmp sgt i32 %3, 0, !dbg !40
  br i1 %5, label %6, label %12, !dbg !41

6:                                                ; preds = %4
  %7 = zext nneg i32 %3 to i64, !dbg !40
  %8 = zext nneg i32 %3 to i64
  %9 = zext nneg i32 %3 to i64
  br label %10, !dbg !41

10:                                               ; preds = %6, %15
  %11 = phi i64 [ 0, %6 ], [ %16, %15 ]
  tail call void @llvm.dbg.value(metadata i64 %11, metadata !28, metadata !DIExpression()), !dbg !39
  tail call void @llvm.dbg.value(metadata i32 0, metadata !30, metadata !DIExpression()), !dbg !42
  br label %13, !dbg !43

12:                                               ; preds = %15, %4
  ret void, !dbg !44

13:                                               ; preds = %10, %18
  %14 = phi i64 [ 0, %10 ], [ %20, %18 ]
  tail call void @llvm.dbg.value(metadata i64 %14, metadata !30, metadata !DIExpression()), !dbg !42
  tail call void @llvm.dbg.value(metadata i32 0, metadata !36, metadata !DIExpression()), !dbg !45
  tail call void @llvm.dbg.value(metadata i32 0, metadata !33, metadata !DIExpression()), !dbg !46
  br label %22, !dbg !47

15:                                               ; preds = %18
  %16 = add nuw nsw i64 %11, 1, !dbg !48
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !28, metadata !DIExpression()), !dbg !39
  %17 = icmp eq i64 %16, %7, !dbg !40
  br i1 %17, label %12, label %10, !dbg !41, !llvm.loop !49

18:                                               ; preds = %22
  %19 = getelementptr inbounds [64 x i32], ptr %2, i64 %11, i64 %14, !dbg !53
  store i32 %30, ptr %19, align 4, !dbg !54, !tbaa !55
  %20 = add nuw nsw i64 %14, 1, !dbg !59
  tail call void @llvm.dbg.value(metadata i64 %20, metadata !30, metadata !DIExpression()), !dbg !42
  %21 = icmp eq i64 %20, %8, !dbg !60
  br i1 %21, label %15, label %13, !dbg !43, !llvm.loop !61

22:                                               ; preds = %13, %22
  %23 = phi i64 [ 0, %13 ], [ %31, %22 ]
  %24 = phi i32 [ 0, %13 ], [ %30, %22 ]
  tail call void @llvm.dbg.value(metadata i64 %23, metadata !36, metadata !DIExpression()), !dbg !45
  tail call void @llvm.dbg.value(metadata i32 %24, metadata !33, metadata !DIExpression()), !dbg !46
  %25 = getelementptr inbounds [64 x i32], ptr %0, i64 %11, i64 %23, !dbg !63
  %26 = load i32, ptr %25, align 4, !dbg !63, !tbaa !55
  %27 = getelementptr inbounds [64 x i32], ptr %1, i64 %23, i64 %14, !dbg !65
  %28 = load i32, ptr %27, align 4, !dbg !65, !tbaa !55
  %29 = mul nsw i32 %28, %26, !dbg !66
  %30 = add nsw i32 %29, %24, !dbg !67
  tail call void @llvm.dbg.value(metadata i32 %30, metadata !33, metadata !DIExpression()), !dbg !46
  %31 = add nuw nsw i64 %23, 1, !dbg !68
  tail call void @llvm.dbg.value(metadata i64 %31, metadata !36, metadata !DIExpression()), !dbg !45
  %32 = icmp eq i64 %31, %9, !dbg !69
  br i1 %32, label %18, label %22, !dbg !47, !llvm.loop !70
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: read) uwtable
define dso_local void @unroll_candidate(ptr nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #2 !dbg !72 {
  tail call void @llvm.dbg.value(metadata ptr %0, metadata !77, metadata !DIExpression()), !dbg !86
  tail call void @llvm.dbg.value(metadata i32 %1, metadata !78, metadata !DIExpression()), !dbg !86
  tail call void @llvm.dbg.value(metadata i32 0, metadata !79, metadata !DIExpression()), !dbg !87
  %3 = icmp sgt i32 %1, 0, !dbg !88
  br i1 %3, label %4, label %9, !dbg !89

4:                                                ; preds = %2
  %5 = zext nneg i32 %1 to i64, !dbg !88
  br label %6, !dbg !89

6:                                                ; preds = %4, %10
  %7 = phi i64 [ 0, %4 ], [ %13, %10 ]
  tail call void @llvm.dbg.value(metadata i64 %7, metadata !79, metadata !DIExpression()), !dbg !87
  tail call void @llvm.dbg.value(metadata i32 0, metadata !84, metadata !DIExpression()), !dbg !90
  tail call void @llvm.dbg.value(metadata i32 0, metadata !81, metadata !DIExpression()), !dbg !91
  %8 = getelementptr i32, ptr %0, i64 %7, !dbg !92
  br label %15, !dbg !92

9:                                                ; preds = %10, %2
  ret void, !dbg !93

10:                                               ; preds = %15
  %11 = load volatile i32, ptr @sink, align 4, !dbg !94, !tbaa !55
  %12 = add nsw i32 %11, %20, !dbg !94
  store volatile i32 %12, ptr @sink, align 4, !dbg !94, !tbaa !55
  %13 = add nuw nsw i64 %7, 1, !dbg !95
  tail call void @llvm.dbg.value(metadata i64 %13, metadata !79, metadata !DIExpression()), !dbg !87
  %14 = icmp eq i64 %13, %5, !dbg !88
  br i1 %14, label %9, label %6, !dbg !89, !llvm.loop !96

15:                                               ; preds = %6, %15
  %16 = phi i64 [ 0, %6 ], [ %21, %15 ]
  %17 = phi i32 [ 0, %6 ], [ %20, %15 ]
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !84, metadata !DIExpression()), !dbg !90
  tail call void @llvm.dbg.value(metadata i32 %17, metadata !81, metadata !DIExpression()), !dbg !91
  %18 = getelementptr i32, ptr %8, i64 %16, !dbg !98
  %19 = load i32, ptr %18, align 4, !dbg !98, !tbaa !55
  %20 = add nsw i32 %19, %17, !dbg !100
  tail call void @llvm.dbg.value(metadata i32 %20, metadata !81, metadata !DIExpression()), !dbg !91
  %21 = add nuw nsw i64 %16, 1, !dbg !101
  tail call void @llvm.dbg.value(metadata i64 %21, metadata !84, metadata !DIExpression()), !dbg !90
  %22 = icmp eq i64 %21, 4, !dbg !102
  br i1 %22, label %10, label %15, !dbg !92, !llvm.loop !103
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local void @double_fixed() local_unnamed_addr #3 !dbg !105 {
  tail call void @llvm.dbg.value(metadata i32 0, metadata !109, metadata !DIExpression()), !dbg !115
  tail call void @llvm.dbg.value(metadata i32 0, metadata !110, metadata !DIExpression()), !dbg !116
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !110, metadata !DIExpression()), !dbg !116
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !109, metadata !DIExpression()), !dbg !115
  store volatile i32 784, ptr @sink, align 4, !dbg !117, !tbaa !55
  ret void, !dbg !118
}

; Function Attrs: nofree norecurse nounwind memory(readwrite, argmem: none) uwtable
define dso_local noundef i32 @main() local_unnamed_addr #3 !dbg !119 {
  call void @llvm.dbg.assign(metadata i1 poison, metadata !123, metadata !DIExpression(), metadata !129, metadata ptr undef, metadata !DIExpression()), !dbg !130
  call void @llvm.dbg.assign(metadata i1 poison, metadata !126, metadata !DIExpression(), metadata !131, metadata ptr undef, metadata !DIExpression()), !dbg !130
  call void @llvm.dbg.assign(metadata i1 poison, metadata !127, metadata !DIExpression(), metadata !132, metadata ptr undef, metadata !DIExpression()), !dbg !130
  %1 = alloca [64 x i32], align 16, !DIAssignID !133
  call void @llvm.dbg.assign(metadata i1 undef, metadata !128, metadata !DIExpression(), metadata !133, metadata ptr %1, metadata !DIExpression()), !dbg !130
  tail call void @llvm.dbg.value(metadata ptr poison, metadata !24, metadata !DIExpression()), !dbg !134
  tail call void @llvm.dbg.value(metadata ptr poison, metadata !25, metadata !DIExpression()), !dbg !134
  tail call void @llvm.dbg.value(metadata ptr poison, metadata !26, metadata !DIExpression()), !dbg !134
  tail call void @llvm.dbg.value(metadata i32 64, metadata !27, metadata !DIExpression()), !dbg !134
  tail call void @llvm.dbg.value(metadata i32 0, metadata !28, metadata !DIExpression()), !dbg !136
  tail call void @llvm.dbg.value(metadata i64 poison, metadata !28, metadata !DIExpression()), !dbg !136
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %1) #7, !dbg !137
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(256) %1, i8 0, i64 256, i1 false), !dbg !138, !DIAssignID !139
  call void @llvm.dbg.assign(metadata i8 0, metadata !128, metadata !DIExpression(), metadata !139, metadata ptr %1, metadata !DIExpression()), !dbg !130
  tail call void @llvm.dbg.value(metadata ptr %1, metadata !77, metadata !DIExpression()), !dbg !140
  tail call void @llvm.dbg.value(metadata i32 60, metadata !78, metadata !DIExpression()), !dbg !140
  tail call void @llvm.dbg.value(metadata i32 0, metadata !79, metadata !DIExpression()), !dbg !142
  br label %2, !dbg !143

2:                                                ; preds = %5, %0
  %3 = phi i64 [ 0, %0 ], [ %8, %5 ]
  tail call void @llvm.dbg.value(metadata i64 %3, metadata !79, metadata !DIExpression()), !dbg !142
  tail call void @llvm.dbg.value(metadata i32 0, metadata !84, metadata !DIExpression()), !dbg !144
  tail call void @llvm.dbg.value(metadata i32 0, metadata !81, metadata !DIExpression()), !dbg !145
  %4 = getelementptr i32, ptr %1, i64 %3, !dbg !146
  br label %10, !dbg !146

5:                                                ; preds = %10
  %6 = load volatile i32, ptr @sink, align 4, !dbg !147, !tbaa !55
  %7 = add nsw i32 %6, %15, !dbg !147
  store volatile i32 %7, ptr @sink, align 4, !dbg !147, !tbaa !55
  %8 = add nuw nsw i64 %3, 1, !dbg !148
  tail call void @llvm.dbg.value(metadata i64 %8, metadata !79, metadata !DIExpression()), !dbg !142
  %9 = icmp eq i64 %8, 60, !dbg !149
  br i1 %9, label %18, label %2, !dbg !143, !llvm.loop !150

10:                                               ; preds = %10, %2
  %11 = phi i64 [ 0, %2 ], [ %16, %10 ]
  %12 = phi i32 [ 0, %2 ], [ %15, %10 ]
  tail call void @llvm.dbg.value(metadata i64 %11, metadata !84, metadata !DIExpression()), !dbg !144
  tail call void @llvm.dbg.value(metadata i32 %12, metadata !81, metadata !DIExpression()), !dbg !145
  %13 = getelementptr i32, ptr %4, i64 %11, !dbg !152
  %14 = load i32, ptr %13, align 4, !dbg !152, !tbaa !55
  %15 = add nsw i32 %14, %12, !dbg !153
  tail call void @llvm.dbg.value(metadata i32 %15, metadata !81, metadata !DIExpression()), !dbg !145
  %16 = add nuw nsw i64 %11, 1, !dbg !154
  tail call void @llvm.dbg.value(metadata i64 %16, metadata !84, metadata !DIExpression()), !dbg !144
  %17 = icmp eq i64 %16, 4, !dbg !155
  br i1 %17, label %5, label %10, !dbg !146, !llvm.loop !156

18:                                               ; preds = %5
  tail call void @llvm.dbg.value(metadata i32 0, metadata !109, metadata !DIExpression()), !dbg !158
  tail call void @llvm.dbg.value(metadata i32 poison, metadata !109, metadata !DIExpression()), !dbg !158
  store volatile i32 784, ptr @sink, align 4, !dbg !160, !tbaa !55
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %1) #7, !dbg !161
  ret i32 0, !dbg !162
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
!llvm.module.flags = !{!8, !9, !10, !11, !12, !13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sink", scope: !2, file: !5, line: 10, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/adhithi__iyer/loop-advisor/tests/test_nested.c", directory: "/home/adhithi__iyer/loop-advisor", checksumkind: CSK_MD5, checksum: "020c97147aa5e81263fffaae5861753d")
!4 = !{!0}
!5 = !DIFile(filename: "tests/test_nested.c", directory: "/home/adhithi__iyer/loop-advisor", checksumkind: CSK_MD5, checksum: "020c97147aa5e81263fffaae5861753d")
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
!16 = distinct !DISubprogram(name: "matrix_mul", scope: !5, file: !5, line: 15, type: !17, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !23)
!17 = !DISubroutineType(types: !18)
!18 = !{null, !19, !19, !19, !7}
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 2048, elements: !21)
!21 = !{!22}
!22 = !DISubrange(count: 64)
!23 = !{!24, !25, !26, !27, !28, !30, !33, !36}
!24 = !DILocalVariable(name: "a", arg: 1, scope: !16, file: !5, line: 15, type: !19)
!25 = !DILocalVariable(name: "b", arg: 2, scope: !16, file: !5, line: 15, type: !19)
!26 = !DILocalVariable(name: "c", arg: 3, scope: !16, file: !5, line: 15, type: !19)
!27 = !DILocalVariable(name: "n", arg: 4, scope: !16, file: !5, line: 15, type: !7)
!28 = !DILocalVariable(name: "i", scope: !29, file: !5, line: 16, type: !7)
!29 = distinct !DILexicalBlock(scope: !16, file: !5, line: 16, column: 5)
!30 = !DILocalVariable(name: "j", scope: !31, file: !5, line: 17, type: !7)
!31 = distinct !DILexicalBlock(scope: !32, file: !5, line: 17, column: 9)
!32 = distinct !DILexicalBlock(scope: !29, file: !5, line: 16, column: 5)
!33 = !DILocalVariable(name: "acc", scope: !34, file: !5, line: 18, type: !7)
!34 = distinct !DILexicalBlock(scope: !35, file: !5, line: 17, column: 37)
!35 = distinct !DILexicalBlock(scope: !31, file: !5, line: 17, column: 9)
!36 = !DILocalVariable(name: "k", scope: !37, file: !5, line: 19, type: !7)
!37 = distinct !DILexicalBlock(scope: !34, file: !5, line: 19, column: 13)
!38 = !DILocation(line: 0, scope: !16)
!39 = !DILocation(line: 0, scope: !29)
!40 = !DILocation(line: 16, column: 23, scope: !32)
!41 = !DILocation(line: 16, column: 5, scope: !29)
!42 = !DILocation(line: 0, scope: !31)
!43 = !DILocation(line: 17, column: 9, scope: !31)
!44 = !DILocation(line: 23, column: 1, scope: !16)
!45 = !DILocation(line: 0, scope: !37)
!46 = !DILocation(line: 0, scope: !34)
!47 = !DILocation(line: 19, column: 13, scope: !37)
!48 = !DILocation(line: 16, column: 29, scope: !32)
!49 = distinct !{!49, !41, !50, !51, !52}
!50 = !DILocation(line: 22, column: 9, scope: !29)
!51 = !{!"llvm.loop.mustprogress"}
!52 = !{!"llvm.loop.unroll.disable"}
!53 = !DILocation(line: 21, column: 13, scope: !34)
!54 = !DILocation(line: 21, column: 21, scope: !34)
!55 = !{!56, !56, i64 0}
!56 = !{!"int", !57, i64 0}
!57 = !{!"omnipotent char", !58, i64 0}
!58 = !{!"Simple C/C++ TBAA"}
!59 = !DILocation(line: 17, column: 33, scope: !35)
!60 = !DILocation(line: 17, column: 27, scope: !35)
!61 = distinct !{!61, !43, !62, !51, !52}
!62 = !DILocation(line: 22, column: 9, scope: !31)
!63 = !DILocation(line: 20, column: 24, scope: !64)
!64 = distinct !DILexicalBlock(scope: !37, file: !5, line: 19, column: 13)
!65 = !DILocation(line: 20, column: 34, scope: !64)
!66 = !DILocation(line: 20, column: 32, scope: !64)
!67 = !DILocation(line: 20, column: 21, scope: !64)
!68 = !DILocation(line: 19, column: 37, scope: !64)
!69 = !DILocation(line: 19, column: 31, scope: !64)
!70 = distinct !{!70, !47, !71, !51, !52}
!71 = !DILocation(line: 20, column: 40, scope: !37)
!72 = distinct !DISubprogram(name: "unroll_candidate", scope: !5, file: !5, line: 26, type: !73, scopeLine: 26, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !76)
!73 = !DISubroutineType(types: !74)
!74 = !{null, !75, !7}
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!76 = !{!77, !78, !79, !81, !84}
!77 = !DILocalVariable(name: "arr", arg: 1, scope: !72, file: !5, line: 26, type: !75)
!78 = !DILocalVariable(name: "n", arg: 2, scope: !72, file: !5, line: 26, type: !7)
!79 = !DILocalVariable(name: "i", scope: !80, file: !5, line: 27, type: !7)
!80 = distinct !DILexicalBlock(scope: !72, file: !5, line: 27, column: 5)
!81 = !DILocalVariable(name: "sub", scope: !82, file: !5, line: 28, type: !7)
!82 = distinct !DILexicalBlock(scope: !83, file: !5, line: 27, column: 33)
!83 = distinct !DILexicalBlock(scope: !80, file: !5, line: 27, column: 5)
!84 = !DILocalVariable(name: "j", scope: !85, file: !5, line: 29, type: !7)
!85 = distinct !DILexicalBlock(scope: !82, file: !5, line: 29, column: 9)
!86 = !DILocation(line: 0, scope: !72)
!87 = !DILocation(line: 0, scope: !80)
!88 = !DILocation(line: 27, column: 23, scope: !83)
!89 = !DILocation(line: 27, column: 5, scope: !80)
!90 = !DILocation(line: 0, scope: !85)
!91 = !DILocation(line: 0, scope: !82)
!92 = !DILocation(line: 29, column: 9, scope: !85)
!93 = !DILocation(line: 33, column: 1, scope: !72)
!94 = !DILocation(line: 31, column: 14, scope: !82)
!95 = !DILocation(line: 27, column: 29, scope: !83)
!96 = distinct !{!96, !89, !97, !51, !52}
!97 = !DILocation(line: 32, column: 5, scope: !80)
!98 = !DILocation(line: 30, column: 20, scope: !99)
!99 = distinct !DILexicalBlock(scope: !85, file: !5, line: 29, column: 9)
!100 = !DILocation(line: 30, column: 17, scope: !99)
!101 = !DILocation(line: 29, column: 33, scope: !99)
!102 = !DILocation(line: 29, column: 27, scope: !99)
!103 = distinct !{!103, !92, !104, !51, !52}
!104 = !DILocation(line: 30, column: 29, scope: !85)
!105 = distinct !DISubprogram(name: "double_fixed", scope: !5, file: !5, line: 36, type: !106, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !108)
!106 = !DISubroutineType(types: !107)
!107 = !{null}
!108 = !{!109, !110, !112}
!109 = !DILocalVariable(name: "sum", scope: !105, file: !5, line: 37, type: !7)
!110 = !DILocalVariable(name: "i", scope: !111, file: !5, line: 38, type: !7)
!111 = distinct !DILexicalBlock(scope: !105, file: !5, line: 38, column: 5)
!112 = !DILocalVariable(name: "j", scope: !113, file: !5, line: 39, type: !7)
!113 = distinct !DILexicalBlock(scope: !114, file: !5, line: 39, column: 9)
!114 = distinct !DILexicalBlock(scope: !111, file: !5, line: 38, column: 5)
!115 = !DILocation(line: 0, scope: !105)
!116 = !DILocation(line: 0, scope: !111)
!117 = !DILocation(line: 41, column: 10, scope: !105)
!118 = !DILocation(line: 42, column: 1, scope: !105)
!119 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 44, type: !120, scopeLine: 44, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !122)
!120 = !DISubroutineType(types: !121)
!121 = !{!7}
!122 = !{!123, !126, !127, !128}
!123 = !DILocalVariable(name: "a", scope: !119, file: !5, line: 45, type: !124)
!124 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 131072, elements: !125)
!125 = !{!22, !22}
!126 = !DILocalVariable(name: "b", scope: !119, file: !5, line: 45, type: !124)
!127 = !DILocalVariable(name: "c", scope: !119, file: !5, line: 45, type: !124)
!128 = !DILocalVariable(name: "arr", scope: !119, file: !5, line: 47, type: !20)
!129 = distinct !DIAssignID()
!130 = !DILocation(line: 0, scope: !119)
!131 = distinct !DIAssignID()
!132 = distinct !DIAssignID()
!133 = distinct !DIAssignID()
!134 = !DILocation(line: 0, scope: !16, inlinedAt: !135)
!135 = distinct !DILocation(line: 46, column: 5, scope: !119)
!136 = !DILocation(line: 0, scope: !29, inlinedAt: !135)
!137 = !DILocation(line: 47, column: 5, scope: !119)
!138 = !DILocation(line: 47, column: 9, scope: !119)
!139 = distinct !DIAssignID()
!140 = !DILocation(line: 0, scope: !72, inlinedAt: !141)
!141 = distinct !DILocation(line: 48, column: 5, scope: !119)
!142 = !DILocation(line: 0, scope: !80, inlinedAt: !141)
!143 = !DILocation(line: 27, column: 5, scope: !80, inlinedAt: !141)
!144 = !DILocation(line: 0, scope: !85, inlinedAt: !141)
!145 = !DILocation(line: 0, scope: !82, inlinedAt: !141)
!146 = !DILocation(line: 29, column: 9, scope: !85, inlinedAt: !141)
!147 = !DILocation(line: 31, column: 14, scope: !82, inlinedAt: !141)
!148 = !DILocation(line: 27, column: 29, scope: !83, inlinedAt: !141)
!149 = !DILocation(line: 27, column: 23, scope: !83, inlinedAt: !141)
!150 = distinct !{!150, !143, !151, !51, !52}
!151 = !DILocation(line: 32, column: 5, scope: !80, inlinedAt: !141)
!152 = !DILocation(line: 30, column: 20, scope: !99, inlinedAt: !141)
!153 = !DILocation(line: 30, column: 17, scope: !99, inlinedAt: !141)
!154 = !DILocation(line: 29, column: 33, scope: !99, inlinedAt: !141)
!155 = !DILocation(line: 29, column: 27, scope: !99, inlinedAt: !141)
!156 = distinct !{!156, !146, !157, !51, !52}
!157 = !DILocation(line: 30, column: 29, scope: !85, inlinedAt: !141)
!158 = !DILocation(line: 0, scope: !105, inlinedAt: !159)
!159 = distinct !DILocation(line: 49, column: 5, scope: !119)
!160 = !DILocation(line: 41, column: 10, scope: !105, inlinedAt: !159)
!161 = !DILocation(line: 51, column: 1, scope: !119)
!162 = !DILocation(line: 50, column: 5, scope: !119)
