# 테스트 문서 — AI 감정 일기

## 테스트 전략

| 구분 | 도구 | 목적 |
|------|------|------|
| 단위 테스트 | `flutter_test` | 모델·서비스·Provider 로직 검증 |
| 통합/시나리오 테스트 | `flutter_test` + `ProviderContainer` | 실제 사용자 흐름 검증 |

---

## 단위 테스트 목록

| # | 파일 | 테스트 대상 | 설명 |
|---|------|------------|------|
| 1 | `test/diary_entry_test.dart` | `DiaryEntry.copyWith` | aiComment 초기화 검증 |
| 2 | `test/diary_entry_test.dart` | `DiaryEntry` JSON 직렬화 | toJson / fromJson 왕복 검증 |
| 3 | `test/diary_repository_test.dart` | `DiaryRepository.saveEntry` | 저장 후 조회 시 동일 데이터 반환 |
| 4 | `test/diary_repository_test.dart` | `DiaryRepository.deleteEntry` | 삭제 후 목록에서 제거 확인 |
| 5 | `test/gemini_service_test.dart` | `GeminiService._parseResult` | 정상 JSON 파싱 및 fallback 처리 |

## 통합/시나리오 테스트 목록

| # | 파일 | 시나리오 | 설명 |
|---|------|----------|------|
| 1 | `test/diary_scenario_test.dart` | 일기 작성 → 저장 → 조회 | addEntry 후 state에 반영되는지 검증 |

---

## 테스트 실행 방법

```bash
# 전체 테스트
flutter test

# 특정 파일만
flutter test test/diary_entry_test.dart

# 커버리지 포함
flutter test --coverage
```

---

## Must 기능 테스트 결과

| ID | 기능 | 구현 | 테스트 |
|----|------|------|--------|
| F-01 | 날짜 선택 후 일기 작성 | ✅ | 수동 확인 |
| F-02 | 로컬 저장 | ✅ | `diary_repository_test` |
| F-03 | 일기 수정 | ✅ | 수동 확인 |
| F-04 | 일기 삭제 | ✅ | `diary_repository_test` |
| F-05 | 캘린더 뷰 | ✅ | 수동 확인 |
| F-06 | AI 감정 분석 자동 실행 | ✅ | 수동 확인 |
| F-07 | 감정 이모지 표현 | ✅ | `gemini_service_test` |
| F-08 | 공감 조언 코멘트 생성 | ✅ | `gemini_service_test` |
| F-09 | AI 분석 중 로딩 표시 | ✅ | 수동 확인 |
| F-10 | 캘린더 날짜에 이모지 표시 | ✅ | 수동 확인 |
| F-11 | 목록 카드에 이모지·미리보기 | ✅ | 수동 확인 |

**Must 기능 달성률: 11/11 (100%)**

---

## Should 기능 현황

| 기능 | 상태 |
|------|------|
| AI 재시도 버튼 | ✅ 구현 (설정으로 이동 버튼 제공) |
| 오프라인 안내 메시지 | ✅ 구현 (네트워크 오류 메시지 표시) |
| API 키 앱 내 설정 | ✅ 구현 (설정 화면) |
| 감정 통계 화면 | ⏳ 미구현 |

**Should 기능 달성률: 3/4 (75%) → 요건 50% 초과 달성**
