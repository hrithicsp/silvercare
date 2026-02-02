<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Service Categories</title>

  <!-- Bootstrap / Icons / Fonts -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

  <style>
    /* Main page styling */
    body { font-family:'Poppins', sans-serif; background:#f9fafb; }

    /* Category card styles */
    .category-card{
      border:none; background:white; padding:20px;
      border-radius:14px; box-shadow:0 4px 12px rgba(0,0,0,.08);
      text-align:center; transition:.3s;
    }
    .category-card:hover{
      transform:translateY(-7px);
      box-shadow:0 12px 28px rgba(0,0,0,.15);
    }

    /* Circle icon container */
    .icon-circle{
      width:70px;height:70px;border-radius:50%;
      display:flex;align-items:center;justify-content:center;
      background:#e7f1ff;color:#0d6efd;margin:0 auto 15px;
    }

    /* Chatbot floating button */
    .chatbot-launch {
      position: fixed; bottom: 25px; right: 25px;
      width: 70px; height: 70px; border-radius: 50%;
      background: #00796B; color: #fff; font-size: 30px;
      display:flex; align-items:center; justify-content:center;
      cursor:pointer; box-shadow:0 10px 25px rgba(0,0,0,.3);
      z-index:9999; transition:.2s;
    }
    .chatbot-launch:hover { transform:scale(1.12); }

    /* Chatbot window card */
    .chatbot-window {
      position: fixed; bottom:110px; right:25px;
      width:350px; height:440px; background:#fff;
      border-radius:18px; display:flex; flex-direction:column;
      box-shadow:0 14px 35px rgba(0,0,0,.35);
      z-index:99999;
    }

    /* Chatbot header bar */
    .chatbot-header {
      background:#00796B; padding:12px; color:#fff;
      font-weight:600; display:flex; justify-content:space-between;
    }

    /* Chat messages area */
    .chatbot-body {
      flex:1; padding:12px; overflow-y:auto;
      display:flex; flex-direction:column; gap:6px;
    }

    /* Chat bubbles */
    .bot-msg, .user-msg {
      padding:10px 15px; border-radius:14px; max-width:85%;
      word-wrap:break-word;
    }
    .bot-msg { background:#e8f9f6; align-self:flex-start; }
    .user-msg { background:#dff0ff; align-self:flex-end; }

    /* Quick reply buttons */
    .chatbot-options {
      padding:10px; display:flex; flex-wrap:wrap;
      gap:7px; justify-content:center;
    }
    .chatbot-options button{
      background:#00796B; border:none; color:#fff;
      padding:7px 12px; border-radius:12px; cursor:pointer;
      font-size:13px;
    }

    /* Fake typing animation */
    .typing-indicator{
      align-self:flex-start; background:#e8f9f6;
      padding:10px 15px; border-radius:14px;
      display:inline-flex; gap:4px;
    }
    .typing-dot{
      width:7px;height:7px; background:#00796B;
      border-radius:50%; animation:blink 1.4s infinite;
    }
    .typing-dot:nth-child(2){ animation-delay:.2s; }
    .typing-dot:nth-child(3){ animation-delay:.4s; }

    @keyframes blink{
      0%{opacity:.2;} 20%{opacity:1;} 100%{opacity:.2;}
    }
  </style>
</head>

<body>

<!-- Common header -->
<%@ include file="../header_and_footer/header.jsp" %>

<div class="container py-5">
  <p class="mb-3">
    <a href="<%=request.getContextPath()%>/home.jsp" class="text-primary text-decoration-none">
      <i class="fa-solid fa-arrow-left me-1"></i> Back to Home
    </a>
  </p>
  <h2 class="text-center fw-bold mb-5">Our Service Categories</h2>

  <div class="row g-4">

    <%
      // Load category list from DB
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
      );

      Statement st = conn.createStatement();
      ResultSet rs = st.executeQuery("SELECT * FROM service_category");

      // Icons for each category
      String[] icons = {
        "bi-heart-pulse-fill",
        "bi-people-fill",
        "bi-bandaid-fill",
        "bi-house-heart-fill"
      };

      int idx = 0; // track which icon to use
      while(rs.next()){
    %>

    <div class="col-md-4">
      <!-- Clicking category goes to service listing -->
      <a style="text-decoration:none;color:inherit;"
         href="services.jsp?category_id=<%=rs.getInt(1)%>">
        
        <div class="category-card">
          <div class="icon-circle">
            <i class="bi <%=icons[idx++ % icons.length]%> fs-2"></i>
          </div>
          <h5 class="fw-bold"><%=rs.getString("category_name")%></h5>
          <p class="text-muted">Explore available services</p>
        </div>

      </a>
    </div>

    <%
      }

      // Clean up DB connections
      rs.close();
      st.close();
      conn.close();
    %>

  </div>
</div>

<!-- Chatbot button -->
<div class="chatbot-launch" id="chatbotLauncher">
  <i class="fa-solid fa-robot"></i>
</div>

<!-- Chatbot popup -->
<div id="chatbotWindow" class="chatbot-window" style="display:none;">
  <div class="chatbot-header">
    ElderCare Assistant
    <div id="chatbotClose" style="cursor:pointer;">&times;</div>
  </div>

  <div id="chatArea" class="chatbot-body"></div>

  <!-- Quick options -->
  <div class="chatbot-options">
    <button data-issue="med">Medication Issues</button>
    <button data-issue="walk">Difficulty Walking</button>
    <button data-issue="hospital">Post-Hospital Recovery</button>
    <button data-issue="meal">Preparing Meals</button>
  </div>
</div>

<!-- Common footer -->
<%@ include file="../header_and_footer/footer.html" %>


<script>
// Basic chatbot elements
const chatbotLauncher = document.getElementById('chatbotLauncher');
const chatbotWindow   = document.getElementById('chatbotWindow');
const chatbotClose    = document.getElementById('chatbotClose');
const chatArea        = document.getElementById('chatArea');
const optionButtons   = document.querySelectorAll('.chatbot-options button');

let started = false; // Only greet once

// Adds typing bubble
function showTyping(){
  const wrap = document.createElement('div');
  wrap.classList.add("typing-indicator");
  wrap.id = "typingIndicator";

  wrap.innerHTML = `
    <div class="typing-dot"></div>
    <div class="typing-dot"></div>
    <div class="typing-dot"></div>
  `;

  chatArea.appendChild(wrap);
  chatArea.scrollTop = chatArea.scrollHeight;
}

// Removes typing bubble
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

// User bubble
function addUserMessage(txt){
  const div = document.createElement('div');
  div.className = 'user-msg';
  div.textContent = txt;
  chatArea.appendChild(div);
  chatArea.scrollTop = chatArea.scrollHeight;
}

// Open chatbot window
chatbotLauncher.addEventListener('click', () => {
  chatbotWindow.style.display = 'flex';

  // Only greet once
  if(!started){
    started = true;
    showTyping();

    setTimeout(() => {
      addBotMessage(
        "Hello there! I'm your ElderCare Assistant.<br><br>" +
        "I'm here to help recommend the right services based on your needs.<br>" +
        "Choose any topic below to begin!"
      );
    }, 1000);
  }
});

// Close chatbot
chatbotClose.addEventListener('click', () => {
  chatbotWindow.style.display = 'none';
});

// Handle quick reply buttons
optionButtons.forEach(btn => {
  btn.addEventListener('click', () => {

    const issue = btn.dataset.issue;
    addUserMessage(btn.textContent);

    let response = "";

    // Basic replies depending on the selected issue
    switch(issue){
      case 'med':
        response = `Managing your medications can be tricky. We recommend our <b>Medication Supervision</b> service.<br><br>
                    <a href="services.jsp?category_id=1">View Home Nursing</a>`;
        break;

      case 'walk':
        response = `If moving around is difficult, our <b>Rehabilitation Therapy</b> may help.<br><br>
                    <a href="services.jsp?category_id=2">View Physiotherapy</a>`;
        break;

      case 'hospital':
        response = `For recovery after discharge, you may need our <b>Post-Hospitalisation Care</b>.<br><br>
                    <a href="services.jsp?category_id=1">View Home Nursing</a>`;
        break;

      case 'meal':
        response = `Need meal support? Check out our <b>Healthy Meal Plan</b> options.<br><br>
                    <a href="services.jsp?category_id=3">View Meal Delivery</a>`;
        break;
    }

    // Delay with typing animation for realism
    showTyping();
    setTimeout(() => addBotMessage(response), 1000);
  });
});
</script>

</body>
</html>
