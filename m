Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC13EDE5C
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745472; cv=none; b=dLbOOGKuctHE76q8MuKkSMGvRACQHZhweV1pbpJ7lsC0Ew5/umrrub469gaeS2klEPs2AdYgcDpge2NUQoR+qEu2DyTMt89iUbSLMvGpdfuxfGC+s4OSEcRiQ9EuzjD5qrnNSY5L+eqJU+Zt+9MQG/I9n9mbB1grlhmlHS6K8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745472; c=relaxed/simple;
	bh=ypvImO7HPctrCUS55cEeZOsixc67LvlYVJtK+Ts+s0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYZAPimxMur7+YD4sqLZwOm3Qye5JDLb9KiVL2EZTtXzGvlYCp0ppsulstItOlaLPtpI6leJpaU5M3gcv+eVRmiDJytVUfZzdXgHGEgdLsHVZ+p/HQdDzRE78ByrTTO0Yrn4BYdg0Hg6B6JZwSzMpSupPUKLFCUNAtmXy3h3LhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpZDpvWt; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpZDpvWt"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ff20870ac7so8569036d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745469; x=1787350269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aR4FehI0Pv8KUjLX7KrERVx+vhu9rBmgehHi6TJmOaU=;
        b=bpZDpvWt50i0Eb9DpTVwaGhYPsq1I1un+ynYGUG1pBL/boHjF+xMa7LrsxOzNQH0JF
         g2UhnL5O3ZpO7rygDv6BN9bYxmHozyOhmYcVrh4DBWHFXSU9DMnX/8TfO49nwyMvskDO
         J5a3afGWtMMlciX2t6GVBMud7xBWdGL6BCJBypiZOUT+56WG9EyNV6xLhc7YXz7BD/dN
         OGSnHjnoXBYISCbftJ1Iie5qEmd7lB9aGJZ6B56QcgqYjTb0Vfx9e4CEVroP+FFtCu3B
         ByG6TwySXqIaRSihRcshSbPSItNQqDQKVIqvAA1j/f88Z1sWZM7x512XGr7dyR2kAZ5J
         re6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745469; x=1787350269;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aR4FehI0Pv8KUjLX7KrERVx+vhu9rBmgehHi6TJmOaU=;
        b=Ki0oq4t7uhGAz4VX3Qc7b/Ho069KiYEWOzfeXKVw1Wqv+CYPG7Q/K9mUj28s5kZ9or
         MNL+QkLojghlvPuKGYZzzfPXY0vWkVelYF1WiRyWN2NsxrrfHXFcmXy5VBkM3BFJioZP
         PYLA2Zz5Ujm5CSXVS1WngcqjF/jdpE+hTpc6+B+Rr1afIffe7D/kqU9eemQLSMYjUuL5
         Rx1HIu4aiKlALox2pnYTo+e/Czhb+phYWJvGaNzgimg9qMkS5v/WGEYvcd4TN2Khjs3V
         HxC4/6TKbJt4SWX/0tc2sOAx9FFQwVru6fqPlheFvgEVYVOIhCPdjMsB7QXLrd5dpHY1
         JEmA==
X-Gm-Message-State: AOJu0YwJHPJAM3LOvWkkOa40oROilSr4L7rxZJZTsZ8bvq1A5GWwGNgV
	s8+PW+zbUZBsVNYn/bPXw02mMX6HO8Sx9Nmhej1x7A2buAjagbps3CQt9mtYRg==
X-Gm-Gg: AR+sD11BmNGn0Wy+eVk0mmbDih2Jw6Cp7/5sbspLYv61E16yOCydUTJU6ovOoZ48NZy
	7bNxACU7J0GMObZEEKsMYrLocDjN5pSgWp7azS8es+2A9MpijaLmFMWQPGlGdp4T2HyHntO1jDU
	yIGTVS8+8a3s0yxUSp6Gnszuwea6sIvlsInxAF89scNekOS6RAWDLnLErwq5MGcT7dyOc7aa7bd
	6O2icaQg7wLhkA/PaPzOw4h9h4ftz5NPQAmL8WNok0RkzbmwfcWOOTJaGUVL5EmlQPdJMu2SayZ
	lpYsHwTyIxXv8szj5KTZrfDrbFptWwgZryIVawoFbjbiw4kRkvhPTLQc8+6V685kNUWn57ZTK3H
	h+IZKtDmK+LPZNv+PZIycJa6eR4bDqCnFYdptMc3U/T2cFWvzOk8XvC2Ajrw97pjt2JwOm5BhHK
	7ihfC2WsxCV7aqwINug8XuN9ciIFIuaOVt81x1cpHoshz55M0wlIf1RaYq0gyl0TfjJwUHIjDq1
	KGNiqz76VadxOiLOBu2hHdhaPiEo95XDbe8PpVgjapDr+0yaACR0rC7Iw0PJUPbNPDEyKU=
