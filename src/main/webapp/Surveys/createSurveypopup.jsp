
                 <%--            pop up content             --%>

<div id="popup" class="popup">
    <div class="popup-content">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <div class="popup-multi-step">
            <!-- Step 1: Survey Info -->
            <div class="step step-11 active">
                <h2>Create Survey</h2> <br>
                <label>Survey Topic:</label>
                <input type="text" id="survey-topic" placeholder="Enter Topic" class="custom-input"/>
                <label>Number of Questions:</label>
                <input type="number" id="question-count" min="1" max="30" class="custom-input"/> <br><br>
                <button class="next-btn" onclick="goToStep()">Next
                    <i class="fa-solid fa-arrow-right-long"></i>
                </button>
            </div>

            <!-- Step 2: Question Info -->
            <div class="step step-22">
                <h2>Question 1 Details</h2> <br>
                <label>Question:</label>
                <input type="text" id="question-text" placeholder="Enter Question" class="custom-input"/>
                <label>Number of Answers (max 5):</label>
                <input type="number" id="answer-count" min="1" max="5" class="custom-input"/> <br><br>
                <button class="next-btn" onclick="goToStep()">Next
                    <i class="fa-solid fa-arrow-right-long"></i>
                </button>
            </div>

            <!-- Step 3: Answers (Updated to show file name instead of image) -->
            <div class="step step-33">
                <h2>Question 1 Answer 1 Details</h2> <br>
                <label>Answer:</label>
                <input type="text" id="answer-text" placeholder="Enter Answer" class="custom-input"/> <br>
                <label>Image of Answer:</label> <br>
                <label for="answer-image">
                    <input type="file" class="image-upload-inp" name="img_url" id="answer-image" hidden accept="image/png, image/jpg, image/jpeg" />
                    <div class="img-view row">
                        <i class="fa-duotone fa-solid fa-cloud-arrow-up" style="--fa-secondary-color: #a2aec3;"></i>
                        <span id="answer-image-label">Image For Answer</span>
                    </div>
                </label> <br><br>
                <button class="next-btn" onclick="goToStep()">Next
                    <i class="fa-solid fa-arrow-right-long"></i>
                </button>
            </div>

            <!-- Step 4: Success Message -->
            <div class="step step-44">
                <h2 class="success-message">Survey Created Successfully!</h2> <br><br>
                <button class="ok-btn" onclick="closePopup()">OK</button>
            </div>
        </div>
    </div>
</div>
       <%--             pop up content  ends                    --%>

       <!--          JavaScript to handle the popup logic        -->


