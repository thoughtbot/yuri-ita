import { Controller } from "stimulus"
import hljs from 'highlight.js/lib/core';
import ruby from 'highlight.js/lib/languages/ruby';

hljs.registerLanguage('ruby', ruby);

export default class extends Controller {
  connect() {
    const codeSelector = "pre[lang=ruby] code, pre[lang=erb] code"

    document.querySelectorAll(codeSelector).forEach((block) => {
      hljs.highlightBlock(block);
    });
  }
}
