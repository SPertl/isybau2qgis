/*
KNOTEN
Abwassertechnische Anlagen gem. Arbeitshilfen Abwasser 
(http://www.arbeitshilfen-abwasser.de/html/ISYBAU_Austauschformate_Abwasser.14.08.html)
Schächte (S), Anschlusspunkte (AP) und Bauwerke (BW)
*/

-- Erstellung der Views in separatem Schema zum Schutz bei GMLAS Import -overwrite
--CREATE SCHEMA isybau;

-- S punktförmige Schächte repräsentiert durch den Schachtmittelpunkt 
CREATE OR REPLACE VIEW qgisybau.v_knoten_schacht_smp AS 
 SELECT a.ogc_fid,
    a.ogr_pkid,
    a.parent_ogr_pkid,
    a.objektbezeichnung,
    a.objektart,
    a.alteobjektbezeichnung,
    a.lisa_guid,
    a.reihenfolgeid,
    a.status,
    a.baujahr,
    a.entwaesserungsart,
    a.kommentar,
    a.knoten_knotentyp,
    a.knoten_schacht_schachtfunktion,
    a.knoten_schacht_schachttiefe,
    a.knoten_schacht_einstieghilfe,
    a.knoten_schacht_arteinstieghilfe,
    a.knoten_schacht_materialsteighilfen,
    a.knoten_schacht_innenschutz,
    a.knoten_schacht_anzahlanschluesse,
    a.knoten_schacht_uebergabeschacht,
    a.knoten_schacht_anzahldeckel,
    a.knoten_schacht_abdeckung_deckelform,
    a.knoten_schacht_abdeckung_deckeltyp,
    a.knoten_schacht_abdeckung_laengedeckel,
    a.knoten_schacht_abdeckung_breitedeckel,
    a.knoten_schacht_abdeckung_abdeckungsklasse,
    a.knoten_schacht_abdeckung_materialabdeckung,
    a.knoten_schacht_abdeckung_anzahlauflageringe,
    a.knoten_schacht_abdeckung_hoeheauflageringe,
    a.knoten_schacht_abdeckung_schmutzfaenger,
    a.knoten_schacht_aufbau_aufbauform,
    a.knoten_schacht_aufbau_abdeckplatte,
    a.knoten_schacht_aufbau_konus,
    a.knoten_schacht_aufbau_laengeaufbau,
    a.knoten_schacht_aufbau_breiteaufbau,
    a.knoten_schacht_aufbau_hoeheaufbau,
    a.knoten_schacht_aufbau_materialaufbau,
    a.knoten_schacht_untereschachtzone_untereschachtzoneform,
    a.knoten_schacht_untereschachtzone_uebergangsplatte,
    a.knoten_schacht_untereschachtzone_konus,
    a.knoten_schacht_untereschachtzone_laengeunten,
    a.knoten_schacht_untereschachtzone_breiteunten,
    a.knoten_schacht_untereschachtzone_hoeheunten,
    a.knoten_schacht_untereschachtzone_materialunten,
    a.knoten_schacht_untereschachtzone_podest,
    a.knoten_schacht_unterteil_unterteilform,
    a.knoten_schacht_unterteil_laengeunterteil,
    a.knoten_schacht_unterteil_breiteunterteil,
    a.knoten_schacht_unterteil_hoeheunterteil,
    a.knoten_schacht_unterteil_materialunterteil,
    a.knoten_schacht_unterteil_gerinneform,
    a.knoten_schacht_unterteil_materialgerinne,
    a.knoten_strang,
    a.lage_strassenschluessel,
    a.lage_strassenname,
    a.lage_ortsteilschluessel,
    a.lage_ortsteilname,
    a.lage_lageoberflaeche,
    a.lage_kommentarlage,
    a.lage_ueberschwemmungsgebiet,
    a.umweltparameter_abwasserart,
    a.umweltparameter_abwasserartwgs,
    a.umweltparameter_gwabstand,
    a.umweltparameter_wasserschutzzone,
    a.umweltparameter_bodenart,
    a.geometrie_vorlaeufigebezeichnung,
    a.geometrie_geoobjektart,
    a.geometrie_geoobjekttyp,
    a.geometrie_lagegenauigkeitsklasse,
    a.geometrie_hoehengenauigkeitsklasse,
    a.geometrie_datenherkunft,
    a.geometrie_kommentar,
    a.geometrie_crslage,
    p.punktattributabwasser,
    a.sanierung_artmassnahme,
    p.p_geom_2d AS geom
   FROM isybau.identifikati_datenkollekti_stammdatenkol_abwassertechnanlage a
     JOIN qgisybau.v_punktgeometrien p ON a.ogr_pkid::text = p.parent_ogr_pkid::text
  WHERE a.objektart = 2 -- G100 2=Knoten
    AND a.knoten_knotentyp = 0 -- G300 0=Schacht
    AND a.geometrie_geoobjekttyp::text = 'P'::text -- V200 P=Punktobjekt
    AND p.punktattributabwasser::text = 'SMP'::text; -- V106: PunktattributAbwasser=SMP

COMMENT ON view qgisybau.v_knoten_schacht_smp IS 'punktförmige Schächte repräsentiert durch den Schachtmittelpunkt';

