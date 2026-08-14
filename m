Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE03EF666
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745476; cv=none; b=TRhUIKAZArO8O42zf0aXWMBp2p/zF2ewnhVj6RfcWh8cRBWqZVdm72d8lwK74mAyqNNX0nnjiVMadS7wgRxYWy+t5KGRmhMou0DhUe2AWu3+SSxCFMgVrQSxC1Psf6tTGEW0b89Gic240uJ7wJDweA3U7JKtdt24go5j9Si3KJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745476; c=relaxed/simple;
	bh=RdxIOV1QZJpmgbFVSGU6jc5ZWqfYzp0xAPUNRAvgKx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKvlPwc7A7arKwB4/ZXpBqQv9p9vDdeumKCOVPof2eKV2R6ENTRkBIM/X6t+9IixvjrWeJdhgJ7m+Z9WoEOAd/iRdFYR83GUYKsK3ORziix7ALoY8b3Z29XCMKTJ6ihlBSw2DfaZZ25xW9JWhgbX4Ud3OHBCVwC96h5LUUQdxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rsa3zRWg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rsa3zRWg"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8edda5d56a5so15802816d6.3
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745473; x=1787350273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QmKX9eARdGkCDw59qzJwID0eOheErPWSS75msJI/QpM=;
        b=Rsa3zRWg23IL4RU9fUpQMPGBTGQ8qlfSfRj8k7JrXsXi/Da9tYmGpvtqpOIyEPTypR
         zXlTkorCWehDODG+gvdAjlJu9FlRGxZaITQZCdRao3SxAVuR7brQJMWLa/H+H2D3NG8f
         8MHNDO3Ggc9Ta8CbrEJ96gpD4JqHEI+AgMOx03zUV3NHjL9ZYMu6euL3KFTdOwGNe/2l
         YiJsIvFNSGSwO0U2OP2U2mnbCq+hCn1wTyo8RKsX3lg1NDeYMO++zHwtHID+t5JTMeYl
         pLD0b4SIA7A9KeExh7dmFefvEmH4o+6qBHtNhjeZQ+OYuDUBKroyvA1HKdkA4hyhldSF
         5klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745473; x=1787350273;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmKX9eARdGkCDw59qzJwID0eOheErPWSS75msJI/QpM=;
        b=CZm6a+IyQwNymgjDwUnsArJ8fmeLMTEwWT6+N6Qf03wnK5M9QHeLykWNN+NFRiaZub
         vmGh0lbWvGLR0tmcO1xPdki3M+2FUMj8lxwEog/b4TSay35ZN9RUyOBm/rm2ZA6INkGf
         octRf+FEHSQx8IXA5KXvpbEihwNZR3OvHcjutG6PZXVNuD3uM22rc3eGYEAtN0j2OA2B
         fe6OS5OIDFX4AGlI0XHnsQmP1Z/avE39JCrZR+3QzWnRViXTWYFxQLXGE0PxmvNNwrUY
         Szl3l9gfxIXGJ/FWIuNFrDJ2SIeZQJldh6HNUl/MOmbRHmibR3gI77MBc/jHbazYo4/D
         aVkQ==
X-Gm-Message-State: AOJu0YxZi08GcWw7Wfxqlt5HNOP5ajfK/PrT1llq52+iW6EaBN5OK9Er
	pKrfm/YhtoxJgVutEq64rQf0uyD0A27/mPWsomqdINOail16QmAFFLWgMbGZgA==
