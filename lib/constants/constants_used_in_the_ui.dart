import 'package:apho/constants/core.dart';
import 'package:apho/constants/ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/service.dart';
import '../models/testimonial.dart';
import 'images.dart';

const THEYRESCAMMINGME = "scam";
const THEYREOFFENSIVE = "offensive";
const OTHER = "other";

const FLUTTERWAVE = "flutterwave";
const WALLET = "wallet";

const PANICBUTTONSERVICEID = "y5DP7D94rDH2vbyW73lV";
const APHOEMERGENCYSERVICESSPECIALTYID = "dYjfV0IXfJTuQdhROPh5";

List<String> reportOptions = [
  THEYRESCAMMINGME,
  THEYREOFFENSIVE,
  OTHER,
];

List<Testimonial> testimonies = [
  Testimonial(
    text:
        "ApHO is super useful to my grandma. It's where i get the nurses to care for her when I'm upcountry.",
    commenter: "Latim",
    company: null,
    post: null,
    projectName: "ApHO",
  ),
  Testimonial(
    text: "Literally all my health needs in one. Astounding.",
    commenter: "Marcel",
    company: "MEDS",
    post: "Sales Manager",
    projectName: "ApHO",
  ),
  Testimonial(
    text: "\"Recommend\" isn't a strong enough word.",
    commenter: "Emma",
    company: null,
    post: null,
    projectName: "ApHO",
  ),
];

List<ServiceModel> services = [
  ServiceModel(
    id: "antenatal",
    desc:
        "A nurse to care for aged adults and very sick patients living at home and help with all activities of personal care.\n\nComprehensive range of medical, personal, and social services coordinated to meet the physical, social, and emotional needs of people who are chronically ill or disabled.",
    image: pregnantPic,
    icon: Icons.baby_changing_station,
    color: darkerBlue,
    name: "Antenatal Care",
  ),
  ServiceModel(
    id: "postnatal",
    icon: Icons.health_and_safety,
    color: altColor,
    desc: "Caring for you after your pregnancy.",
    image: babyPic,
    name: "PostNatal Care",
  ),
  ServiceModel(
    id: "homeCleaning",
    icon: Icons.clean_hands,
    color: Colors.blue,
    image: cleanersPic,
    desc:
        "Tidying up, cleaning and maintaining hygiene in the place of residence of the patient. \n\nThese services are for patients who are unable to care for themselves or maintain their personal hygiene.",
    name: "Home Cleaners",
  ),
  ServiceModel(
    id: "homecareNurse",
    icon: FontAwesomeIcons.userNurse,
    color: primaryColor,
    desc:
        "A nurse to care for aged adults and very sick patients living at home and help with all activities of personal care.\n\nComprehensive range of medical, personal, and social services coordinated to meet the physical, social, and emotional needs of people who are chronically ill or disabled.",
    image: nurse,
    name: "Home Care Nurses",
  ),
  ServiceModel(
    id: "panicButton",
    image: panicPic,
    icon: Icons.emergency,
    color: darkerBlue,
    desc:
        "This is to be used in dire emergencies when you need medical help ASAP.\n\nThe Panic button is our latest innovative feature. You can tap it to summon emergency services to your location, for example if someone near you desperately needs medical attention but you don't know what to do.",
    name: "The Panic Button",
  ),
  ServiceModel(
    id: "swallowingReminders",
    image: clockJpg,
    desc:
        "Appointments and Reminders to take drugs.\n\nThis is meant to improve drug adherence by providing reminders to take their medicine, check their vitals and record their symptoms.",
    icon: Icons.alarm,
    color: Colors.indigo,
    name: "Swallowing Reminders",
  ),
  ServiceModel(
    id: "maternitySection",
    icon: Icons.female,
    image: babyPic,
    desc:
        "A section dedicated to the mothers. Daily maternity health tips and week by week information about the magical miraculous time of pregnancy.",
    color: primaryColor,
    name: "Maternity Section",
  ),
  ServiceModel(
    id: "healthCenters",
    desc:
        "Quick access to all sorts of pharmacies and health centers near and around you.",
    image: ambulance,
    icon: Icons.local_pharmacy,
    color: darkerBlue,
    name: "Health Centers",
  ),
];

