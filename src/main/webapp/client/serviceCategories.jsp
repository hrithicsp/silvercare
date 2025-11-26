<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Service Categories</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js"></script>

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

  <style>
    body { font-family:'Poppins', sans-serif; background:#f9fafb; }
    .category-card{ border:none; background:white; padding:20px; border-radius:14px; box-shadow:0 4px 12px rgba(0,0,0,.08); text-align:center; transition:.3s; }
    .category-card:hover{ transform:translateY(-7px); box-shadow:0 12px 28px rgba(0,0,0,.15); }
    .icon-circle{ width:70px;height:70px;border-radius:50%; display:flex;align-items:center;justify-content:center; background:#e7f1ff;color:#0d6efd;margin:0 auto 15px; }

    /* ===== CHATBOT ===== */
    .chatbot-launch {
      position: fixed; bottom: 25px; right: 25px;
      width: 70px; height: 70px; border-radius: 50%;
      background: #00796B; color: #fff; font-size: 30px;
      display: flex; align-items: center; justify-content: center;
      cursor: pointer; box-shadow: 0 10px 25px rgba(0,0,0,.3);
      z-index: 9999; transition: .2s;
    }
    .chatbot-launch:hover { transform: scale(1.12); }

    .chatbot-window {
      position: fixed; bottom: 110px; right: 25px;
      width: 350px; height: 440px;
      background: #fff; border-radius: 18px;
      display: flex; flex-direction: column;
      box-shadow: 0 14px 35px rgba(0,0,0,.35);
      z-index: 99999;
    }

    .chatbot-header { background: #00796B; padding: 12px; color: #fff; font-weight: 600; display: flex; justify-content: space-between; }

    .chatbot-body {
      flex: 1; padding: 12px; overflow-y: auto;
      display: flex; flex-direction: column; gap: 6px; min-height: 100px;
    }

    .bot-msg, .user-msg {
      display: inline-block; padding: 10px 15px; border-radius: 14px;
      max-width: 85%; word-wrap: break-word;
    }
    .bot-msg { background: #e8f9f6; align-self: flex-start; }
    .user-msg { background: #dff0ff; align-self: flex-end; }

    .chatbot-options { padding: 10px; display: flex; flex-wrap: wrap; gap: 7px; justify-content: center; }
    .chatbot-options button { background: #00796B; padding: 7px 12px; border: none; color: #fff; border-radius: 12px; cursor: pointer; font-size: 13px; }

    .bot-msg a, .user-msg a { color: #00796B; text-decoration: underline; }

    /* ===== typing animation ===== */
    .typing-indicator {
      align-self: flex-start;
      background: #e8f9f6;
      padding: 10px 15px;
      border-radius: 14px;
      display: inline-flex;
      gap: 4px;
    }

    .typing-dot {
      width: 7px;
      height: 7px;
      background: #00796B;
      border-radius: 50%;
      animation: blink 1.4s infinite;
    }

    .typing-dot:nth-child(2) { animation-delay: 0.2s; }
    .typing-dot:nth-child(3) { animation-delay: 0.4s; }

    @keyframes blink {
      0% { opacity: 0.2; }
      20% { opacity: 1; }
      100% { opacity: 0.2; }
    }
  </style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="container py-5">
  <h2 class="text-center fw-bold mb-5">Our Service Categories</h2>
  <div class="row g-4">
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/silvercare?user=root&password=root&serverTimezone=UTC");
      Statement st = conn.createStatement();
      ResultSet rs = st.executeQuery("SELECT * FROM service_category");

      String[] icons = {"bi-heart-pulse-fill","bi-people-fill","bi-bandaid-fill","bi-house-heart-fill"};
      int idx=0;
      while(rs.next()){
    %>
    <div class="col-md-4">
      <a style="text-decoration:none;color:inherit;" href="services.jsp?category_id=<%=rs.getInt(1)%>">
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
      rs.close(); st.close(); conn.close();
    %>
  </div>
</div>

<!-- ===== CHATBOT LAUNCHER ===== -->
<div class="chatbot-launch" id="chatbotLauncher">
  <i class="fa-solid fa-robot"></i>
</div>

<!-- ===== CHATBOT WINDOW ===== -->
<div id="chatbotWindow" class="chatbot-window" style="display:none;">
  <div class="chatbot-header">
    ElderCare Assistant
    <span id="chatbotClose" style="cursor:pointer;">×</span>
  </div>
  <div id="chatArea" class="chatbot-body"></div>
  <div class="chatbot-options">
    <button data-issue="med">Medication Issues</button>
    <button data-issue="walk">Difficulty Walking</button>
    <button data-issue="hospital">Post-Hospital Recovery</button>
    <button data-issue="meal">Preparing Meals</button>
  </div>
</div>

<%@ include file="../header_and_footer/footer.html" %>


<script>
// ===== CHATBOT LOGIC + TYPING ANIMATION =====
const chatbotLauncher = document.getElementById('chatbotLauncher');
const chatbotWindow = document.getElementById('chatbotWindow');
const chatbotClose = document.getElementById('chatbotClose');
const chatArea = document.getElementById('chatArea');
const optionButtons = document.querySelectorAll('.chatbot-options button');

let started = false;

function showTyping() {
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

function hideTyping() {
  const t = document.getElementById("typingIndicator");
  if (t) t.remove();
}

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
      addBotMessage("Hello there! I'm your ElderCare Assistant.<br><br>I'm here to guide you and suggest the right services based on your needs. Here are some common topics. Please choose a topic below to get started.");
    }, 1000);
  }
});

chatbotClose.addEventListener('click', () => {
  chatbotWindow.style.display = 'none';
});

optionButtons.forEach(btn => {
  btn.addEventListener('click', () => {
    const issue = btn.dataset.issue;
    let response = '';

    switch(issue){
      case 'med':
        addUserMessage("Medication Issues");
        response = `Managing your medications can be tricky. We recommend our <b>Medication Supervision</b> service, under the <b>Home Nursing</b> category, where a trained caregiver ensures that you take your medicines safely and on time. Click on the link below to view all the services in <b>Home Nursing Category</b>.<br><br><a href="services.jsp?category_id=1">View Home Nursing</a>`;
        break;

      case 'walk':
        addUserMessage("Difficulty Walking");
        response = `If walking or moving around has become challenging, our <b>Rehabilitation Therapy</b> service, under the <b>Physiotherapy</b> category, can help. We provide guided exercises and support to improve your mobility and confidence. Click on the link below to view all the services in <b>Physiotherapy Category</b>.<br><br><a href="services.jsp?category_id=2">View Physiotherapy</a>`;
        break;

      case 'hospital':
        addUserMessage("Post-Hospital Recovery");
        response = `After a hospital stay, you may need extra care at home. Our <b>Post-Hospitalisation Care</b> service, under the <b>Home Nursing</b> category, provides personalized support to help you recover safely and comfortably. Click on the link below to view all the services in <b>Home Nursing Category</b>.<br><br><a href="services.jsp?category_id=1">View Home Nursing</a>`;
        break;

      case 'meal':
        addUserMessage("Preparing Meals");
        response = `Healthy meals are important for staying strong. Our <b>Healthy Meal Plan</b> service, under the <b>Meal Delivery</b> category, ensures you get nutritious, tasty meals prepared and delivered, tailored to your dietary needs. Click on the link below to view all the services in <b>Meal Delivery Category</b>.<br><br><a href="services.jsp?category_id=3">View Meal Delivery</a>`;
        break;
    }

    showTyping();
    setTimeout(() => addBotMessage(response), 1000);
  });
});
</script>

</body>
</html>


