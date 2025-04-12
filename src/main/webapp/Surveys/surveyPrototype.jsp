<div class="survey-container">
  <div class="top f-row">
    <div class="profile f-row">
      <div class="p-img"></div>
      <div class="surv-details f-col">
        <div class="name">Manuja ransara</div>
        <div class="date">April 1</div>
      </div>
    </div>
    <div style="display: flex;">
      <button id="viewAnalyticsBtn">View Analytics</button>&nbsp;
      <button id="share-btn" class="f-row">
        Share  &nbsp; <i class="fa-solid fa-share"></i>
      </button>
    </div>


  </div> <br>
  <div class="survey-topic" style="justify-content: center;font-size: larger;">
    Survey Topic&nbsp;:&nbsp;Communism or capitalism,which was most most bad in history
  </div> <br>
  <div class="question-slider" id="question-slider"></div>
  <div class="nav-buttons">
    <button id="prev-btn" class="btn-prev" disabled>Previous</button>
    <button id="next-btn" class="btn-next">Next</button>
  </div>
</div>

<!-- submit ok Popup HTML -->
<div id="popup" class="popup">
  <div class="popup-content1">
    <p style="font-size: 15px;">Your vote has been successfully recorded.</p> <br>
    <button id="ok-btn">OK</button>
  </div>
</div>

<!-- Analytics popup -->
<div id="analyticsPopup" class="analytics-popup">
  <div class="analytics-popup-content">
    <span id="closePopup" class="analytics-close">&times;</span>
    <h2>Analytics</h2>
    <div class="analytics-filters">
      <select id="provinceFilter">
        <option value="">Select Province</option>
        <option value="ontario">Ontario</option>
        <option value="quebec">Quebec</option>
        <option value="bc">British Columbia</option>
      </select>
      <select id="questionFilter">
        <option value="">Select Question</option>
        <option value="q1">Question 1: Satisfaction Level</option>
        <option value="q2">Question 2: Service Quality</option>
        <option value="q3">Question 3: Recommendation</option>
      </select>
    </div>
    <div class="analytics-chart-container">
      <canvas id="barGraph"></canvas>
    </div>
    <div id="voteStats" class="analytics-vote-stats">
      <h3>Vote Statistics</h3>
      <p>Total Votes: <span id="totalVotes">0</span></p>
      <ul id="answerVotes" class="analytics-answer-votes"></ul>
    </div>
  </div>
</div>

<!-- question javascripts -->

