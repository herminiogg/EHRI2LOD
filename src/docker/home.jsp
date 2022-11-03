<%@page session="true"%><%@taglib uri="http://www.springframework.org/tags" prefix="sp"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><html version="XHTML+RDFa 1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/xhtml http://www.w3.org/MarkUp/SCHEMA/xhtml-rdfa-2.xsd" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:foaf="http://xmlns.com/foaf/0.1/">
<head data-color="${colorPair}" profile="http://www.w3.org/1999/xhtml/vocab">
<title>${results.getTitle()}&mdash;LodView</title>
<jsp:include page="inc/header.jsp"></jsp:include>
</head>
<body id="top">
	<article>
		<div id="logoBanner">
			<div id="logo"></div>
		</div>
		<header>
			<hgroup>
				<h1>
					<span>Welcome to the EHRI Linked Open Data portal</span>
				</h1>
				<h2></h2>
			</hgroup>
			<div id="abstract">
				<div class="value">You can browse countries, archival institutions and archival holdings as an interconnected graph.</div>
			</div>

		</header>

		<aside class="empty"></aside>

		<div id="directs">

			<div class="value">
                <p>To start browsing the data we give you some hints of countries that you may want to explore:</p>
                <ul id="countriesList">
                    <li><a href="countries/us">United States of America</a></li>
                    <li><a href="countries/il">Israel</a></li>
                    <li><a href="countries/de">Germany</a></li>
                    <li><a href="countries/be">Belgium</a></li>
                    <li><a href="countries/nl">The Netherlands</a></li>
                </ul>
            </div>

		</div>

		<div id="inverses" class="empty"></div> 
		<jsp:include page="inc/custom_footer.jsp"></jsp:include>
	</article>
	<jsp:include page="inc/footer.jsp"></jsp:include>

</body>
</html>
