# 오늘의 컨디션 기록

한국어 모바일용 항암치료 데일리 기록 앱입니다. Vercel에서 정적 화면/API를 제공하고 Supabase Auth와 Postgres에 사용자별 기록을 저장합니다.

## 배포

1. Supabase에서 프로젝트를 만들고 **SQL Editor**에서 `supabase/schema.sql`을 실행합니다. 이 SQL은 로그인한 사용자가 자기 기록만 읽고 수정할 수 있도록 RLS를 켭니다.
2. Supabase **Project Settings → API**에서 Project URL과 publishable/anon 키를 확인합니다. `service_role` 키는 브라우저나 Vercel 환경 변수에 넣지 마세요.
3. Vercel에서 GitHub 저장소 `yujin-kim12/so`를 새 프로젝트로 가져옵니다. Framework Preset은 **Other**, Root Directory는 저장소 루트로 둡니다.
4. Vercel 프로젝트의 **Settings → Environment Variables**에 다음 값을 추가합니다.
   - `SUPABASE_URL`: Supabase Project URL
   - `SUPABASE_ANON_KEY`: Supabase publishable 또는 anon 키
5. **Deployments**에서 최신 커밋을 재배포합니다. 첫 배포 후 Supabase **Authentication → URL Configuration**의 Site URL에 Vercel 도메인을 등록합니다.
6. 배포된 URL을 열고 이메일 계정을 만든 다음 로그인합니다. 이메일 확인을 켜 둔 경우 인증 메일을 먼저 확인하세요.

## 데이터와 개인정보

- 앱 기록은 Supabase 계정별 행에 저장하고, RLS 정책으로 본인 계정만 접근할 수 있게 합니다.
- 현재 브라우저에도 계정별 임시 사본을 둡니다. 로그아웃은 브라우저 사본을 지우지 않으므로 개인 기기에서만 사용하고, 공용 기기에서는 브라우저 데이터를 정리하세요.
- GitHub Pages의 `localStorage`는 다른 도메인인 Vercel에서 자동 이전되지 않습니다. 예전 기록을 옮기려면 기존 브라우저에서 별도로 복사/내보내야 합니다.
- 이 앱은 기록 도구이며 진단이나 치료 조언을 제공하지 않습니다. 의료 관련 안내는 담당 의료진을 따르세요.
