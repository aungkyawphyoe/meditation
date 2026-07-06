import { definePlugin } from "opencode";

export default definePlugin({
  name: "env-protection",
  description: "Prevents accidental exposure of environment variables and secrets",
  hooks: {
    "beforeCommand": (cmd: string) => {
      const dangerous = ["printenv", "env", "echo $"];
      if (dangerous.some((d) => cmd.includes(d))) {
        console.warn("⚠️  Command may expose environment variables:", cmd);
      }
    },
  },
});
