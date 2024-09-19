import { Controller } from "@hotwired/stimulus";
import Cookies from 'js-cookie';

const postControllerIndexFilePath = "app/javascript/controllers/landing/index_controller.js"

export default class extends Controller {
  initialize() {
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

    // Animation effects with aos.js
    document.addEventListener('turbo:load', () => { AOS.init(
      {
        'offset': 200,
        'duration': 800,
        'easing': 'ease-in-sine'
        //'data-aos-once': true
      }
    ) });
  };
}
