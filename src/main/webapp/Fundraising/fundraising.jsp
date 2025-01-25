<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundraisers</title>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="fundraising.css" rel="stylesheet">
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./fund-popup.css" />

    <link
            rel="stylesheet"
            data-purpose="Layout StyleSheet"
            title="Web Awesome"
            href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"
    />

</head>
<body class="">

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>
<form action="CreateRequestServlet" method="post" class="popup-f" id="popup-f" enctype="multipart/form-data">
    <div class="bg"></div>
    <div class="fund-popup col">
        <div class="head row">
            <div class="close-btn">
                <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="icon">
                <i class="fa-regular fa-briefcase"></i>
            </div>
            <div class="title">Request a fundraise</div>
            <div class="separator"></div>
        </div>
        <div class="body col">
            <div class="fund-title field">
                <label for="fundtitle" class="title">Title</label>
                <input type="text" required placeholder="Fundraise for the senior care house" name="title" id="fundtitle">
            </div>
            <input type="hidden" name="userid" id="useri" value="${user.userId}" />
            <input type="hidden" name="username" id="usernam" value="${userProfile.name}" />
            <div class="fund-decs field">
                <label for="fund-desc" class="title">Description</label>
                <textarea required name="description" placeholder="Every elderly person deserves a life filled with dignity, care, and comfort..." id="fund-desc"></textarea>
            </div>
            <div class="multi-fields row">
                <div class="fund-cat field">
                    <label for="fund-categ" class="title">Category</label>
                    <select required name="category" id="fund-categ">
                        <option value="educational">Educational</option>
                        <option value="social">Social</option>
                        <option value="community-se">Community Service</option>
                    </select>
                </div>
                <div class="fund-amount field col">
                    <label class="title" for="fund-amount">Fund Target</label>
                    <div class="content row">
                        <div class="curr">
                            <select required name="currency" id="fund-currency">
                                <option value="lkr">LKR</option>
                                <option value="usd">USD</option>
                            </select>
                        </div>
                        <div class="amount">
                            <input required type="number" name="targetamount" step="1000" id="fund-amount" placeholder="1,000,000.00">
                        </div>
                    </div>
                </div>
            </div>

            <div class="fund-attach field">
                <span for="" class="title">Upload Attachments</span>
                <div class="att-container">
                    <div class="action row">
                        <label for="fund-att" class="att-btn">Select File</label>
                        <input type="file" name="attachmentUrl" id="fund-att" multiple>
                        <div class="sep"></div>
                    </div>
                    <div class="att-content">
                        <span class="no-of-files">No file attached</span>
                        <ul id="att-list" class="col">
                            <!-- uploaded files will be listed here -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="bottom row">
            <button class="cancel-btn form-btn">Cancel</button>
            <button type="submit" class="submit-btn form-btn row">
                <i class="fa-duotone fa-solid fa-check"></i>
                Publish
            </button>
        </div>
    </div>
</form>

