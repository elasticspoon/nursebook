module.exports = {
  plugins: [
    require("postcss-import"),
    require("postcss-import-ext-glob"),
    require("postcss-nesting"),
    require("autoprefixer"),
    require("css-has-pseudo"),
  ],
};
