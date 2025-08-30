import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~10.1.0/config";

export class Config extends BaseConfig {
  override config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiOptions: {
        //_: {
        //  filterInputFunc: "cmdline#input",
        //  filterInputOptsFunc: "cmdline#input_opts",
        //},
        filer: {
          toggle: true,
        },
      },
      uiParams: {
        ff: {
          autoAction: {
            name: "preview",
            delay: 100,
          },
          split: "floating",
          floatingBorder: "rounded",
          startFilter: true,
          prompt: "> ",
          previewFloating: true,
          previewFloatingBorder: "rounded",
          previewFloatingTitle: "Preview",
          filterSplitDirection: "floating",
          filterFloatingPosition: "top",
        },
        filer: {
          autoAction: {
            name: "preview",
          },
          split: "floating",
          floatingBorder: "rounded",
          floatingTitle: "Filer",
          winWidth: "&columns / 2 + 1",
          winHeight: "&lines / 2 + 1",
          previewSplit: "floating",
          previewFloating: true,
          previewFloatingBorder: "rounded",
          previewFloatingTitle: "Preview",
          previewWidth: 80,
          previewHeight: 20,
        },
      },
      sourceOptions: {
        _: {
          ignoreCase: true,
          matchers: [
            "matcher_substring",
          ],
        },
      },
      sourceParams: {
        rg: {
          args: [
            "--smart-case",
            "--column",
            "--no-heading",
            "--color",
            "never",
          ],
        },
      },
      kindOptions: {
        action: {
	      defaultAction: "do",
        },
        file: {
	      defaultAction: "open",
	    },
      },
    });
    args.contextBuilder.patchLocal("file_recursive", {
      sources: [
        {
          name: [ "file_rec" ],
          options: {
            converters: [
              "converter_devicon",
            ],
          },
          params: {
            ignoredDirectories: [
              ".git",
            ],
          },
        },
      ],
    });
    args.contextBuilder.patchLocal("filer", {
      ui: "filer",
      sources: [
        {
          name: [ "file" ],
          param: {},
        },
      ],
      sourceOptions: {
        _: {
	      columns: [ "filename" ],
        },
      },
    });
    args.contextBuilder.patchLocal("rg", {
      sources: [
        {
          name: [ "colorscheme" ],
        },
      ],
      kindOptions: {
        colorscheme: {
          defaultAction: "set",
        },
      },
    });

    return Promise.resolve();
  }
}
