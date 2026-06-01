# 모르는 영역 질문 목록

> AI Agent가 현재 프로젝트를 분석하여 학습이 필요한 영역을 자동 추출한 목록입니다.
> 해결되면 ✅ 표시 후 답변을 기록하세요.

---

## Flutter / Dart

| # | 질문 | 중요도 | 상태 |
|---|------|--------|------|
| 1 | `StateNotifier`와 `AsyncNotifier`의 차이는? 언제 무엇을 써야 하나? | 높음 | ⬜ |
| 2 | `FutureProvider.autoDispose.family`에서 `autoDispose`가 정확히 언제 실행되나? | 높음 | ⬜ |
| 3 | `context.go()`와 `context.push()`의 차이와 언제 어떤 걸 써야 하나? | 중간 | ⬜ |
| 4 | Flutter에서 `SharedPreferences` 대신 더 복잡한 데이터 저장이 필요하면 어떤 걸 써야 하나? (Hive, Isar, SQLite 비교) | 낮음 | ⬜ |
| 5 | `ConsumerWidget`과 `ConsumerStatefulWidget`의 차이는? | 중간 | ⬜ |

---

## Gemini API / AI

| # | 질문 | 중요도 | 상태 |
|---|------|--------|------|
| 6 | Gemini API 429 오류의 정확한 원인은? 무료 쿼터 한도는 얼마인가? | 높음 | ⬜ |
| 7 | `system_instruction`이 없으면 AI 응답 품질이 얼마나 달라지나? | 중간 | ⬜ |
| 8 | Gemini가 JSON 형식으로 응답을 보장하게 하는 더 좋은 방법이 있나? (responseSchema 등) | 중간 | ⬜ |
| 9 | 프롬프트 엔지니어링에서 Few-shot 예시를 추가하면 감정 분석 정확도가 올라가나? | 낮음 | ⬜ |

---

## 아키텍처 / 설계

| # | 질문 | 중요도 | 상태 |
|---|------|--------|------|
| 10 | Feature-first 구조에서 feature 간 의존성이 생기면 어떻게 처리해야 하나? | 중간 | ⬜ |
| 11 | Riverpod에서 Provider를 너무 많이 만들면 성능 문제가 생기나? | 낮음 | ⬜ |
| 12 | `.env` 파일은 앱 배포(APK/IPA) 시 어떻게 처리되나? 보안 문제는 없나? | 높음 | ⬜ |

---

## 답변 기록

> 질문을 해결하면 여기에 기록합니다.

### Q3 — context.go() vs context.push()
- `go()`: 전체 스택을 교체 (뒤로 가기 불가)
- `push()`: 현재 스택 위에 추가 (뒤로 가기 가능)
- **결론**: 홈→작성은 `push`, 작성→상세(저장 후)는 `pop` + `push` 조합 사용
- **상태**: ✅ 해결
