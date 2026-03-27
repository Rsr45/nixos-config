pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // ───────── CPU ─────────
    property real cpuPerc: 0.0      // 0.0 – 1.0
    property real cpuTemp: 0.0

    property real lastCpuIdle: 0
    property real lastCpuTotal: 0

    // ───────── MEMORY ─────────
    property real memUsed: 0
    property real memTotal: 1
    readonly property real memPerc: memTotal > 0 ? memUsed / memTotal : 0

    // ───────── STORAGE ─────────
    property real storageUsed: 0
    property real storageTotal: 1
    readonly property real storagePerc: storageTotal > 0 ? storageUsed / storageTotal : 0

    // ───────── GPU ─────────
    property string gpuType: "NONE"  // NONE | GENERIC | NVIDIA
    property real gpuPerc: 0.0
    property real gpuTemp: 0.0

    // ───────── REF COUNT ─────────
    property int refCount: 0

    // ───────── POLL TIMER ─────────
    Timer {
        interval: 3000
        repeat: true
        running: root.refCount > 0
        triggeredOnStart: true
        onTriggered: {
            stat.reload();
            meminfo.reload();
            storage.running = true;
            gpuUsage.running = true;
            sensors.running = true;
        }
    }

    // ───────── CPU USAGE ─────────
    FileView {
        id: stat
        path: "/proc/stat"

        onLoaded: {
            const m = text().match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);
            if (!m)
                return;
            const nums = m.slice(1).map(n => parseInt(n, 10));
            const idle = nums[3] + nums[4];
            const total = nums.reduce((a, b) => a + b, 0);

            const totalDiff = total - root.lastCpuTotal;
            const idleDiff = idle - root.lastCpuIdle;

            root.cpuPerc = totalDiff > 0 ? (1 - idleDiff / totalDiff) : 0;

            root.lastCpuIdle = idle;
            root.lastCpuTotal = total;
        }
    }

    // ───────── MEMORY ─────────
    FileView {
        id: meminfo
        path: "/proc/meminfo"

        onLoaded: {
            const data = text();
            const total = data.match(/MemTotal:\s+(\d+)/);
            const avail = data.match(/MemAvailable:\s+(\d+)/);

            if (total && avail) {
                root.memTotal = parseInt(total[1], 10);
                root.memUsed = root.memTotal - parseInt(avail[1], 10);
            }
        }
    }

    // ───────── STORAGE ─────────
    Process {
        id: storage
        command: ["sh", "-c", "df -k | awk '$1 ~ /^\\/dev\\// {u+=$3; a+=$4} END {print u, u+a}'"]

        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(/\s+/);
                if (parts.length === 2) {
                    root.storageUsed = parseInt(parts[0], 10);
                    root.storageTotal = parseInt(parts[1], 10);
                }
            }
        }
    }

    // ───────── GPU TYPE DETECT ─────────
    Process {
        id: gpuDetect
        running: true
        command: ["sh", "-c", "if command -v nvidia-smi >/dev/null; then echo NVIDIA; \
             elif ls /sys/class/drm/card*/device/gpu_busy_percent 2>/dev/null | grep -q .; then echo GENERIC; \
             else echo NONE; fi"]

        stdout: StdioCollector {
            onStreamFinished: root.gpuType = text.trim()
        }
    }

    // ───────── GPU USAGE ─────────
    // Process {
    //     id: gpuUsage
    //
    //     command:
    //         root.gpuType === "NVIDIA"
    //             ? ["nvidia-smi", "--query-gpu=utilization.gpu,temperature.gpu", "--format=csv,noheader,nounits"]
    //         : root.gpuType === "GENERIC"
    //             ? ["sh", "-c", "cat /sys/class/drm/card*/device/gpu_busy_percent"]
    //         : ["echo"]
    //
    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             if (root.gpuType === "NVIDIA") {
    //                 const [u, t] = text.trim().split(",")
    //                 root.gpuPerc = parseInt(u, 10) / 100
    //                 root.gpuTemp = parseInt(t, 10)
    //             } else if (root.gpuType === "GENERIC") {
    //                 const vals = text.trim().split("\n").map(v => parseInt(v, 10))
    //                 const sum = vals.reduce((a, b) => a + b, 0)
    //                 root.gpuPerc = vals.length ? (sum / vals.length) / 100 : 0
    //             } else {
    //                 root.gpuPerc = 0
    //                 root.gpuTemp = 0
    //             }
    //         }
    //     }
    // }

    Process {
        id: gpuUsage

        command: {
            if (root.gpuType === "GENERIC") {
                return ["sh", "-c", "cat /sys/class/drm/card*/device/gpu_busy_percent"];
            } else if (root.gpuType === "NVIDIA") {
                return ["nvidia-smi", "--query-gpu=utilization.gpu,temperature.gpu", "--format=csv,noheader,nounits"];
            } else {
                return ["echo"];
            }
        }

        stdout: StdioCollector {
            onStreamFinished: {
                if (root.gpuType === "GENERIC") {
                    const percs = text.trim().split("\n");
                    const sum = percs.reduce((a, b) => a + parseInt(b, 10), 0);
                    root.gpuPerc = percs.length ? (sum / percs.length) / 100 : 0;
                } else if (root.gpuType === "NVIDIA") {
                    const parts = text.trim().split(",");
                    root.gpuPerc = parseInt(parts[0], 10) / 100;
                    root.gpuTemp = parseInt(parts[1], 10);
                } else {
                    root.gpuPerc = 0;
                    root.gpuTemp = 0;
                }
            }
        }
    }

    // ───────── TEMPERATURES ─────────
    Process {
        id: sensors
        command: ["sensors"]
        environment: ({
                LANG: "C",
                LC_ALL: "C"
            })

        stdout: StdioCollector {
            onStreamFinished: {
                const cpu = text.match(/(?:Tdie|Package id \d+):\s+\+?([0-9.]+)/);
                if (cpu)
                    root.cpuTemp = parseFloat(cpu[1]);
            }
        }
    }
}
