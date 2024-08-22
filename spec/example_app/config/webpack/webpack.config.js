const mode = process.env.NODE_ENV === "development" ? "development" : "production";
const path    = require("path")
const webpack = require("webpack")

module.exports = {
  mode,
  entry: {
    application: "./app/javascript/application.js"
  },
  optimization: {
    moduleIds: "deterministic",
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    chunkFormat: "module",
    path: path.resolve(__dirname, "..", "..", "app/assets/builds"),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ]
}