X-Gm-Gg: AR+sD13Fm7qWJ091DVYSnYNo+IyHcnNZl+vA0zMe/UqDegt9NOpM9BDpP2KBIEmxEx0
	mNtAcJeS/704HKp9M0jb+VjEkxkofyylj+G8Z47K3GpGXj9d7qwWPEMMKgKlhFFS4OinWNtC0ZL
	6kQg2iRGKfR+4y+42YO1Kt4k36RxWFdkt2C/BybWa7gqTccB4ywUC66Xn/zOmnSBxu0GxEBhgss
	40LiwiNcJfBacZeNOU9xEfRKpdZPeBp/sDX/0MZB798QjPqRBZmlsmzLujYkYiENM/jSdGh2Sp2
	ELIzW5UuOyCz0KvsLcpD+I4o662defDXPF9xT+Fu7TJFERce+WtBO822DHdaLmGYEQtUI8xET0G
	YP+Ro/5lpfEOgq1vLNtd21A5pcdri71+232favJna8HMW5l/9fVr6+f/iYIA62ESWlm2W6jGAdi
	3Np5RLmFJq8tzYJeDJxlTbUKm3Hnx95vVqk//uzZETRkGVHOR+tr3jGTPTCqwBvyiVTQ2EHQKhm
	KC4kx0Vyd1qeou+o19cvPEBxKH7FavQ2bcGpVlbm4mVBPFsALFCkS8=
X-Received: by 2002:a05:6214:19ca:b0:8ef:c64a:ffef with SMTP id 6a1803df08f44-90a91cf1433mr104969796d6.1.1786745473203;
        Fri, 14 Aug 2026 15:11:13 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 17/23] mcp-server: Add load information extraction and filtering
Date: Fri, 14 Aug 2026 18:10:16 -0400
Message-ID: <20260814221027.213574-18-jkacur@redhat.com>
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

Add comprehensive load information analysis capabilities to the rteval
MCP server. This allows users to query and filter rteval test results
based on load configuration and metrics.

New functionality includes:

- extract_load_info() helper function to extract load configuration
  (load average, CPUs used, load generators) from rteval XML files

- get_load_info MCP tool to display load configuration for a single
  rteval result file

- Enhanced filter_results tool with three new filtering parameters:
  - load_type: Filter by load generator (kcompile, hackbench, stressng)
  - min_load_average: Minimum load average threshold
  - max_load_average: Maximum load average threshold

- Enhanced batch_analysis tool to display load information for each
  result and aggregate load average statistics

- Updated extract_rteval_data() to include load_info section in the
  returned data structure

- Comprehensive documentation in README.md with:
  - Complete tool usage guide showing both technical tool call format
    and natural language query examples for all 11 MCP tools
  - Load filtering examples and use cases
  - Updated feature descriptions

This enables users to query load configurations with natural language
such as "Show me rteval results that used hackbench" or "Find results
with load average between 1000 and 1500".

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/README.md | 241 ++++++++++++++++++++++++++++++++++++++++++-
 mcp-server/server.py | 178 ++++++++++++++++++++++++++++++++
 2 files changed, 416 insertions(+), 3 deletions(-)

diff --git a/mcp-server/README.md b/mcp-server/README.md
index ecc04ea90daa..ce4cfdda4781 100644
--- a/mcp-server/README.md
+++ b/mcp-server/README.md
@@ -53,6 +53,9 @@ sudo dnf install python3-mcp python3-mcp+cli python3-lxml
 - **get_percentiles**: Calculate latency percentiles (P50, P95, P99, P99.9, etc.)
 - **get_per_cpu_stats**: Get per-CPU latency statistics and identify problematic cores
 
+### Load Analysis
+- **get_load_info**: Extract load configuration and metrics from an rteval result file
+
 ## Usage
 
 ### Testing the Server Directly
