#!/usr/bin/env node

const path = require('path');
const puppeteer = require('puppeteer');
const chalk = require('chalk');
const slugify = require('@sindresorhus/slugify');

// TODO: Handle exceptions
process.on('unhandledRejection', (up) => { throw up; });

(async () => {
  const htmlPath = path.resolve(process.argv[2]);
  const pdfDir = path.dirname(htmlPath);

  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  console.log();

  await page.goto(`file:${htmlPath}`);

  const htmlTitle = await page.title();
  const pdfPath = path.join(pdfDir, `${slugify(htmlTitle)}.pdf`);

  await page.pdf({ path: pdfPath });

  // Styling like pug-cli
  console.log(chalk`  {gray rendered} {cyan ${pdfPath}}`);

  await browser.close();
})();