-- AP Anschlusspunkte: verschiedene Punkte, Anfangs- und/oder Endpunkte von Leitungen, vgl. V106.
CREATE OR REPLACE VIEW qgisybau.v_knoten_ap AS 
 SELECT a.ogc_fid,
    a.ogr_pkid,
    a.parent_ogr_pkid,
    a.objektbezeichnung,
    a.objektart,
    a.alteobjektbezeichnung,
    a.lisa_guid,
    a.reihenfolgeid,
    a.status,
    a.baujahr,
    a.entwaesserungsart,
    a.kommentar,
    a.knoten_knotentyp,
    a.knoten_anschlusspunkt_punktkennung,
    a.knoten_anschlusspunkt_uebergabepunkt,
    a.knoten_strang,
    a.lage_strassenschluessel,
    a.lage_strassenname,
    a.lage_ortsteilschluessel,
    a.lage_ortsteilname,
    a.lage_lageoberflaeche,
    a.lage_kommentarlage,
    a.lage_ueberschwemmungsgebiet,
    a.umweltparameter_abwasserart,
    a.umweltparameter_abwasserartwgs,
    a.umweltparameter_gwabstand,
    a.umweltparameter_wasserschutzzone,
    a.umweltparameter_bodenart,
    a.geometrie_vorlaeufigebezeichnung,
    a.geometrie_geoobjektart,
    a.geometrie_geoobjekttyp,
    a.geometrie_lagegenauigkeitsklasse,
    a.geometrie_hoehengenauigkeitsklasse,
    a.geometrie_datenherkunft,
    a.geometrie_kommentar,
    a.geometrie_crslage,
    p.punktattributabwasser,
    a.sanierung_artmassnahme,
    p.p_geom_2d AS geom
   FROM isybau.identifikati_datenkollekti_stammdatenkol_abwassertechnanlage a
     JOIN qgisybau.v_punktgeometrien p ON a.ogr_pkid::text = p.parent_ogr_pkid::text
  WHERE a.objektart = 2 -- G100 2=Knoten
    AND a.knoten_knotentyp = 1 -- G300 1=Anschlusspunkt
    AND a.geometrie_geoobjekttyp::text = 'P'::text -- V200 P=Punktobjekt
    AND p.punktattributabwasser::text <> 'GOK'::text; -- evt. "Höhenpunkt Geländeoberkante" (GOK) ausschließen, da nicht Teil der Anlagen!

COMMENT ON view qgisybau.v_knoten_ap IS 'Anschlusspunkte: verschiedene Punkte, Anfangs- und/oder Endpunkte von Leitungen, vgl. V106.';