@@ -129,6 +132,231 @@ Which CPUs have the most variable latency?
 mcp dev server.py
 ```
 
+## Complete Tool Usage Guide
+
+This section shows both the technical tool call format and natural language queries users can ask.
+
+### list_results
+
+**Tool Call:**
+```python
+list_results(directory=".", pattern="*.xml")
+```
+
+**User Asks:**
+- "List all rteval results"
+- "Show me rteval result files in ~/src/rteval"
+- "What rteval results are in the current directory?"
+
+---
+
+### parse_result
+
+**Tool Call:**
+```python
+parse_result(file_path="rteval-20260724-1/summary.xml")
+```
+
+**User Asks:**
+- "Parse rteval-20260724-1"
+- "Show me the results from rteval-20260724-1"
+- "What's in the rteval-20260724-1 summary?"
+- "Analyze rteval-20260724-1/summary.xml"
+
+---
+
+### compare_results
+
+**Tool Call:**
+```python
+compare_results(file1="rteval-20260724-1/summary.xml",
+                file2="rteval-20260724-2/summary.xml")
+```
+
+**User Asks:**
+- "Compare rteval-20260724-1 and rteval-20260724-2"
+- "What's the difference between rteval-20260724-1 and rteval-20260724-2?"
+- "Show me a comparison of these two rteval runs"
+
+---
+
+### batch_analysis
+
+**Tool Call:**
+```python
+batch_analysis(directory=".", pattern="*.xml", recursive=False)
+```
+
+**User Asks:**
+- "Analyze all rteval results"
+- "Show me aggregate statistics for all rteval runs"
+- "What's the average max latency across all results?"
+- "Summarize all rteval results"
+- "What's the range of load averages across all runs?"
+
+---
+
+### filter_results
+
+**Tool Call:**
+```python
+filter_results(directory=".",
+               kernel_pattern="7.0",
+               is_rt=True,
+               date_from="2026-06-01",
+               date_to="2026-07-31",
+               min_duration_minutes=5,
+               max_latency_threshold=6000,
+               load_type="hackbench",
+               min_load_average=1000,
+               max_load_average=1500)
+```
+
+**User Asks:**
+- "Show me rteval results with kernel 7.0"
+- "Find rteval results from June 2026"
+- "Show results with max latency under 6000 microseconds"
+- "Filter rteval results by RT kernel"
+- "Show me results that used hackbench"
+- "Find runs with load average between 1000 and 1500"
+- "Which results ran with kcompile load?"
+- "Show me RT kernel runs with stress-ng that had low latency"
+
+---
+
+### find_best_worst
+
+**Tool Call:**
+```python
+find_best_worst(directory=".", metric="maximum", count=5)
+```
+
+**User Asks:**
+- "Find the 3 best and worst rteval runs by maximum latency"
+- "Which rteval runs had the lowest mean latency?"
+- "Show me the 5 best and worst runs"
+- "What were the top performing runs by median latency?"
+
+---
+
+### compare_to_baseline
+
+**Tool Call:**
+```python
+compare_to_baseline(baseline_file="rteval-20260605-1/summary.xml",
+                    directory=".",
+                    threshold_percent=10)
+```
+
+**User Asks:**
+- "Compare all rteval results to rteval-20260605-1/summary.xml"
+- "Check for regressions against the baseline"
+- "Which runs regressed compared to rteval-20260605-1?"
+- "Are there any performance regressions with 5% threshold?"
+
+---
+
+### list_logs
+
+**Tool Call:**
+```python
+list_logs(result_dir="rteval-20260724-1")
+```
+
+**User Asks:**
+- "List logs in rteval-20260724-1"
+- "What log files are available for rteval-20260724-1?"
+- "Show me the logs from this run"
+
+---
+
+### read_log
+
+**Tool Call:**
+```python
+read_log(log_path="rteval-20260724-1/logs/timerlat.stdout",
+         tail=100,
+         grep="error")
+```
+
+**User Asks:**
+- "Show me the last 100 lines of the timerlat log"
+- "Read the timerlat stdout from rteval-20260724-1"
+- "Search for 'error' in the timerlat log"
+- "Show me the beginning of the kcompile log"
+
+---
+
+### extract_histogram
+
+**Tool Call:**
+```python
+extract_histogram(file_path="rteval-20260714-1/summary.xml",
+                  include_per_cpu=True)
+```
+
+**User Asks:**
+- "Extract histogram data from rteval-20260714-1"
+- "Show me the latency distribution for rteval-20260714-1"
+- "What does the histogram look like?"
+- "Show me per-CPU histogram data"
+
+---
+
+### get_percentiles
+
+**Tool Call:**
+```python
+get_percentiles(file_path="rteval-20260714-1/summary.xml",
+                percentiles=[50, 90, 95, 99, 99.9, 99.99],
+                per_cpu=False)
+```
+
+**User Asks:**
+- "Calculate P99 and P99.9 percentiles for rteval-20260714-1"
+- "Show me percentiles for each CPU in rteval-20260714-1"
+- "What percentage of samples had latency under 10 microseconds?"
+- "What's the P95 latency?"
+- "Show me per-CPU percentiles"
+
+---
+
+### get_per_cpu_stats
+
+**Tool Call:**
+```python
+get_per_cpu_stats(file_path="rteval-20260714-1/summary.xml",
+                  sort_by="maximum",
+                  show_top_n=5,
+                  highlight_threshold=1000)
+```
+
+**User Asks:**
+- "Show me per-CPU statistics for rteval-20260714-1"
+- "Which CPUs had the worst maximum latency?"
+- "Show the top 5 CPUs sorted by mean latency"
+- "Highlight CPUs with max latency above 1000 microseconds"
+- "Which CPUs have the most variable latency?"
+- "Which CPU had the worst latency spike?"
+
+---
+
+### get_load_info
+
+**Tool Call:**
+```python
+get_load_info(file_path="rteval-20260724-1/summary.xml")
+```
+
+**User Asks:**
+- "What loads were running in rteval-20260724-1?"
+- "Show me the load configuration for rteval-20260724-1"
+- "What was the load average in this run?"
+- "What load generators were used?"
+- "Show me the load setup for this test"
+
+---
+
 ## Features in Detail
 
 ### filter_results
@@ -138,8 +366,14 @@ Filter rteval results by multiple criteria:
 - **date_from/date_to**: Date range filter (YYYY-MM-DD format)
 - **min_duration_minutes**: Minimum test duration
 - **max_latency_threshold**: Maximum acceptable latency in µs
+- **load_type**: Filter by load generator type (e.g., "kcompile", "hackbench", "stressng")
+- **min_load_average**: Minimum load average threshold
+- **max_load_average**: Maximum load average threshold
 
-Example: Find all RT kernel runs from June 2026 with max latency under 4000 µs
+Examples:
+- Find all RT kernel runs from June 2026 with max latency under 4000 µs
+- Find runs with hackbench load and load average between 1000 and 1500
+- Show runs with stress-ng that had low latency on RT kernels
 
 ### find_best_worst
 Identify optimal and poorest performing runs:
@@ -164,9 +398,10 @@ Aggregate statistics across multiple runs:
 - Total files analyzed
 - Date range coverage
 - Min/max/average latencies across all runs
-- Individual result summaries
+- Min/max/average load averages across all runs
+- Individual result summaries with load information
 
-Useful for understanding performance trends over time.
+Useful for understanding performance trends over time and correlating load with latency.
 
 ### extract_histogram
 Extract raw histogram data from rteval results:
diff --git a/mcp-server/server.py b/mcp-server/server.py
index a007c6a7f2f3..8fbe7836facd 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -109,6 +109,44 @@ def parse_rtla_command(cmd_line: str) -> dict[str, str]:
     return params
 
 
+def extract_load_info(file_path: str) -> dict[str, Any]:
+    """Extract load configuration and metrics from an rteval XML file.
+
+    Returns information about what load generators were running during the test,
+    including load average, CPU assignments, and per-load details.
+    """
+    tree = ET.parse(file_path)
+    root = tree.getroot()
+
+    load_info = {
+        "file": file_path,
+        "load_average": None,
+        "load_cpus": None,
+        "num_load_types": 0,
+        "load_generators": []
+    }
+
+    loads_elem = root.find(".//loads")
+    if loads_elem is not None:
+        load_info["load_average"] = loads_elem.get("load_average")
+        load_info["load_cpus"] = loads_elem.get("loadcpus")
+        load_info["num_load_types"] = int(loads_elem.get("loads", "0"))
+
+        # Extract each load generator
+        for cmd in loads_elem.findall("command_line"):
+            load_name = cmd.get("name")
+            job_instances = int(cmd.get("job_instances", "1"))
+            command_text = cmd.text.strip() if cmd.text else ""
+
+            load_info["load_generators"].append({
+                "name": load_name,
+                "job_instances": job_instances,
+                "command": command_text
+            })
+
+    return load_info
+
+
 def extract_rteval_data(file_path: str) -> dict[str, Any]:
     """Extract key data from an rteval XML file for comparison."""
     tree = ET.parse(file_path)
@@ -119,6 +157,7 @@ def extract_rteval_data(file_path: str) -> dict[str, Any]:
         "rteval_version": root.get("version", "unknown"),
         "run_info": {},
         "system_info": {},
+        "load_info": {},
         "measurements": {}
     }
 
@@ -151,6 +190,23 @@ def extract_rteval_data(file_path: str) -> dict[str, Any]:
                     else:
                         data["system_info"][elem] = node.text
 
+    # Load information
+    loads_elem = root.find(".//loads")
+    if loads_elem is not None:
+        data["load_info"]["load_average"] = loads_elem.get("load_average")
+        data["load_info"]["load_cpus"] = loads_elem.get("loadcpus")
+        data["load_info"]["num_load_types"] = int(loads_elem.get("loads", "0"))
+        data["load_info"]["load_generators"] = []
+
+        for cmd in loads_elem.findall("command_line"):
+            load_name = cmd.get("name")
+            job_instances = int(cmd.get("job_instances", "1"))
+
+            data["load_info"]["load_generators"].append({
+                "name": load_name,
+                "job_instances": job_instances
+            })
+
     # Timerlat measurements
     timerlat = root.find(".//timerlat")
     if timerlat is not None:
@@ -517,6 +573,18 @@ async def list_tools() -> list[Tool]:
                         "type": "number",
                         "description": "Filter results with max latency below this threshold (µs)",
                     },
+                    "load_type": {
+                        "type": "string",
+                        "description": "Filter by load generator type (e.g., 'kcompile', 'hackbench', 'stressng')",
+                    },
+                    "min_load_average": {
+                        "type": "number",
+                        "description": "Minimum load average threshold",
+                    },
+                    "max_load_average": {
+                        "type": "number",
+                        "description": "Maximum load average threshold",
+                    },
                 },
                 "required": [],
             },
@@ -640,6 +708,20 @@ async def list_tools() -> list[Tool]:
                 "required": ["file_path"],
             },
         ),
+        Tool(
+            name="get_load_info",
+            description="Extract load configuration and metrics from an rteval result file",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "file_path": {
+                        "type": "string",
+                        "description": "Path to the rteval XML result file",
+                    },
+                },
+                "required": ["file_path"],
+            },
+        ),
     ]
 
 
@@ -1138,6 +1220,7 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
             max_latencies = []
             mean_latencies = []
             dates = []
+            load_averages = []
 
             for data in results:
                 file_name = Path(data["file"]).name
@@ -1162,6 +1245,19 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                         result += f" (RT: {'Yes' if data['system_info']['is_RT'] else 'No'})"
                     result += "\n"
 
+                # Load information
+                if "load_info" in data and data["load_info"]:
+                    load_info = data["load_info"]
+                    if "load_average" in load_info and load_info["load_average"]:
+                        result += f"  Load Average: {load_info['load_average']}\n"
+                        try:
+                            load_averages.append(float(load_info["load_average"]))
+                        except ValueError:
+                            pass
+                    if "load_generators" in load_info and load_info["load_generators"]:
+                        load_names = [gen.get("name", "unknown") for gen in load_info["load_generators"]]
+                        result += f"  Load Types: {', '.join(load_names)}\n"
+
                 # Measurements - timerlat
                 if "timerlat" in data["measurements"]:
                     meas = data["measurements"]["timerlat"]
@@ -1224,6 +1320,12 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                 result += f"  Highest mean: {max(mean_latencies):.2f} µs\n"
                 result += f"  Average mean: {sum(mean_latencies) / len(mean_latencies):.2f} µs\n"
 
+            if load_averages:
+                result += f"\nLoad Averages:\n"
+                result += f"  Lowest load avg: {min(load_averages):.2f}\n"
+                result += f"  Highest load avg: {max(load_averages):.2f}\n"
+                result += f"  Average load avg: {sum(load_averages) / len(load_averages):.2f}\n"
+
             return [TextContent(type="text", text=result)]
 
         except Exception as e:
@@ -1240,6 +1342,9 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
         date_to = arguments.get("date_to")
         min_duration = arguments.get("min_duration_minutes")
         max_threshold = arguments.get("max_latency_threshold")
+        load_type = arguments.get("load_type")
+        min_load_avg = arguments.get("min_load_average")
+        max_load_avg = arguments.get("max_load_average")
 
         try:
             path = Path(directory)
@@ -1304,6 +1409,35 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                         if max_lat is None or max_lat > max_threshold:
                             continue
 
+                    # Load filtering
+                    if load_type or min_load_avg or max_load_avg:
+                        load_info = data.get("load_info", {})
+
+                        # Filter by load type
+                        if load_type:
+                            load_generators = load_info.get("load_generators", [])
+                            has_load_type = any(
+                                load_type.lower() in gen.get("name", "").lower()
+                                for gen in load_generators
+                            )
+                            if not has_load_type:
+                                continue
+
+                        # Filter by load average
+                        if min_load_avg or max_load_avg:
+                            load_avg_str = load_info.get("load_average")
+                            if load_avg_str:
+                                try:
+                                    load_avg = float(load_avg_str)
+                                    if min_load_avg and load_avg < min_load_avg:
+                                        continue
+                                    if max_load_avg and load_avg > max_load_avg:
+                                        continue
+                                except ValueError:
+                                    continue
+                            else:
+                                continue
+
                     filtered.append(data)
 
                 except Exception:
@@ -1812,6 +1946,50 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                 text=f"Error extracting per-CPU stats: {str(e)}"
             )]
 
+    elif name == "get_load_info":
+        file_path = arguments["file_path"]
+
+        try:
+            path = Path(file_path)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: File '{file_path}' does not exist"
+                )]
+
+            # Extract load information
+            load_info = extract_load_info(file_path)
+
+            result = f"Load Configuration from: {path.name}\n"
+            result += "=" * 60 + "\n\n"
+
+            if load_info["load_average"]:
+                result += f"Load Average: {load_info['load_average']}\n"
+            if load_info["load_cpus"]:
+                result += f"Load CPUs: {load_info['load_cpus']}\n"
+            result += f"Number of Load Types: {load_info['num_load_types']}\n\n"
+
+            if load_info["load_generators"]:
+                result += "Load Generators:\n"
+                for gen in load_info["load_generators"]:
+                    result += f"  - {gen['name']}: {gen['job_instances']} instance(s)\n"
+                    if gen.get('command'):
+                        # Truncate long commands
+                        cmd = gen['command']
+                        if len(cmd) > 80:
+                            cmd = cmd[:77] + "..."
+                        result += f"    Command: {cmd}\n"
+            else:
+                result += "No load generators found\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error extracting load info: {str(e)}"
+            )]
+
     else:
         return [TextContent(
             type="text",
-- 
2.55.0

