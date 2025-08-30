import { BaseConfig, ConfigArguments } from "jsr:@shougo/ddc-vim/config";
import type { Context, DdcItem } from "jsr:@shougo/ddc-vim/types";

import type { Denops } from "jsr:@denops/std";
import * as fn from "jsr:@denops/std/function";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {
    const commonSources = [
      "around",
    ]
    args.contextBuiler.patchGlobal({
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
	},
	around: {
          mark: "A",
        },
      },
    });
  }
}