-- BW Bauwerke punktförmig: alle Typen, hier keine Differenzierung nach Bauwerkstyp G400
CREATE OR REPLACE VIEW qgisybau.v_knoten_bauwerke AS 
 SELECT a.ogc_fid,
    a.ogr_pkid,
    a.parent_ogr_pkid,
    a.objektbezeichnung,
    a.objektart,
    a.alteobjektbezeichnung,
    a.lisa_guid,
    a.reihenfolgeid,
    a.status,
    a.baujahr,
    a.entwaesserungsart,
    a.kommentar,
    a.knoten_knotentyp,
    a.knoten_bauwerk_bauwerkstyp,
    a.knoten_bauwerk_hersteller_typ,
    a.knoten_bauwerk_adressehersteller,
    a.knoten_bauwerk_ufis_baunummer,
    a.knoten_bauwerk_uebergabebauwerk,
    a.knoten_bauwerk_kommentar,
    a.knoten_bauwerk_pumpwerk_grundflaeche,
    a.knoten_bauwerk_pumpwerk_maxlaenge,
    a.knoten_bauwerk_pumpwerk_maxbreite,
    a.knoten_bauwerk_pumpwerk_maxhoehe,
    a.knoten_bauwerk_pumpwerk_raumhochbau,
    a.knoten_bauwerk_pumpwerk_raumtiefbau,
    a.knoten_bauwerk_pumpwerk_anzahldeckel,
    a.knoten_bauwerk_becken_beckenfunktion,
    a.knoten_bauwerk_becken_beckenart,
    a.knoten_bauwerk_becken_anordnung,
    a.knoten_bauwerk_becken_beckenbauart,
    a.knoten_bauwerk_becken_beckenform,
    a.knoten_bauwerk_becken_beckenausfuehrung,
    a.knoten_bauwerk_becken_grundflaeche,
    a.knoten_bauwerk_becken_maxlaenge,
    a.knoten_bauwerk_becken_maxbreite,
    a.knoten_bauwerk_becken_maxhoehe,
    a.knoten_bauwerk_becken_boeschungsneigung,
    a.knoten_bauwerk_becken_nutzvolumen,
    a.knoten_bauwerk_becken_raumhochbau,
    a.knoten_bauwerk_becken_raumtiefbau,
    a.knoten_bauwerk_becken_anzahlzulaeufe,
    a.knoten_bauwerk_becken_anzahlablaeufe,
    a.knoten_bauwerk_becken_anzahlkammern,
    a.knoten_bauwerk_becken_anzahldeckel,
    a.knoten_bauwerk_becken_filterschicht,
    a.knoten_bauwerk_becken_filtermaterial,
    a.knoten_bauwerk_becken_bepflanzung,
    a.knoten_bauwerk_behandlungsanlage_kombinationsanlage,
    a.knoten_bauwerk_behandlungsanlage_kombinationsart,
    a.knoten_bauwerk_behandlungsanlage_bypass,
    b.behandlungsart,
    b.aufstellungsart,
    b.breite,
    b.laenge,
    b.hoehe,
    b.hoehezulauf,
    b.hoeheablauf,
    b.materialanlage,
    b.anzahldeckel,
    b.schlammfang_gesamtspeicher,
    b.lfabscheider_abscheiderklasse,
    b.lfabscheider_nenngroesse,
    b.lfabscheider_schichtdicke,
    b.lfabscheider_gesamtspeicher,
    b.lfabscheider_lfspeicher,
    b.lfabscheider_schwimmerabschluss,
    b.lfabscheider_warnanlage,
    b.lfabscheider_kommentarwarnanlage,
    b.staerkeabscheider_nenngroesse,
    b.staerkeabscheider_gesamtspeicher,
    b.staerkeabscheider_frischwasser,
    b.fettabscheider_nenngroesse,
    b.fettabscheider_gesamtspeicher,
    b.emulsionspaltanlage_leistung,
    b.emulsionspaltanlage_einwohnerwerte,
    b.emulsionspaltanlage_flockungsmittel,
    b.stapelbecken_gesamtspeicher,
    b.stapelbecken_lfspeicher,
    b.stapelbecken_durchflussleistung,
    b.stapelbecken_existenzpumpe,
    b.neutralisationsanlage_neutralisationsart,
    b.neutralisationsanlage_gesamtvolumen,
    b.neutralisationsanlage_neutralisationsmittel,
    b.neutralisationsanlage_phwert,
    b.neutralisationsanlage_ablaufleistung,
    a.knoten_bauwerk_klaeranlage_klaeranlagefunktion,
    a.knoten_bauwerk_klaeranlage_einwohnerwerte,
    a.knoten_bauwerk_auslaufbauwerk_artauslaufbauwerk,
    a.knoten_bauwerk_auslaufbauwerk_einleitungsart,
    a.knoten_bauwerk_auslaufbauwerk_schutzgitter,
    a.knoten_bauwerk_auslaufbauwerk_sohlsicherung,
    a.knoten_bauwerk_auslaufbauwerk_boeschungssicherung,
    a.knoten_bauwerk_auslaufbauwerk_material,
    a.knoten_bauwerk_auslaufbauwerk_neigung,
    a.knoten_bauwerk_auslaufbauwerk_laenge,
    a.knoten_bauwerk_auslaufbauwerk_breite,
    a.knoten_bauwerk_auslaufbauwerk_hoehe,
    a.knoten_bauwerk_pumpe_pumpenart,
    a.knoten_bauwerk_pumpe_foerderhoehegesamt,
    a.knoten_bauwerk_pumpe_foerderhoehemanometrisch,
    a.knoten_bauwerk_pumpe_leistungsaufnahme,
    a.knoten_bauwerk_pumpe_leistung,
    a.knoten_bauwerk_pumpe_uebergeordnetebauwerk_objektbezeichnung,
    a.knoten_bauwerk_pumpe_uebergeordnetesbauwerk_anlagentyp,
    a.knoten_bauwerk_wehr_ueberlauf_wehrfunktion,
    a.knoten_bauwerk_wehr_ueberlauf_wehrtyp,
    a.knoten_bauwerk_wehr_ueberlauf_oeffnungsweite,
    a.knoten_bauwerk_wehr_ueberlauf_schwellenhoehemin,
    a.knoten_bauwerk_wehr_ueberlauf_schwellenhoehemax,
    a.knoten_bauwerk_wehr_ueberlauf_laengewehrschwelle,
    a.knoten_bauwerk_wehr_ueberlauf_artwehrkrone,
    a.knoten_bauwerk_wehr_ueberlauf_verfahrgeschwindigkeit,
    a.knoten_bauwerk_wehr_ueberla_uebergeobauwerk_objektbezeichnun,
    a.knoten_bauwerk_wehr_ueberlauf_uebergeordnebauwerk_anlagentyp,
    a.knoten_bauwerk_drossel_ablaufart,
    a.knoten_bauwerk_drossel_nennleistung,
    a.knoten_bauwerk_drossel_uebergeordnebauwerk_objektbezeichnung,
    a.knoten_bauwerk_drossel_uebergeordnetesbauwerk_anlagentyp,
    a.knoten_bauwerk_schieber_schieberfunktion,
    a.knoten_bauwerk_schieber_schieberart,
    a.knoten_bauwerk_schieber_schieberbreite,
    a.knoten_bauwerk_schieber_schiebernulllage,
    a.knoten_bauwerk_schieber_hubhoehemax,
    a.knoten_bauwerk_schieber_verfahrgeschwindigkeit,
    a.knoten_bauwerk_schieber_uebergeordnbauwerk_objektbezeichnung,
    a.knoten_bauwerk_schieber_uebergeordnetesbauwerk_anlagentyp,
    a.knoten_bauwerk_rechen_rechentyp,
    a.knoten_bauwerk_rechen_rechenrost,
    a.knoten_bauwerk_rechen_aufstellungsart,
    a.knoten_bauwerk_rechen_breite,
    a.knoten_bauwerk_rechen_laenge,
    a.knoten_bauwerk_rechen_hoehe,
    a.knoten_bauwerk_rechen_reinigereingriff,
    a.knoten_bauwerk_rechen_material,
    a.knoten_bauwerk_rechen_uebergeordnetbauwerk_objektbezeichnung,
    a.knoten_bauwerk_rechen_uebergeordnetesbauwerk_anlagentyp,
    a.knoten_bauwerk_sieb_siebtyp,
    a.knoten_bauwerk_sieb_siebkoerper,
    a.knoten_bauwerk_sieb_aufstellungsart,
    a.knoten_bauwerk_sieb_einbauart,
    a.knoten_bauwerk_sieb_siebflaeche,
    a.knoten_bauwerk_sieb_material,
    a.knoten_bauwerk_sieb_uebergeordnetesbauwerk_objektbezeichnung,
    a.knoten_bauwerk_sieb_uebergeordnetesbauwerk_anlagentyp,
    a.knoten_bauwerk_versickerungsanlage_versickerungsanlagetyp,
    a.knoten_bauwerk_versickerungsanlage_datuminbetriebnahme,
    a.knoten_bauwerk_versickerungsanlage_artflaechenanschluss,
    a.knoten_bauwerk_versickerungsanlage_maxversickerungsleistung,
    a.knoten_bauwerk_versickerungsanlage_bemessungshaeufigkeit,
    a.knoten_bauwerk_versickerungsanlage_umfeld,
    a.knoten_bauwerk_versickerungsanlage_mulde_teich_laenge,
    a.knoten_bauwerk_versickerungsanlage_mulde_teich_breite,
    a.knoten_bauwerk_versickerungsanlage_mulde_teich_tiefe,
    a.knoten_bauwerk_versickerungsanlag_mulde_teich_grundflaecheva,
    a.knoten_bauwerk_versickerungsanl_mulde_teich_flaechedauerstau,
    a.knoten_bauwerk_versickerungsanlag_mulde_teich_hoehedauerstau,
    a.knoten_bauwerk_versickerungsanlage_mulde_teich_boeschungva,
    a.knoten_bauwerk_versickerungs_mulde_teich_staerkebodenschicht,
    a.knoten_bauwerk_versickerungsanla_mulde_teich_maxeinstauhoehe,
    a.knoten_bauwerk_versickerungsanla_mulde_teich_speichervolumen,
    a.knoten_bauwerk_versickerungsan_mulde_teich_existenzueberlauf,
    a.knoten_bauwerk_versickerungsanlage_mulde_teich_ueberlauf,
    a.knoten_bauwerk_versickerungsanlage_rohr_rigole_laenge,
    a.knoten_bauwerk_versickerungsanlage_rohr_rigole_breite,
    a.knoten_bauwerk_versickerungsanlage_rohr_rigole_tiefe,
    a.knoten_bauwerk_versickerungsanlage_rohr_rigole_rohrva,
    a.knoten_bauwerk_versickerungsanlage_rohr_rigole_anzahlrohre,
    a.knoten_bauwerk_versickerungsanlage_rohr_rigole_rohrmaterial,
    a.knoten_bauwerk_versickerungsanlage_rohr_rigole_fuellmaterial,
    a.knoten_bauwerk_versickerungsanla_rohr_rigole_speichervolumen,
    a.knoten_bauwerk_versickerungs_rohr_rigole_speicherkoeffizient,
    a.knoten_bauwerk_versickerungsanlag_rohr_rigole_drosselabfluss,
    a.knoten_bauwerk_versickeru_rohr_rigole_existenzdrosselschacht,
    a.knoten_bauwerk_versickerungsanlag_rohr_rigole_drosselschacht,
    a.knoten_bauwerk_versickerungsan_rohr_rigole_existenzueberlauf,
    a.knoten_bauwerk_versickerungsanlage_rohr_rigole_ueberlauf,
    a.knoten_bauwerk_versickerungsanl_versickerungssch_vschachttyp,
    a.knoten_bauwerk_versickerungsanlag_versickerungsschach_laenge,
    a.knoten_bauwerk_versickerungsanlag_versickerungsschach_breite,
    a.knoten_bauwerk_versickerungsanlage_versickerungsschach_tiefe,
    a.knoten_bauwerk_versickerungsa_versickerungssc_grundflaecheva,
    a.knoten_bauwerk_versickerungsan_versickerungssc_fuellmaterial,
    a.knoten_bauwerk_versickerung_versickerungs_existenzfiltersack,
    a.knoten_bauwerk_versickerungsa_versickerungss_maxeinstauhoehe,
    a.knoten_bauwerk_versickerungsa_versickerungss_speichervolumen,
    a.knoten_bauwerk_versickerungsa_versickerungssc_drosselabfluss,
    a.knoten_bauwerk_versickerungs_versickerungs_existenzueberlau1,
    a.knoten_bauwerk_versickerungsanla_versickerungsscha_ueberlauf,
    a.knoten_bauwerk_versickerungsanlag_versickerungsflaech_laenge,
    a.knoten_bauwerk_versickerungsanlag_versickerungsflaech_breite,
    a.knoten_bauwerk_versickerungs_versickerungs_existenzueberlau2,
    a.knoten_bauwerk_versickerungsanla_versickerungsflae_ueberlauf,
    a.knoten_bauwerk_zisterne_regenwassernutzungfunktion,
    a.knoten_bauwerk_zisterne_laenge,
    a.knoten_bauwerk_zisterne_breite,
    a.knoten_bauwerk_zisterne_tiefe,
    a.knoten_bauwerk_zisterne_hoehe,
    a.knoten_bauwerk_zisterne_durchmesser,
    a.knoten_bauwerk_zisterne_grundflaechern,
    a.knoten_bauwerk_zisterne_bauart,
    a.knoten_bauwerk_zisterne_materialrn,
    a.knoten_bauwerk_zisterne_filterart,
    a.knoten_bauwerk_zisterne_artflaechenanschluss,
    a.knoten_bauwerk_zisterne_angeschlosseneflaeche,
    a.knoten_bauwerk_zisterne_volumennutzbar,
    a.knoten_bauwerk_zisterne_rueckhaltevolumen,
    a.knoten_bauwerk_zisterne_drosselabfluss,
    a.knoten_bauwerk_zisterne_anzahldeckel,
    a.knoten_strang,
    a.lage_strassenschluessel,
    a.lage_strassenname,
    a.lage_ortsteilschluessel,
    a.lage_ortsteilname,
    a.lage_lageoberflaeche,
    a.lage_kommentarlage,
    a.lage_ueberschwemmungsgebiet,
    a.umweltparameter_abwasserart,
    a.umweltparameter_abwasserartwgs,
    a.umweltparameter_gwabstand,
    a.umweltparameter_wasserschutzzone,
    a.umweltparameter_bodenart,
    a.geometrie_vorlaeufigebezeichnung,
    a.geometrie_geoobjektart,
    a.geometrie_geoobjekttyp,
    a.geometrie_lagegenauigkeitsklasse,
    a.geometrie_hoehengenauigkeitsklasse,
    a.geometrie_datenherkunft,
    a.geometrie_kommentar,
    a.geometrie_crslage,
    p.punktattributabwasser,
    a.sanierung_artmassnahme,
    p.p_geom_2d AS geom
   FROM isybau.identifikati_datenkollekti_stammdatenkol_abwassertechnanlage a
     LEFT JOIN isybau.ident_daten_stamm_abwasanlag_knote_bauwe_behan_anlage_anlage b ON a.ogr_pkid::text = b.parent_ogr_pkid::text
     LEFT JOIN qgisybau.v_punktgeometrien p ON a.ogr_pkid::text = p.parent_ogr_pkid::text
  WHERE a.objektart = 2 -- G100 2=Knoten
    AND a.knoten_knotentyp = 2 -- G300 2=Bauwerk
    AND a.geometrie_geoobjekttyp::text = 'P'::text -- V200 P=Punktobjekt
    AND (p.punktattributabwasser::text <> ALL (ARRAY['SBD'::character varying::text, 'DMP'::character varying::text])); -- "Deckel/Einstieg Sonderbauwerk" und "Deckelmittelpunkte" ausschließen! (s.u.) 

