module.exports = {
  runtimeCompiler: true,

  chainWebpack: (config) => {
    config.plugin("html").tap((args) => {
      //   args[0].title = "Muse Vue Ant Design - by Creative Tim";
      args[0].title = "Happyhouse";
      return args;
    });
  },

  pluginOptions: {
    express: {
      shouldServeApp: false,
      serverDir: "N",
    },
  },
};
