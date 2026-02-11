<%@ page import="java.util.List, com.silvercare.model.Category" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Service Categories | SilverCare</title>

  <!-- Bootstrap / Icons / Fonts -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

  <style>
    /* Main page styling */
    body { font-family:'Poppins', sans-serif; background:#f9fafb; }
    .category-card{ border:none; background:white; padding:20px; border-radius:14px; box-shadow:0 4px 12px rgba(0,0,0,.08); text-align:center; transition:.3s; }
    .category-card:hover{ transform:translateY(-7px); box-shadow:0 12px 28px rgba(0,0,0,.15); }
    .icon-circle{ width:70px;height:70px;border-radius:50%; display:flex;align-items:center;justify-content:center; background:#e7f1ff;color:#0d6efd;margin:0 auto 15px; }

    .chatbot-launch {
      position: fixed; bottom: 25px; right: 25px;
      width: 70px; height: 70px; border-radius: 50%;
      background: #00796B; color: #fff; font-size: 30px;
      display:flex; align-items:center; justify-content:center;
      cursor:pointer; box-shadow:0 10px 25px rgba(0,0,0,.3);
      z-index:9999; transition:.2s;
    }
    .chatbot-launch:hover { transform:scale(1.12); }
    .chatbot-window {
      position: fixed; bottom:110px; right:25px;
      width:350px; height:440px; background:#fff;
      border-radius:18px; display:none; flex-direction:column;
      box-shadow:0 14px 35px rgba(0,0,0,.35); z-index:99999;
    }
    .chatbot-header { background:#00796B; padding:12px; color:#fff; font-weight:600; display:flex; justify-content:space-between; }
    .chatbot-body { flex:1; padding:12px; overflow-y:auto; display:flex; flex-direction:column; gap:6px; }
    .bot-msg { background:#e8f9f6; align-self:flex-start; padding:10px 15px; border-radius:14px; max-width:85%; }
    .user-msg { background:#dff0ff; align-self:flex-end; padding:10px 15px; border-radius:14px; max-width:85%; }
    .chatbot-options { padding:10px; display:flex; flex-wrap:wrap; gap:7px; justify-content:center; }
    .chatbot-options button{ background:#00796B; border:none; color:#fff; padding:7px 12px; border-radius:12px; cursor:pointer; font-size:13px; }
    .typing-indicator{ align-self:flex-start; background:#e8f9f6; padding:10px 15px; border-radius:14px; display:inline-flex; gap:4px; }
    .typing-dot{ width:7px;height:7px; background:#00796B; border-radius:50%; animation:blink 1.4s infinite; }
    .typing-dot:nth-child(2){ animation-delay:.2s; }
    .typing-dot:nth-child(3){ animation-delay:.4s; }
    @keyframes blink{ 0%{opacity:.2;} 20%{opacity:1;} 100%{opacity:.2;} }
  </style>
</head>

<body>

<!-- Common header -->
<%@ include file="../header_and_footer/header.jsp" %>

<div class="container py-5">
  <h2 class="text-center fw-bold mb-5">Our Service Categories</h2>


  <div class="row g-4">
    <%
      List<Category> catList = (List<Category>) request.getAttribute("categoryList");
      String[] icons = { "bi-heart-pulse-fill", "bi-people-fill", "bi-bandaid-fill", "bi-house-heart-fill" };
      int idx = 0;

      if (catList != null && !catList.isEmpty()) {
        for (Category cat : catList) {
    %>
    <div class="col-md-4">
      <a style="text-decoration:none;color:inherit;" href="<%=request.getContextPath()%>/ServiceController?action=listClient&category_id=<%= cat.getCategoryId() %>">
        <div class="category-card">
          <div class="icon-circle">
            <i class="bi <%= icons[idx++ % icons.length] %> fs-2"></i>
          </div>
          <h5 class="fw-bold"><%= cat.getCategoryName() %></h5>
          <p class="text-muted">Explore available services</p>
        </div>
      </a>
    </div>
    <%
        }
      } else {
    %>
    <div class="col-12 text-center">
      <p class="text-muted">No categories available. Please access this page via Services from the menu.</p>
      <a href="<%=request.getContextPath()%>/ServiceController?action=loadCategories" class="btn btn-outline-primary mt-2">Reload</a>
    </div>
    <%
      }
    %>
  </div>
</div>

<div class="chatbot-launch" id="chatbotLauncher"><i class="fa-solid fa-robot"></i></div>
<div id="chatbotWindow" class="chatbot-window" style="display:none;">
  <div class="chatbot-header">ElderCare Assistant <div id="chatbotClose" style="cursor:pointer;">&times;</div></div>
  <div id="chatArea" class="chatbot-body"></div>

  <!-- Quick options -->
  <div class="chatbot-options">
    <button data-issue="med">Medication</button>
    <button data-issue="walk">Walking Aid</button>
    <button data-issue="hospital">Recovery</button>
    <button data-issue="meal">Meals</button>
  </div>
</div>

<%@ include file="../header_and_footer/footer.html" %>

<script>
const chatbotLauncher = document.getElementById('chatbotLauncher');
const chatbotWindow   = document.getElementById('chatbotWindow');
const chatbotClose    = document.getElementById('chatbotClose');
const chatArea        = document.getElementById('chatArea');
const optionButtons   = document.querySelectorAll('.chatbot-options button');

let started = false; // Only greet once

function showTyping(){
  const wrap = document.createElement('div');
  wrap.classList.add("typing-indicator");
  wrap.id = "typingIndicator";
  wrap.innerHTML = '<span class="typing-dot"></span><span class="typing-dot"></span><span class="typing-dot"></span>';
  chatArea.appendChild(wrap);
  chatArea.scrollTop = chatArea.scrollHeight;
}
function hideTyping(){
  const t = document.getElementById("typingIndicator");
  if(t) t.remove();
}

// Bot bubble
function addBotMessage(txt){
  hideTyping();
  const div = document.createElement('div');
  div.className = 'bot-msg';
  div.innerHTML = txt;
  chatArea.appendChild(div);
  chatArea.scrollTop = chatArea.scrollHeight;
}

function addUserMessage(txt){
  const div = document.createElement('div');
  div.className = 'user-msg';
  div.textContent = txt;
  chatArea.appendChild(div);
  chatArea.scrollTop = chatArea.scrollHeight;
}

chatbotLauncher.addEventListener('click', () => {
  chatbotWindow.style.display = 'flex';
  if(!started){
    started = true;
    showTyping();
    setTimeout(() => {
      addBotMessage("Hello! I'm your ElderCare Assistant. How can I help you find the right service today?");
    }, 800);
  }
});

chatbotClose.addEventListener('click', () => chatbotWindow.style.display = 'none');

optionButtons.forEach(btn => {
  btn.addEventListener('click', () => {
    const issue = btn.dataset.issue;
    addUserMessage(btn.textContent);
    let response = "";
    switch(issue){
      case 'med':
        response = `We recommend our <b>Medication Supervision</b>.<br><br>
                    <a href="<%=request.getContextPath()%>/ServiceController?action=listClient&category_id=1" class="btn btn-sm btn-success">View Nursing</a>`;
        break;
      case 'walk':
        response = `Our <b>Rehabilitation Therapy</b> can assist with mobility.<br><br>
                    <a href="<%=request.getContextPath()%>/ServiceController?action=listClient&category_id=2" class="btn btn-sm btn-success">View Physio</a>`;
        break;
      case 'hospital':
        response = `Need help after discharge? Try our <b>Post-Hospital Care</b>.<br><br>
                    <a href="<%=request.getContextPath()%>/ServiceController?action=listClient&category_id=1" class="btn btn-sm btn-success">View Nursing</a>`;
        break;
      case 'meal':
        response = `Check out our <b>Healthy Meal Plans</b>.<br><br>
                    <a href="<%=request.getContextPath()%>/ServiceController?action=listClient&category_id=3" class="btn btn-sm btn-success">View Meals</a>`;
        break;
    }
    showTyping();
    setTimeout(() => addBotMessage(response), 800);
  });
});
</script>
</body>
</html>