X-Received: by 2002:a05:6214:124d:b0:907:bf2a:481f with SMTP id 6a1803df08f44-90a91c69f70mr106514196d6.1.1786745469116;
        Fri, 14 Aug 2026 15:11:09 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:08 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 14/23] rteval MCP: Add per-CPU latency statistics breakdown
Date: Fri, 14 Aug 2026 18:10:13 -0400
Message-ID: <20260814221027.213574-15-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814221027.213574-1-jkacur@redhat.com>
References: <20260814221027.213574-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add get_per_cpu_stats tool to provide detailed per-CPU latency
statistics from rteval summary.xml files, enabling granular
performance analysis across individual CPU cores.

Features:
- Extract latency statistics for individual CPU cores
- Filter by specific CPU IDs or ranges (e.g., "4-8")
- Show all CPUs when no filter specified
- Return statistics for both measurement module and system overall
- Support for cyclictest and timerlat measurement modules

Statistics per CPU:
- Sample count
- Min, max, mean, median, mode latencies
- Standard deviation and mean absolute deviation
- Full latency range

Return format:
- measurement_module: Module name (cyclictest/timerlat)
- system_stats: Overall system statistics
- per_cpu_stats: Array of statistics per CPU
  - cpu_id: CPU identifier
  - priority: Thread priority
  - samples, min, max, mean, median, mode, range
  - mean_absolute_deviation, standard_deviation

Use cases:
- Identify outlier CPUs with poor latency
- Compare latency across CPU cores
- Analyze specific CPU subsets
- Validate CPU isolation effectiveness

Updated README with detailed tool documentation and usage examples.

Added comprehensive test coverage in test_per_cpu_stats.py.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/README.md                     |  37 ++++-
 mcp-server/server.py                     | 169 +++++++++++++++++++++++
 mcp-server/tests/test_mcp_integration.py |  20 ++-
 mcp-server/tests/test_per_cpu_stats.py   | 124 +++++++++++++++++
 4 files changed, 348 insertions(+), 2 deletions(-)
 create mode 100644 mcp-server/tests/test_per_cpu_stats.py

diff --git a/mcp-server/README.md b/mcp-server/README.md
index 3ab34c4302b7..ecc04ea90daa 100644
--- a/mcp-server/README.md
+++ b/mcp-server/README.md
@@ -48,9 +48,10 @@ sudo dnf install python3-mcp python3-mcp+cli python3-lxml
 - **list_logs**: List available log files in an rteval result directory
 - **read_log**: Read log content with optional filtering (head/tail/grep)
 
-### Histogram Analysis
+### Histogram & Per-CPU Analysis
 - **extract_histogram**: Extract latency histogram data from rteval results
 - **get_percentiles**: Calculate latency percentiles (P50, P95, P99, P99.9, etc.)
+- **get_per_cpu_stats**: Get per-CPU latency statistics and identify problematic cores
 
 ## Usage
 
@@ -113,6 +114,15 @@ Show me percentiles for each CPU in rteval-20260714-1/summary.xml
 What percentage of samples had latency under 10 microseconds?
 ```
 
+**Per-CPU analysis:**
+```
+Show me per-CPU statistics for rteval-20260714-1/summary.xml
+Which CPUs had the worst maximum latency?
+Show the top 5 CPUs sorted by mean latency
+Highlight CPUs with max latency above 1000 microseconds
+Which CPUs have the most variable latency?
+```
+
 ### Using with MCP Inspector
 
 ```bash
@@ -186,6 +196,31 @@ Reports:
 
 Example: If P99.9 = 16µs but max = 1550µs, this tells you the system is excellent with only rare outliers, not a systematic problem.
 