COMMENT ON view qgisybau.v_knoten_bauwerke IS 'Bauwerke punktförmig: alle Typen, hier keine Differenzierung nach Bauwerkstyp G400';

/* optionale Erweiterung */
-- Deckel/Abdeckung: alle Arten von Deckeln und Einstiegs-Abdeckungen. Kein Objekt im ISYBAU Modell aber hilfreich für Kartendarstellung und notwendig zur Vermeidung von Multipart-/Geometrycollection-Objekten.
CREATE OR REPLACE VIEW qgisybau.v_deckel AS 
-- Schachtabdeckung 1:1
 SELECT a.ogc_fid,
    a.ogr_pkid,
    a.parent_ogr_pkid,
    a.objektbezeichnung,
    a.objektart,
    a.alteobjektbezeichnung,
    a.lisa_guid,
    a.reihenfolgeid,
    a.status,
    a.baujahr,
    a.entwaesserungsart,
    a.kommentar,
    a.knoten_knotentyp,
    a.knoten_bauwerk_bauwerkstyp,
    a.knoten_bauwerk_hersteller_typ,
    a.knoten_bauwerk_adressehersteller,
    a.knoten_bauwerk_ufis_baunummer,
    a.knoten_bauwerk_uebergabebauwerk,
    a.knoten_bauwerk_kommentar,
    a.knoten_schacht_abdeckung_deckelform AS deckelform,
    a.knoten_schacht_abdeckung_deckeltyp AS deckeltyp,
    a.knoten_schacht_abdeckung_laengedeckel AS laengedeckel,
    a.knoten_schacht_abdeckung_breitedeckel AS breitedeckel,
    a.knoten_schacht_abdeckung_abdeckungsklasse AS abdeckungsklasse,
    a.knoten_schacht_abdeckung_materialabdeckung AS materialabdeckung,
    a.knoten_schacht_abdeckung_schmutzfaenger AS schmutzfaenger,
    a.knoten_strang,
    a.lage_strassenschluessel,
    a.lage_strassenname,
    a.lage_ortsteilschluessel,
    a.lage_ortsteilname,
    a.lage_lageoberflaeche,
    a.lage_kommentarlage,
    a.lage_ueberschwemmungsgebiet,
    a.umweltparameter_abwasserart,
    a.umweltparameter_abwasserartwgs,
    a.umweltparameter_gwabstand,
    a.umweltparameter_wasserschutzzone,
    a.umweltparameter_bodenart,
    a.geometrie_vorlaeufigebezeichnung,
    a.geometrie_geoobjektart,
    a.geometrie_geoobjekttyp,
    a.geometrie_lagegenauigkeitsklasse,
    a.geometrie_hoehengenauigkeitsklasse,
    a.geometrie_datenherkunft,
    a.geometrie_kommentar,
    a.geometrie_crslage,
    p.punktattributabwasser,
    a.sanierung_artmassnahme,
    p.p_geom_2d AS geom
   FROM isybau.identifikati_datenkollekti_stammdatenkol_abwassertechnanlage a
     LEFT JOIN qgisybau.v_punktgeometrien p ON a.ogr_pkid::text = p.parent_ogr_pkid::text
  WHERE a.objektart = 2 
    AND a.knoten_knotentyp = 0 
    AND a.geometrie_geoobjekttyp::text = 'P'::text 
    AND (p.punktattributabwasser::text = ANY (ARRAY['SBD'::character varying::text, 'DMP'::character varying::text])) -- beide DeckelAttribute um evt. Fehler aufzufangen.
