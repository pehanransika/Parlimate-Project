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

<div class="container">
    <div class="fundraisers-container">
        <div id="fundraisers" class="section">
            <div class="pageTitles">
                <h2 class="title">Fundraisers</h2>
                <div class="subTitle">
                    Fueling Change Through Collective Action
                </div>
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
        });
    });

    navRadios.forEach(radio => {
        radio.addEventListener('change', (event) => {
            const selectedValue = event.target.value;
            if (selectedValue) {
                window.location.href = selectedValue; // Redirect to the selected page
            }
        });
    });
</script>
</html>