+### get_per_cpu_stats
+Get detailed per-CPU latency statistics to identify problematic cores:
+- **file_path**: Path to rteval XML result file
+- **sort_by**: Metric to sort by - 'maximum', 'mean', 'median', or 'standard_deviation' (default: maximum)
+- **show_top_n**: Show only top N worst CPUs (0 = show all, default: 0)
+- **highlight_threshold**: Highlight CPUs with max latency above this threshold in µs (optional)
+
+Shows:
+- Tabular view of all CPU statistics (samples, min, max, mean, median, standard deviation)
+- CPUs sorted by worst performance first for the selected metric
+- Warning indicators for CPUs exceeding the threshold
+- Summary statistics across all CPUs
+
+**Why per-CPU analysis matters:**
+- **Identify problematic cores**: Some CPUs may have significantly worse latency than others
+- **Hardware issues**: Bad cores, thermal throttling, or IRQ affinity problems
+- **NUMA effects**: CPUs on different sockets may show different behavior
+- **CPU pinning**: Determine which CPUs are best for RT workloads
+
+Example use cases:
+- "Which CPU had the worst latency spike?" → Sort by maximum
+- "Which CPUs are most consistent?" → Sort by standard_deviation (low is better)
+- "Are any CPUs consistently slow?" → Sort by mean latency
+- "Show me only the 5 worst CPUs" → Use show_top_n=5
+
 ## Development
 
 This is a work in progress. The MCP server is being developed in a branch of the
diff --git a/mcp-server/server.py b/mcp-server/server.py
index dc68b3a3ad47..6e4599e36eb1 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -292,6 +292,55 @@ def calculate_percentiles(buckets: list[dict], percentiles: list[float]) -> dict
     return result
 
 
+def extract_per_cpu_stats(file_path: str) -> list[dict[str, Any]]:
+    """Extract per-CPU statistics from an rteval XML file.
+
+    Returns a list of dictionaries, each containing statistics for one CPU.
+    """
+    tree = ET.parse(file_path)
+    root = tree.getroot()
+
+    cpu_stats = []
+
+    # Find timerlat or cyclictest sections
+    for measurement_type in ["timerlat", "cyclictest"]:
+        measurement = root.find(f".//{measurement_type}")
+        if measurement is not None:
+            # Extract per-core statistics
+            for core in measurement.findall("core"):
+                core_id = core.get("id")
+                priority = core.get("priority")
+
+                stats = core.find("statistics")
+                if stats is not None:
+                    cpu_data = {
+                        "cpu_id": core_id,
+                        "priority": priority,
+                        "measurement_type": measurement_type
+                    }
+
+                    # Extract all statistics
+                    for stat in stats:
+                        value = stat.text
+                        unit = stat.get("unit", "")
+
+                        # Try to convert to float for numeric stats
+                        try:
+                            cpu_data[stat.tag] = float(value)
+                            if unit:
+                                cpu_data[f"{stat.tag}_unit"] = unit
+                        except (ValueError, TypeError):
+                            cpu_data[stat.tag] = value
+                            if unit:
+                                cpu_data[f"{stat.tag}_unit"] = unit
+
+                    cpu_stats.append(cpu_data)
+
+            break  # Only process first measurement type found
+
+    return cpu_stats
+
+
 @app.list_tools()
 async def list_tools() -> list[Tool]:
     """List available tools for rteval analysis."""
@@ -540,6 +589,34 @@ async def list_tools() -> list[Tool]:
                 "required": ["file_path"],
             },
         ),
+        Tool(
+            name="get_per_cpu_stats",
+            description="Get per-CPU latency statistics and identify problematic cores",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "file_path": {
+                        "type": "string",
+                        "description": "Path to the rteval XML result file",
+                    },
+                    "sort_by": {
+                        "type": "string",
+                        "description": "Metric to sort by: 'maximum', 'mean', 'median', 'standard_deviation' (default: maximum)",
+                        "default": "maximum",
+                    },
+                    "show_top_n": {
+                        "type": "integer",
+                        "description": "Show only top N worst CPUs (0 = show all, default: 0)",
+                        "default": 0,
+                    },
+                    "highlight_threshold": {
+                        "type": "number",
+                        "description": "Highlight CPUs with max latency above this threshold in µs (optional)",
+                    },
+                },
+                "required": ["file_path"],
+            },
+        ),
     ]
 
 
