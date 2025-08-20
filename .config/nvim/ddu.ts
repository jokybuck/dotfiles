import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~10.1.0/config";

export class Config extends BaseConfig {
  override config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchLocal("file_recursive", {
      ui: "ff",
      sources: [
        {
          name: "file_rec",
	}
      ],
    });

    return Promise.resolve();
  }
}
