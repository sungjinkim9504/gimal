# /deploy — 발표자료 배포

발표 슬라이드(`index.html`)를 GitHub Pages에 배포하고 URL을 확인합니다.

## 실행 절차

1. `index.html` 현재 상태 확인
2. 변경사항이 있으면 커밋 메시지 작성 후 `git add index.html && git commit`
3. `git push origin master` 로 GitHub Pages 배포
4. `https://sungjinkim9504.github.io/gimal/` 접근 가능 여부 확인

## 사용 예시

```
/deploy
```

## 주의사항

- `.env` 파일은 절대 커밋하지 않음 (`.gitignore` 등록 확인)
- 배포 후 GitHub Pages 반영까지 1~2분 소요