UNION ALL
-- Abdeckung von Versickerungsanlagen 1:1
 SELECT a.ogc_fid,
    a.ogr_pkid,
    a.parent_ogr_pkid,
    a.objektbezeichnung,
    a.objektart,
    a.alteobjektbezeichnung,
    a.lisa_guid,
    a.reihenfolgeid,
    a.status,
    a.baujahr,
    a.entwaesserungsart,
    a.kommentar,
    a.knoten_knotentyp,
    a.knoten_bauwerk_bauwerkstyp,
    a.knoten_bauwerk_hersteller_typ,
    a.knoten_bauwerk_adressehersteller,
    a.knoten_bauwerk_ufis_baunummer,
    a.knoten_bauwerk_uebergabebauwerk,
    a.knoten_bauwerk_kommentar,
    a.knoten_bauwerk_versickerun_versickerung_abdeckung_deckelform AS deckelform,
    a.knoten_bauwerk_versickerung_versickerung_abdeckung_deckeltyp AS deckeltyp,
    a.knoten_bauwerk_versickeru_versickerun_abdeckung_laengedeckel AS laengedeckel,
    a.knoten_bauwerk_versickeru_versickerun_abdeckung_breitedeckel AS breitedeckel,
    a.knoten_bauwerk_versicke_versicker_abdeckung_abdeckungsklasse AS abdeckungsklasse,
    a.knoten_bauwerk_versicke_versicke_abdeckung_materialabdeckung AS materialabdeckung,
    a.knoten_bauwerk_versicker_versickeru_abdeckung_schmutzfaenger AS schmutzfaenger,
    a.knoten_strang,
    a.lage_strassenschluessel,
    a.lage_strassenname,
    a.lage_ortsteilschluessel,
    a.lage_ortsteilname,
    a.lage_lageoberflaeche,
    a.lage_kommentarlage,
    a.lage_ueberschwemmungsgebiet,
    a.umweltparameter_abwasserart,
    a.umweltparameter_abwasserartwgs,
    a.umweltparameter_gwabstand,
    a.umweltparameter_wasserschutzzone,
    a.umweltparameter_bodenart,
    a.geometrie_vorlaeufigebezeichnung,
    a.geometrie_geoobjektart,
    a.geometrie_geoobjekttyp,
    a.geometrie_lagegenauigkeitsklasse,
    a.geometrie_hoehengenauigkeitsklasse,
    a.geometrie_datenherkunft,
    a.geometrie_kommentar,
    a.geometrie_crslage,
    p.punktattributabwasser,
    a.sanierung_artmassnahme,
    p.p_geom_2d AS geom
   FROM isybau.identifikati_datenkollekti_stammdatenkol_abwassertechnanlage a
     LEFT JOIN qgisybau.v_punktgeometrien p ON a.ogr_pkid::text = p.parent_ogr_pkid::text
  WHERE a.objektart = 2 
    AND a.knoten_knotentyp = 2 
    AND a.geometrie_geoobjekttyp::text = 'P'::text 
    AND (p.punktattributabwasser::text = ANY (ARRAY['SBD'::character varying::text, 'DMP'::character varying::text]))
