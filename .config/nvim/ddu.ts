import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~10.1.0/config";

export class Config extends BaseConfig {
  override config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiParams: {
        ff: {
          split: "floating",
          startFilter: true,
          filterFloatingPosition: "top",
          filterSplitDirection: "floating",
          floatingBorder: "rounded",
          previewFloating: true,
          previewFloatingBorder: "rounded",
          previewFloatingTitle: "Preview",
          prompt: "> ",
        },
        filer: {
          split: "floating",
          floatingBorder: "rounded",
	  floatingTitle: "Filer",
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
      kindOptions: {
        file: {
          defaultAction: "open",
        },
      },
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
      kindOptions: {
        file: {
          defaultAction: "open",
        },
      },
    });
    args.contextBuilder.patchLocal("colorscheme", {
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
