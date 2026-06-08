# /review — 코드 리뷰

현재 변경된 파일 또는 지정한 파일을 리뷰하고 개선점을 제안합니다.

## 실행 절차

1. `git diff` 또는 지정 파일을 읽어 변경 내용 파악
2. 다음 관점에서 검토:
   - 버그 가능성 (null safety, 비동기 처리, 예외 처리)
   - Flutter/Dart 컨벤션 준수 여부
   - 성능 (불필요한 rebuild, 메모리 누수)
   - 보안 (API 키 노출, 민감 데이터 처리)
3. 심각도(높음/중간/낮음)와 함께 개선 제안 제공

## 사용 예시

```
/review                          # 현재 git diff 기준 리뷰
/review lib/features/ai/         # 특정 디렉토리 리뷰
```

## 참고 파일

- `docs/architecture.md` — 아키텍처 설계 문서
- `.planning/01-requirements.md` — 기능 요구사항