<div class="container">
    <div class="fundraisers-container">
        <div id="fundraisers" class="section">
            <div class="pageTitles">
                <h2 class="title">Fundraisers</h2>
                <div class="subTitle">
                    Fueling Change Through Collective Action
                </div>
            </div>
            <div class="fund-btns row">
                <a href="GetAllRequestServlet">
                <button class="my-funds row">
                    <i class="fa-solid fa-wallet"></i>
                    <span>
                        my fundraises
                    </span>
                </button>
                </a>
                <button class="req-funds row">
                    <i class="fa-sharp fa-solid fa-plus"></i>
                    <span>
                        Request fundraise
                    </span>
                </button>
            </div>

            <div class="funds-container row">
                <div class="fund col">
                    <div class="top col">
                        <div class="head row">
                            <div class="title">Bringing Clean Water Access to Morawewa</div>
                            <div class="location row">
                                <i class="fa-sharp fa-light fa-location-dot fa-fw"></i>
                                Trincomalee
                            </div>
                        </div>
                        <div class="organizer">Organized by <span>John Silva</span></div>
                        <div class="category">Social</div>
                    </div>
                    <div class="content col">
                        <div class="imgs row">
                            <div class="img"></div>
                            <div class="img"></div>
                        </div>
                        <div class="desc">
                            Millions of people in rural Sri Lanka lack access to clean drinking water, leading to serious health issues. This fundraiser aims to install a sustainable water purification system in morawewa benefiting over 500 families. The funds will cover the cost of equipment, installation, and initial maintenance for one year.
                        </div>
                        <div class="donations row">
                            LKR
                            <div class="raised">
                                152,876
                            </div>
                            <div class="target">
                                200,000
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <div class="donation-progress row">
                            <div class="seperator top"></div>
                            <div class="percentage row">
                                <div class="icon">
                                    <i class="fa-light fa-sack-dollar"></i>
                                </div>
                                <div succ class="progress col">
                                    <div class="numeric row">
                                        76%
                                        <span>completed</span>
                                    </div>
                                    <div class="graphical">
                                        <div class="bg-bar">
                                            <div class="success-bar" style="width: 76%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="contributions row">
                                <div class="icon">
                                    <i class="fa-solid fa-users"></i>
                                </div>
                                <div class="text row">
                                    <span>764</span> people have contributed
                                </div>
                            </div>
                            <div class="seperator bottom"></div>
                        </div>
                        <div class="donate-btn">
                            <i class="fa-sharp fa-solid fa-dollar-sign"></i>
                            <span>Donate</span>
                        </div>
                    </div>
                </div>
                <div class="fund col">
                    <div class="top col">
                        <div class="head row">
                            <div class="title">Rebuild Hope: Homes for Flood-Affected Families in Ratnapura</div>
                            <div class="location row">
                                <i class="fa-sharp fa-light fa-location-dot fa-fw"></i>
                                Ratnapura
                            </div>
                        </div>
                        <div class="organizer">Organized by <span>Siri Sena</span></div>
                        <div class="category">Community</div>
                    </div>
                    <div class="content col">
                        <div class="imgs row">
                            <div class="img"></div>
                            <div class="img"></div>
                        </div>
                        <div class="desc">
                            Recent floods in the Ratnapura District have left hundreds of families homeless. This fundraiser aims to provide immediate shelter and rebuild homes for 10 affected families. The funds will cover construction materials, labor, and basic household essentials.
                        </div>
                        <div class="donations row">
                            LKR
                            <div class="raised">
                                502,661
                            </div>
                            <div class="target">
                                3,000,000
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <div class="donation-progress row">
                            <div class="seperator top"></div>
                            <div class="percentage row">
                                <div class="icon">
                                    <i class="fa-light fa-sack-dollar"></i>
                                </div>
                                <div succ class="progress col">
                                    <div class="numeric row">
                                        16%
                                        <span>completed</span>
                                    </div>
                                    <div class="graphical">
                                        <div class="bg-bar">
                                            <div class="success-bar" style="width: 16%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="contributions row">
                                <div class="icon">
                                    <i class="fa-solid fa-users"></i>
                                </div>
                                <div class="text row">
                                    <span>224</span> people have contributed
                                </div>
                            </div>
                            <div class="seperator bottom"></div>
                        </div>
                        <div class="donate-btn">
                            <i class="fa-sharp fa-solid fa-dollar-sign"></i>
                            <span>Donate</span>
                        </div>
                    </div>
                </div>
                <div class="fund col">
                    <div class="top col">
                        <div class="head row">
                            <div class="title">Lighting Up Lives: Solar Power for Rural Schools in Monaragala</div>
                            <div class="location row">
                                <i class="fa-sharp fa-light fa-location-dot fa-fw"></i>
                                Monaragala
                            </div>
                        </div>
                        <div class="organizer">Organized by <span>Sudewa rathnapala</span></div>
                        <div class="category">Social</div>
                    </div>
                    <div class="content col">
                        <div class="imgs row">
                            <div class="img"></div>
                            <div class="img"></div>
                        </div>
                        <div class="desc">
                            Many rural schools in Monaragala lack consistent electricity, affecting the quality of education. This project will install solar panels in 5 schools, ensuring students have access to electricity for uninterrupted learning and development
                        </div>
                        <div class="donations row">
                            LKR
                            <div class="raised">
                                600,000
                            </div>
                            <div class="target">
                                1,500,000
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <div class="donation-progress row">
                            <div class="seperator top"></div>
                            <div class="percentage row">
                                <div class="icon">
                                    <i class="fa-light fa-sack-dollar"></i>
                                </div>
                                <div succ class="progress col">
                                    <div class="numeric row">
                                        40%
                                        <span>completed</span>
                                    </div>
                                    <div class="graphical">
                                        <div class="bg-bar">
                                            <div class="success-bar" style="width: 40%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="contributions row">
                                <div class="icon">
                                    <i class="fa-solid fa-users"></i>
                                </div>
                                <div class="text row">
                                    <span>398</span> people have contributed
                                </div>
                            </div>
                            <div class="seperator bottom"></div>
                        </div>
                        <div class="donate-btn">
                            <i class="fa-sharp fa-solid fa-dollar-sign"></i>
                            <span>Donate</span>
                        </div>
                    </div>
                </div>
                <div class="fund col">
                    <div class="top col">
                        <div class="head row">
                            <div class="title">Healing Together: Mental Health Support for War-Affected Communities in Jaffna</div>
                            <div class="location row">
                                <i class="fa-sharp fa-light fa-location-dot fa-fw"></i>
                                jaffna
                            </div>
                        </div>
                        <div class="organizer">Organized by <span>Ruvin Udesh</span></div>
                        <div class="category">Social</div>
                    </div>
                    <div class="content col">
                        <div class="imgs row">
                            <div class="img"></div>
                            <div class="img"></div>
                        </div>
                        <div class="desc">
                            Decades after the civil war, many communities in Jaffna still struggle with trauma. This fundraiser supports mental health initiatives, including counseling sessions, workshops, and training local mental health professionals.
                        </div>
                        <div class="donations row">
                            LKR
                            <div class="raised">
                                322,876
                            </div>
                            <div class="target">
                                2,000,000
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <div class="donation-progress row">
                            <div class="seperator top"></div>
                            <div class="percentage row">
                                <div class="icon">
                                    <i class="fa-light fa-sack-dollar"></i>
                                </div>
                                <div succ class="progress col">
                                    <div class="numeric row">
                                        12%
                                        <span>completed</span>
                                    </div>
                                    <div class="graphical">
                                        <div class="bg-bar">
                                            <div class="success-bar" style="width: 12%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="contributions row">
                                <div class="icon">
                                    <i class="fa-solid fa-users"></i>
                                </div>
                                <div class="text row">
                                    <span>300</span> people have contributed
                                </div>
                            </div>
                            <div class="seperator bottom"></div>
                        </div>
                        <div class="donate-btn">
                            <i class="fa-sharp fa-solid fa-dollar-sign"></i>
                            <span>Donate</span>
                        </div>
                    </div>
                </div>
                <div class="fund col">
                    <div class="top col">
                        <div class="head row">
                            <div class="title">Bringing Clean Water Access to Morawewa</div>
                            <div class="location row">
                                <i class="fa-sharp fa-light fa-location-dot fa-fw"></i>
                                Trincomalee
                            </div>
                        </div>
                        <div class="organizer">Organized by <span>John Silva</span></div>
                        <div class="category">Social</div>
                    </div>
                    <div class="content col">
                        <div class="imgs row">
                            <div class="img"></div>
                            <div class="img"></div>
                        </div>
                        <div class="desc">
                            Millions of people in rural Sri Lanka lack access to clean drinking water, leading to serious health issues. This fundraiser aims to install a sustainable water purification system in morawewa benefiting over 500 families. The funds will cover the cost of equipment, installation, and initial maintenance for one year.
                        </div>
                        <div class="donations row">
                            LKR
                            <div class="raised">
                                152,876
                            </div>
                            <div class="target">
                                200,000
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <div class="donation-progress row">
                            <div class="seperator top"></div>
                            <div class="percentage row">
                                <div class="icon">
                                    <i class="fa-light fa-sack-dollar"></i>
                                </div>
                                <div succ class="progress col">
                                    <div class="numeric row">
                                        76%
                                        <span>completed</span>
                                    </div>
                                    <div class="graphical">
                                        <div class="bg-bar">
                                            <div class="success-bar" style="width: 76%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="contributions row">
                                <div class="icon">
                                    <i class="fa-solid fa-users"></i>
                                </div>
                                <div class="text row">
                                    <span>569</span> people have contributed
                                </div>
                            </div>
                            <div class="seperator bottom"></div>
                        </div>
                        <div class="donate-btn">
                            <i class="fa-sharp fa-solid fa-dollar-sign"></i>
                            <span>Donate</span>
                        </div>
                    </div>
                </div>
                <div class="fund col">
                    <div class="top col">
                        <div class="head row">
                            <div class="title">Rebuild Hope: Homes for Flood-Affected Families in Ratnapura</div>
                            <div class="location row">
                                <i class="fa-sharp fa-light fa-location-dot fa-fw"></i>
                                Ratnapura
                            </div>
                        </div>
                        <div class="organizer">Organized by <span>Siri Sena</span></div>
                        <div class="category">Community</div>
                    </div>
                    <div class="content col">
                        <div class="imgs row">
                            <div class="img"></div>
                            <div class="img"></div>
                        </div>
                        <div class="desc">
                            Recent floods in the Ratnapura District have left hundreds of families homeless. This fundraiser aims to provide immediate shelter and rebuild homes for 10 affected families. The funds will cover construction materials, labor, and basic household essentials.
                        </div>
                        <div class="donations row">
                            LKR
                            <div class="raised">
                                502,661
                            </div>
                            <div class="target">
                                3,000,000
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <div class="donation-progress row">
                            <div class="seperator top"></div>
                            <div class="percentage row">
                                <div class="icon">
                                    <i class="fa-light fa-sack-dollar"></i>
                                </div>
                                <div succ class="progress col">
                                    <div class="numeric row">
                                        16%
                                        <span>completed</span>
                                    </div>
                                    <div class="graphical">
                                        <div class="bg-bar">
                                            <div class="success-bar" style="width: 16%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="contributions row">
                                <div class="icon">
                                    <i class="fa-solid fa-users"></i>
                                </div>
                                <div class="text row">
                                    <span>224</span> people have contributed
                                </div>
                            </div>
                            <div class="seperator bottom"></div>
                        </div>
                        <div class="donate-btn">
                            <i class="fa-sharp fa-solid fa-dollar-sign"></i>
                            <span>Donate</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>
</body>
<script src="../loadSidebar.js"></script>
<script>
    let sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
    const body = document.querySelector("body");
    const navRadios = document.querySelectorAll('input[name="nav"]');

    sideMenuBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
            if (body.classList.contains("sidebar-deactive")) {
                body.classList.remove("sidebar-deactive");
            } else {
                body.classList.add("sidebar-deactive");
            }
        })
    });

    navRadios.forEach(radio => {
        radio.addEventListener('change', (event) => {
            const selectedValue = event.target.value;
            if (selectedValue) {
                window.location.href = selectedValue; // Redirect to the selected page
            }
        })
    });
</script>
<script src="./fund-pop.js"></script>

</html>
