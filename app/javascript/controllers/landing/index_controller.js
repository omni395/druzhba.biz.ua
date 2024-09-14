import { Controller } from "@hotwired/stimulus"
import Cookies from 'js-cookie'

const postControllerIndexFilePath = "app/javascript/controllers/landing/index_controller.js"

// Connects to data-controller="posts--index"
export default class extends Controller {

  // Optional function for when controller is initialized, can remove
  initialize(){
    //this.initializeFlowbite();
    this.initializeAnimateCSS();
    this.initializeGoogleFonts();
  }

  // Optional function for when controller is connected, can remove
  connect(){
    if (this.areCookiesAllowed()) {
      this.appendGACode();
      this.consentUpdate();
    }
    else {
      this.consentDefault();
    }

    this.exFunction();
    window.addEventListener('load', function(){
      $('.odd').addClass('animate__animated animate__fadeInUp');
      $('.even').addClass('animate__animated animate__fadeInUp');
      $('.odd, .even').attr("data-wow-duration", "2s");
      $('.odd,  .even').attr("data-wow-delay", ".5s");
    });

    // Other functions you want to execute when controller is connected
  }

  // Optional function for when controller is disconnected, can remove
  disconnect() {
  }

  areCookiesAllowed() {
    return Cookies.get("allow_cookies") === "yes";
  }

  allowCookies() {
    document.getElementById('consentDefault').remove();
    Cookies.set('allow_cookies', 'yes', {
      expires: 28
    });

    this.appendGACode();
    this.hideBar();
  }

  rejectCookies() {
    Cookies.set('allow_cookies', 'no', {
      expires: 28
    });

    this.hideBar();
  }

  hideBar() {
    //document.getElementsByClassName('cookies-bar').addClass('hidden');
    this.element.classList.add('hidden');
  }

  appendGACode() {
    const tagManagerScriptTag = document.createElement("script");
    const eventsScriptTag = document.createElement("script");
    const facebookPixel = document.createElement("script");

    tagManagerScriptTag.src = "https://www.googletagmanager.com/gtag/js?id=G-B1HN94WVHN";
    tagManagerScriptTag.async = true;

    eventsScriptTag.textContent = "window.dataLayer = window.dataLayer || []; \
          function gtag(){dataLayer.push(arguments);} \
          gtag('js', new Date());\
          gtag('config', 'GTM-TJBHGWFJ', {\
              'cookie_prefix': 'gtm-druzhba.biz.ua',\
              'cookie_domain': 'druzhba.biz.ua',\
              'cookie_expires': 28 * 24 * 60 * 60\
          });\
          gtag('config', 'G-B1HN94WVHN', {\
              'cookie_prefix': 'g-druzhba.biz.ua',\
              'cookie_domain': 'druzhba.biz.ua',\
              'cookie_expires': 28 * 24 * 60 * 60});";
    
    facebookPixel.id = 'facebookPixel';
    facebookPixel.textContent = "!function(f,b,e,v,n,t,s)\
          {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\
          n.callMethod.apply(n,arguments):n.queue.push(arguments)};\
          if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\
          n.queue=[];t=b.createElement(e);t.async=!0;\
          t.src=v;s=b.getElementsByTagName(e)[0];\
          s.parentNode.insertBefore(t,s)}(window, document,'script',\
          'https://connect.facebook.net/en_US/fbevents.js');\
          fbq('init', '1562402937679169');\
          fbq('track', 'PageView');";
    
    document.getElementsByTagName('head')[0].appendChild(tagManagerScriptTag);
    document.getElementsByTagName('head')[0].appendChild(eventsScriptTag);
    document.getElementsByTagName('head')[0].appendChild(facebookPixel);
  }
 
  consentDefault() {
    const defaultConsent = document.createElement("script");
    defaultConsent.id = 'consentDefault';
    defaultConsent.textContent = 'window.dataLayer = window.dataLayer || [];\
        function gtag(){dataLayer.push(arguments)};\
        gtag("config", "GTM-TJBHGWFJ");\
        gtag("config", "G-B1HN94WVHN");\
        gtag("consent", "default", {\
          "ad_storage": "denied",\
          "ad_user_data": "denied",\
          "ad_personalization": "denied",\
          "analytics_storage": "denied"\
        })\
    ';
    document.getElementsByTagName('head')[0].appendChild(defaultConsent);
  }

