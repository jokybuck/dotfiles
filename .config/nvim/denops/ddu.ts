import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~10.1.0/config";

export class Config extends BaseConfig {
  override config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiOptions: {
        _: {
          filterInputFunc: "cmdline#input",
          filterInputOptsFunc: "cmdline#input_opts",
        },
        filer: {
          toggle: true,
        },
      },
      uiParams: {
        ff: {
          autoAction: {
            name: "preview",
          },
          split: "floating",
          winWidth: '&columns * 2 / 3',
          winHeight: '&lines * 2 / 3',
          winRow: '(&lines - eval(uiParams.winHeight)) / 2',
          floatingBorder: "rounded",
          previewFloating: true,
          previewSplit: "horizontal",
          previewFloatingBorder: "rounded",
          previewFloatingTitle: "Preview",
          previewWidth: 'eval(uiParams.winWidth)',
        },
        filer: {
          autoAction: {
            name: "preview",
          },
          split: "floating",
          winWidth: '&columns * 2 / 3',
          winHeight: '&lines * 2 / 3',
          winRow: '(&lines - eval(uiParams.winHeight)) / 2',
          floatingBorder: "rounded",
          floatingTitle: "Filer",
          previewSplit: "horizontal",
          previewFloatingBorder: "rounded",
          previewFloatingTitle: "Preview",
          previewWidth: 'eval(uiParams.winWidth)',
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
        help: {
	      defaultAction: "open",
	    },
      },
    });
    args.contextBuilder.patchLocal("file_recursive", {
      sources: [
        {
          name: "file_rec",
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
          name: "file",
          params: {},
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
          name: "colorscheme",
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
