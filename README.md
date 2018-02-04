# realty-scraper

Who says you can't put time and energy into solving dumb, everyday problems with code? Not me, apparently. I'm buying a new house and wanted to save photos from the listing for future reference, but didn't want to manually Right Click -> Save As for 30+ photos. Enter this dumb program.

Turns out my Realty Site of Choice (the Zpecific Zite shall not be named) exposes all their images for a listing at a single endpoint. The client in this program mimics a real user in a browser (with a proper User Agent so we don't look suspicious) and uses RMagick to process and save the images to your machine.

## Installation

Requires Ruby 2.3 or later and [ImageMagick](https://www.imagemagick.org/script/index.php) (`brew install imagemagick@6` on macOS).

```
git clone https://github.com/megantiu/realty-scraper.git
cd realty-scraper
gem install rmagick httparty
```

## Setup

First, you'll have to do a little sleuthing of your own.
1. Open the realty zite's listing of your property in your browser of choice (I'm in Chrome). Check the Network tab of the dev tools and select XHR.

    ![Chrome dev tools Network XHR tab](https://s3-us-west-2.amazonaws.com/github-assets-holla/Screen+Shot+2018-02-03+at+7.06.36+PM.png)

2. Click on an image to open the lightbox. You should see an additional request pop up in your tab. This is the key.

    ![new request pops up in Network list](https://s3-us-west-2.amazonaws.com/github-assets-holla/Screen+Shot+2018-02-03+at+7.08.14+PM.png)

3. Click into that request. The `Request URL` field is what we want here.

    ![test](https://s3-us-west-2.amazonaws.com/github-assets-holla/Screen+Shot+2018-02-03+at+7.08.51+PM.png)

Now, modify the file to use your specific info:

4. In `realty_scraper.rb`, replace `RealtyScraper::URL` with the full URL, **including query string parameters**, where the realty zite is hosting the images. If your URL includes basic authentication with `null:null@` before the realty zite's domain, go ahead and remove that part; it won't help where we're going.
5. Replace `Image::FILE_PATH` with the relative path to the directory where you'd like to store your images.

## Running the program

```
ruby realty_scraper.rb
```

Voila!

![resulting photos](https://s3-us-west-2.amazonaws.com/github-assets-holla/Screen+Shot+2018-02-03+at+7.02.33+PM.png)

Ultimately this is a pretty narrow and ridiculous use case, but overall, this was a silly, fun way to spend a Saturday.
