<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>

  .share-popup {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }

  .share-popup-content {
    background: white;
    padding: 25px;
    border-radius: 10px;
    width: 90%;
    max-width: 500px;
    position: relative;
  }

  .share-close {
    position: absolute;
    top: 15px;
    right: 20px;
    font-size: 28px;
    cursor: pointer;
    color: #666;
  }

  .share-input-group {
    display: flex;
    gap: 10px;
    margin: 20px 0;
  }

  .share-input-group input {
    flex: 1;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 19px;
  }

  .copy-btn {
    padding: 10px 20px;
    background: #000000;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s;
  }

  .copy-btn:hover {
    background: #080809;
  }

  .copy-status {
    color: rgba(0, 0, 0, 0.82);
    font-size: 14px;
    text-align: center;
    margin-top: 10px;
    height: 20px;
  }
</style>


<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<!-- Inside the loop -->
  <c:forEach var="survey" items="${surveys}" varStatus="status">
    <div class="survey-container" id="surveyContainer${status.index}">
      <div class="top f-row">
        <div class="profile f-row">
          <div class="p-img"></div>
          <div class="surv-details f-col">
            <div class="name">
              <c:choose>
                <c:when test="${survey.user[0].userType == 'Politician' || survey.user[0].userType == 'Citizen' || survey.user[0].userType == 'Political Party'}">
                  ${survey.user[0].name}
                </c:when>
                <c:otherwise>
                  Parlimate
                </c:otherwise>
              </c:choose>

            </div>
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

          <c:if test="${user.userId == survey.user[0].userId}">
            <button id="deleteSurveyBtn${status.index}" style='font-size:12px;background-color:white;'>
              <i class='fas fa-trash' style='font-size:20px'></i>
            </button> &nbsp;

          </c:if>

          <button id="viewAnalyticsBtn${status.index}">View Analytics</button> &nbsp
          <button id="share-btn${status.index}" class="f-row">
            Share <i class="fa-solid fa-share"></i>
          </button>
        </div>

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

      document.addEventListener("DOMContentLoaded", function() {

        var okBtn = document.getElementById("ok-btn");
        var popup = document.getElementById("popup1");


        if (okBtn && popup) {
          okBtn.addEventListener("click", function() {

            window.location.reload();
            popup.style.display = "none";
          });
        }
      });
    </script>




    <div id="sharePopup${status.index}" class="share-popup">
      <div class="share-popup-content">
        <span class="share-close" onclick="closeSharePopup(${status.index})">&times;</span>
        <h3 style="font-size: 19px;">Share Survey</h3> <br>
        <div class="share-input-group">
          <input type="text"
                 id="shareLink${status.index}"
                 value="<%= request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/Surveys/GetUserSurveysServlet?surveyId=${survey.surveyId}"
                 readonly>
          <button onclick="copyShareLink(${status.index})" class="copy-btn">
            <i class='fas fa-copy'></i>
          </button>
        </div>
        <p class="copy-status" id="copyStatus${status.index}"></p>
      </div>
    </div>


    <script>

      function showSharePopup(index) {
        const popup = document.getElementById("sharePopup"+index);
        popup.style.display = 'flex';
        document.getElementById("copyStatus"+index).textContent = '';
      }

      function closeSharePopup(index) {
        document.getElementById("sharePopup"+index).style.display = 'none';
      }

      function copyShareLink(index) {
        const input = document.getElementById("shareLink"+index);
        input.select();
        navigator.clipboard.writeText(input.value)
                .then(() => {
                  const status = document.getElementById("copyStatus"+index);
                  status.textContent = 'Link copied!';
                  setTimeout(() => {
                    status.textContent = '';
                  }, 2000);
                })
                .catch(err => {
                  console.error('Failed to copy:', err);
                  alert('Failed to copy link. Please try again.');
                });
      }

      window.onclick = function(event) {
        const sharePopups = document.querySelectorAll('.share-popup');
        sharePopups.forEach(popup => {
          if (event.target === popup) {
            popup.style.display = 'none';
          }
        });
      };


      document.getElementById("share-btn${status.index}").addEventListener('click', () => {
        showSharePopup(${status.index});
      });
    </script>







    <c:if test="${user.userId == survey.user[0].userId}">
      <div id="deletepopup" class="popup">
        <div  style="height:150px;width:345px;justify-content: center;display: flex; flex-direction: column; align-items: center;"
              class="popup-content">
          <span class="close-btn" onclick="closeDeletePopup()">&times;</span> <br>

          <p style="font-size: 17px;justify-content: center;">Are you sure to delete this survey?</p> <br>
          <button onclick="deleteSurvey(${survey.surveyId})" id="delete-ok-btn" style="justify-content: center;right:20px;">Delete</button>

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
        function deleteSurvey(surveyId) {
          const params = new URLSearchParams();
          params.append('surveyId', surveyId); // Use the passed surveyId

          fetch('<%= request.getContextPath() %>/DeleteSurveyServlet', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
            },
            body: params
          })
                  .then(response => {
                    if (!response.ok) {
                      throw new Error("Server returned " + response.status);
                    }
                    return response.text();
                  })
                  .then(msg => {
                    // On success, reload to reflect changes
                    window.location.reload();
                  })
                  .catch(err => {
                    console.error('Deletion error:', err);
                    alert('Failed to delete survey: ' + err.message);
                  });

          // Close popup and reload
          requestAnimationFrame(() => {
            requestAnimationFrame(() => {
              document.getElementById('deletepopup').classList.remove('show');
              window.location.reload();
            });
          });
          document.body.style.overflow = "hidden";
        }
      </script>

    </c:if>





    <script>

      const questions${status.index} = [
        <c:forEach items="${survey.questions}" var="question" varStatus="qStatus">
        {
          questionId: "${question.questionId}",
          question: "${question.questionText}",
          options: [
            <c:forEach items="${question.answers}" var="answer" varStatus="aStatus">
            {
              answerId: "${answer.answerId}",
              text: "${answer.answerText}",
              img: "${pageContext.request.contextPath}/images/user_${survey.user[0].userId}/user_surveys/${answer.imageUrl}"
            }<c:if test="${!aStatus.last}">,</c:if>
            </c:forEach>
          ],
          votes: [
            <c:forEach items="${question.answers}" var="answer" varStatus="aStatus">
                  ${answer.numberOfVotes}
            <c:if test="${!aStatus.last}">, </c:if>
            </c:forEach>
          ],
          userVote: <c:choose>
                  <c:when test="${not empty question.userVotes}">
                  [${question.userVotes[0].userId},
                    ${question.userVotes[0].answerId}]
                    </c:when>
                    <c:otherwise>
                    "null"
                    </c:otherwise>
                    </c:choose>

        }<c:if test="${!qStatus.last}">, </c:if>
        </c:forEach>
          ];


      (function() {
        const questionSlider = document.getElementById('question-slider${status.index}');
        const prevBtn = document.getElementById('prev-btn${status.index}');
        const nextBtn = document.getElementById('next-btn${status.index}');

        <c:if test="${user.userId == survey.user[0].userId}">
        const deleteBtn = document.getElementById('deleteSurveyBtn${status.index}');
        </c:if>

        let currentQuestion = 0;
        const selectedAnswers = Array(questions${status.index}.length).fill(null);
        let isTransitioning = false;

        function renderQuestion(index) {
          const q = questions${status.index}[index];
          const totalVotes = q.votes.reduce((a, b) => a + b, 0);
          let html = "<div class=\"question\">" + (index + 1) + ". " + q.question + "</div>";
          const userVotedAnswerId = q.userVote && q.userVote[1];

          q.options.forEach((opt, optIndex) => {
            const percent = totalVotes ? ((q.votes[optIndex] / totalVotes) * 100).toFixed(1) : 0;
            let answerIdId = Number(q.options[optIndex].answerId);
            console.log("user vote:", q.userVote[0], ",", q.userVote[1]);
            console.log("answerId", answerIdId);
            console.log("selected answerid:", q.userVote[1]);
            const isSelected = answerIdId === q.userVote[1];
            console.log("isSelected:", isSelected);


            html += '<div class="option ' + (isSelected ? 'selected' : '') + '" style="--percent: ' + percent + '%" onclick="vote' + ${status.index} +'(' + optIndex + ')">' +
                    (opt.img && opt.img !== 'null'
                            ? '<img  src="' + opt.img + '"  />'
                            : '') +
                    '<div class="text">' +
                    '<div><strong>' + opt.text + '</strong></div>' +
                    (selectedAnswers[index] != null || userVotedAnswerId
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

        const userId = ${user.userId != null ? user.userId : 'null'};
        console.log("User ID:", userId);

        const surveyId = ${survey.surveyId};
        console.log("Survey ID:", surveyId);

        window['vote' + ${status.index}] = function (optIndex) {
          console.log("Vote function called for option:", optIndex);
          if (!userId) {
            console.log("User ID is null or undefined");
            alert('Please log in to vote.');
            return;
          }

          const q = questions${status.index}[currentQuestion];
          console.log("Question:", q);
          const answerId = q.options[optIndex].answerId;
          const questionId = q.questionId;
          console.log("Sending vote - Survey ID:", surveyId, "Question ID:", questionId, "Answer ID:", answerId, "User ID:", userId);

          const prev = selectedAnswers[currentQuestion]; // Store the previously selected option
          if (prev !== null) q.votes[prev]--; // Decrease vote count for previous selection
          q.votes[optIndex]++; // Increase vote count for new selection
          selectedAnswers[currentQuestion] = optIndex; // Update the selected answer
          const slide = document.querySelector('#question-slider${status.index} .question-slide');
          slide.innerHTML = renderQuestion(currentQuestion);

          fetch('<%= request.getContextPath() %>/vote', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              survey_id: surveyId,
              question_id: questionId,
              answer_id: answerId,
              user_id: userId
            })
          })
                  .then(response => {
                    console.log("Vote response status:", response.status);
                    if (!response.ok) throw new Error('Network response was not ok');
                    return response.json();
                  })
                  .then(data => {
                    console.log("Vote response data:", data);
                    console.log("user vote:", q.userVote[0], ",", q.userVote[1])
                    if (data.success) {

                      fetch('<%= request.getContextPath() %>/getUserVote?question_id=' + questionId + '&user_id=' + userId)
                              .then(response => response.json())
                              .then(latestAnswerId => {
                                q.userVote = [${user.userId}, latestAnswerId];
                                console.log("new user vote:", q.userVote[1]);
                                console.log("latest answer id:", latestAnswerId)
                                console.log("hello im manuja");

                                fetch('<%= request.getContextPath() %>/getVotes?question_id=' + questionId)
                                        .then(response => {
                                          console.log("GetVotes response status:", response.status);
                                          if (!response.ok) throw new Error('GetVotes response was not ok');
                                          return response.json();
                                        })
                                        .then(votes => {
                                          console.log("Updated votes:", votes);
                                          q.votes = votes;
                                          const slide = document.querySelector('#question-slider${status.index} .question-slide');
                                          slide.innerHTML = renderQuestion(currentQuestion);
                                        })
                                        .catch(error => console.error('Error fetching votes:', error));
                              })
                              .catch(error => console.error('Error fetching user vote:', error));
                    } else {
                      console.log("Vote failed:", data);
                      alert('Failed to record vote');
                      if (prev !== null) q.votes[prev]++;
                      q.votes[optIndex]--;
                      selectedAnswers[currentQuestion] = prev;
                      const slide = document.querySelector('#question-slider${status.index} .question-slide');
                      slide.innerHTML = renderQuestion(currentQuestion);
                    }
                  })
                  .catch(error => {
                    console.error('Error sending vote:', error);
                    if (prev !== null) q.votes[prev]++;
                    q.votes[optIndex]--;
                    selectedAnswers[currentQuestion] = prev;
                    const slide = document.querySelector('#question-slider${status.index} .question-slide');
                    slide.innerHTML = renderQuestion(currentQuestion);
                  });
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

        <c:if test="${user.userId == survey.user[0].userId}">
        deleteBtn.addEventListener('click', () => {
          const deletepopup = document.getElementById('deletepopup');
          deletepopup.style.display = 'flex';
          deletepopup.classList.add("show");
        });


        </c:if>


        document.getElementById('ok-btn').addEventListener('click', () => {
          document.getElementById('popup').style.display = 'none';
        });



        showSlide(currentQuestion, 0);
      })();
    </script>



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
          <p>Total Survey Votes : ${survey.totalVotes}</p>
          <p>Total Question Votes: <span id="totalVotes${status.index}">0</span></p>
          <ul id="answerVotes${status.index}" class="analytics-answer-votes"></ul>
        </div>
      </div>
    </div>


    



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


        const ctx = document.getElementById('barGraph${status.index}').getContext('2d');
        let barChart = new Chart(ctx, {
          type: 'bar',
          data: {
            labels: [],
            datasets: [{
              label: 'Percentage',
              data: [],
              backgroundColor: '#8952c5',
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
