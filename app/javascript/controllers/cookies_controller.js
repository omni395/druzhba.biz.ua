import { Controller } from "@hotwired/stimulus"
import Cookies from 'js-cookie';

// Connects to data-controller="landing--cookies"
export default class extends Controller {
  connect() {
    console.log('connected');
    if (this.areCookiesAllowed()) {
      this.appendGACode();
      this.setConsent('update');
    } else {
      this.setConsent('default');
    }
    this.addListeners();
  }

  areCookiesAllowed() {
    return Cookies.get("allow_cookies") === "yes";
  }

  allowCookies() {
    console.log("allowCookies called");
    console.log("allow_cookies:", Cookies.get("allow_cookies"));
    const consentDefault = document.getElementById('consentdefault');
    if (consentDefault) {
      consentDefault.remove();
    }
    Cookies.set('allow_cookies', 'yes');
    console.log("allow_cookies after setting:", Cookies.get("allow_cookies"));
    this.appendGACode();
    this.setConsent('update');
    this.hideBar();
  }
  
  rejectCookies() {
    if (Cookies.get("allow_cookies") === "no") return;
    Cookies.set('allow_cookies', 'no');
    this.hideBar();
  }

  hideBar() {
    console.log("hideBar called");
    const consentDefault = document.getElementById('consentdefault');
    const cookiesBar = document.getElementById('cookies-bar');
    if (consentDefault) {
      consentDefault.remove();
    }
    cookiesBar.classList.add('hidden');
    console.log("cookiesBar hidden:", cookiesBar.classList.contains('hidden'));
  }

  appendGACode() {
    console.log("GA appended");
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

  addListeners() {
    // Add event listeners to cookies buttons
    const acceptButton = document.getElementById('accept');
    const rejectButton = document.getElementById('reject');
  
    if (acceptButton) {
      acceptButton.addEventListener('click', () => this.allowCookies());
    }
      
    if (rejectButton) {
      rejectButton.addEventListener('click', () => this.rejectCookies());
    }
  }
}