List<ProjectModel> apps = [
  ProjectModel(
    title: "Breakthrough App Launch",
    coverImage: appScreenshots,
    left: true,
    name: "ApHO",
    color: primaryColor,
    topDesc:
        "So there we were, just enjoying your typical saturday afternoon conversation with one of our tailoring clients at REACT Offices when she started a rant about a problem she's facing. Her grandma is really old and frail and she is in dire need of daily help and support. She can't bathe herself anymore and she can't even feed herself. It was seriously impacting her and her concentration at her workplace. Aand that got us thinking.",
    image: appScreenshots,
    desc:
        "Beautiful android app for accessing medical services. In this one app, you get access to postnatal, antenatal and all sorts of other medical services you may need.",
    problem:
        "People need nurses, cleaning services and all sorts of health services but access to health in Uganda is difficult and tricky.",
    solution:
        "Introducing an app to the market that will fix all these issues and many more.",
    result:
        "A revolutionary mobile app that solves all the aforementioned problems and does much more.",
    problemDetails:
        '''Individuals living with acute and chronic health conditions confront severe difficulties in accessing healthcare services and performing household tasks.Not withstanding that proximity to health facilities is fundamental to delivering quality healthservice, nearly 30% of Ugandans live farther than one hour’s walking distance from a reliable health center. Significant clusters of low health center access are predominantly associated with areas of high poverty and urbanity. This compounds communicable and non-communicable disease burdens on healthcare systems. 
        
        [Reference: Dowhaniuk, Nicholas: Exploring country-wide equitable government healthcare facility access in Uganda - - International Journal for Equity in Health: Jan 2021].
        
        Uganda’s adult mortality rate stands at 6.381/1000 (World Bank, 2019), a significant proportion of which is attributable to dysfunctionalities in access to healthcare. Women and infants experience a higher incidence of medical emergencies and routine care-related problems such as unattended labor, neonatal disorders, unintentional injury, birth asphyxia, infections and complications of preterm birth, among countless more challenges. A report on the Situation of Newborn Health from the Ministry of Health of Uganda, (2015) indicates:
           ● At least 45,000 new-born deaths occur each year, an equal number to which are stillborn. 
           ● Only 57.4% of births were attended by skilled health personnel 
           ● Neonatal Mortality Rate (NMR) - possibly underestimated - looms high at 29deathsper 1,000 live births and has not declined in over 15 years. 
           ● Maternal mortality ratio per 100,000 live births is343(247-493)as of 2015, resultingin around 8,000 maternal deaths in Uganda each year. Additionally:
           ● UNICEF reports Uganda’s under-five mortality rate at 45.8 per 1000 live births. 
           ● Statistics from the World Health Organization show the neonatal mortality rate per 1000 live births stood at 21.4%, 2016; children dying by the age of 5 per 1000 live births at 53.0%, 2016. 
        
        This situation is particularly complicated among rural populations and internally displaced communities. Individuals with the most need for health services find difficulty with limited financial resources, stigma and misinformation regarding health services such as vaccination, a general shortage in healthcare personnel and physical barriers to transportation. This deficiency is further compounded by ongoing lockdown measures, which further restrict movement to
health facilities and access to routine healthcare, which adversely affects populations in rural and urban settings alike.''',
    problemImage: pregnantPic,
    results:
        "Our client’s frustrating experience with a dance studio has developed into a SaaS company. Ventive is handing off operations to SuitePeach’s in-house team, including developers, marketers, and a CTO, none of whom existed two years ago. Even though SuitePeach was originally designed for dance studios that serve students from preschool to high school age, with just a little UX copy tweaking, it could run a yoga studio or any other kind of studio setting. The future is bright for SuitePeach.",
    solutionDetails:
        '''The Application for Health Online is an android-based mobile application that apposes ordinary users with service providers for on-demand services that are tailored to their personal needs.The platform is designed to serve as an interface between users and serviceproviders, as an option to the traditional means of physical movement in search of health services - one riddled with transportation challenges, out-of-pocket spending and occasional neglect, especially in public health facilities. ApHO’s current model is a tripartite package comprising the client application, the service provider application and the administrator application. The client application gives users access to services and facilitates payment for the same.
        
        The service provider application combines three functions for our partners; employment, clientsupervision/ maintenance and client geolocation in instances of emergency. Only the client and service provider applications are publicly available on Google PlayStore. Features The application encapsulates the following features: 
            a. Public Health Forum: a bulletin board for disseminating vital information to promote client health and wellness allowing clients to save and share health tips across social media. 
            b. Services section: the services on offer include the “I don’t feel fine” feature, Home-based care, Antenatal care, Obstetrics and newborn care, postnatal care, treatment adherence,
housekeeping services, Talk to a Doctor (specialists on hold) and a panic button for emergencies. 
            c. Alarms Section: a reminder function to alert clients to take their medicine 
            d. Inbox: a tool for real-time consultation between clients and specialists, which information is stored therein. 
            e. Alerts: a notification function for scheduled, cancelled or rescheduled appointments.''',
  ),
  ProjectModel(
    title: "For the Health Providers",
    coverImage: aphoSpShots,
    left: false,
    name: "ApHO Health Provider",
    color: darkerBlue,
    topDesc:
        "Well, having designed the ApHO App, we needed a way for the health providers to easily manage their appointment requests and easily track their payments and work.",
    image: appScreenshots,
    desc:
        "A single app in which you can manage your appointments, business transactions and payments on the ApHO Network.",
    problem:
        "People need nurses, cleaning services and all sorts of health services but access to health in Uganda is difficult and tricky.",
    solution:
        "Introducing an app to the market that will fix all these issues and many more.",
    result:
        "A revolutionary mobile app that solves all the aforementioned problems and does much more.",
    problemDetails:
        '''Individuals living with acute and chronic health conditions confront severe difficulties in accessing healthcare services and performing household tasks.Not withstanding that proximity to health facilities is fundamental to delivering quality healthservice, nearly 30% of Ugandans live farther than one hour’s walking distance from a reliable health center. Significant clusters of low health center access are predominantly associated with areas of high poverty and urbanity. This compounds communicable and non-communicable disease burdens on healthcare systems. 
        
        [Reference: Dowhaniuk, Nicholas: Exploring country-wide equitable government healthcare facility access in Uganda - - International Journal for Equity in Health: Jan 2021].
        
        Uganda’s adult mortality rate stands at 6.381/1000 (World Bank, 2019), a significant proportion of which is attributable to dysfunctionalities in access to healthcare. Women and infants experience a higher incidence of medical emergencies and routine care-related problems such as unattended labor, neonatal disorders, unintentional injury, birth asphyxia, infections and complications of preterm birth, among countless more challenges. A report on the Situation of Newborn Health from the Ministry of Health of Uganda, (2015) indicates:
           ● At least 45,000 new-born deaths occur each year, an equal number to which are stillborn. 
           ● Only 57.4% of births were attended by skilled health personnel 
           ● Neonatal Mortality Rate (NMR) - possibly underestimated - looms high at 29deathsper 1,000 live births and has not declined in over 15 years. 
           ● Maternal mortality ratio per 100,000 live births is343(247-493)as of 2015, resultingin around 8,000 maternal deaths in Uganda each year. Additionally:
           ● UNICEF reports Uganda’s under-five mortality rate at 45.8 per 1000 live births. 
           ● Statistics from the World Health Organization show the neonatal mortality rate per 1000 live births stood at 21.4%, 2016; children dying by the age of 5 per 1000 live births at 53.0%, 2016. 
        
        This situation is particularly complicated among rural populations and internally displaced communities. Individuals with the most need for health services find difficulty with limited financial resources, stigma and misinformation regarding health services such as vaccination, a general shortage in healthcare personnel and physical barriers to transportation. This deficiency is further compounded by ongoing lockdown measures, which further restrict movement to
health facilities and access to routine healthcare, which adversely affects populations in rural and urban settings alike.''',
    problemImage: nurse,
    results:
        "Our client’s frustrating experience with a dance studio has developed into a SaaS company. Ventive is handing off operations to SuitePeach’s in-house team, including developers, marketers, and a CTO, none of whom existed two years ago. Even though SuitePeach was originally designed for dance studios that serve students from preschool to high school age, with just a little UX copy tweaking, it could run a yoga studio or any other kind of studio setting. The future is bright for SuitePeach.",
    solutionDetails:
        '''The Application for Health Online is an android-based mobile application that apposes ordinary users with service providers for on-demand services that are tailored to their personal needs.The platform is designed to serve as an interface between users and serviceproviders, as an option to the traditional means of physical movement in search of health services - one riddled with transportation challenges, out-of-pocket spending and occasional neglect, especially in public health facilities. ApHO’s current model is a tripartite package comprising the client application, the service provider application and the administrator application. The client application gives users access to services and facilitates payment for the same.
        
        The service provider application combines three functions for our partners; employment, clientsupervision/ maintenance and client geolocation in instances of emergency. Only the client and service provider applications are publicly available on Google PlayStore. Features The application encapsulates the following features: 
            a. Public Health Forum: a bulletin board for disseminating vital information to promote client health and wellness allowing clients to save and share health tips across social media. 
            b. Services section: the services on offer include the “I don’t feel fine” feature, Home-based care, Antenatal care, Obstetrics and newborn care, postnatal care, treatment adherence,
housekeeping services, Talk to a Doctor (specialists on hold) and a panic button for emergencies. 
            c. Alarms Section: a reminder function to alert clients to take their medicine 
            d. Inbox: a tool for real-time consultation between clients and specialists, which information is stored therein. 
            e. Alerts: a notification function for scheduled, cancelled or rescheduled appointments.''',
  )
];

