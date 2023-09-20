*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String
Library    OperatingSystem
Library    XML
Library    Collections
Variables    ../Locators/locatorsLoginDashbordPage.py
Variables    ../Locators/locatorsAdminPage.py
Variables    ../Locators/locatorsFormUneListeDonnes.py
Variables    ../Locators/locatorsGestionnaireModele.py
Variables    ../Locators/locatorsModuleSitePage.py

*** Variables ***
${TIMEOUT}        10s
${vURL}

*** Keywords ***

Login
    # vURL contient l'adresse URL de la page web
    # vBrowser contient l'identifiant du navigateur cible
    # vUsername contient le login
    # vPassword contient le mot de passe
    [Arguments]    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}
    # Definir la valeur de timeout pour le cas de test
    Set Selenium Timeout    ${TIMEOUT}
    # Ouvrir le navigateur en precisant l'URL et le navigateur   
    Open Browser    ${vURL}    ${vBrowser}    options=add_argument('--lang=fr')

    # Maximiser la fenetre du navigateur
    Maximize Browser Window
    # Saisie du login
    Input text    ${txt_UserName}    ${vUsername}
    # Saisie du mot de passe
    Input text    ${txt_Password}    ${vPassword}
    # Click sur le bouton Connexion
    Click Button    ${btn_Login}
    # S'assurer que la page est chargee
    Wait Until Element Is Visible    ${lblTitle}
    # S'assurer que l'utilisateur est connecte et que le tableau de bord est affiche
    Element Should Contain    ${lblTitle}    Tableau de bord de
Logout
    Wait Until Element Is Visible    ${link_HeaderUserMenu}
    Click Element    ${link_HeaderUserMenu}
    Wait Until Element Is Visible    ${link_HeaderDeconnexion}
    Click Element    ${link_HeaderDeconnexion}
    #[Teardown]    Close Browser


# K13: Creer une liste de donnes(dans un site deja cree)
Creer Une Liste De Donnes   
    [Arguments]    ${nomSite}    ${nomTypeDonnes}    ${title}    ${description}

    Wait Until Element Is Visible    ${link_HeaderAccueil}
    Sleep    3
    #Aller sur la site   
    Go To    ${vURL}/site/${nomSite}/dashboard
    Sleep    3
    Click Element    ${tab_Liste_De_Donnes}
    Sleep    3
    #Click sur le bouton de creer la liste nouvelle
    Click Element    ${btn_Nouvelle_liste}
    Sleep    3
    #Choisir Agenda Evenement    
    Click Element    ${link_Type_Donnes_P1}${nomTypeDonnes}${link_Type_Donnes_P2}
    #Input title et description dans le form
    Input Text    ${input_Title}    ${title}
    Sleep    3
    Input Text    ${input_Description}    ${description}
    Sleep    3
    #Click sur le bouton Enregistrer
    Click Element    ${btn_Enregistrer}
    Sleep    3

#K28: Supprimer un type personnalise(dans un modele deja cree)
Supprimer un type personnalise
    [Arguments]    ${vNomModele}    ${vTypePersonalise}

    Wait Until Element Is Visible    ${link_HeaderAccueil}
    Sleep    3
    #Aller sur l'outil Admin   
    Go To    ${vURL}/console/admin-console/application
    Sleep    3
    #Click sur la link Gestion de Modeles
    Click Element    ${gestionnaire_De_Modeles}
    Sleep    3
    Wait Until Element Is Visible    //*[contains(text(), 'Actions')]
    #Click sur le nom de modele
    Click Element    ${link_NomModelePart1}${vNomModele}${link_NomModelePart2}
    Sleep    3
    
    Wait Until Element Is Visible    ${nom_Modele_HEADINGPart1}${vNomModele}${nom_Modele_HEADINGPart2}
    #Click sur le menu Actions que le nom de type de personalise
    Click Element    ${link_ActionMenuPart1}${vTypePersonalise}${link_ActionMenuPart2}
    Sleep    3 

    #Click sur l'option Supprimer du menu Actions 
    ${item2}=     Get WebElement    ${img_Deleted}  
    Click Element    ${item2}    
    Sleep    3

    #Attendre le popup visible
    Wait Until Element Is Visible    ${supprimer_DIALOG_HEADING}

    #Click sur le bouton Supprimer
    ${btnSupprimer}=    Get WebElement    ${btn_Supprimer}
    Click Element    ${btnSupprimer}
    Sleep    3 

#K43: Afficher un module dans un site
Afficher un module dans un site
    [Arguments]    ${nomSite}    ${nomModule}
    Wait Until Element Is Visible    ${link_HeaderAccueil}
    Sleep    3 
    #Aller sur la site  
    Go To    ${vURL}/site/${nomSite}/dashboard
    Sleep    3
    
    ${nomModuleExist}=    Get Text    ${nom_Module_Locator_P1}${nomModule}${nom_Module_Locator_P2}
    # Check le module est diponible dans la tabs,
    IF   "${nomModuleExist}" == "${nomModule}"
        #S'il est disponible, click le
        Click Element    ${nom_Module_Locator_P1}${nomModule}${nom_Module_Locator_P2}
        Sleep    3
    ELSE
        #Si no, click sur le Plus
        Click Element    ${btn_Plus}
        Sleep    3
        #Affichage une liste de module
        #Choisir le module par click sur le nom de module
        Click Element    ${nom_Module_De_Liste_P1}${nomModule}${nom_Module_De_Liste_P2} 
        Sleep    3       
    END
    