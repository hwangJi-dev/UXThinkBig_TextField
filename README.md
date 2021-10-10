<img width=800px height=400px src=https://user-images.githubusercontent.com/63224278/136712623-c81d81dc-18af-41a2-9eb3-2fa46d84695e.png>
<br>

## 💡 UXThinkBig-TextField
> **TextField**  
> 텍스트필드는 사용자의 정보를 입력하기 위해 사용하는 입력 컨트롤이지만 범주화되지 않은 예를 들어) 이름, 아이디, 비밀번호 등과 같은 개인정보를 입력하기 위해 주로 사용된다. 
> 
- 사용자가 정보를 쉽게 입력할 수 있게 하기 위해 슬라이더, 스피너, Date/Time picker(날짜/시간 선택 컨트롤), 컬러 피커 등 입력 컨트롤에 대한 아이디어들이 나와있지만 텍스트 필드 또한 가장 기본적인 입력 컨트롤이다.

-  모바일 사용자는 입력을 최소화하길 원하고, 입력 개수가 많거나 많은 오류를 범하게 될 때 이탈이 발생할 수 있으므로 TextField UI/UX를 구성할 때 신중해야 하며 사용자가 입력하는 행동을 최대한 편안하게 할 수 있도록 유도해야 하고, 입력되는 텍스트를 직관적으로 파악 가능하도록 구성하는 게 중요하다고 생각된다 🙂
<br>
<br>

> **💎 Amondz App** <br>
> Data Entry도 적절히, TextField 요소도 적절하게 UI를 구성한 사례라고 생각하였다.
> 휴대폰 번호를 입력 완료하면 인증번호 필드가 나타나는 애니메이션도 인상깊었고, 
> 다음 뷰에서 텍스트 필드와 Data Entry를 적재적소에 배치한 점이 인상깊었다.
> 
> 범주화 된 날짜를 사용하는 생일 필드는 DatePicker를 사용한 점, 
> 선택지가 2개인 필드는 라디오 버튼을 사용하여 배치한 점, 
> 범주화되지 않은 정보는 TextField를 사용해 사용자의 입력을 유도한 점이 인상깊어서 
> 아몬즈 앱을 채택하게 되었다!
> 
<br>
<br>

> **✨ 구현 방법** <br>
- TextField 영역을 재사용하기 위해 Reusable View 구성에 초점.
- checkbox, timer 분기처리를 통해 확인이 필요한 TextField에서는 checkbox를, 시간 제한이 필요한 TextField에서는 timer를 사용.
- TextField에 커서 이동시 descLabel Animation과 함께 appear

<br>
<br>

> **📺 구현**

<img width=375px src=https://user-images.githubusercontent.com/63224278/136712526-d32adfc4-05a8-4ce8-8c57-fdc27c2137ec.gif>

<br>
