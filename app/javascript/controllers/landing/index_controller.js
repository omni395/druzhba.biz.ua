import { Controller } from "@hotwired/stimulus"
import Cookies from 'js-cookie'

const postControllerIndexFilePath = "app/javascript/controllers/landing/index_controller.js"

// Connects to data-controller="posts--index"
export default class extends Controller {

  // Optional function for when controller is initialized, can remove
  initialize(){
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
      expires: 365
    });

    this.appendGACode();
    this.hideBar();
  }

  rejectCookies() {
    Cookies.set('allow_cookies', 'no', {
      expires: 365
    });

    this.hideBar();
  }

  hideBar() {
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
}
