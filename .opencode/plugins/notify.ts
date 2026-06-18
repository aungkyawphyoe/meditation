import { definePlugin } from "opencode";

export default definePlugin({
  name: "notify",
  description: "Sends desktop notifications on long-running task completion",
  hooks: {
    "afterCommand": (cmd: string, result: { duration: number; status: string }) => {
      if (result.duration > 30000) {
        // Send system notification for tasks > 30s
        console.log(`🔔 Task completed (${result.status}) in ${result.duration}ms`);
      }
    },
  },
});