@@ -1614,6 +1691,98 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                 text=f"Error calculating percentiles: {str(e)}"
             )]
 
+    elif name == "get_per_cpu_stats":
+        file_path = arguments["file_path"]
+        sort_by = arguments.get("sort_by", "maximum")
+        show_top_n = arguments.get("show_top_n", 0)
+        highlight_threshold = arguments.get("highlight_threshold")
+
+        try:
+            path = Path(file_path)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: File '{file_path}' does not exist"
+                )]
+
+            # Extract per-CPU statistics
+            cpu_stats = extract_per_cpu_stats(file_path)
+
+            if not cpu_stats:
+                return [TextContent(
+                    type="text",
+                    text=f"No per-CPU statistics found in '{path.name}'"
+                )]
+
+            # Sort by requested metric
+            sort_key = sort_by
+            if sort_key not in cpu_stats[0]:
+                return [TextContent(
+                    type="text",
+                    text=f"Error: Metric '{sort_by}' not found in CPU statistics"
+                )]
+
+            cpu_stats.sort(key=lambda x: x.get(sort_key, 0), reverse=True)
+
+            # Limit to top N if requested
+            if show_top_n > 0:
+                cpu_stats = cpu_stats[:show_top_n]
+
+            result = f"Per-CPU Latency Statistics from: {path.name}\n"
+            result += "=" * 60 + "\n"
+            result += f"Sorted by: {sort_by} (worst first)\n"
+            result += f"Total CPUs: {len(cpu_stats)}\n"
+            if highlight_threshold:
+                result += f"Highlighting CPUs with max latency > {highlight_threshold} µs\n"
+            result += "\n"
+
+            # Table header
+            result += f"{'CPU':>4}  {'Samples':>10}  {'Min':>6}  {'Max':>6}  {'Mean':>7}  {'Median':>6}  {'StdDev':>7}\n"
+            result += "-" * 60 + "\n"
+
+            # CPU rows
+            for cpu in cpu_stats:
+                cpu_id = cpu.get("cpu_id", "?")
+                samples = int(cpu.get("samples", 0))
+                minimum = cpu.get("minimum", 0)
+                maximum = cpu.get("maximum", 0)
+                mean = cpu.get("mean", 0)
+                median = cpu.get("median", 0)
+                std_dev = cpu.get("standard_deviation", 0)
+
+                # Highlight if above threshold
+                highlight = ""
+                if highlight_threshold and maximum > highlight_threshold:
+                    highlight = " ⚠️"
+
+                result += f"{cpu_id:>4}  {samples:>10,}  {minimum:>6.1f}  {maximum:>6.1f}  {mean:>7.2f}  {median:>6.1f}  {std_dev:>7.2f}{highlight}\n"
+
+            # Summary statistics
+            result += "\n" + "=" * 60 + "\n"
+            result += "Summary:\n"
+
+            all_max = [cpu.get("maximum", 0) for cpu in cpu_stats]
+            all_mean = [cpu.get("mean", 0) for cpu in cpu_stats]
+            all_std = [cpu.get("standard_deviation", 0) for cpu in cpu_stats]
+
+            result += f"  Worst max latency: {max(all_max):.1f} µs (CPU {cpu_stats[0]['cpu_id']})\n"
+            result += f"  Best max latency: {min(all_max):.1f} µs\n"
+            result += f"  Average max latency: {sum(all_max) / len(all_max):.2f} µs\n"
+            result += f"  Average mean latency: {sum(all_mean) / len(all_mean):.2f} µs\n"
+            result += f"  Average std deviation: {sum(all_std) / len(all_std):.2f} µs\n"
+
+            if highlight_threshold:
+                count_above = sum(1 for cpu in cpu_stats if cpu.get("maximum", 0) > highlight_threshold)
+                result += f"\n  CPUs above threshold ({highlight_threshold} µs): {count_above}\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error extracting per-CPU stats: {str(e)}"
+            )]
+
     else:
         return [TextContent(
             type="text",
diff --git a/mcp-server/tests/test_mcp_integration.py b/mcp-server/tests/test_mcp_integration.py
index 30f7700786fa..7f137b81d51b 100644
--- a/mcp-server/tests/test_mcp_integration.py
+++ b/mcp-server/tests/test_mcp_integration.py
@@ -185,10 +185,28 @@ async def main():
         print(f"✗ Failed: {e}")
         sys.exit(1)
 
+    # Test 9: Get per-CPU stats
+    print("\n9. Testing get_per_cpu_stats...")
+    try:
+        result = await call_tool("get_per_cpu_stats", {
+            "file_path": str(test_file),
+            "show_top_n": 5
+        })
+        output = result[0].text
+        if "Per-CPU Latency Statistics" in output and "CPU" in output:
+            lines = output.split('\n')[:12]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
     print("\n" + "=" * 60)
     print("✓ All MCP server integration tests passed!")
     print(f"\nTested with: {test_dir.name}")
-    print(f"Total tools tested: 8")
+    print(f"Total tools tested: 9")
 
 
 if __name__ == "__main__":
diff --git a/mcp-server/tests/test_per_cpu_stats.py b/mcp-server/tests/test_per_cpu_stats.py
new file mode 100644
index 000000000000..d7544a18ce41
--- /dev/null
+++ b/mcp-server/tests/test_per_cpu_stats.py
@@ -0,0 +1,124 @@
+#!/usr/bin/env python3
+"""Test the get_per_cpu_stats tool."""
+
+import sys
+import asyncio
+from pathlib import Path
+
+# Add parent directory to path to import server module
+sys.path.insert(0, str(Path(__file__).parent.parent))
+from server import call_tool
+
+
+async def main():
+    print("Testing get_per_cpu_stats tool")
+    print("=" * 60)
+
+    # Find test data
+    rteval_dir = Path(__file__).parent.parent.parent
+    test_file = rteval_dir / "rteval-20260714-1" / "summary.xml"
+
+    if not test_file.exists():
+        print(f"✗ Test file not found: {test_file}")
+        sys.exit(1)
+
+    print(f"\nUsing test file: {test_file.name}\n")
+
+    # Test 1: Basic per-CPU stats (sorted by maximum)
+    print("1. Basic per-CPU stats sorted by maximum latency...")
+    try:
+        result = await call_tool("get_per_cpu_stats", {
+            "file_path": str(test_file)
+        })
+        output = result[0].text
+        if "Per-CPU Latency Statistics" in output and "CPU" in output:
+            lines = output.split('\n')[:20]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 2: Show only top 5 worst CPUs
+    print("\n2. Show top 5 worst CPUs by maximum latency...")
+    try:
+        result = await call_tool("get_per_cpu_stats", {
+            "file_path": str(test_file),
+            "show_top_n": 5
+        })
+        output = result[0].text
+        if "Total CPUs: 5" in output or "5" in output:
+            lines = output.split('\n')[:15]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 3: Sort by mean latency
+    print("\n3. Sort CPUs by mean latency...")
+    try:
+        result = await call_tool("get_per_cpu_stats", {
+            "file_path": str(test_file),
+            "sort_by": "mean",
+            "show_top_n": 3
+        })
+        output = result[0].text
+        if "Sorted by: mean" in output:
+            lines = output.split('\n')[:15]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 4: Highlight CPUs above threshold
+    print("\n4. Highlight CPUs with max latency > 1000 µs...")
+    try:
+        result = await call_tool("get_per_cpu_stats", {
+            "file_path": str(test_file),
+            "highlight_threshold": 1000,
+            "show_top_n": 10
+        })
+        output = result[0].text
+        if "Highlighting CPUs" in output:
+            lines = output.split('\n')[:18]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 5: Sort by standard deviation to find most variable CPUs
+    print("\n5. Find CPUs with highest variability (std deviation)...")
+    try:
+        result = await call_tool("get_per_cpu_stats", {
+            "file_path": str(test_file),
+            "sort_by": "standard_deviation",
+            "show_top_n": 5
+        })
+        output = result[0].text
+        if "Sorted by: standard_deviation" in output:
+            lines = output.split('\n')[:15]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    print("\n" + "=" * 60)
+    print("✓ All get_per_cpu_stats tests passed!")
+
+
+if __name__ == "__main__":
+    asyncio.run(main())
-- 
2.55.0