UNION ALL
-- Für die Bauwerkstypen Pumpwerk, Becken, Behandlungsanlage und Zisterne können jeweils 1:n Deckel dokumentiert sein. 
-- Becken
 SELECT a.ogc_fid,
    a.ogr_pkid,
    a.parent_ogr_pkid,
    a.objektbezeichnung,
    a.objektart,
    a.alteobjektbezeichnung,
    a.lisa_guid,
    a.reihenfolgeid,
    a.status,
    a.baujahr,
    a.entwaesserungsart,
    a.kommentar,
    a.knoten_knotentyp,
    a.knoten_bauwerk_bauwerkstyp,
    a.knoten_bauwerk_hersteller_typ,
    a.knoten_bauwerk_adressehersteller,
    a.knoten_bauwerk_ufis_baunummer,
    a.knoten_bauwerk_uebergabebauwerk,
    a.knoten_bauwerk_kommentar,
    d.deckelform,
    d.deckeltyp,
    d.laengedeckel,
    d.breitedeckel,
    d.abdeckungsklasse,
    d.materialabdeckung,
    d.schmutzfaenger,
    a.knoten_strang,
    a.lage_strassenschluessel,
    a.lage_strassenname,
    a.lage_ortsteilschluessel,
    a.lage_ortsteilname,
    a.lage_lageoberflaeche,
    a.lage_kommentarlage,
    a.lage_ueberschwemmungsgebiet,
    a.umweltparameter_abwasserart,
    a.umweltparameter_abwasserartwgs,
    a.umweltparameter_gwabstand,
    a.umweltparameter_wasserschutzzone,
    a.umweltparameter_bodenart,
    a.geometrie_vorlaeufigebezeichnung,
    a.geometrie_geoobjektart,
    a.geometrie_geoobjekttyp,
    a.geometrie_lagegenauigkeitsklasse,
    a.geometrie_hoehengenauigkeitsklasse,
    a.geometrie_datenherkunft,
    a.geometrie_kommentar,
    a.geometrie_crslage,
    p.punktattributabwasser,
    a.sanierung_artmassnahme,
    p.p_geom_2d AS geom
   FROM isybau.identifikati_datenkollekti_stammdatenkol_abwassertechnanlage a
     RIGHT JOIN isybau.ident_datenk_stammd_abwassanlage_knoten_bauwer_becken_deckel d ON a.ogr_pkid::text = d.parent_ogr_pkid::text -- Becken
     LEFT JOIN qgisybau.v_punktgeometrien p ON a.ogr_pkid::text = p.parent_ogr_pkid::text
  WHERE a.objektart = 2 
    AND a.knoten_knotentyp = 2 
    AND a.geometrie_geoobjekttyp::text = 'P'::text 
    AND (p.punktattributabwasser::text = ANY (ARRAY['SBD'::character varying::text, 'DMP'::character varying::text])) -- beide Deckelattribute um evt. Fehler aufzufangen.