<script type="text/javascript">
    // State variables
    let surveyData = {
        topic: '',
        questions: []
    };
    let totalQuestions = 0;
    let currentQuestionIndex = 0;
    let currentAnswerIndex = 0;

    // Show a specific step
    function showStep(stepClass) {
        document.querySelectorAll('.step').forEach(function(step) {
            step.classList.remove('active');
        });
        // Adds the 'active' class to the targeted element
        var target = document.querySelector('.' + stepClass);
        if (target) {
            target.classList.add('active');
        } else {
            console.warn("Element with class " + stepClass + " not found.");
        }
    }

    // Update the question title
    function updateQuestionTitle() {
        document.querySelector('.step-22 h2').textContent = "Question " + (currentQuestionIndex + 1) + " Details";
    }

    // Update the answer title and button
    function updateAnswerTitle() {
        document.querySelector('.step-33 h2').textContent =
            "Question " + (currentQuestionIndex + 1) +
            " Answer " + (currentAnswerIndex + 1) +
            " Details";

        const nextBtn = document.querySelector('.step-33 .next-btn');
        const isLastQuestion = currentQuestionIndex + 1 === totalQuestions;
        const isLastAnswer = currentAnswerIndex + 1 === surveyData.questions[currentQuestionIndex].numAnswers;
        if (isLastQuestion && isLastAnswer) {
            nextBtn.innerHTML = 'Finish';
        } else {
            nextBtn.innerHTML = 'Next <i class="fa-solid fa-arrow-right-long"></i>';
        }
    }

    // Clear Step 2 inputs
    function clearQuestionInputs() {
        document.getElementById('question-text').value = '';
        document.getElementById('answer-count').value = '';
    }

    // Clear Step 3 inputs and reset image label
    function clearAnswerInputs() {
        document.getElementById('answer-text').value = '';
        document.getElementById('answer-image').value = '';
        document.getElementById('answer-image-label').textContent = 'Image For Answer';
    }

    // Close the popup and reset state
    function closePopup() {
        const popup = document.getElementById("popup");
        popup.classList.remove("show");
        setTimeout(() => {
            popup.style.display = "none";
            location.reload();
        }, 300);
        document.body.style.overflow = "auto";
        surveyData = { topic: '', questions: [] };
        totalQuestions = 0;
        currentQuestionIndex = 0;
        currentAnswerIndex = 0;
        document.getElementById('survey-topic').value = '';
        document.getElementById('question-count').value = '';
        clearQuestionInputs();
        clearAnswerInputs();
    }

    // Handle navigation and data collection
    function goToStep() {
        const currentStep = document.querySelector('.step.active');

        if (currentStep.classList.contains('step-11')) {
            surveyData.topic = document.getElementById('survey-topic').value;
            totalQuestions = parseInt(document.getElementById('question-count').value, 10);
            if (!surveyData.topic || isNaN(totalQuestions) || totalQuestions < 1 || totalQuestions > 30) {
                alert('Please enter a valid survey topic and number of questions (1-30).');
                return;
            }
            currentQuestionIndex = 0;
            showStep('step-22');
            updateQuestionTitle();
            clearQuestionInputs();

        } else if (currentStep.classList.contains('step-22')) {
            const questionText = document.getElementById('question-text').value;
            const numAnswers = parseInt(document.getElementById('answer-count').value, 10);
            if (!questionText || isNaN(numAnswers) || numAnswers < 1 || numAnswers > 5) {
                alert('Please enter valid question text and number of answers (1-5).');
                return;
            }
            surveyData.questions.push({ text: questionText, numAnswers: numAnswers, answers: [] });
            currentAnswerIndex = 0;
            showStep('step-33');
            updateAnswerTitle();
            clearAnswerInputs();

        } else if (currentStep.classList.contains('step-33')) {
            const answerText = document.getElementById('answer-text').value;
            const answerImage = document.getElementById('answer-image').files[0] || null;
            if (!answerText) {
                alert('Please enter answer text.');
                return;
            }
            surveyData.questions[currentQuestionIndex].answers.push({ text: answerText, image: answerImage });
            currentAnswerIndex++;

            if (currentAnswerIndex < surveyData.questions[currentQuestionIndex].numAnswers) {
                clearAnswerInputs();
                updateAnswerTitle();
            } else {
                currentQuestionIndex++;
                if (currentQuestionIndex < totalQuestions) {
                    showStep('step-22');
                    updateQuestionTitle();
                    clearQuestionInputs();
                } else {
                    showStep('step-44');
                }
            }
        }
    }

    // Open the popup
    document.getElementById('open-popup-btn').addEventListener('click', () => {
        const popup = document.getElementById("popup");
        popup.style.display = "flex";
        requestAnimationFrame(() => {
            requestAnimationFrame(() => {
                popup.classList.add("show");
            });
        });
        document.body.style.overflow = "hidden";
    });

    // Update label with file name when an image is selected
    document.getElementById('answer-image').addEventListener('change', function() {
        const file = this.files[0];
        const label = document.getElementById('answer-image-label');
        if (file && file.type.startsWith('image/')) {
            label.textContent = 'Image Selected: ' + file.name;
        } else {
            label.textContent = 'Image For Answer';
            if (file) {
                alert('Please select an image file.');
                this.value = '';
            }
        }
    });
</script>

    <!--                 JavaScript to handle the popup logic ends               -->