  consentUpdate() {
    const updateConsent = document.createElement("script");
    updateConsent.id = 'consentupdate';
    updateConsent.textContent = 'window.dataLayer = window.dataLayer || [];\
        function gtag(){dataLayer.push(arguments)};\
        gtag("config", "GTM-TJBHGWFJ");\
        gtag("config", "G-B1HN94WVHN");\
        gtag("consent", "update", {\
          "ad_storage": "granted",\
          "ad_user_data": "granted",\
          "ad_personalization": "granted",\
          "analytics_storage": "granted"\
        })\
    ';
    document.getElementsByTagName('head')[0].appendChild(updateConsent);
  }

  exFunction() {
    // Плавная прокрутка
    var $page = $('html, body');
    $('a[href*="#"]').click(function() {
        $page.animate({
            scrollTop: $($.attr(this, 'href')).offset().top
        }, 400);
        return false;
    });

    // Toggle the modal
    const openContactFormButton = document.getElementById('openContactForm');
    const closeContactFormButton = document.getElementById('closeContactForm');
    const contactFormModal = document.getElementById('contactFormModal');
    
    openContactFormButton.addEventListener('click', () => {
        contactFormModal.classList.remove('hidden');
    });

    closeContactFormButton.addEventListener('click', () => {
        contactFormModal.classList.add('hidden');
    });

    // Toggle nav menu
    const toggleNavMenu = document.getElementById('toggleNavMenu');
    const navMenu = document.getElementById('navMenu');
    toggleNavMenu.addEventListener('click', () => {
        navMenu.classList.toggle('hidden');
    });
  };

  initializeGoogleFonts() {
    const googleFontsApis = document.createElement('link');
    const googleFontsGstatic = document.createElement('link');
    const googleFontElMessiri = document.createElement('link');
    const googleFontBadScript = document.createElement('link');

    googleFontsApis.href = 'https://fonts.googleapis.com';
    googleFontsApis.rel = 'preconnect';
    
    googleFontsGstatic.crossorigin = '';
    googleFontsGstatic.href = 'https://fonts.gstatic.com';
    googleFontsGstatic.rel = 'preconnect';
    
    googleFontElMessiri.href = 'https://fonts.googleapis.com/css2?family=El+Messiri:wght@400..700&display=swap';
    googleFontElMessiri.rel = 'stylesheet';

    googleFontBadScript.href = 'https://fonts.googleapis.com/css2?family=Bad+Script&family=messiri:wght@400..700&display=swap';
    googleFontBadScript.rel = 'stylesheet';

    document.getElementsByTagName('head')[0].appendChild(googleFontsApis);
    document.getElementsByTagName('head')[0].appendChild(googleFontsGstatic);
    document.getElementsByTagName('head')[0].appendChild(googleFontElMessiri);
    document.getElementsByTagName('head')[0].appendChild(googleFontBadScript);
  };

  // AnimatedCSS and WOWjs
  initializeAnimateCSS() {
    const animateCSSLink = document.createElement('link');
    const animateCSSScript = document.createElement('script');
    const WOWjsScript = document.createElement('script');

    animateCSSLink.href = 'https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css';
    animateCSSLink.rel = 'stylesheet';

    animateCSSScript.async = true;
    animateCSSScript.crossorigin = 'anonymous';
    animateCSSScript.integrity = 'sha512-Eak/29OTpb36LLo2r47IpVzPBLXnAMPAVypbSZiZ4Qkf8p/7S/XRG5xp7OKWPPYfJT6metI+IORkR5G8F900+g==';
    animateCSSScript.referrerpolicy = 'no-referrer';
    animateCSSScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.min.js';

    WOWjsScript.async = true;
    WOWjsScript.integrity = 'sha512-Eak/29OTpb36LLo2r47IpVzPBLXnAMPAVypbSZiZ4Qkf8p/7S/XRG5xp7OKWPPYfJT6metI+IORkR5G8F900+g==';
    WOWjsScript.crossorigin = 'anonymous';
    WOWjsScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.min.js';
    WOWjsScript.referrerpolicy = 'no-referrer';

    document.getElementsByTagName('head')[0].appendChild(animateCSSLink);
    document.getElementsByTagName('head')[0].appendChild(animateCSSScript);
    document.getElementsByTagName('head')[0].appendChild(WOWjsScript);
  };

  /* FlowbiteJS
  initializeFlowbite() {
    const flowbiteLink = document.createElement('link');
    const flowbiteScript = document.createElement('script');

    flowbiteLink.href = 'https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.5.1/flowbite.min.css';
    flowbiteLink.rel = 'stylesheet';

    flowbiteScript.async = true;
    flowbiteScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.5.1/flowbite.min.js';

    document.getElementsByTagName('head')[0].appendChild('flowbiteLink');
    document.getElementsByTagName('head')[0].appendChild('flowbiteScript');
  };
  */
}