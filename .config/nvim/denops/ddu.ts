import {
  type ActionArguments,
  ActionFlags,
} from "jsr:@shougo/ddu-vim/types";
import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~11.1.0/config";

import type { ActionData as FileAction } from "jsr:@shougo/ddu-kind-file";
import type { ActionData as GitStatusActionData } from "jsr:@kuuote/ddu-kind-git-status@";

import * as fn from "jsr:@denops/std/function";
import * as stdpath from "jsr:@std/path";
import * as u from "jsr:@core/unknownutil";

type Never = Record<never, never>;

export class Config extends BaseConfig {
  override config(args: ConfigArguments): Promise<void> {
    args.setAlias("_", "source", "file_rg", "file_external");
    args.setAlias("_", "source", "file_git", "file_external");
    args.setAlias("_", "source", "file_yadm", "file_external");
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
          floatingBorder: 'rounded',
          previewFloating: true,
          previewSplit: 'horizontal',
          previewFloatingBorder: 'rounded',
          previewFloatingTitle: 'Preview',
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
          floatingBorder: 'rounded',
          floatingTitle: 'Filer',
          previewSplit: 'horizontal',
          previewFloatingBorder: 'rounded',
          previewFloatingTitle: 'Preview',
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
        file_git: {
          matchers: [
            "matcher_relative",
            "matcher_substring",
          ],
          sorters: ["sorter_mtime"],
          converters: ["converter_hl_dir"],
        },
        file_rec: {
          matchers: [
            "matcher_substring",
            "matcher_hidden",
          ],
          sorters: ["sorter_mtime"],
          converters: ["converter_hl_dir"],
        },
        file_yadm: {
          matchers: [
            "matcher_relative",
            "matcher_substring",
          ],
          sorters: ["sorter_mtime"],
          converters: ["converter_hl_dir"],
        },
        file: {
          matchers: [
            "matcher_substring",
            "matcher_hidden",
          ],
          sorters: ["sorter_mtime"],
          converters: ["converter_hl_dir"],
        },
        git_status: {
          converters: [
            "converter_git_status",
            "converter_hl_dir",
          ],
        },
      },
      sourceParams: {
        file_git: {
          cmd: ["git", "ls-files", "-co", "--exclude-standard"],
        },
        rg: {
          args: [
            "--smart-case",
            "--column",
            "--no-heading",
            "--color",
            "never",
          ],
        },
        file_rg: {
          cmd: [
            "rg",
            "--files",
            "--glob",
            "!.git",
            "--color",
            "never",
            "--no-messages",
          ],
          updateItems: 50000,
        },
        file_yadm: {
          cmd: ["yadm", "ls-files", "-co", "--exclude-standard"],
        },
      },
      kindOptions: {
        action: {
          defaultAction: "do",
        },
        file: {
          defaultAction: "open",
          actions: {
            grep: {
              description: "Grep from the path.",
              callback: async (args: ActionArguments<Params>) => {
                const action = args.items[0]?.action as FileAction;

                await args.denops.call("ddu#start", {
                  name: args.options.name,
                  push: true,
                  sources: [
                    {
                      name: "rg",
                      params: {
                        path: action.path,
                        input: await fn.input(args.denops, "Pattern: "),
                      },
                    },
                  ],
                });
                return Promise.resolve(ActionFlags.None);
              },
            },
          },
        },
        help: {
          defaultAction: "open",
        },
        source: {
          defaultAction: "execute",
        },
        git_status: {
          actions: {
            // show diff of file
            // using https://github.com/kuuote/ddu-source-git_diff
            // example:
            //   call ddu#ui#do_action('itemAction', #{name: 'diff'})
            //   call ddu#ui#do_action('itemAction', #{name: 'diff', params: #{cached: v:true}})
            diff: async (args) => {
              const action = args.items[0].action as GitStatusActionData;
              const path = stdpath.join(action.worktree, action.path);
              await args.denops.call("ddu#start", {
                name: "git_diff",
                sources: [{
                  name: "git_diff",
                  options: {
                    path,
                  },
                  params: {
                    ...u.maybe(args.actionParams, u.isRecord) ?? {},
                    onlyFile: true,
                  },
                }],
              });
              return ActionFlags.None;
            },
          },
        },
      },
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