UNION ALL
-- Pumpwerk
 SELECT a.ogc_fid,
    a.ogr_pkid,
    a.parent_ogr_pkid,
    a.objektbezeichnung,
    a.objektart,
    a.alteobjektbezeichnung,
    a.lisa_guid,
    a.reihenfolgeid,
    a.status,
    a.baujahr,
    a.entwaesserungsart,
    a.kommentar,
    a.knoten_knotentyp,
    a.knoten_bauwerk_bauwerkstyp,
    a.knoten_bauwerk_hersteller_typ,
    a.knoten_bauwerk_adressehersteller,
    a.knoten_bauwerk_ufis_baunummer,
    a.knoten_bauwerk_uebergabebauwerk,
    a.knoten_bauwerk_kommentar,
    d.deckelform,
    d.deckeltyp,
    d.laengedeckel,
    d.breitedeckel,
    d.abdeckungsklasse,
    d.materialabdeckung,
    d.schmutzfaenger,
    a.knoten_strang,
    a.lage_strassenschluessel,
    a.lage_strassenname,
    a.lage_ortsteilschluessel,
    a.lage_ortsteilname,
    a.lage_lageoberflaeche,
    a.lage_kommentarlage,
    a.lage_ueberschwemmungsgebiet,
    a.umweltparameter_abwasserart,
    a.umweltparameter_abwasserartwgs,
    a.umweltparameter_gwabstand,
    a.umweltparameter_wasserschutzzone,
    a.umweltparameter_bodenart,
    a.geometrie_vorlaeufigebezeichnung,
    a.geometrie_geoobjektart,
    a.geometrie_geoobjekttyp,
    a.geometrie_lagegenauigkeitsklasse,
    a.geometrie_hoehengenauigkeitsklasse,
    a.geometrie_datenherkunft,
    a.geometrie_kommentar,
    a.geometrie_crslage,
    p.punktattributabwasser,
    a.sanierung_artmassnahme,
    p.p_geom_2d AS geom
   FROM isybau.identifikati_datenkollekti_stammdatenkol_abwassertechnanlage a
     RIGHT JOIN isybau.ident_datenk_stammd_abwassanlage_knoten_bauwer_pumpwe_deckel d ON a.ogr_pkid::text = d.parent_ogr_pkid::text -- Pumpwerk
     LEFT JOIN qgisybau.v_punktgeometrien p ON a.ogr_pkid::text = p.parent_ogr_pkid::text
  WHERE a.objektart = 2 
    AND a.knoten_knotentyp = 2 
    and a.geometrie_geoobjekttyp::text = 'P'::text 
    AND (p.punktattributabwasser::text = ANY (ARRAY['SBD'::character varying::text, 'DMP'::character varying::text]))
