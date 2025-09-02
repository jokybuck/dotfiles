import {
  BaseConfig,
  ConfigArguments,
} from "jsr:@shougo/ddt-vim/config";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      uiParams: {
        terminal: {
          command: ["zsh"],
        },
      },
    });
    return Promise.resolve();
  }
}
