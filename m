Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94F3DAAAA
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745463; cv=none; b=U2ryc+jYa2fJ3yk0+dNuXDyQaiqsuaivJHKYjrGcb+HRHr9+/6XZZHtnnBMDZrN0zxwkslg6TLt6wcKWozf71zDQwT4DxNFW5AdMMalXq0Vs0BP7lJRPJTKsiiUTXxtPzX7EyHE30T5ZEERSmlYLEq9YC8TGopZtZK4i+SINM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745463; c=relaxed/simple;
	bh=vYVs+jNAhOdDNkrEe1Q25LxGiYq4MPNnCI+5DP4/A6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTReGIKMo/tEEx0bUr10nBbsHNMEqj73nXT6WfvjNmXhoXzswnUDe2OlK/nyMRI62e6Csqgqu6LUcQDc8k1rOValVkaR0sb5+nadCiV3Tw3Otx0tn15nyZtgZCF0wWyFw9KOkog+aWKLC74Cz8G5XuUKRT47pm5HVPeyxXQfceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCIa+Hzm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCIa+Hzm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52d58d7aad6so8424361cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745460; x=1787350260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QIrMpHHfkEIHZmJtsjSITIB91UD/n1wK06uleVh524Y=;
        b=HCIa+HzmZP0cRwTeEfo0FXeY7bC/f9QRsPkMUDrDmwKUJhnxDB3zHafH9UlNchT/cg
         X4u5D0o+QrV+qThk8Mi2HZ7MDlEvKKRRXsatvKrcoJX3M1GHgxFn6WQSSuAnx1BWWEni
         pjw8AHUlGWuddiPoZXJ7aOfALAEfInDRuQ2uLOf42m/1EhMyQ1pOCvk9iFP/nEy/s+n7
         GDi7btJ8/6Zz+NTB5L/RXAdCI+8Il1OpDn+13sGWRBzysGtbLSzxJFNk2R+2FKKcRRrb
         x09LteP9bxVNPARfywdpc1vOvxQJZKznJgXALY+3CZ+32oiWqYS0f1bqgprVQux31hQL
         P2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745460; x=1787350260;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIrMpHHfkEIHZmJtsjSITIB91UD/n1wK06uleVh524Y=;
        b=HurkiJUleXPcOqaxsAWvo+ss9M4ltH9bJEdVxBhIyGT4ngtIQOz63iJJXWABYzgPH6
         aSe6IfQwHFpTGkmfxVw33ZJ7bqS24xqvEo4lcVq3mVGkaIhT10aU3SfhgVJTb0DjrAR+
         h4yhhTlq+QcrAcQBpm/hxUi580jo0ug7MEYp8mfvd+Kr5QRYmTYDy/NxzglPqXDH3XY5
         4FWqUkgEfi13cSDJ1pI6qVkmsJqn/w1Drg45VDeOBr/T/vX4yJAZcLtw5dCf7nVB+qH1
         hkcS4JjX5gYyu/Msetfk45zGqQ56BfCQlDLHB09lmE044u6Jw3He6nuaQIXpKVjX0k38
         nc3Q==
X-Gm-Message-State: AOJu0Yx7RmERCQXCkUH9+5Lqr0YafpKeJ68dRyeIcoTmCRqlqLyvjtFf
	xhOTKl9kg38RjpIBE5oQkGKh1a9Sae0vYBRSG7T/o6+LDgSfIFLWP/q08sSaKA==
