*** Settings ***
Library           SeleniumLibrary
Library           DateTime
Library           String
Library           Dialogs
Library           OperatingSystem
Library           Collections
Resource          ../Ressources/Keywords/keywords.robot


*** Variables ***
${vURL}           http://localhost:8088/share/page
${vBrowser}       chrome
${vUsername}      admin
${vPassword}      12345678
${TIMEOUT}        5s

# Mock data
#K13: Creer une liste de donnes(dans un site deja cree)
${nomTypeDonnes}    Liste de contacts
${title}    Creer_Une_Liste111111
${description}    Test1
#K28: Supprimer un type personnalise(dans un modele deja cree)
${nomSite}    Groupe1247
${nomModele}    Nanana
${vTypePersonalise}    Nanananana:Test4

${nom_Module}    Calendrier

*** Test Cases ***
Creer Une Liste De Donnes Pour Un Site Deja Creer
    Login    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword} 
    Sleep    3
    Creer Une Liste De Donnes    ${nomSite}    ${nomTypeDonnes}    ${title}    ${description}
    Logout

Supprimer un type personnalite dans un modele
    Login    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}
    Sleep    3
    Supprimer un type personnalise    ${nomModele}    ${vTypePersonalise}
   

Afficher un module dans un site deja cree
    Login    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}
    Sleep    3
    Afficher un module dans un site    ${nomSite}    ${nom_Module}
    Sleep    3
    Logout
