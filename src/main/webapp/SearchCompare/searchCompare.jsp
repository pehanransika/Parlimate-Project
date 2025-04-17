<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 4/17/2025
  Time: 7:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Search & Compare</title>

  <link rel="stylesheet" href="searchCompare.css" />
  <link href="http://localhost:8080/Parlimate/index/sidebar1.css" rel="stylesheet" />
  <link href="http://localhost:8080/Parlimate/index/header/header.css" rel="stylesheet" />

  <link
          rel="stylesheet"
          href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"
          data-purpose="Layout StyleSheet"
          title="Web Awesome"
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
<body>

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container">
  <div class="pageTitles">
    <h2 class="title">Fundraisers</h2>
    <div class="subTitle">
      Fueling Change Through Collective Action
    </div>
  </div>
  <div class="scContainer">
    <table>
      <tr>
        <td>
          <select
                  name="role"
                  id="roleSelect"
                  class="roleType caps"
          >
            <option value="politician">politician</option>
            <option value="political-party">
              <i class="fa-solid fa-landmark"></i
              >political party
            </option>
          </select>
        </td>
        <td class="column-head f-col">
          <div class="content f-col">
            <div class="search">
              <input
                      type="text"
                      name="col1-search"
                      placeholder="Mahinda Rajapaksha"
                      class="search-2"
                      id="col1-search"
                      autocomplete="off"
              />
              <div
                      class="suggestions-dropdown"
                      id="suggestions"
              ></div>
              <label for="col1-search">
                <i
                        class="fa-regular fa-magnifying-glass"
                ></i>
              </label>
            </div>
            <div class="image"></div>
            <div class="name-shown">
              Ms. Anjali Karunaratne
            </div>
          </div>
        </td>
        <td class="column-head f-col">
          <div class="content f-col">
            <div class="search">
              <input
                      type="text"
                      name="col2-search"
                      placeholder="Mahinda Rajapaksha"
                      class="search-2"
                      id="col2-search"
                      autocomplete="off"
              />

              <label for="col2-search">
                <i
                        class="fa-regular fa-magnifying-glass"
                ></i>
              </label>
            </div>
            <div class="image"></div>
            <div class="name-shown">
              Dr. Niroshan Wijegunawardena
            </div>
          </div>
        </td>
      </tr>
      <tr style="border: 0">
        <td colspan="3">
          <div class="select-attributes f-row">
            <input
                    type="radio"
                    name="select-attr"
                    id="all-attr"
                    checked
            />
            <label for="all-attr">All</label>
            <input
                    type="radio"
                    name="select-attr"
                    id="gen-info-attr"
            />
            <label for="gen-info-attr"
            >General Information</label
            >
            <input
                    type="radio"
                    name="select-attr"
                    id="key-attr"
            />
            <label for="key-attr">Key Policies</label>
            <input
                    type="radio"
                    name="select-attr"
                    id="edu-attr"
            />
            <label for="edu-attr">Education</label>
          </div>
        </td>
      </tr>
      <!-- from here we will update details :) -->
      <div class="gen-inf detail-section">
        <tr class="detail-begin row-title">
          <td colspan="3">
            <div class="details-title">
              General Information
            </div>
          </td>
        </tr>
        <tr>
          <td class="row-head">party</td>
          <td>Progressive Party</td>
          <td>Conservation alliance</td>
        </tr>
        <tr>
          <td class="row-head">age</td>
          <td>38</td>
          <td>45</td>
        </tr>
        <tr>
          <td class="row-head">Position</td>
          <td>Senetor</td>
          <td>governor</td>
        </tr>
        <tr>
          <td class="row-head">Profession before politics</td>
          <td>Teacher</td>
          <td>lecturer</td>
        </tr>
        <tr>
          <td class="row-head">Years in politics</td>
          <td>8</td>
          <td>13</td>
        </tr>
        <tr>
          <td class="row-head">Constituency</td>
          <td>colombo central</td>
          <td>Kandy south</td>
        </tr>
        <tr>
          <td class="row-head">rank on the platform</td>
          <td>300</td>
          <td>256</td>
        </tr>
      </div>
      <div class="key-pol detail-section">
        <tr class="row-title">
          <td colspan="3">
            <div class="details-title">key policies</div>
          </td>
        </tr>
        <tr>
          <td class="row-head">Economic Policy</td>
          <td>Raise minimum wage, tax the rich</td>
          <td>-</td>
        </tr>
        <tr>
          <td class="row-head">healthcare</td>
          <td>Universal healthcare</td>
          <td>Private market-based healthcare</td>
        </tr>
        <tr>
          <td class="row-head">Climate Policy</td>
          <td>100% renewables by 2040</td>
          <td>Support oil & gas, carbon capture</td>
        </tr>
        <tr>
          <td class="row-head">Education</td>
          <td>Free public college</td>
          <td>School choice & vocational ed</td>
        </tr>
        <tr>
          <td class="row-head">Notable Quotes</td>
          <td>“Healthcare is a human right.”</td>
          <td>“Freedom begins with less gov’t.”</td>
        </tr>
        <tr>
          <td class="row-head">Immigration</td>
          <td>-</td>
          <td>Stricter border control</td>
        </tr>
      </div>
    </table>
  </div>