X-Gm-Gg: AR+sD13gmzb9Oso3aAkBws9/lKydZS4x6e0PUpZxUPuSeh957UumFaRoMqlESxwY+6V
	gqqeVOHRcVMAk5KAnlvuTLQdQIOZnyNBQ9t3dZfsMHkKWhL9u+uMaSwm5hC7A7N8AeTIQWQwnWp
	Y2aDBjzGHHSsFcZC8dXoRYwpJnAsrh+2RV5cqIzzCYhm8c2KRrh5ftkIWYkcCcrvRANGMzF5uaA
	4EfKAUX5iXGwukeAwhk9drlF+9GnnClr0gz8VXQnESAGffrJdVJa6Jh49YqS2DSATJ5rBuwH9Ji
	Ylt++K5Dv5gex1DYUFwVIyIQwEn+HOiek9O0apW6Im+EKNtVgcfwRF+vGx8TOyw/JJU33QncL/c
	wK9C1nggxx+3Sk4NU+dt6PDjtB/3lseN5zQovseKvIHt3/fBWOxBjnUu13lE3xB9QbowGwAmjbd
	Yo/PzUqIg/wzYrJ3FFnaRubFReSnorCB+Gc1MtiySFC+UI6dMgxbj3G99WPvo6lKaQSKjEQ7K/i
	/fo6J5ctxF1qyhrqhi9NZpzcgpMr6CYpNTJcTupR8neQy6sTFXsgKc=
X-Received: by 2002:ac8:594c:0:b0:516:d955:ea6 with SMTP id d75a77b69052e-52d8534140cmr102881021cf.14.1786745459948;
        Fri, 14 Aug 2026 15:10:59 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:10:59 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 08/23] rteval: mcp-server: Add query and filter capabilities
Date: Fri, 14 Aug 2026 18:10:07 -0400
Message-ID: <20260814221027.213574-9-jkacur@redhat.com>
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

Add three new tools to the MCP server for advanced result analysis:

filter_results - Filter rteval results by multiple criteria including
kernel version pattern, RT kernel status, date range, minimum test
duration, and maximum latency threshold. Enables targeted analysis
of specific test configurations.

find_best_worst - Identify optimal and poorest performing runs based
on configurable latency metrics (maximum, mean, or median). Returns
ranked results with kernel version, date, and latency information.

compare_to_baseline - Regression detection by comparing multiple
results against a baseline file. Detects and reports regressions
above a configurable threshold percentage (default 10%), showing
detailed percentage changes for all metrics.

Updated README with tool descriptions, usage examples, and detailed
feature documentation to help users understand the new capabilities.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/README.md |  81 +++++++-
 mcp-server/server.py | 450 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 530 insertions(+), 1 deletion(-)

diff --git a/mcp-server/README.md b/mcp-server/README.md
index 1e09bd63775c..7ce028b512f5 100644
--- a/mcp-server/README.md
+++ b/mcp-server/README.md
@@ -33,9 +33,18 @@ sudo dnf install python3-mcp python3-mcp+cli python3-lxml
 
 ## Available Tools
 
+### Basic Analysis
 - **list_results**: List rteval result files in a directory
 - **parse_result**: Parse an rteval XML result file and extract key metrics
 - **compare_results**: Compare two rteval result files side-by-side
+- **batch_analysis**: Analyze multiple rteval result files and aggregate statistics
+
+### Query & Filter
+- **filter_results**: Filter rteval results by kernel version, date range, test duration, and latency thresholds
+- **find_best_worst**: Find best and worst rteval runs based on latency metrics (maximum, mean, or median)
+- **compare_to_baseline**: Compare multiple results against a baseline file and detect regressions
+
+### Log Access
 - **list_logs**: List available log files in an rteval result directory
 - **read_log**: Read log content with optional filtering (head/tail/grep)
 
@@ -56,9 +65,40 @@ The server is configured as a Claude Code plugin. After installation:
 3. Restart Claude Code to load the plugin
 4. Tools will be available with the prefix: `mcp__plugin_rteval-mcp_rteval__`
 
-Example:
+Example queries:
 ```
 list rteval results in ~/src/rteval
+find the best and worst rteval runs
+show me rteval results with kernel 7.0
+compare rteval results to a baseline
+```
+
+### Query & Filter Examples
+
+**Find best and worst runs:**
+```
+Find the 3 best and worst rteval runs by maximum latency
+Which rteval runs had the lowest mean latency?
+```
+
+**Filter by criteria:**
+```
+Show me rteval results with kernel version 7.0
+Find rteval results from June 2026
+Show results with max latency under 3500 microseconds
+Filter rteval results by RT kernel
+```
+
+**Baseline comparison:**
+```
+Compare all rteval results to rteval-20260605-1/summary.xml
+Check for regressions against the baseline with 5% threshold
+```
+
+**Batch analysis:**
+```
+Analyze all rteval results and show aggregate statistics
+What's the average max latency across all runs?
 ```
 
 ### Using with MCP Inspector
