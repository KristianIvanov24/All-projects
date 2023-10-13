<?xml version = "1.0" encoding = "UTF-8"?>
<xsl:stylesheet version = "1.0" 
	xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo = "http://www.w3.org/1999/XSL/Format">
	<xsl:output method = "xml" indent = "yes"/>
	
	<xsl:template match = "/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master page-height = "297mm" page-width = "210mm" margin = "5mm 20mm 5mm 20mm" master-name = "template">
					<fo:region-body margin = "20mm 0mm 20mm 0mm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			
			<!-- Project title page -->	
			<fo:page-sequence master-reference = "template">
				<fo:flow flow-name = "xsl-region-body">
					<fo:block position = "absolute" text-align = "right" font-size = "40pt" 
							  margin-bottom = "30mm" font-family = "Impact" padding-before = "30mm">
						Тема №09:<fo:block/>КАТАЛОГ НА IT ФИРМИ - 1
					</fo:block>
					<fo:block position = "absolute" font-family = "Franklin Gothic Book">
						<fo:block margin-bottom = "5mm" text-align = "center" font-size = "24pt" font-style = "italic">Курсов проект</fo:block>
						<fo:block text-align = "center" font-size = "16pt">XML технологии за семантичен уеб, зимен семестър 2022/2023 г.</fo:block>
						<fo:block text-align = "justify" padding-before = "30mm" font-size = "14pt">
							<fo:table>
								<fo:table-column column-width="35mm"/>
								<fo:table-column column-width="150mm"/>
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Изготвен от:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>Моника Красимирова Митрева, фак. номер 62522</fo:block>
											<fo:block margin-bottom = "10mm">Кристиан Филипов Иванов, фак. номер 0MI0600137</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Проверен от:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block margin-bottom = "30mm">гл. ас. д-р Явор Данков</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
						<fo:block text-align = "center">09 януари 2023 г.<fo:block/>
							гр. София
						</fo:block>
					</fo:block>		
				</fo:flow>
			</fo:page-sequence>

			<!-- PaysafeGroup -->
			<fo:page-sequence master-reference = "template">
				<fo:flow flow-name = "xsl-region-body">
					<fo:block-container position = "absolute" top = "-2.5cm" left = "-2.5cm">
						<!-- Company name -->
						<fo:block position = "absolute" text-align = "center" padding-before = "2cm" 
								  margin-left = "2.5cm" font-family = "Impact" font-size = "36pt">
							<xsl:value-of select = "//company[@companyID = 'PaysafeGroup']/companyName"/>
						</fo:block>
						<!-- Company picture/logo -->
						<fo:block position = "absolute" text-align="center">
							<fo:external-graphic src = "{unparsed-entity-uri(//company[@companyID = 'PaysafeGroup']/image/@href)}"/>
						</fo:block>
						<!-- Company information -->
						<fo:block position = "relative" font-family = "Franklin Gothic Book" 
								  font-size = "12pt" text-align = "justify" padding-before = "5mm" 
								  margin-left = "2.5cm">
							<!-- Company description -->
							<fo:block padding-after = "10mm">
								Визитна картичка:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'PaysafeGroup']/description"/> 
								</fo:inline>
							</fo:block> 
							
							<!-- Used technologies/programming languages -->
							<fo:block padding-after = "10mm">
								Технологии / програмни езици, които се използват в компанията:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'PaysafeGroup']/technologies"/> 
								</fo:inline>
							</fo:block>
							
							<!-- General information -->
							<fo:table margin-left = "-1.25cm">
								<fo:table-column column-width = "70mm"/>
								<fo:table-column column-width = "120mm"/>
								<fo:table-body>
									<!-- Year of establishment -->
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Година на основаване:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'PaysafeGroup']/yearOfEstablishment"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<!-- Contacts -->
									<fo:table-row>
										<!-- Address -->
										<fo:table-cell>
											<fo:block font-style = "italic">Адрес:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'PaysafeGroup']/contacts/address/city"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Email -->
										<fo:table-cell>
											<fo:block font-style = "italic">Имейл:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'PaysafeGroup']/contacts/email"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Official website -->
										<fo:table-cell>
											<fo:block font-style = "italic">Официален уебсайт:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'PaysafeGroup']/contacts/site"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Facebook -->
										<fo:table-cell>
											<fo:block font-style = "italic">Facebook:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'PaysafeGroup']/contacts/facebook"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Linkedin -->
										<fo:table-cell>
											<fo:block font-style = "italic">Linkedin:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'PaysafeGroup']/contacts/linkedin"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>  	
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>
			
			<!-- Adastra -->
			<fo:page-sequence master-reference = "template">
				<fo:flow flow-name = "xsl-region-body">
					<fo:block-container position = "absolute" top = "-2.5cm" left = "-2.5cm">
						<!-- Company name -->
						<fo:block position = "absolute" text-align = "center" padding-before = "2cm" 
							margin-left = "2.5cm" font-family = "Impact" font-size = "36pt">
							<xsl:value-of select = "//company[@companyID = 'Adastra']/companyName"/>
						</fo:block>
						<!-- Company picture/logo -->
						<fo:block position = "absolute" text-align="center">
							<fo:external-graphic src = "{unparsed-entity-uri(//company[@companyID = 'Adastra']/image/@href)}"/>
						</fo:block>
						<!-- Company information -->
						<fo:block position = "relative" font-family = "Franklin Gothic Book" 
							font-size = "12pt" text-align = "justify" padding-before = "5mm" 
							margin-left = "2.5cm">
							<!-- Company description -->
							<fo:block padding-after = "10mm">
								Визитна картичка:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'Adastra']/description"/> 
								</fo:inline>
							</fo:block> 
							
							<!-- Used technologies/programming languages -->
							<fo:block padding-after = "10mm">
								Технологии / програмни езици, които се използват в компанията:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'Adastra']/technologies"/> 
								</fo:inline>
							</fo:block>
							
							<!-- General information -->
							<fo:table margin-left = "-1.25cm">
								<fo:table-column column-width = "70mm"/>
								<fo:table-column column-width = "120mm"/>
								<fo:table-body>
									<!-- Year of establishment -->
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Година на основаване:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Adastra']/yearOfEstablishment"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<!-- Contacts -->
									<fo:table-row>
										<!-- Address -->
										<fo:table-cell>
											<fo:block font-style = "italic">Адрес:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Adastra']/contacts/address/city"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Email -->
										<fo:table-cell>
											<fo:block font-style = "italic">Имейл:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Adastra']/contacts/email"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Official website -->
										<fo:table-cell>
											<fo:block font-style = "italic">Официален уебсайт:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Adastra']/contacts/site"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Facebook -->
										<fo:table-cell>
											<fo:block font-style = "italic">Facebook:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Adastra']/contacts/facebook"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Linkedin -->
										<fo:table-cell>
											<fo:block font-style = "italic">Linkedin:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Adastra']/contacts/linkedin"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>

			<!-- AsteaSolutions -->
			<fo:page-sequence master-reference = "template">
				<fo:flow flow-name = "xsl-region-body">
					<fo:block-container position = "absolute" top = "-2.5cm" left = "-2.5cm">
						<!-- Company name -->
						<fo:block position = "absolute" text-align = "center" padding-before = "2cm" 
							margin-left = "2.5cm" font-family = "Impact" font-size = "36pt">
							<xsl:value-of select = "//company[@companyID = 'AsteaSolutions']/companyName"/>
						</fo:block>
						<!-- Company picture/logo -->
						<fo:block position = "absolute" text-align=";eft">
							<fo:external-graphic src = "{unparsed-entity-uri(//company[@companyID = 'AsteaSolutions']/image/@href)}" content-width="scale-to-fit" width="120%"/>
						</fo:block>
						<!-- Company information -->
						<fo:block position = "relative" font-family = "Franklin Gothic Book" 
							font-size = "12pt" text-align = "justify" padding-before = "5mm" 
							margin-left = "2.5cm">
							<!-- Company description -->
							<fo:block padding-after = "10mm">
								Визитна картичка:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'AsteaSolutions']/description"/> 
								</fo:inline>
							</fo:block> 
							
							<!-- Used technologies/programming languages -->
							<fo:block padding-after = "10mm">
								Технологии / програмни езици, които се използват в компанията:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'AsteaSolutions']/technologies"/> 
								</fo:inline>
							</fo:block>
							
							<!-- General information -->
							<fo:table margin-left = "-1.25cm">
								<fo:table-column column-width = "70mm"/>
								<fo:table-column column-width = "120mm"/>
								<fo:table-body>
									<!-- Year of establishment -->
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Година на основаване:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'AsteaSolutions']/yearOfEstablishment"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<!-- Contacts -->
									<fo:table-row>
										<!-- Address -->
										<fo:table-cell>
											<fo:block font-style = "italic">Адрес:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'AsteaSolutions']/contacts/address/city"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Email -->
										<fo:table-cell>
											<fo:block font-style = "italic">Имейл:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'AsteaSolutions']/contacts/email"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Official website -->
										<fo:table-cell>
											<fo:block font-style = "italic">Официален уебсайт:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'AsteaSolutions']/contacts/site"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Facebook -->
										<fo:table-cell>
											<fo:block font-style = "italic">Facebook:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'AsteaSolutions']/contacts/facebook"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Linkedin -->
										<fo:table-cell>
											<fo:block font-style = "italic">Linkedin:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'AsteaSolutions']/contacts/linkedin"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>
			
			<!-- Melon -->
			<fo:page-sequence master-reference = "template">
				<fo:flow flow-name = "xsl-region-body">
					<fo:block-container position = "absolute" top = "-2.5cm" left = "-2.5cm">
						<!-- Company name -->
						<fo:block position = "absolute" text-align = "center" padding-before = "2cm" 
							margin-left = "2.5cm" font-family = "Impact" font-size = "36pt">
							<xsl:value-of select = "//company[@companyID = 'Melon']/companyName"/>
						</fo:block>
						<!-- Company picture/logo -->
						<fo:block position = "absolute" text-align="center">
							<fo:external-graphic src = "{unparsed-entity-uri(//company[@companyID = 'Melon']/image/@href)}" content-width="scale-to-fit" width="120%"/>
						</fo:block>
						<!-- Company information -->
						<fo:block position = "relative" font-family = "Franklin Gothic Book" 
							font-size = "12pt" text-align = "justify" padding-before = "5mm" 
							margin-left = "2.5cm">
							<!-- Company description -->
							<fo:block padding-after = "10mm">
								Визитна картичка:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'Melon']/description"/> 
								</fo:inline>
							</fo:block> 
							
							<!-- Used technologies/programming languages -->
							<fo:block padding-after = "10mm">
								Технологии / програмни езици, които се използват в компанията:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'Melon']/technologies"/> 
								</fo:inline>
							</fo:block>
							
							<!-- General information -->
							<fo:table margin-left = "-1.25cm">
								<fo:table-column column-width = "70mm"/>
								<fo:table-column column-width = "120mm"/>
								<fo:table-body>
									<!-- Year of establishment -->
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Година на основаване:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Melon']/yearOfEstablishment"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<!-- Contacts -->
									<fo:table-row>
										<!-- Address -->
										<fo:table-cell>
											<fo:block font-style = "italic">Адрес:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Melon']/contacts/address/city"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Email -->
										<fo:table-cell>
											<fo:block font-style = "italic">Имейл:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Melon']/contacts/email"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Official website -->
										<fo:table-cell>
											<fo:block font-style = "italic">Официален уебсайт:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Melon']/contacts/site"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Facebook -->
										<fo:table-cell>
											<fo:block font-style = "italic">Facebook:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Melon']/contacts/facebook"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Linkedin -->
										<fo:table-cell>
											<fo:block font-style = "italic">Linkedin:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Melon']/contacts/linkedin"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>

			<!-- DraftKings -->
			<fo:page-sequence master-reference = "template">
				<fo:flow flow-name = "xsl-region-body">
					<fo:block-container position = "absolute" top = "-2.5cm" left = "-2.5cm">
						<!-- Company name -->
						<fo:block position = "absolute" text-align = "center" padding-before = "2cm" 
							margin-left = "2.5cm" font-family = "Impact" font-size = "36pt">
							<xsl:value-of select = "//company[@companyID = 'DraftKings']/companyName"/>
						</fo:block>
						<!-- Company picture/logo -->
						<fo:block position = "absolute" text-align="left">
							<fo:external-graphic src = "{unparsed-entity-uri(//company[@companyID = 'DraftKings']/image/@href)}" content-width="scale-to-fit" width="120%"/>
						</fo:block>
						<!-- Company information -->
						<fo:block position = "relative" font-family = "Franklin Gothic Book" 
							font-size = "12pt" text-align = "justify" padding-before = "5mm" 
							margin-left = "2.5cm">
							<!-- Company description -->
							<fo:block padding-after = "10mm">
								Визитна картичка:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'DraftKings']/description"/> 
								</fo:inline>
							</fo:block> 
							
							<!-- Used technologies/programming languages -->
							<fo:block padding-after = "10mm">
								Технологии / програмни езици, които се използват в компанията:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'DraftKings']/technologies"/> 
								</fo:inline>
							</fo:block>
							
							<!-- General information -->
							<fo:table margin-left = "-1.25cm">
								<fo:table-column column-width = "70mm"/>
								<fo:table-column column-width = "120mm"/>
								<fo:table-body>
									<!-- Year of establishment -->
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Година на основаване:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'DraftKings']/yearOfEstablishment"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<!-- Contacts -->
									<fo:table-row>
										<!-- Address -->
										<fo:table-cell>
											<fo:block font-style = "italic">Адрес:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'DraftKings']/contacts/address/city"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Email -->
										<fo:table-cell>
											<fo:block font-style = "italic">Имейл:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'DraftKings']/contacts/email"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Official website -->
										<fo:table-cell>
											<fo:block font-style = "italic">Официален уебсайт:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'DraftKings']/contacts/site"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Facebook -->
										<fo:table-cell>
											<fo:block font-style = "italic">Facebook:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'DraftKings']/contacts/facebook"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Linkedin -->
										<fo:table-cell>
											<fo:block font-style = "italic">Linkedin:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'DraftKings']/contacts/linkedin"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>
			
			<!-- Strypes -->
			<fo:page-sequence master-reference = "template">
				<fo:flow flow-name = "xsl-region-body">
					<fo:block-container position = "absolute" top = "-2.5cm" left = "-2.5cm">
						<!-- Company name -->
						<fo:block position = "absolute" text-align = "center" padding-before = "2cm" 
							margin-left = "2.5cm" font-family = "Impact" font-size = "36pt">
							<xsl:value-of select = "//company[@companyID = 'Strypes']/companyName"/>
						</fo:block>
						<!-- Company picture/logo -->
						<fo:block position = "absolute" text-align="center">
							<fo:external-graphic src = "{unparsed-entity-uri(//company[@companyID = 'Strypes']/image/@href)}"/>
						</fo:block>
						<!-- Company information -->
						<fo:block position = "relative" font-family = "Franklin Gothic Book" 
							font-size = "12pt" text-align = "justify" padding-before = "5mm" 
							margin-left = "2.5cm">
							<!-- Company description -->
							<fo:block padding-after = "10mm">
								Визитна картичка:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'Strypes']/description"/> 
								</fo:inline>
							</fo:block> 
							
							<!-- Used technologies/programming languages -->
							<fo:block padding-after = "10mm">
								Технологии / програмни езици, които се използват в компанията:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'Strypes']/technologies"/> 
								</fo:inline>
							</fo:block>
							
							<!-- General information -->
							<fo:table margin-left = "-1.25cm">
								<fo:table-column column-width = "70mm"/>
								<fo:table-column column-width = "120mm"/>
								<fo:table-body>
									<!-- Year of establishment -->
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Година на основаване:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Strypes']/yearOfEstablishment"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<!-- Contacts -->
									<fo:table-row>
										<!-- Address -->
										<fo:table-cell>
											<fo:block font-style = "italic">Адрес:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Strypes']/contacts/address/city"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Email -->
										<fo:table-cell>
											<fo:block font-style = "italic">Имейл:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Strypes']/contacts/email"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Official website -->
										<fo:table-cell>
											<fo:block font-style = "italic">Официален уебсайт:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Strypes']/contacts/site"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Facebook -->
										<fo:table-cell>
											<fo:block font-style = "italic">Facebook:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Strypes']/contacts/facebook"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Linkedin -->
										<fo:table-cell>
											<fo:block font-style = "italic">Linkedin:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'Strypes']/contacts/linkedin"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>
			
			<!-- SigmaSoftware -->
			<fo:page-sequence master-reference = "template">
				<fo:flow flow-name = "xsl-region-body">
					<fo:block-container position = "absolute" top = "-2.5cm" left = "-2.5cm">
						<!-- Company name -->
						<fo:block position = "absolute" text-align = "center" padding-before = "2cm" 
							margin-left = "2.5cm" font-family = "Impact" font-size = "36pt">
							<xsl:value-of select = "//company[@companyID = 'SigmaSoftware']/companyName"/>
						</fo:block>
						<!-- Company picture/logo -->
						<fo:block position = "absolute" text-align="justify">
							<fo:external-graphic src = "{unparsed-entity-uri(//company[@companyID = 'SigmaSoftware']/image/@href)}" content-width="scale-to-fit" width="110%"/>
						</fo:block>
						<!-- Company information -->
						<fo:block position = "relative" font-family = "Franklin Gothic Book" 
							font-size = "12pt" text-align = "justify" padding-before = "5mm" 
							margin-left = "2.5cm">
							<!-- Company description -->
							<fo:block padding-after = "10mm">
								Визитна картичка:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'SigmaSoftware']/description"/> 
								</fo:inline>
							</fo:block> 
							
							<!-- Used technologies/programming languages -->
							<fo:block padding-after = "10mm">
								Технологии / програмни езици, които се използват в компанията:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'SigmaSoftware']/technologies"/> 
								</fo:inline>
							</fo:block>
							
							<!-- General information -->
							<fo:table margin-left = "-1.25cm">
								<fo:table-column column-width = "70mm"/>
								<fo:table-column column-width = "120mm"/>
								<fo:table-body>
									<!-- Year of establishment -->
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Година на основаване:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SigmaSoftware']/yearOfEstablishment"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<!-- Contacts -->
									<fo:table-row>
										<!-- Address -->
										<fo:table-cell>
											<fo:block font-style = "italic">Адрес:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SigmaSoftware']/contacts/address/city"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Email -->
										<fo:table-cell>
											<fo:block font-style = "italic">Имейл:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SigmaSoftware']/contacts/email"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Official website -->
										<fo:table-cell>
											<fo:block font-style = "italic">Официален уебсайт:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SigmaSoftware']/contacts/site"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Facebook -->
										<fo:table-cell>
											<fo:block font-style = "italic">Facebook:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SigmaSoftware']/contacts/facebook"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Linkedin -->
										<fo:table-cell>
											<fo:block font-style = "italic">Linkedin:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SigmaSoftware']/contacts/linkedin"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>
			
			<!-- SoftServe -->
			<fo:page-sequence master-reference = "template">
				<fo:flow flow-name = "xsl-region-body">
					<fo:block-container position = "absolute" top = "-2.5cm" left = "-2.5cm">
						<!-- Company name -->
						<fo:block position = "absolute" text-align = "center" padding-before = "2cm" 
							margin-left = "2.5cm" font-family = "Impact" font-size = "36pt">
							<xsl:value-of select = "//company[@companyID = 'SoftServe']/companyName"/>
						</fo:block>
						<!-- Company picture/logo -->
						<fo:block position = "absolute" text-align="center">
							<fo:external-graphic src = "{unparsed-entity-uri(//company[@companyID = 'SoftServe']/image/@href)}" content-width="scale-to-fit" width="120%"/>
						</fo:block>
						<!-- Company information -->
						<fo:block position = "relative" font-family = "Franklin Gothic Book" 
							font-size = "12pt" text-align = "justify" padding-before = "5mm" 
							margin-left = "2.5cm">
							<!-- Company description -->
							<fo:block padding-after = "10mm">
								Визитна картичка:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'SoftServe']/description"/> 
								</fo:inline>
							</fo:block> 
							
							<!-- Used technologies/programming languages -->
							<fo:block padding-after = "10mm">
								Технологии / програмни езици, които се използват в компанията:<fo:block/>
								<fo:inline padding-left = "10mm">
									<xsl:value-of select = "//company[@companyID = 'SoftServe']/technologies"/> 
								</fo:inline>
							</fo:block>
							
							<!-- General information -->
							<fo:table margin-left = "-1.25cm">
								<fo:table-column column-width = "70mm"/>
								<fo:table-column column-width = "120mm"/>
								<fo:table-body>
									<!-- Year of establishment -->
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-style = "italic">Година на основаване:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SoftServe']/yearOfEstablishment"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<!-- Contacts -->
									<fo:table-row>
										<!-- Address -->
										<fo:table-cell>
											<fo:block font-style = "italic">Адрес:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SoftServe']/contacts/address/city"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Email -->
										<fo:table-cell>
											<fo:block font-style = "italic">Имейл:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SoftServe']/contacts/email"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Official website -->
										<fo:table-cell>
											<fo:block font-style = "italic">Официален уебсайт:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SoftServe']/contacts/site"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Facebook -->
										<fo:table-cell>
											<fo:block font-style = "italic">Facebook:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SoftServe']/contacts/facebook"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<!-- Linkedin -->
										<fo:table-cell>
											<fo:block font-style = "italic">Linkedin:</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<fo:inline>
													<xsl:value-of select = "//company[@companyID = 'SoftServe']/contacts/linkedin"/> 
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>