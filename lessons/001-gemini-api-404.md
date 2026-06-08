# 디버깅 사례 001 — Gemini API 404 오류

**날짜:** 2026-06-08  
**증상:** AI 코멘트 영역에 "네트워크 오류가 발생했습니다. (404)" 표시

---

## 증상

일기 상세 화면에서 AI 코멘트가 생성되지 않고 아래 메시지가 표시됨:

```
네트워크 오류가 발생했습니다. (404)
```

## 원인 분석

### 1단계 — 에러 코드 확인

`GeminiService.analyze()` 의 catch 블록에서 404를 잡아 에러 메시지를 반환.  
404는 HTTP "Not Found" → **API 엔드포인트 URL이 잘못됐거나 모델이 존재하지 않음**.

### 2단계 — 모델명 확인

```dart
// 기존 코드 (문제)
static const _baseUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';
```

`gemini-1.5-flash` 모델이 2026년 기준으로 deprecated되어 404 반환.

### 3단계 — API 키 형식 확인

Google AI Studio 신버전에서 발급한 키는 `AQ.` 로 시작하는 형식.  
기존에 알려진 `AIzaSy...` 형식과 다르지만 **동일하게 유효함**.  
→ 키 자체는 문제 없었음.

## 해결 방법

모델명을 최신 버전으로 변경:

```dart
// 수정 후
static const _baseUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';
```

변경 후 404 → **429(한도 초과)** 로 바뀌어 API 연결 자체는 성공 확인.

## 교훈

1. **404는 키 문제가 아니라 URL/모델명 문제**일 가능성이 높다.
2. Gemini API 모델명은 버전업마다 바뀌므로 [공식 문서](https://ai.google.dev/models)에서 현재 지원 모델을 확인해야 한다.
3. **429(Too Many Requests)가 뜨면 오히려 정상 연결된 것**이다 — 단순 한도 초과.
4. Chrome DevTools Network 탭에서 실제 요청/응답을 확인하면 디버깅이 빠르다.

## 관련 파일

- `lib/features/ai/services/gemini_service.dart` — 모델 URL 정의
- `lib/features/ai/providers/ai_provider.dart` — API 키 로드 로직
- `.env` — API 키 저장