</div>
</body>

<script src="http://localhost:8080/Parlimate/script.js"></script>

<script>
  // Sample politician data (replace with your actual data source)
  const politicians = [
    {
      name: "Mahinda Rajapaksa",
      party: "SLPP",
    },
    { name: "Ranil Wickremesinghe", party: "UNP" },
    { name: "Sajith Premadasa", party: "SJB" },
    {
      name: "Anura Kumara Dissanayake",
      party: "JVP",
    },
    {
      name: "Maithripala Sirisena",
      party: "SLFP",
    },
    {
      name: "Chandrika Kumaratunga",
      party: "SLFP",
    },
    { name: "Dullas Alahapperuma", party: "SLPP" },
    {
      name: "Patali Champika Ranawaka",
      party: "SJB",
    },
    { name: "Wimal Weerawansa", party: "NPP" },
    { name: "Udaya Gammanpila", party: "SLPP" },
    { name: "Rosy Senanayake", party: "UNP" },
    { name: "Harin Fernando", party: "SJB" },
  ];

  const searchInput = document.getElementById("col1-search");
  const suggestionsContainer = document.getElementById("suggestions");

  searchInput.addEventListener("input", function () {
    const searchTerm = this.value.toLowerCase();
    suggestionsContainer.innerHTML = "";

    if (searchTerm.length < 1) {
      suggestionsContainer.style.display = "none";
      return;
    }

    const filteredPoliticians = politicians.filter(
            (politician) =>
                    politician.name.toLowerCase().includes(searchTerm) ||
                    politician.party.toLowerCase().includes(searchTerm)
    );

    if (filteredPoliticians.length > 0) {
      filteredPoliticians.forEach((politician) => {
        const suggestionItem = document.createElement("div");
        suggestionItem.className = "suggestion-item";
        suggestionItem.innerHTML = `
      <img src="https://i.pravatar.cc/50" alt="${politician.name}">
      <div>
        <div class="politician-name">${politician.name}</div>
        <div class="politician-party">${politician.party}</div>
      </div>
    `;
        suggestionItem.addEventListener("click", () => {
          searchInput.value = politician.name;
          suggestionsContainer.style.display = "none";
          // You can trigger search or selection action here
        });
        suggestionsContainer.appendChild(suggestionItem);
      });
      suggestionsContainer.style.display = "block";
    } else {
      suggestionsContainer.style.display = "none";
    }
  });

  // Close suggestions when clicking outside
  document.addEventListener("click", function (e) {
    if (
            !searchInput.contains(e.target) &&
            !suggestionsContainer.contains(e.target)
    ) {
      suggestionsContainer.style.display = "none";
    }
  });
</script>

<body>

</body>
</html>