<script>
  const questions = [
    {
      question: "What is your favorite frontend framework?",
      options: [
        { text: "React", img: "https://upload.wikimedia.org/wikipedia/commons/a/a7/React-icon.svg" },
        { text: "Vue", img: "https://upload.wikimedia.org/wikipedia/commons/9/95/Vue.js_Logo_2.svg" },
        { text: "Angular", img: "https://upload.wikimedia.org/wikipedia/commons/c/cf/Angular_full_color_logo.svg" },
        { text: "Svelte", img: "https://upload.wikimedia.org/wikipedia/commons/1/1b/Svelte_Logo.svg" }
      ],
      votes: [10, 5, 3, 2]
    },
    {
      question: "Which backend language do you prefer?",
      options: [
        { text: "Node.js", img: "https://upload.wikimedia.org/wikipedia/commons/d/d9/Node.js_logo.svg" },
        { text: "Python", img: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Python-logo-notext.svg" },
        { text: "Java", img: "https://upload.wikimedia.org/wikipedia/en/3/30/Java_programming_language_logo.svg" },
        { text: "PHP", img: "https://upload.wikimedia.org/wikipedia/commons/2/27/PHP-logo.svg" }
      ],
      votes: [7, 8, 4, 1]
    }
  ];

  let currentQuestion = 0;
  const selectedAnswers = Array(questions.length).fill(null);
  const questionSlider = document.getElementById('question-slider');
  const prevBtn = document.getElementById('prev-btn');
  const nextBtn = document.getElementById('next-btn');
  let isTransitioning = false;

  function renderQuestion(index) {
    const q = questions[index];
    const totalVotes = q.votes.reduce((a, b) => a + b, 0);
    let html = "<div class=\"question\">" + (index + 1) + ". " + q.question + "</div>";

    q.options.forEach((opt, optIndex) => {
      const percent = totalVotes ? ((q.votes[optIndex] / totalVotes) * 100).toFixed(1) : 0;
      const isSelected = selectedAnswers[index] === optIndex;

      html +=  '<div class="option ' + (isSelected ? 'selected' : '') + '" style="--percent: ' + percent + '%" onclick="vote(' + optIndex + ')">' +
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

    // For initial render, make it active immediately
    if (direction === 0) {
      newSlide.classList.add('active');
    } else {
      newSlide.classList.add(direction === 1 ? 'enter-from-right' : 'enter-from-left');
      requestAnimationFrame(() => {
        newSlide.classList.remove('enter-from-right', 'enter-from-left');
        newSlide.classList.add('active');
      });
    }

    // Update navigation buttons
    prevBtn.disabled = index === 0;
    nextBtn.innerHTML = index === questions.length - 1 ? "Finish" : "Next";
    nextBtn.className = index === questions.length - 1 ? "btn-finish" : "btn-next";

    setTimeout(() => {
      isTransitioning = false;
    }, 500);
  }

  function vote(optIndex) {
    const q = questions[currentQuestion];
    const prev = selectedAnswers[currentQuestion];

    if (prev !== null) q.votes[prev]--;
    q.votes[optIndex]++;
    selectedAnswers[currentQuestion] = optIndex;

    const slide = questionSlider.querySelector('.question-slide');
    slide.innerHTML = renderQuestion(currentQuestion);
  }

  prevBtn.addEventListener('click', () => {
    if (currentQuestion > 0) {
      currentQuestion--;
      showSlide(currentQuestion, -1);
    }
  });

  nextBtn.addEventListener('click', () => {
    if (currentQuestion < questions.length - 1) {
      currentQuestion++;
      showSlide(currentQuestion, 1);
    } else if (nextBtn.classList.contains('btn-finish')) {
      console.log("manua");
      const popupup = document.getElementById('popup');
      popupup.style.display = 'flex';
      popupup.classList.add("show");

    }
  });

  // Popup close functionality
  document.getElementById('ok-btn').addEventListener('click', () => {
    document.getElementById('popup').style.display = 'none';
  });

  document.getElementById('popup').addEventListener('click', (e) => {
    if (e.target === document.getElementById('popup')) {
      document.getElementById('popup').style.display = 'none';
    }
  });

  // Initial render
  showSlide(currentQuestion, 0);
</script>


<!-- analytics pop up javascripts -->


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', () => {
    const viewAnalyticsBtn = document.getElementById('viewAnalyticsBtn');
    const popup = document.getElementById('analyticsPopup');
    const closePopup = document.getElementById('closePopup');
    const provinceFilter = document.getElementById('provinceFilter');
    const questionFilter = document.getElementById('questionFilter');
    const totalVotesEl = document.getElementById('totalVotes');
    const answerVotesEl = document.getElementById('answerVotes');

    // Sample data with varying answer counts (1–6)
    const analyticsData = {
      ontario: {
        q1: {
          answers: ['Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied'],
          percentages: [40, 30, 20, 10],
          votes: [400, 300, 200, 100],
          totalVotes: 1000
        },
        q2: {
          answers: ['Excellent', 'Good'],
          percentages: [60, 40],
          votes: [600, 400],
          totalVotes: 1000
        },
        q3: {
          answers: ['1', '2', '3', '4', '5', '6'],
          percentages: [20, 20, 20, 20, 10, 10],
          votes: [200, 200, 200, 200, 100, 100],
          totalVotes: 1000
        }
      },
      quebec: {
        q1: {
          answers: ['Very Satisfied', 'Satisfied', 'Neutral'],
          percentages: [50, 30, 20],
          votes: [500, 300, 200],
          totalVotes: 1000
        },
        q2: {
          answers: ['Yes'],
          percentages: [100],
          votes: [1000],
          totalVotes: 900
        }
      },
      bc: {
        q3: {
          answers: ['Strongly Agree', 'Agree', 'Disagree'],
          percentages: [50, 30, 20],
          votes: [500, 300, 200],
          totalVotes: 1000
        }
      }
    };

    // Initialize Chart.js
    const ctx = document.getElementById('barGraph').getContext('2d');
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
              font: { family: 'Poppins', size: 14 }
            },
            ticks: { color: '#000', font: { family: 'Poppins' } },
            grid: { color: '#ccc' }
          },
          x: {
            title: {
              display: true,
              text: 'Answers',
              color: '#000',
              font: { family: 'Poppins', size: 14 }
            },
            ticks: {
              color: '#000',
              font: { family: 'Poppins' },
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
      popup.style.display = "flex";
      requestAnimationFrame(() => {
        requestAnimationFrame(() => {
          popup.classList.add("show");
        });
      });
      document.body.style.overflow = "hidden";
      updateAnalytics();
    });

    // Close popup
    closePopup.addEventListener('click', () => {
      popup.classList.remove("show");
      setTimeout(() => {
        popup.style.display = "none";
        location.reload();
      }, 300);
      document.body.style.overflow = "auto";
      popup.style.display = 'none';
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

