import { Controller } from "@hotwired/stimulus"
import Cookies from 'js-cookie'

const postControllerIndexFilePath = "app/javascript/controllers/landing/index_controller.js"

export default class extends Controller {
  initialize() {
    this.initializeAnimateCSS();
    this.initializeGoogleFonts();
  }

  connect() {
    if (this.areCookiesAllowed()) {
      this.appendGACode();
      this.setConsent('update');
    } else {
      this.setConsent('default');
    }

    this.exFunction();
  }

  areCookiesAllowed() {
    return Cookies.get("allow_cookies") === "yes";
  }

  allowCookies() {
    const consentDefault = document.getElementById('consentDefault');
    if (consentDefault) {
      consentDefault.remove();
    }
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
    const consentDefault = document.getElementById('consentDefault');
    if (consentDefault) {
      consentDefault.remove();
    }
  }

  appendGACode() {
    const script = document.createElement('script');
    script.src = 'https://www.googletagmanager.com/gtag/js?id=G-B1HN94WVHN';
    script.async = true;
    script.onload = () => {
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'GTM-TJBHGWFJ', {
        'cookie_prefix': 'gtm-druzhba.biz.ua',
        'cookie_domain': 'druzhba.biz.ua',
        'cookie_expires': 28 * 24 * 60 * 60
      });
      gtag('config', 'G-B1HN94WVHN', {
        'cookie_prefix': 'g-druzhba.biz.ua',
        'cookie_domain': 'druzhba.biz.ua',
        'cookie_expires': 28 * 24 * 60 * 60
      });
    };
    document.getElementsByTagName('head')[0].appendChild(script);
  }

  setConsent(type) {
    const script = document.createElement("script");
    script.id = 'consent' + type;
    script.textContent = 'window.dataLayer = window.dataLayer || [];function gtag(){dataLayer.push(arguments)};gtag("config", "GTM-TJBHGWFJ");gtag("config", "G-B1HN94WVHN");gtag("consent", "' + type + '", {"ad_storage": "' + (type === 'default'? 'denied' : 'granted') + '","ad_user_data": "' + (type === 'default'? 'denied' : 'granted') + '","ad_personalization": "' + (type === 'default'? 'denied' : 'granted') + '","analytics_storage": "' + (type === 'default'? 'denied' : 'granted') + '"})';
    document.getElementsByTagName('head')[0].appendChild(script);
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

  initializeAnimateCSS() {
    const animateCSSLink = document.createElement('link');
    const animateCSSScript = document.createElement('script');
    const WOWjsScript = document.createElement('script');

    animateCSSLink.href = 'https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.compat.min.css';
    animateCSSLink.rel = 'stylesheet';
    animateCSSScript.integrity = 'sha512-b42SanD3pNHoihKwgABd18JUZ2g9j423/frxIP5/gtYgfBz/0nDHGdY/3hi+3JwhSckM3JLklQ/T6tJmV7mZEw==';

    WOWjsScript.crossorigin = 'anonymous';
    WOWjsScript.async = true;
    WOWjsScript.integrity = 'sha512-Eak/29OTpb36LLo2r47IpVzPBLXnAMPAVypbSZiZ4Qkf8p/7S/XRG5xp7OKWPPYfJT6metI+IORkR5G8F900+g==';
    WOWjsScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.min.js?crossorigin=anonymous';
    WOWjsScript.referrerpolicy = 'no-referrer';

    document.getElementsByTagName('head')[0].appendChild(animateCSSLink);
    document.getElementsByTagName('head')[0].appendChild(animateCSSScript);
    document.getElementsByTagName('head')[0].appendChild(WOWjsScript);
  };
  
}