@@ -67,6 +107,45 @@ list rteval results in ~/src/rteval
 mcp dev server.py
 ```
 
+## Features in Detail
+
+### filter_results
+Filter rteval results by multiple criteria:
+- **kernel_pattern**: Match kernel version (e.g., "7.0", "rt", "6.17")
+- **is_rt**: Filter by RT kernel (true/false)
+- **date_from/date_to**: Date range filter (YYYY-MM-DD format)
+- **min_duration_minutes**: Minimum test duration
+- **max_latency_threshold**: Maximum acceptable latency in µs
+
+Example: Find all RT kernel runs from June 2026 with max latency under 4000 µs
+
+### find_best_worst
+Identify optimal and poorest performing runs:
+- **metric**: Choose maximum, mean, or median latency
+- **count**: Number of best/worst results to return (default: 5)
+
+Shows ranked results with kernel version, date, and latency metrics.
+
+### compare_to_baseline
+Regression detection against a baseline result:
+- **baseline_file**: Reference rteval XML file
+- **directory**: Directory containing results to compare
+- **threshold_percent**: Alert threshold for regressions (default: 10%)
+
+Reports:
+- Regressions (results exceeding threshold)
+- Passes (results within threshold)
+- Detailed percentage changes for all metrics
+
+### batch_analysis
+Aggregate statistics across multiple runs:
+- Total files analyzed
+- Date range coverage
+- Min/max/average latencies across all runs
+- Individual result summaries
+
+Useful for understanding performance trends over time.
+
 ## Development
 
 This is a work in progress. The MCP server is being developed in a branch of the
diff --git a/mcp-server/server.py b/mcp-server/server.py
index aa8cfe1102d9..8dbcd9c62fd1 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -297,6 +297,91 @@ async def list_tools() -> list[Tool]:
                 "required": [],
             },
         ),
+        Tool(
+            name="filter_results",
+            description="Filter rteval results by kernel version, date range, and test parameters",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "directory": {
+                        "type": "string",
+                        "description": "Directory to search (default: current directory)",
+                    },
+                    "kernel_pattern": {
+                        "type": "string",
+                        "description": "Filter by kernel version pattern (e.g., '6.17', 'rt', '7.0')",
+                    },
+                    "is_rt": {
+                        "type": "boolean",
+                        "description": "Filter by RT kernel (true/false)",
+                    },
+                    "date_from": {
+                        "type": "string",
+                        "description": "Start date (YYYY-MM-DD)",
+                    },
+                    "date_to": {
+                        "type": "string",
+                        "description": "End date (YYYY-MM-DD)",
+                    },
+                    "min_duration_minutes": {
+                        "type": "integer",
+                        "description": "Minimum test duration in minutes",
+                    },
+                    "max_latency_threshold": {
+                        "type": "number",
+                        "description": "Filter results with max latency below this threshold (µs)",
+                    },
+                },
+                "required": [],
+            },
+        ),
+        Tool(
+            name="find_best_worst",
+            description="Find best and worst rteval runs based on latency metrics",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "directory": {
+                        "type": "string",
+                        "description": "Directory to search (default: current directory)",
+                    },
+                    "metric": {
+                        "type": "string",
+                        "description": "Metric to evaluate: 'maximum', 'mean', or 'median' (default: maximum)",
+                        "default": "maximum",
+                    },
+                    "count": {
+                        "type": "integer",
+                        "description": "Number of best/worst results to return (default: 5)",
+                        "default": 5,
+                    },
+                },
+                "required": [],
+            },
+        ),
+        Tool(
+            name="compare_to_baseline",
+            description="Compare multiple rteval results against a baseline result",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "baseline_file": {
+                        "type": "string",
+                        "description": "Path to baseline rteval XML file",
+                    },
+                    "directory": {
+                        "type": "string",
+                        "description": "Directory containing results to compare (default: current directory)",
+                    },
+                    "threshold_percent": {
+                        "type": "number",
+                        "description": "Alert if results exceed baseline by this percentage (default: 10)",
+                        "default": 10,
+                    },
+                },
+                "required": ["baseline_file"],
+            },
+        ),
     ]
 
 
@@ -889,6 +974,371 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                 text=f"Error in batch analysis: {str(e)}"
             )]
 
+    elif name == "filter_results":
+        directory = arguments.get("directory", ".")
+        kernel_pattern = arguments.get("kernel_pattern")
+        is_rt = arguments.get("is_rt")
+        date_from = arguments.get("date_from")
+        date_to = arguments.get("date_to")
+        min_duration = arguments.get("min_duration_minutes")
+        max_threshold = arguments.get("max_latency_threshold")
+
+        try:
+            path = Path(directory)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: Directory '{directory}' does not exist"
+                )]
+
+            # Find all XML files
+            files = list(path.glob("*.xml"))
+            if not files:
+                return [TextContent(
+                    type="text",
+                    text=f"No XML files found in '{directory}'"
+                )]
+
+            # Parse and filter
+            filtered = []
+            for file_path in files:
+                try:
+                    data = extract_rteval_data(str(file_path))
+
+                    # Apply filters
+                    if kernel_pattern and kernel_pattern.lower() not in data["system_info"].get("kernel", "").lower():
+                        continue
+
+                    if is_rt is not None and data["system_info"].get("is_RT") != is_rt:
+                        continue
+
+                    # Date filtering
+                    if date_from or date_to:
+                        run_date = data["run_info"].get("date")
+                        if run_date:
+                            if date_from and run_date < date_from:
+                                continue
+                            if date_to and run_date > date_to:
+                                continue
+
+                    # Duration filtering
+                    if min_duration:
+                        ri = data["run_info"]
+                        total_minutes = (ri.get("days", 0) * 24 * 60 +
+                                       ri.get("hours", 0) * 60 +
+                                       ri.get("minutes", 0))
+                        if total_minutes < min_duration:
+                            continue
+
+                    # Max latency threshold
+                    if max_threshold:
+                        max_lat = None
+                        for mtype in ["timerlat", "cyclictest"]:
+                            if mtype in data["measurements"]:
+                                max_val = data["measurements"][mtype].get("maximum", {}).get("value")
+                                if max_val:
+                                    try:
+                                        max_lat = float(max_val)
+                                        break
+                                    except ValueError:
+                                        pass
+
+                        if max_lat is None or max_lat > max_threshold:
+                            continue
+
+                    filtered.append(data)
+
+                except Exception:
+                    continue
+
+            if not filtered:
+                return [TextContent(
+                    type="text",
+                    text="No results matched the filter criteria"
+                )]
+
+            # Build output
+            result = f"Filtered Results ({len(filtered)} of {len(files)} files matched):\n"
+            result += "=" * 60 + "\n\n"
+
+            for data in filtered:
+                result += f"{Path(data['file']).name}:\n"
+                if "date" in data["run_info"]:
+                    result += f"  Date: {data['run_info']['date']}\n"
+                if "kernel" in data["system_info"]:
+                    result += f"  Kernel: {data['system_info']['kernel']}"
+                    if "is_RT" in data["system_info"]:
+                        result += f" (RT: {'Yes' if data['system_info']['is_RT'] else 'No'})"
+                    result += "\n"
+
+                # Show key metrics
+                for mtype in ["timerlat", "cyclictest"]:
+                    if mtype in data["measurements"]:
+                        meas = data["measurements"][mtype]
+                        if "maximum" in meas:
+                            result += f"  Max latency: {meas['maximum']['value']} {meas['maximum']['unit']}\n"
+                        if "mean" in meas:
+                            result += f"  Mean latency: {meas['mean']['value']} {meas['mean']['unit']}\n"
+                        break
+
+                result += "\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error filtering results: {str(e)}"
+            )]
+
+    elif name == "find_best_worst":
+        directory = arguments.get("directory", ".")
+        metric = arguments.get("metric", "maximum")
+        count = arguments.get("count", 5)
+
+        try:
+            path = Path(directory)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: Directory '{directory}' does not exist"
+                )]
+
+            # Find all XML files
+            files = list(path.glob("*.xml"))
+            if not files:
+                return [TextContent(
+                    type="text",
+                    text=f"No XML files found in '{directory}'"
+                )]
+
+            # Parse and collect metrics
+            results_with_metrics = []
+            for file_path in files:
+                try:
+                    data = extract_rteval_data(str(file_path))
+
+                    # Extract the requested metric
+                    metric_value = None
+                    for mtype in ["timerlat", "cyclictest"]:
+                        if mtype in data["measurements"]:
+                            metric_data = data["measurements"][mtype].get(metric)
+                            if metric_data:
+                                try:
+                                    metric_value = float(metric_data["value"])
+                                    break
+                                except ValueError:
+                                    pass
+
+                    if metric_value is not None:
+                        results_with_metrics.append((data, metric_value))
+
+                except Exception:
+                    continue
+
+            if not results_with_metrics:
+                return [TextContent(
+                    type="text",
+                    text=f"No results found with {metric} metric"
+                )]
+
+            # Sort by metric value
+            results_with_metrics.sort(key=lambda x: x[1])
+
+            # Build output
+            result = f"Best and Worst Results (by {metric} latency):\n"
+            result += "=" * 60 + "\n\n"
+
+            # Best results (lowest latency)
+            result += f"BEST {min(count, len(results_with_metrics))} Results (lowest {metric}):\n"
+            result += "-" * 60 + "\n"
+            for i, (data, metric_val) in enumerate(results_with_metrics[:count], 1):
+                result += f"\n{i}. {Path(data['file']).name}\n"
+                result += f"   {metric.capitalize()}: {metric_val:.2f} µs\n"
+                if "kernel" in data["system_info"]:
+                    result += f"   Kernel: {data['system_info']['kernel']}\n"
+                if "date" in data["run_info"]:
+                    result += f"   Date: {data['run_info']['date']}\n"
+
+            # Worst results (highest latency)
+            result += f"\nWORST {min(count, len(results_with_metrics))} Results (highest {metric}):\n"
+            result += "-" * 60 + "\n"
+            for i, (data, metric_val) in enumerate(reversed(results_with_metrics[-count:]), 1):
+                result += f"\n{i}. {Path(data['file']).name}\n"
+                result += f"   {metric.capitalize()}: {metric_val:.2f} µs\n"
+                if "kernel" in data["system_info"]:
+                    result += f"   Kernel: {data['system_info']['kernel']}\n"
+                if "date" in data["run_info"]:
+                    result += f"   Date: {data['run_info']['date']}\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error finding best/worst results: {str(e)}"
+            )]
+
+    elif name == "compare_to_baseline":
+        baseline_file = arguments["baseline_file"]
+        directory = arguments.get("directory", ".")
+        threshold_percent = arguments.get("threshold_percent", 10)
+
+        try:
+            # Load baseline
+            if not Path(baseline_file).exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: Baseline file '{baseline_file}' does not exist"
+                )]
+
+            baseline_data = extract_rteval_data(baseline_file)
+
+            # Get baseline metrics
+            baseline_metrics = {}
+            for mtype in ["timerlat", "cyclictest"]:
+                if mtype in baseline_data["measurements"]:
+                    for metric in ["maximum", "mean", "median"]:
+                        if metric in baseline_data["measurements"][mtype]:
+                            try:
+                                baseline_metrics[metric] = float(
+                                    baseline_data["measurements"][mtype][metric]["value"]
+                                )
+                            except ValueError:
+                                pass
+                    break
+
+            if not baseline_metrics:
+                return [TextContent(
+                    type="text",
+                    text="Could not extract metrics from baseline file"
+                )]
+
+            # Find files to compare
+            path = Path(directory)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: Directory '{directory}' does not exist"
+                )]
+
+            files = list(path.glob("*.xml"))
+            if not files:
+                return [TextContent(
+                    type="text",
+                    text=f"No XML files found in '{directory}'"
+                )]
+
+            # Build comparison report
+            result = f"Baseline Comparison Report\n"
+            result += "=" * 60 + "\n\n"
+            result += f"Baseline: {Path(baseline_file).name}\n"
+            result += f"Baseline Metrics:\n"
+            for metric, value in baseline_metrics.items():
+                result += f"  {metric}: {value:.2f} µs\n"
+            result += f"\nThreshold: {threshold_percent}% above baseline\n"
+            result += "=" * 60 + "\n\n"
+
+            regressions = []
+            passes = []
+
+            for file_path in files:
+                # Skip baseline file itself
+                if str(file_path) == str(Path(baseline_file).resolve()):
+                    continue
+
+                try:
+                    data = extract_rteval_data(str(file_path))
+
+                    # Extract metrics
+                    test_metrics = {}
+                    for mtype in ["timerlat", "cyclictest"]:
+                        if mtype in data["measurements"]:
+                            for metric in ["maximum", "mean", "median"]:
+                                if metric in data["measurements"][mtype]:
+                                    try:
+                                        test_metrics[metric] = float(
+                                            data["measurements"][mtype][metric]["value"]
+                                        )
+                                    except ValueError:
+                                        pass
+                            break
+
+                    if not test_metrics:
+                        continue
+
+                    # Check for regressions
+                    has_regression = False
+                    comparison = {
+                        "file": Path(file_path).name,
+                        "kernel": data["system_info"].get("kernel", "unknown"),
+                        "date": data["run_info"].get("date", "unknown"),
+                        "metrics": {}
+                    }
+
+                    for metric in baseline_metrics:
+                        if metric in test_metrics:
+                            baseline_val = baseline_metrics[metric]
+                            test_val = test_metrics[metric]
+                            diff = test_val - baseline_val
+                            pct_change = (diff / baseline_val) * 100 if baseline_val != 0 else 0
+
+                            comparison["metrics"][metric] = {
+                                "baseline": baseline_val,
+                                "test": test_val,
+                                "diff": diff,
+                                "pct_change": pct_change
+                            }
+
+                            if pct_change > threshold_percent:
+                                has_regression = True
+
+                    if has_regression:
+                        regressions.append(comparison)
+                    else:
+                        passes.append(comparison)
+
+                except Exception:
+                    continue
+
+            # Report regressions
+            if regressions:
+                result += f"REGRESSIONS DETECTED ({len(regressions)} files):\n"
+                result += "-" * 60 + "\n\n"
+                for comp in regressions:
+                    result += f"{comp['file']}:\n"
+                    result += f"  Kernel: {comp['kernel']}\n"
+                    result += f"  Date: {comp['date']}\n"
+                    for metric, values in comp["metrics"].items():
+                        result += f"  {metric}:\n"
+                        result += f"    Baseline: {values['baseline']:.2f} µs\n"
+                        result += f"    Test: {values['test']:.2f} µs\n"
+                        result += f"    Change: {values['pct_change']:+.2f}%"
+                        if values['pct_change'] > threshold_percent:
+                            result += " ⚠️  REGRESSION"
+                        result += "\n"
+                    result += "\n"
+
+            # Report passes
+            if passes:
+                result += f"\nPASSED COMPARISON ({len(passes)} files):\n"
+                result += "-" * 60 + "\n\n"
+                for comp in passes:
+                    result += f"{comp['file']}: "
+                    max_pct = max(m['pct_change'] for m in comp['metrics'].values())
+                    result += f"Max change: {max_pct:+.2f}% ✓\n"
+
+            if not regressions and not passes:
+                result += "No comparable results found\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error comparing to baseline: {str(e)}"
+            )]
+
     else:
         return [TextContent(
             type="text",
-- 
2.55.0