List<Team> team = [
  Team(
    id: "mitirikpwePatricia",
    name: "Patricia Mitirikpwe",
    color: Colors.pink,
    image: patricia,
    post: "Operations Manager",
    desc:
        "Patricia Mitirikpwe possesses extensive experience working in private and public sectors. She has successfully provided human resource and administrative leadership for DEAP initially, and later REACT, from project start-up, serving as the link between management and employees as well as external partners, by handling questions, interpreting and administering contracts and helping resolve work related problems. Patricia possesses experience in development and implementation of human resource policies, maintenance of records and compilation of project and personnel reports. She has a Bachelor’s degree in Industrial and Fine Art from Makerere University, Kampala, Uganda.",
    email: null,
    linkedIn: null,
    phone: aphoPhoneNumber,
  ),
  Team(
    id: "michealMukiibi",
    name: "Micheal Mukiibi",
    color: primaryColor,
    post: "CEO",
    image: micheal,
    desc:
        '''Michael Mukiibi has had a progressive public health career during which he has accumulated over 16 years of experience in strengthening and upscaling laboratories and health systems across different countries to create resilient and sustainable programs sensitive enough to detect global health security risks from microbial threats. He achieved this while working in multiple organizations funded by the U.S. Centers for Disease Control and Prevention (CDC), the United States Agency for International Development (USAID), the German Corporation and the Global Fund. 

More broadly, his speciality encompasses quality management systems, supply chain management, emerging and reemerging infectious diseases including Antimicrobial Resistance (AMR) surveillance/containment; infectious disease and epidemic prevention and control; Human Immunodeficiency Virus/Tuberculosis (HIV/TB) surveillance; leadership and management; development and operationalization of policies, guidelines and standard operating procedures. He has operated across Africa, having commenced his career in Uganda, which later broadened to Nigeria, Liberia, Malawi, Somalia, and Zimbabwe. He has enhanced his expertise in Virology through a preceptorship at the Institute of Human Virology (IHV) of the University of Maryland in Baltimore, USA.

Michael possesses a Bachelor of Biomedical Laboratory Technology, a Master of Technology in Medical Microbiology and a Master of Science in Public Health. He is currently a PhD candidate of Public Health.''',
    email: "http://mukiibim@reactug.org/",
    linkedIn: null,
    phone: null,
  ),
  Team(
    id: "mubiruSimeon",
    name: "Mubiru Simeon",
    color: Colors.purple,
    image: micheal,
    post: "IT Manager",
    desc:
        "Simeon is good at coding and computer stuff. He studied from here and then he studied a little more from there and then afterwards, he added some more studying from here and there. Geneh he has studied a lot.",
    email: "mubzsimeon@gmail.com",
    linkedIn: "simeon.web.app",
    phone: "0708387637",
  ),
];

class Team {
  final String name;
  final String image;
  final Color color;
  final String desc;
  final String post;
  final String linkedIn;
  final String phone;
  final String id;
  final String email;
  Team({
    @required this.name,
    @required this.id,
    @required this.color,
    @required this.image,
    @required this.desc,
    @required this.post,
    @required this.email,
    @required this.linkedIn,
    @required this.phone,
  });
}

class ProjectModel {
  final String name;
  final String image;
  final Color color;
  final String desc;
  final String solution;
  final String problem;
  final String problemImage;
  final String problemDetails;
  final String results;
  final String solutionDetails;
  final String topDesc;
  final String result;
  final String coverImage;
  final String title;
  final bool left;

  ProjectModel({
    @required this.name,
    @required this.color,
    @required this.topDesc,
    @required this.image,
    @required this.desc,
    @required this.problem,
    @required this.solution,
    @required this.result,
    @required this.problemDetails,
    @required this.problemImage,
    @required this.results,
    @required this.solutionDetails,
    @required this.left,
    @required this.title,
    @required this.coverImage,
  });
}
