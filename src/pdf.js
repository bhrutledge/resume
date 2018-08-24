const path = require('path');
const puppeteer = require('puppeteer');

// TODO: Handle exceptions
process.on('unhandledRejection', (up) => { throw up; });

(async () => {
  const htmlPath = path.resolve(process.argv[2]);
  const pdfPath = `${path.basename(htmlPath, '.html')}.pdf`;

  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  await page.goto(`file:${htmlPath}`);
  await page.pdf({ path: `${pdfPath}` });

  console.log(`Rendered ${pdfPath}`);

  await browser.close();
})();