UNION ALL
-- Zisterne
 SELECT a.ogc_fid,
    a.ogr_pkid,
    a.parent_ogr_pkid,
    a.objektbezeichnung,
    a.objektart,
    a.alteobjektbezeichnung,
    a.lisa_guid,
    a.reihenfolgeid,
    a.status,
    a.baujahr,
    a.entwaesserungsart,
    a.kommentar,
    a.knoten_knotentyp,
    a.knoten_bauwerk_bauwerkstyp,
    a.knoten_bauwerk_hersteller_typ,
    a.knoten_bauwerk_adressehersteller,
    a.knoten_bauwerk_ufis_baunummer,
    a.knoten_bauwerk_uebergabebauwerk,
    a.knoten_bauwerk_kommentar,
    d.deckelform,
    d.deckeltyp,
    d.laengedeckel,
    d.breitedeckel,
    d.abdeckungsklasse,
    d.materialabdeckung,
    d.schmutzfaenger,
    a.knoten_strang,
    a.lage_strassenschluessel,
    a.lage_strassenname,
    a.lage_ortsteilschluessel,
    a.lage_ortsteilname,
    a.lage_lageoberflaeche,
    a.lage_kommentarlage,
    a.lage_ueberschwemmungsgebiet,
    a.umweltparameter_abwasserart,
    a.umweltparameter_abwasserartwgs,
    a.umweltparameter_gwabstand,
    a.umweltparameter_wasserschutzzone,
    a.umweltparameter_bodenart,
    a.geometrie_vorlaeufigebezeichnung,
    a.geometrie_geoobjektart,
    a.geometrie_geoobjekttyp,
    a.geometrie_lagegenauigkeitsklasse,
    a.geometrie_hoehengenauigkeitsklasse,
    a.geometrie_datenherkunft,
    a.geometrie_kommentar,
    a.geometrie_crslage,
    p.punktattributabwasser,
    a.sanierung_artmassnahme,
    p.p_geom_2d AS geom
   FROM isybau.identifikati_datenkollekti_stammdatenkol_abwassertechnanlage a
     RIGHT JOIN isybau.ident_datenk_stammd_abwassanlage_knoten_bauwer_zister_deckel d ON a.ogr_pkid::text = d.parent_ogr_pkid::text -- Zisterne
     LEFT JOIN qgisybau.v_punktgeometrien p ON a.ogr_pkid::text = p.parent_ogr_pkid::text
  WHERE a.objektart = 2 
    AND a.knoten_knotentyp = 2 
    and a.geometrie_geoobjekttyp::text = 'P'::text 
    AND (p.punktattributabwasser::text = ANY (ARRAY['SBD'::character varying::text, 'DMP'::character varying::text]))
UNION ALL
-- Behandlungsanlage
 SELECT a.ogc_fid,
    a.ogr_pkid,
    a.parent_ogr_pkid,
    a.objektbezeichnung,
    a.objektart,
    a.alteobjektbezeichnung,
    a.lisa_guid,
    a.reihenfolgeid,
    a.status,
    a.baujahr,
    a.entwaesserungsart,
    a.kommentar,
    a.knoten_knotentyp,
    a.knoten_bauwerk_bauwerkstyp,
    a.knoten_bauwerk_hersteller_typ,
    a.knoten_bauwerk_adressehersteller,
    a.knoten_bauwerk_ufis_baunummer,
    a.knoten_bauwerk_uebergabebauwerk,
    a.knoten_bauwerk_kommentar,
    d.deckelform,
    d.deckeltyp,
    d.laengedeckel,
    d.breitedeckel,
    d.abdeckungsklasse,
    d.materialabdeckung,
    d.schmutzfaenger,
    a.knoten_strang,
    a.lage_strassenschluessel,
    a.lage_strassenname,
    a.lage_ortsteilschluessel,
    a.lage_ortsteilname,
    a.lage_lageoberflaeche,
    a.lage_kommentarlage,
    a.lage_ueberschwemmungsgebiet,
    a.umweltparameter_abwasserart,
    a.umweltparameter_abwasserartwgs,
    a.umweltparameter_gwabstand,
    a.umweltparameter_wasserschutzzone,
    a.umweltparameter_bodenart,
    a.geometrie_vorlaeufigebezeichnung,
    a.geometrie_geoobjektart,
    a.geometrie_geoobjekttyp,
    a.geometrie_lagegenauigkeitsklasse,
    a.geometrie_hoehengenauigkeitsklasse,
    a.geometrie_datenherkunft,
    a.geometrie_kommentar,
    a.geometrie_crslage,
    p.punktattributabwasser,
    a.sanierung_artmassnahme,
    p.p_geom_2d AS geom
   FROM isybau.identifikati_datenkollekti_stammdatenkol_abwassertechnanlage a
     RIGHT JOIN isybau.iden_date_stam_abwaanla_knote_bauwe_behan_anlag_anlag_deckel d ON a.ogr_pkid::text = d.parent_ogr_pkid::text -- Behandlungsanlage
     LEFT JOIN qgisybau.v_punktgeometrien p ON a.ogr_pkid::text = p.parent_ogr_pkid::text
  WHERE a.objektart = 2 
    AND a.knoten_knotentyp = 2 
    and a.geometrie_geoobjekttyp::text = 'P'::text 
    AND (p.punktattributabwasser::text = ANY (ARRAY['SBD'::character varying::text, 'DMP'::character varying::text]));

COMMENT ON VIEW qgisybau.v_deckel IS 'Deckel/Abdeckung: alle Arten von Deckeln und Einstiegs-Abdeckungen. Kein Objekt im ISYBAU Modell aber hilfreich für Kartendarstellung und notwendig zur Vermeidung von Multipart-/GeometryCollection-Objekten. Schachtabdeckung 1:1, Abdeckung von Versickerungsanlagen 1:1, Für die Bauwerkstypen Pumpwerk, Becken, Behandlungsanlage und Zisterne können jeweils 1:n Deckel dokumentiert sein.';
