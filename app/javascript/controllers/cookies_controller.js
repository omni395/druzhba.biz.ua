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
    this.appendFacebookPixel();
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

  // Append GA
  appendGACode() {
    console.log("GA appended");
    const script = document.createElement('script');
    script.src = 'https://www.googletagmanager.com/gtag/js?id=G-B1HN94WVHN';
    script.async = true;
    script.onload = () => {
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'G-B1HN94WVHN', {
        'cookie_prefix': 'g-druzhba.biz.ua',
        'cookie_domain': 'druzhba.biz.ua',
        'cookie_expires': 28 * 24 * 60 * 60
      });
    };
    document.getElementsByTagName('head')[0].appendChild(script);
  }
  
  // Append Facebook
  appendFacebookPixel() {
    console.log("Facebook Pixel appending");
    // Создаем новый элемент script
    const script = document.createElement('script');
    // Добавляем код Facebook Pixel в этот элемент
    script.innerHTML = `
        !function(f,b,e,v,n,t,s) {
            if(f.fbq)return;
            n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};
            if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
            n.queue=[];t=b.createElement(e);t.async=!0;
            t.src=v;s=b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t,s)
        }(window, document,'script','https://connect.facebook.net/en_US/fbevents.js');
        
        fbq('init', '1562402937679169');
        fbq('track', 'PageView');
    `;
    // Добавляем скрипт в head документа
    document.getElementsByTagName('head')[0].appendChild(script);
    console.log("Facebook Pixel appended");
  }

  setConsent(i) {
    console.log("Consent appended");
    let t = document.createElement("script");
    t.id = "consent" + i;
    t.textContent = 'window.dataLayer = window.dataLayer || [];' +
        'function gtag(){dataLayer.push(arguments)};' +
        'gtag("config", "G-B1HN94WVHN");' +
        'gtag("consent", "' + i + '", {' +
        '"ad_storage": "' + (i === "default" ? "denied" : "granted") + '",' +
        '"ad_user_data": "' + (i === "default" ? "denied" : "granted") + '",' +
        '"ad_personalization": "' + (i === "default" ? "denied" : "granted") + '",' +
        '"analytics_storage": "' + (i === "default" ? "denied" : "granted") + '"' +
        '})';
    document.getElementsByTagName("head")[0].appendChild(t);
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
