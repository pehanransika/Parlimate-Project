<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<!-- Inside the loop -->
  <c:forEach var="survey" items="${surveys}" varStatus="status">
    <div class="survey-container" id="surveyContainer${status.index}">
      <div class="top f-row">
        <div class="profile f-row">
          <div class="p-img"></div>
          <div class="surv-details f-col">
            <div class="name">${survey.user[0].name}</div>
            <div class="date" data-timestamp="${survey.createdAt}" id="date${status.index}"></div>
          </div>
        </div>
        <script>
          document.addEventListener('DOMContentLoaded', () => {
            const dateElements = document.querySelectorAll('.date');
            dateElements.forEach(el => {
              const timestamp = el.getAttribute('data-timestamp');
              if (!timestamp) return;
              const dateObj = new Date(timestamp);
              const options = {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                hour: 'numeric',
                minute: '2-digit',
                hour12: true,
              };
              el.textContent = dateObj.toLocaleString('en-US', options);
            });
          });
        </script>
        <div style="display: flex;">
          <button id="deleteSurveyBtn${status.index}" style='font-size:12px;background-color:white;'>
            <i class='fas fa-trash' style='font-size:20px'></i>
          </button> &nbsp
          <button id="editSurveyBtn${status.index}" style='font-size:12px;background-color:white;'>
            <i class='fas fa-edit' style='font-size:20px'></i>
          </button> &nbsp
          <button id="viewAnalyticsBtn${status.index}">View Analytics</button> &nbsp
          <button id="share-btn${status.index}" class="f-row">
            Share <i class="fa-solid fa-share"></i>
          </button>
        </div>
        <%@ include file="../Surveys/editSurveypopup.jsp" %>
      </div> <br>
      <div class="survey-topic" style="justify-content: center;font-size: larger;">
        Survey Topic : ${survey.surveyTopic}
      </div> <br>
      <div class="question-slider" id="question-slider${status.index}"></div>
      <div class="nav-buttons">
        <button id="prev-btn${status.index}" class="btn-prev" disabled>Previous</button>
        <button id="next-btn${status.index}" class="btn-next">Next</button>
      </div>
    </div> <br>

    <!-- submit ok Popup HTML and javascript -->
    <div id="popup1" class="popup">
      <div class="popup-content1">
        <p style="font-size: 15px;">Your vote has been successfully recorded.</p> <br>
        <button id="ok-btn">OK</button>
      </div>
    </div>

    <script>
      // Wait until the DOM is fully loaded
      document.addEventListener("DOMContentLoaded", function() {
        // Select the "OK" button and the popup container
        var okBtn = document.getElementById("ok-btn");
        var popup = document.getElementById("popup1");

        // Check if the elements exist before adding event listener
        if (okBtn && popup) {
          okBtn.addEventListener("click", function() {
            // Hide the popup by setting display to 'none'
            popup.style.display = "none";
          });
        }
      });
    </script>


    <!-- Delete Popup HTML and Javascript -->

    <div id="deletepopup" class="popup">
      <div  style="height:150px;width:345px;justify-content: center;display: flex; flex-direction: column; align-items: center;"
            class="popup-content">
        <span class="close-btn" onclick="closeDeletePopup()">&times;</span> <br>

        <p style="font-size: 17px;justify-content: center;">Are you sure to delete this survey?</p> <br>
        <button onclick="deleteSurvey()" id="delete-ok-btn" style="justify-content: center;right:20px;">Delete</button>

      </div>
    </div>

    <script>
      function closeDeletePopup() {
        requestAnimationFrame(() => {
          requestAnimationFrame(() => {
            document.getElementById('deletepopup').classList.remove('show');
          });
        });
        document.body.style.overflow = "hidden";

      }
      function deleteSurvey(){
        requestAnimationFrame(() => {
          requestAnimationFrame(() => {
            document.getElementById('deletepopup').classList.remove('show');
          });
        });
        document.body.style.overflow = "hidden";
      }
    </script>

    <!-- Delete Popup HTML and Javascript End-->


    <%--      survey questions javascripts      --%>

    <script>
      // Define questions for this specific survey
      const questions${status.index} = [
        <c:forEach items="${survey.questions}" var="question" varStatus="qStatus">
        {
          question: "${question.questionText}",
          options: [
            <c:forEach items="${question.answers}" var="answer" varStatus="aStatus">
            {
              text: "${answer.answerText}",
              img: "https://upload.wikimedia.org/wikipedia/commons/2/27/PHP-logo.svg"
            }<c:if test="${!aStatus.last}">,</c:if>
            </c:forEach>
          ],
          votes: [
            <c:forEach items="${question.answers}" var="answer" varStatus="aStatus">
                  ${answer.numberOfVotes}
            <c:if test="${!aStatus.last}">, </c:if>
            </c:forEach>
          ]
        }<c:if test="${!qStatus.last}">, </c:if>
        </c:forEach>
          ];

      // Initialize the survey
      (function() {
        const questionSlider = document.getElementById('question-slider${status.index}');
        const prevBtn = document.getElementById('prev-btn${status.index}');
        const nextBtn = document.getElementById('next-btn${status.index}');
        const deleteBtn = document.getElementById('deleteSurveyBtn${status.index}');
        const editBtn = document.getElementById('editSurveyBtn${status.index}');

        let currentQuestion = 0;
        const selectedAnswers = Array(questions${status.index}.length).fill(null);
        let isTransitioning = false;

        function renderQuestion(index) {
          const q = questions${status.index}[index];
          const totalVotes = q.votes.reduce((a, b) => a + b, 0);
          let html = "<div class=\"question\">" + (index + 1) + ". " + q.question + "</div>";

          q.options.forEach((opt, optIndex) => {
            const percent = totalVotes ? ((q.votes[optIndex] / totalVotes) * 100).toFixed(1) : 0;
            const isSelected = selectedAnswers[index] === optIndex;

            html += '<div class="option ' + (isSelected ? 'selected' : '') + '" style="--percent: ' + percent + '%" onclick="vote' + ${status.index} + '(' + optIndex + ')">' +
                    (opt.img && opt.img !== ''
                            ? '<img src="' + opt.img + '" alt="' + opt.text + '" />'
                            : '') +
                    '<div class="text">' +
                    '<div><strong>' + opt.text + '</strong></div>' +
                    (selectedAnswers[index] != null
                            ? '<small>' + percent + '%</small>'
                            : '') +
                    '</div>' +
                    '</div>';
          });

          return html;
        }

        function showSlide(index, direction) {
          if (isTransitioning) return;
          isTransitioning = true;

          const oldSlide = questionSlider.querySelector('.question-slide');
          if (oldSlide) {
            oldSlide.classList.remove('active');
            oldSlide.classList.add(direction === 1 ? 'exit-to-left' : 'exit-to-right');
            setTimeout(() => oldSlide.remove(), 500);
          }

          const newSlide = document.createElement('div');
          newSlide.classList.add('question-slide');
          newSlide.innerHTML = renderQuestion(index);
          questionSlider.appendChild(newSlide);

          if (direction === 0) {
            newSlide.classList.add('active');
          } else {
            newSlide.classList.add(direction === 1 ? 'enter-from-right' : 'enter-from-left');
            requestAnimationFrame(() => {
              newSlide.classList.remove('enter-from-right', 'enter-from-left');
              newSlide.classList.add('active');
            });
          }

          prevBtn.disabled = index === 0;
          nextBtn.innerHTML = index === questions${status.index}.length - 1 ? "Finish" : "Next";
          nextBtn.className = index === questions${status.index}.length - 1 ? "btn-finish" : "btn-next";

          setTimeout(() => {
            isTransitioning = false;
          }, 500);
        }

        window['vote' + ${status.index}] = function(optIndex) {
          const q = questions${status.index}[currentQuestion];
          const prev = selectedAnswers[currentQuestion];

          if (prev !== null) q.votes[prev]--;
          q.votes[optIndex]++;
          selectedAnswers[currentQuestion] = optIndex;

          const slide = questionSlider.querySelector('.question-slide');
          slide.innerHTML = renderQuestion(currentQuestion);
        };

        prevBtn.addEventListener('click', () => {
          if (currentQuestion > 0) {
            currentQuestion--;
            showSlide(currentQuestion, -1);
          }
        });

        nextBtn.addEventListener('click', () => {
          if (currentQuestion < questions${status.index}.length - 1) {
            currentQuestion++;
            showSlide(currentQuestion, 1);
          } else if (nextBtn.classList.contains('btn-finish')) {
            const popup = document.getElementById('popup1');
            popup.style.display = 'flex';
            popup.classList.add("show");
          }
        });



        deleteBtn.addEventListener('click', () => {
          const deletepopup = document.getElementById('deletepopup');
          deletepopup.style.display = 'flex';
          deletepopup.classList.add("show");
        });

        editBtn.addEventListener('click', () => {
          const editpopup = document.getElementById('editpopup');
          editpopup.style.display = 'flex';
          editpopup.classList.add("show");
        });

        // Popup close functionality
        document.getElementById('ok-btn').addEventListener('click', () => {
          document.getElementById('popup').style.display = 'none';
        });



        // Initial render
        showSlide(currentQuestion, 0);
      })();
    </script>

    <!-- Analytics popup  -->

    <div id="analyticsPopup${status.index}" class="analytics-popup">
      <div class="analytics-popup-content">
        <span id="closePopup${status.index}" class="analytics-close">&times;</span>
        <h2>Analytics</h2>
        <div class="analytics-filters">
          <select id="provinceFilter${status.index}" style="display: none;">
            <option value="All_Island" selected>Select Province</option>
          </select>
          <select id="questionFilter${status.index}">
            <option value="">Select Question</option>
            <c:forEach items="${survey.questions}" var="question" varStatus="qStatus">
              <option value="q${qStatus.index + 1}">${question.questionText}</option>
            </c:forEach>
          </select>
        </div>
        <div class="analytics-chart-container">
          <canvas id="barGraph${status.index}"></canvas>
        </div>
        <div id="voteStats" class="analytics-vote-stats">
          <h3>Vote Statistics</h3>
          <p>Total Votes: <span id="totalVotes${status.index}">0</span></p>
          <ul id="answerVotes${status.index}" class="analytics-answer-votes"></ul>
        </div>
      </div>
    </div>

    <!-- Analytics popup  end -->
    
    <!-- Analytics pop up javascripts -->


    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
      document.addEventListener('DOMContentLoaded', () => {
        const viewAnalyticsBtn = document.getElementById('viewAnalyticsBtn${status.index}');
        const analyticsPopup = document.getElementById('analyticsPopup${status.index}');
        const closePopup = document.getElementById('closePopup${status.index}');
        const provinceFilter = document.getElementById('provinceFilter${status.index}');
        const questionFilter = document.getElementById('questionFilter${status.index}');
        const totalVotesEl = document.getElementById('totalVotes${status.index}');
        const answerVotesEl = document.getElementById('answerVotes${status.index}');

        // Sample data with varying answer counts (1–6)
        const analyticsData = {
          All_Island: {
          <c:forEach items="${survey.questions}" var="question" varStatus="qStatus">
          "q${qStatus.index + 1}": {
            answers: [
              <c:forEach items="${question.answers}" var="answer" varStatus="aStatus">
              '${answer.answerText}'<c:if test="${!aStatus.last}">,</c:if>
              </c:forEach>
            ],
            votes: [
              <c:forEach items="${question.answers}" var="answer" varStatus="aStatus">
              ${answer.numberOfVotes}<c:if test="${!aStatus.last}">,</c:if>
              </c:forEach>
            ],
            totalVotes: <c:set var="totalVotes" value="0" />
            <c:forEach items="${question.answers}" var="answer">
            <c:set var="totalVotes" value="${totalVotes + answer.numberOfVotes}" />
            </c:forEach>
            ${totalVotes},
            percentages: [
              <c:forEach items="${question.answers}" var="answer" varStatus="aStatus">
              <c:choose>
              <c:when test="${totalVotes > 0}">
              <fmt:formatNumber value="${(answer.numberOfVotes / totalVotes) * 100}" pattern="0.0" /><c:if test="${!aStatus.last}">,</c:if>
              </c:when>
              <c:otherwise>
              0<c:if test="${!aStatus.last}">,</c:if>
              </c:otherwise>
              </c:choose>
              </c:forEach>
            ]
          }<c:if test="${!qStatus.last}">,</c:if>
          </c:forEach>}
        };

        // Initialize Chart.js
        const ctx = document.getElementById('barGraph${status.index}').getContext('2d');
        let barChart = new Chart(ctx, {
          type: 'bar',
          data: {
            labels: [],
            datasets: [{
              label: 'Percentage',
              data: [],
              backgroundColor: '#8952c5', // Purple
              borderColor: '#000',
              borderWidth: 1
            }]
          },
          options: {
            scales: {
              y: {
                beginAtZero: true,
                max: 100,
                title: {
                  display: true,
                  text: 'Percentage (%)',
                  color: '#000',
                  font: {family: 'Poppins', size: 14}
                },
                ticks: {color: '#000', font: {family: 'Poppins'}},
                grid: {color: '#ccc'}
              },
              x: {
                title: {
                  display: true,
                  text: 'Answers',
                  color: '#000',
                  font: {family: 'Poppins', size: 14}
                },
                ticks: {
                  color: '#000',
                  font: {family: 'Poppins'},
                  maxRotation: 45,
                  minRotation: 0,
                  autoSkip: false
                },
                grid: { display: false }
              }
            },
            plugins: {
              legend: {
                labels: {
                  color: '#000',
                  font: { family: 'Poppins' }
                }
              }
            },
            responsive: true,
            maintainAspectRatio: false,
            barPercentage: 0.9,
            categoryPercentage: 0.95
          }
        });

        // Open popup
        viewAnalyticsBtn.addEventListener('click', () => {
          analyticsPopup.style.display = "flex";
          requestAnimationFrame(() => {
            requestAnimationFrame(() => {
              analyticsPopup.classList.add("show");
            });
          });
          document.body.style.overflow = "hidden";
          updateAnalytics();
        });

        // Close popup
        closePopup.addEventListener('click', () => {
          analyticsPopup.classList.remove("show");
          setTimeout(() => {
            analyticsPopup.style.display = "none";
            location.reload();
          }, 300);
          document.body.style.overflow = "auto";
          analyticsPopup.style.display = 'none';
        });

        // Update analytics on filter change
        provinceFilter.addEventListener('change', updateAnalytics);
        questionFilter.addEventListener('change', updateAnalytics);

        function updateAnalytics() {
          const province = provinceFilter.value;
          const question = questionFilter.value;

          if (!province || !question || !analyticsData[province] || !analyticsData[province][question]) {
            barChart.data.labels = [];
            barChart.data.datasets[0].data = [];
            totalVotesEl.textContent = '0';
            answerVotesEl.innerHTML = '';
            barChart.update();
            return;
          }

          const data = analyticsData[province][question];
          barChart.data.labels = data.answers;
          barChart.data.datasets[0].data = data.percentages;

          // Adjust bar thickness based on number of answers
          const numAnswers = data.answers.length;
          barChart.options.barPercentage = numAnswers === 1 ? 0.4 : numAnswers === 2 ? 0.45 : 0.9 / numAnswers;
          barChart.options.categoryPercentage = numAnswers === 1 ? 0.5 : numAnswers === 2 ? 0.8 : 0.95;

          barChart.update();

          totalVotesEl.textContent = data.totalVotes;
          answerVotesEl.innerHTML = data.answers.map((answer, index) =>
                  "<li>" + answer + ": " + data.votes[index] + " votes</li>"
          ).join('');
        }
      });
    </script>

  </c:forEach>
