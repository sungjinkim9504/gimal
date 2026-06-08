# /test — 전체 테스트 실행

프로젝트의 모든 Flutter 단위·통합 테스트를 실행하고 결과를 요약합니다.

## 실행 절차

1. `flutter test` 명령으로 `test/` 디렉토리 전체 테스트 실행
2. 실패한 테스트가 있으면 원인 분석 후 수정 방법 제안
3. 결과를 테스트별 통과/실패 목록으로 정리

## 사용 예시

```
/test
```

## 참고 파일

- `test/diary_entry_test.dart` — DiaryEntry 모델 단위 테스트
- `test/gemini_service_test.dart` — Gemini 응답 파싱 단위 테스트
- `test/diary_scenario_test.dart` — 일기 CRUD 시나리오 테스트
- `docs/testing.md` — 테스트 전략 문서
