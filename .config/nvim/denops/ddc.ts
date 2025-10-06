import { BaseConfig, ConfigArguments } from "jsr:@shougo/ddc-vim/config";
import type { Context, DdcItem } from "jsr:@shougo/ddc-vim/types";

import type { Denops } from "jsr:@denops/std";
import * as fn from "jsr:@denops/std/function";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {
    const commonSources = [
      "around",
      "lsp",
    ]
    args.contextBuilder.patchGlobal({
      ui: "pum",
      autoCompleteEvents: [
        "CmdlineEnter",
        "CmdlineChanged",
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "TextChangedT",
      ],
      cmdlineSources: {
        ":": [
          "cmdline",
          "cmdline_history",
          "around",
          "register",
        ],
      },
      sources: commonSources,
      sourceOptions: {
        _: {
        ignoreCase: true,
        matchers: [
            "matcher_head",
        ],
        sorters: [
            "sorter_rank",
          ],
          converters: [
            "converter_remove_overlap"
          ],
      },
      around: {
          mark: "around",
        },
      lsp: {
          mark: "lsp",
          forceCompletionPattern: "\.\w*|:\w*|->\w*",
        },
      },
      sourceParams: {
        lsp: {
          enableAdditionalTextEdit: true,
          enableDisplayDetail: true,
          enableMatchLabel: true,
          enableResolveItem: true,
        },
      },
    });
  }
}
