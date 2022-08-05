// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> cs = {
    "phoneNumberCode": "+420",
    "next": "Další",
    "yes": "Ano",
    "no": "Ne",
    "close": "Zavřít",
    "confirm": "Potvrdit",
    "minutes": "min",
    "min": "min",
    "seconds": "s",
    "days": " ",
    "and": "a",
    "cancel": "Zrušit",
    "ok": "Ok",
    "auth": {
      "splashMessage": "Zůstaňte ve spojení s městem",
      "phoneNumberInputPlaceholder": "Telefonní číslo",
      "enterNumberTitleText": "Zadejte své telefonní číslo",
      "enterNumberDescriptionText": "Pošleme vám SMS kód k ověření vašeho telefonního čísla",
      "termsAndConditions": "Pravidla & Podmínky",
      "privacyPolicy": "Ochrana Osobních Údajů",
      "agreementDisclaimerPart1": " Pro nové účty budou platit ",
      "agreementDisclaimerPart2": " ",
      "signInButtonText": "Přihlásit se / Registrovat",
      "smsCodeSentTitle": "Zadejte kód",
      "smsCodeSentDescription": "SMS kód byl odeslán na ",
      "smsCodeDidntReceiveButton": "Poslat znovu",
      "editPhoneButton": "Upravit telefonní číslo",
      "welcomeTitle": "Začněte dojíždět jednoduše!",
      "successfullyRegisteredTitle": "Registrace byla úspěšná!",
      "successfullyAuthorizedTitle": "Vítejte zpátky!",
      "locationPermission": {
        "allowButton": "Povolit",
        "permissionScreenTitle": "Můžeme dostat přístup k vaší poloze?",
        "permissionScreenDescription": "Citya najde ty nejlepší trasy na základě vaší polohy",
        "noPermissionAlertTitle": "Aplikace potřebuje přístup k vaší poloze pro správné fungování",
        "noPermissionAlertDescription":
            "Citya potřebuje znát vaší polohu, abychom vždycky věděli, kde vás máme vyzvednout.",
        "givePermissionButton": "Přijmout",
        "openSettingsButton": "Otevřít nastavení"
      },
      "errorEmptyPhone": "Zadejte své telefonní číslo",
      "errorInvalidPhone": "Zadejte platné telefonní číslo",
      "errorInvalidSmsCode": "Zadejte platný ověřovací kód. \nProblémy s kódem? Vyžádejte si ho znovu.",
      "errorCodeSendBlocked": "Jejda! Zrovna nám kód nejde odeslat. Zkuste to znovu později.",
      "errorService": "Jejda! Objevila se chyba. Zkuste to znovu později.",
      "errorCantRegisterDriver": "Toto číslo není spojené s žádným řidičem. Zkuste to znovu, nebo se zaregistrujte.",
      "errorUnknown": "Jejda! Něco se pokazilo. Zkuste to znovu později."
    },
    "profile": {
      "logOutButton": "Odhlásit",
      "helpButton": "Potřebuji pomoc",
      "profileInfoButton": "Profil",
      "paymentMethodsButton": "Payment methods",
      "termsAndServiceButton": "Pravidla & Podmínky",
      "deleteAccountButton": "Smazat účet",
      "deleteAccountDisclaimer":
          "Opravdu si přejete smazat svůj účet? Veškeré vaše informace budou smazány. Pokud se rozhodnete používat aplikaci Citya v budoucnu, bude třeba opětovná registrace.",
      "accountDeletedTitle": "Už se nám stýská",
      "accountDeletedDescription1":
          "Váš požadavek o smazání účtu byl zpracován. Veškeré vaše informace byly odstraněny.",
      "accountDeletedDescription2": "Pokud si přejete použít aplikaci znovu, prosím registrujte se.",
      "appVersionCaption": "Citya verze",
      "personalInfo": {
        "registrationTitle": "Rádi vás poznáváme!",
        "registrationSubtitle": "Už to skoro máte!",
        "registrationConfirmButton": "Pokračovat",
        "editProfileTitle": "Upravit profil",
        "editProfileConfirmButton": "Uložit",
        "firstNameInputCaption": "Jméno",
        "firstNameInputPlaceholder": "Vaše jméno",
        "lastNameInputCaption": "Příjmení",
        "lastNameInputPlaceholder": "Vaše příjmení",
        "emailInputCaption": "E-mail",
        "emailInputPlaceholder": "Váš e-mail",
        "fieldRequiredError": "Vyplňte prosím všechna políčka",
        "emailInvalidError": "Zkontrolujte e-mailovou adresu",
        "emailAlreadyTakenError": "Tento e-mail byl již použit"
      }
    },
    "booking": {
      "addressOnMapInputPlaceholder": "Vyberte na mapě, nebo napište zde",
      "pickupAddressInputPlaceholder": "Zadejte svou polohu",
      "dropOffAddressInputPlaceholder": "Zadejte svůj cíl",
      "pickupAddressFormTitle": "Vyberte svou polohu",
      "dropOffAddressFormTitle": "Vyberte cíl cesty",
      "confirmRequestButton": "Můžeme vyrazit!",
      "setOnMapButton": "Vyberte na mapě",
      "reviewRideTitle": "Potvrďte vaši jízdu",
      "startAddressCaption": "Začátek: ",
      "destinationAddressCaption": "Cíl: ",
      "seatsCountCaption": "Kolik míst?",
      "rideRequestPendingText": "Hledáme pro vás tu nejlepší jízdu!",
      "rideRequestApprovedText": "Připravujeme vaši jízdu!",
      "rideRequestFailedText": "Zrovna dokončujeme jiné jízdy, zkuste to prosím za minutku znovu.",
      "cancelRideButtonText": "Zrušit jízdu",
      "cancelRideConfirmationMessage": "Opravdu chcete zrušit vaši jízdu?",
      "cancelDrivingUpRideConfirmationMessage": "Auto je již na cestě. Opravdu si přejete zrušit vaši jízdu?",
      "pointOnMapPickupTitle": "Vyberte svou polohu",
      "pointOnMapDropOffTitle": "Kam to bude?",
      "tryAgainButton": "Zkuste to později",
      "rideProposal": {
        "title": "Souhrn vaší jízdy",
        "pickUpAreaCaption": "Místo vyzvednutí: ",
        "pickUpAreaTime": "{} min chůze",
        "walkToPickup": "Chůze {} min k vašemu místu vyzvednutí",
        "walkToDestination": "Chůze k cíli vaší cesty",
        "pickUpPointCaption": "Místo vyzvednutí: ",
        "dropOffPointCaption": "Místo vysazení: ",
        "estimatedTime": "Časový odhad",
        "seatsCount": {
          "zero": "žádná místa",
          "one": "{} místo",
          "two": "{} místa",
          "few": "{} míst",
          "many": "{} míst",
          "other": "{} míst"
        },
        "approveRideProposalButton": "Potvrdit"
      },
      "warningDestinationOutOfArea":
          "Na adrese, kterou jste zvolili, zatím ještě nejsme. Vyberte prosím adresu uvnitř vyznačené oblasti.",
      "warningPickupOutOfArea":
          "Na adrese, kterou jste zvolili, zatím ještě nejsme. Nabídneme vám nejbližší místo v rámci vyznačené oblasti.",
      "errorRideRequestFailed": "Jejda! Vaše žádost o jízdu se nezdařila! Zkuste to prosím později."
    },
    "ride": {
      "pickUpPointTitle": "Vyzvednutí:",
      "carArrivingIn": "Řidič přijede na místo vyzvednutí za",
      "vehicleArrived": "Vaše auto je tady!",
      "boardNow": "Nastupte teď.",
      "rideStatusOnRoute": "Na cestě",
      "rideStatusCloseToFinish": "Připravte se na vysazení",
      "stopsOnTheWayCaption": "Zastávky po cestě:",
      "etaTitle": "Očekávaný příjezd v ",
      "requestStopButton": "Vyžádat zastávku",
      "waitingForRideRequestMessage": "Čekání na žádosti o jízdu",
      "rideRequestReceivedTitle": "Přišla vám první\nžádost o jízdu",
      "acceptRideRequestButton": "Přijmout jízdu",
      "rideCardPickUpButton": "Vyzvednutí",
      "finished": {
        "rideCompletedTitle": "Jízda dokončena – doufáme, že jste si ji užili!",
        "rideCompletedDescription": "Naviděnou brzy při další jízdě"
      },
      "youMissedPickup":
          "Bohužel jste zmeškali čas vyzvednutí a nám se nepodařilo vás zastihnout. Museli jsme proto vaši jízdu zrušit.",
      "CzechKrona": "Kč"
    },
    "carSelection": {
      "welcomeTitle": "Vítejte v aplikaci pro řidiče!",
      "welcomeCallToAction": "Jaké auto budete dnes řídit?",
      "licensePlateInputPlaceholder": "Poznávací značka",
      "licensePlateCaption": "Poznávací značka",
      "seatsCaption": "Počet míst",
      "selectCarButton": "Vyberte auto",
      "notMyCarButton": "Toto není moje auto"
    },
    "driverAvailability": {
      "onlineStatus": "Online",
      "completingRideStatus": "Dokončování jízd",
      "unavailableStatus": "Offline",
      "youAreAvailableMessage": "V tuto chvíli jste online – můžete přijímat jízdy.",
      "youAreUnavailableMessage": "Nemůžete přijímat nové jízdy. \nDokončete jízdu, abyste se mohli odpojit.",
      "youAreUnavailableTitle": "Jste nedostupní",
      "youAreOfflineMessage": "Jste offline – nemůže přijímat nové jízdy.",
      "goOfflineButton": "Připravte se na odpojení",
      "goBackOnlineButton": "Znovu se připojit",
      "goOnlineButton": "Připojit se",
      "releaseTheCarButton": "Uvolněte auto",
      "driverOutOfArea":
          "Nacházíte se momentálně mimo mapu pokrytí. Přesuňte se prosím do jedné z vyznačených oblastí a zkuste to znovu."
    },
    "ongoingRides": {
      "newRequestNotification": "Máte novou žádost o jízdu. \n Vaše trasa se změnila.",
      "removedRequestNotification": "Jedna žádost o jízdu byla zrušena. \n Vaše trasa se změnila.",
      "rideCard": {
        "statusPickUp": "Vyzvednutí",
        "statusDropOff": "Vysazení",
        "actionStartRide": "Začít jízdu",
        "actionCallPassenger": "Zavolat cestujícímu",
        "actionWaitingForPassenger": "Čekání na cestujícího",
        "actionFinishRide": "Dokončit jízdu",
        "cancelRideModalMessage": "Cestující nedorazil. Chcete zrušit jízdu?"
      }
    },
    "onboarding": {
      "buttonSkip": "Přeskočit",
      "buttonFinish": "Zkuste si Citya jízdy",
      "title1": "Každodenní doprava, která vás pohodlně spojí s městem",
      "title2": "Pohodlná jízda vždy na dosah ruky",
      "title3": "Uvidíme se na Citya \nvirtuálních zastávkách!",
      "title4": "Nastupte tam, \nkde právě jste…",
      "title5": "…a jsme \ntam!",
      "title6": "Předobjednejte si jízdy \npodle potřeby",
      "title7": "Začněte dojíždět jednoduše \njiž dnes",
      "description1": "Doprava na vyžádání pro pohodlné dojíždění za cenu ranního šálku kávy.",
      "description2": "Jezděte od pondělí do soboty, mezi 7:00 a 19:00. Svezeme vás přesně tehdy, když potřebujete.",
      "description3":
          "Namísto tradičních zastávek MHD jsou Citya zastávky virtuálně kdekoliv. Jednoduše rozeznatelné, bezpečné a vždy blízko.",
      "description4":
          "Náš sdílený elektrický minivan přijede vždy nedaleko a vždy načas. Jen naskočte a užijte si jízdu!",
      "description5": "Vysadíme vás jen pár kroků od místa, kam jdete (nebo místa přestupu). A navíc šetříte emise!",
      "description6": "Pro dojíždění bez starostí si objednejte jízdy předem nebo naplánujte opakující se jízdy.",
      "description7": "Objednejte si svou první Citya jízdu a zažijte skutečné pohodlí!"
    },
    "payment": {
      "addCardType": "Add debit/credit card",
      "paymentMethod": "Payment method",
      "youMustAddMethod": "To request a ride you must add a payment method.",
      "addNewCard": "Add new card",
      "addCard": "Add card",
      "smallAmountConfirm":
          "Citya may charge a small amount to confirm your card details. \nThis is immediately refunded.",
      "continue": "Continue"
    }
  };
  static const Map<String, dynamic> en = {
    "phoneNumberCode": "+420",
    "next": "Next",
    "yes": "Yes",
    "no": "No",
    "close": "Close",
    "confirm": "Confirm",
    "minutes": "minutes",
    "min": "min",
    "seconds": "seconds",
    "days": " ",
    "and": "and",
    "cancel": "Cancel",
    "ok": "Ok",
    "auth": {
      "splashMessage": "Stay in touch with the city",
      "phoneNumberInputPlaceholder": "Phone number",
      "enterNumberTitleText": "Enter your phone number",
      "enterNumberDescriptionText": "You'll receive an SMS code to verify your phone number",
      "termsAndConditions": "Terms & Conditions",
      "privacyPolicy": "Privacy policy",
      "agreementDisclaimerPart1": " For new accounts, ",
      "agreementDisclaimerPart2": " apply",
      "signInButtonText": "Sign in / Register",
      "smsCodeSentTitle": "Enter the code",
      "smsCodeSentDescription": "SMS code was sent to ",
      "smsCodeDidntReceiveButton": "Resend code",
      "editPhoneButton": "Edit the phone number",
      "welcomeTitle": "Let's commute easy!",
      "successfullyRegisteredTitle": "Registration successful!",
      "successfullyAuthorizedTitle": "Welcome back!",
      "locationPermission": {
        "allowButton": "Allow",
        "permissionScreenTitle": "Can we access your location?",
        "permissionScreenDescription": "Citya finds the best routes based on your location",
        "noPermissionAlertTitle": "The app requires access to your location to work properly",
        "noPermissionAlertDescription": "Citya needs access to your location so we always know where to pick you up.",
        "givePermissionButton": "Accept",
        "openSettingsButton": "Open settings"
      },
      "errorEmptyPhone": "Enter your phone number",
      "errorInvalidPhone": "Enter a valid phone number",
      "errorInvalidSmsCode": "Enter a valid verification code. \nProblems with the code? Request it again.",
      "errorCodeSendBlocked": "Oops! We cannot send the code right now. Please try again later.",
      "errorService": "Oops! An error occurred. Please try again later.",
      "errorCantRegisterDriver": "This phone number is not associated with any driver account. Try again or sign up.",
      "errorUnknown": "Oops! Something went wrong. Try again later."
    },
    "profile": {
      "logOutButton": "Logout",
      "helpButton": "Help",
      "profileInfoButton": "Your profile",
      "paymentMethodsButton": "Payment methods",
      "termsAndServiceButton": "Terms & Conditions",
      "deleteAccountButton": "Delete account",
      "deleteAccountDisclaimer":
          "Do you really want to delete your account? Information about your profile will be removed. To use Citya after it you would need to register again.",
      "accountDeletedTitle": "We're missing you already",
      "accountDeletedDescription1":
          "Your request to delete the account has been processed. All profile information has been removed.",
      "accountDeletedDescription2":
          "If you wish to use the service again, please register though the application one more time.",
      "appVersionCaption": "Citya Version",
      "personalInfo": {
        "registrationTitle": "Nice to meet you!",
        "registrationSubtitle": "You're almost there.",
        "registrationConfirmButton": "Continue",
        "editProfileTitle": "Edit profile",
        "editProfileConfirmButton": "Save",
        "firstNameInputCaption": "Name",
        "firstNameInputPlaceholder": "Your name",
        "lastNameInputCaption": "Surname",
        "lastNameInputPlaceholder": "Your surname",
        "emailInputCaption": "Email",
        "emailInputPlaceholder": "Your email",
        "fieldRequiredError": "Please fill in all the fields",
        "emailInvalidError": "Please review your email address",
        "emailAlreadyTakenError": "An account with this email already exists"
      }
    },
    "booking": {
      "addressOnMapInputPlaceholder": "Choose on map or tap address here",
      "pickupAddressInputPlaceholder": "Type your location",
      "dropOffAddressInputPlaceholder": "Type your destination",
      "pickupAddressFormTitle": "Select your location",
      "dropOffAddressFormTitle": "Select destination",
      "confirmRequestButton": "Let's go!",
      "setOnMapButton": "Choose on map",
      "reviewRideTitle": "Review your ride",
      "startAddressCaption": "Start: ",
      "destinationAddressCaption": "Destination: ",
      "seatsCountCaption": "How many seats?",
      "rideRequestPendingText": "Confirming your ride",
      "rideRequestApprovedText": "We're preparing your ride!",
      "rideRequestFailedText": "Sorry, all drivers are busy now. Try again later.",
      "cancelRideButtonText": "Cancel ride",
      "cancelRideConfirmationMessage": "Are you sure you want to cancel your ride?",
      "cancelDrivingUpRideConfirmationMessage":
          "The car is already on the way. Do you really want to cancel your ride?",
      "pointOnMapPickupTitle": "Select your location",
      "pointOnMapDropOffTitle": "Where to?",
      "tryAgainButton": "Try later",
      "rideProposal": {
        "title": "Your ride summary",
        "pickUpAreaCaption": "Pick-up area: ",
        "pickUpAreaTime": "{} min walk",
        "walkToPickup": "Walk {} min to your pick-up point",
        "walkToDestination": "Walk to your destination",
        "pickUpPointCaption": "Pick-up point: ",
        "dropOffPointCaption": "Drop-off point: ",
        "estimatedTime": "Time estimate",
        "seatsCount": {
          "zero": "no seats",
          "one": "{} seat",
          "two": "{} seats",
          "few": "{} seats",
          "many": "{} seats",
          "other": "{} seats"
        },
        "approveRideProposalButton": "Confirm"
      },
      "warningDestinationOutOfArea":
          "Citya doesn't cover the address you chose. Please select an address inside the coverage area.",
      "warningPickupOutOfArea":
          "Citya is not available in this location yet. We will offer you a pick-up point within the coverage area.",
      "errorRideRequestFailed": "Oops! Your ride request has failed. Please try again later."
    },
    "ride": {
      "pickUpPointTitle": "Pick-up point:",
      "carArrivingIn": "Driver arrives at pick-up point in",
      "vehicleArrived": "Your ride is here!",
      "boardNow": "Board now.",
      "rideStatusOnRoute": "On route",
      "rideStatusCloseToFinish": "Get ready for drop-off",
      "stopsOnTheWayCaption": "Stops on the way:",
      "etaTitle": "Estimated arrival at ",
      "requestStopButton": "Request stop",
      "waitingForRideRequestMessage": "Waiting for ride requests",
      "rideRequestReceivedTitle": "You received your first\nride request",
      "acceptRideRequestButton": "Accept the ride",
      "rideCardPickUpButton": "Pick-up",
      "finished": {
        "rideCompletedTitle": "Ride complete - we hope you had a great one!",
        "rideCompletedDescription": "See you onboard soon again"
      },
      "youMissedPickup":
          "Unfortunately, you've missed the pick-up time and we couldn't reach you, so we had to cancel your ride.",
      "CzechKrona": "Kč"
    },
    "carSelection": {
      "welcomeTitle": "Welcome to the driver app!",
      "welcomeCallToAction": "Which car will you drive today?",
      "licensePlateInputPlaceholder": "License plate",
      "licensePlateCaption": "License plate",
      "seatsCaption": "Number of seats",
      "selectCarButton": "Select the car",
      "notMyCarButton": "This is not my car"
    },
    "driverAvailability": {
      "onlineStatus": "Online",
      "completingRideStatus": "Finishing rides",
      "unavailableStatus": "Offline",
      "youAreAvailableMessage": "You're currently available to receive rides.",
      "youAreUnavailableMessage": "You're not available  for new rides.\nPlease finish your rides to go offline.",
      "youAreUnavailableTitle": "You are unavailable",
      "youAreOfflineMessage": "You're currently unavailable to receive rides",
      "goOfflineButton": "Prepare to go offline",
      "goBackOnlineButton": "Go back online",
      "goOnlineButton": "Go online",
      "releaseTheCarButton": "Release the car",
      "driverOutOfArea":
          "You are currently outside of the coverage area. Please go to one of our coverage areas and try again."
    },
    "ongoingRides": {
      "newRequestNotification": "You have a new ride request.\nYour route has changed.",
      "removedRequestNotification": "One ride request has been cancelled.\nYour route has changed.",
      "rideCard": {
        "statusPickUp": "Pick-up",
        "statusDropOff": "Drop-off",
        "actionStartRide": "Start ride",
        "actionCallPassenger": "Call passenger",
        "actionWaitingForPassenger": "Waiting for passenger",
        "actionFinishRide": "Finish ride",
        "cancelRideModalMessage": "The passenger didn't show up. Do you want to cancel the ride?"
      }
    },
    "onboarding": {
      "buttonSkip": "Skip",
      "buttonFinish": "Try Citya rides",
      "title1": "Daily mobility to keep you in touch with the city",
      "title2": "Convenient ride always at your fingertips",
      "title3": "Meet you at Citya \nvirtual stops!",
      "title4": "Board right \nwhere you are…",
      "title5": "…and there \nyou go!",
      "title6": "Pre-book your rides \nwhen needed",
      "title7": "Start commuting \neasily today",
      "description1": "On-demand transport for convenient commuting for less than your morning cup of coffee.",
      "description2": "Ride from Monday to Saturday, 7:00 to 19:00. We're ready to go right when you need to.",
      "description3":
          "Instead of fixed public transport stops, Citya stops are virtually everywhere. Easily recognisable, safe and always nearby.",
      "description4":
          "Our pooled electric minivan always arrives nearby and on time. Just hop on and enjoy your journey!",
      "description5":
          "Get off just a few steps from where you need to go (or your transfer point), saving quite some CO2!",
      "description6": "For 100% hassle-free commuting, book your rides in advance or schedule recurring rides.",
      "description7": "Book your first ride with Citya and experience true convenience!"
    },
    "payment": {
      "addCardType": "Add debit/credit card",
      "paymentMethod": "Payment method",
      "youMustAddMethod": "To request a ride you must add a payment method.",
      "addNewCard": "Add new card",
      "addCard": "Add card",
      "smallAmountConfirm":
          "Citya may charge a small amount to confirm your card details. \nThis is immediately refunded.",
      "continue": "Continue"
    }
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"cs": cs, "en": en};
}
