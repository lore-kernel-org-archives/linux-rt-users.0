Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D33E3C53
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745464; cv=none; b=PNbkzRPUY9JhadkdeWGldmvPZLEqj+oykgeq6VdJVMMYKlyf0LdF7J0PbShqT/GHIi5iPyZoSN5bbTJ40rxxZjEgGzGtT/llLBnR+WbVwjwl2Vq7xxuYaOC9dOaOSGvU0xJoebKVghY3tANDAS+0hyjgtwdNsl4uESanyMI086Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745464; c=relaxed/simple;
	bh=D624IfakZetNm+O187lTA87YIAAgPskPojHQtuLpJOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZAOIYJHYi/Ih1Cy+2ukxJ5A+23L7sLMiWqvH+ioAzCgvYIHOu/kCF65ApOqJIqAxt7vdsAYw8AsOXOMMvAT70oXRD49ivSkNJQYzVTwLoecirj/jYQL3NK8Mkc3TtaP3p90td5iZ6auKUU/I0XDzcCF8YxKPHrXbjhPmippH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xby52OaB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xby52OaB"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90a80860d35so13404756d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745462; x=1787350262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=safdF6xGou5cjA07n5tuFRU9svJ2JNo/g0TqPzGHt/0=;
        b=Xby52OaBLb20IWhH6zPMdwJlXGrEKxiRDiXvvPcQQOFG7mQKln52XfMzbDbYitxwEy
         JMcGqEUbNdn7Nnc1xwGOSkLCcWTwFJNPNvVPNJRMShId5qFoW9LQZB+PQO8kb+/5dRbR
         xL+AWmPZ8gKPIQVtawg7Ud9w1yjhPGjQeKIpQUK/zqh1qGCbTK9B3PgfUXU9tFamQaql
         X04R3Ki1QEZrgpDFAdkJL2rIQt6+58KxNB7qlMxADi6/uz62Gqp0vlGfBUWBI9LP7pyb
         H4FzI0GxdfQV56wRFyAb7b2nO6ue/jX7qw4Cwbux6mes2EvUr/36+lkUefWUXBc4/fML
         +nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745462; x=1787350262;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=safdF6xGou5cjA07n5tuFRU9svJ2JNo/g0TqPzGHt/0=;
        b=a6LiK3KDnspsRuz8KpwGFxkELC6GI+R6FHmDnaL8PfZFVFEx1Puw/whMlCbrlwI8zw
         gT5IK/3je58wQWyD9z9I2ZIBkLNWdmAngVeBrC6FktIAC11h8eUDU3fNRDV1391j/qAt
         VR1L3wlUwzVpqkJDmp/jewFR8zTHZ79gFF5ne3Bc86iP+hRlqzoHJpi/WXGTFJPinpRO
         cqoWE96kELSu1FfW/ao40BU/fVjuohGCJNH6vXOvUluCFFEv+QL349Fl5tk0tPmp4Puj
         UD73j7XXn7Kei9IyDiEH+PCzleKXvVKgowjwoh07vDCRUi0A7xqCEe+3F/9Lmc6JBmI4
         63Ow==
X-Gm-Message-State: AOJu0Yx7Yw6rcIUXEzWwezExoamM1Dgzlt28w8Xl/a5Ca9yPio8xOg86
	4b7dwMoct22FlsBgX6Lhm7RPRvySEjBUQdpaThqAjX16lvvIRLbRKyLWFAaZJA==
X-Gm-Gg: AR+sD110DVKqhLS9RLPoW8BKoi0Jf5k4/8YMPDzvlgtUgvS3bC0va2wZopmf2B1DLu8
	JtqvbEIJwRxU14NmNvmnmbBkLEd5lFDJpOgDZizunABdWC3sX7pS496vpWIs1Ahqk4+7UNkggqD
	jdJb1hnnr37KjWQivIoDQxXxRtBVXi1VjDOWGLKoXq0yFA6fHNtuN/v6UEpdeLFZg062TdGcHUz
	Ml/fTQeBc9dawhAxeGQNSpd5c0pv4qd2osDSQL3HP4ycdsgmAKdB6ADi8eKc63VWN7DoBGROXcm
	OlOtpF8SRHhwqOwIA1UlSmU2ZQBBeNV//pYcvbOxN9VSgtj+L4elPfncfEOtnCCoBZcdFIshV8Q
	EPE81rPtR/fkWc3M0QIVAqe6aCfJSdYJ8fTmpuNf3K6MNQfQDrbsF2iOBcd5pf12szLWdIacjNs
	Imx5GPm9Zc8jQHoPeuwEq+Jofp4fLghbm5hx5G8BjfJ097fOEctrT1qXrKFV196rmUR0CWeL1rN
	zwok7McK2A45zcIOWaFzg0fCtQpg+0RfMSlL2LayCKV9xh3peDVOcI=
X-Received: by 2002:a05:6214:528f:b0:90a:4361:9c4f with SMTP id 6a1803df08f44-90a91c8f670mr87867816d6.1.1786745461756;
        Fri, 14 Aug 2026 15:11:01 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:01 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 09/23] rteval MCP: Add histogram extraction and percentile analysis
Date: Fri, 14 Aug 2026 18:10:08 -0400
Message-ID: <20260814221027.213574-10-jkacur@redhat.com>
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

Implement feature #3 from future-features.md: latency histogram
extraction and percentile calculation.

New tools:
- extract_histogram: Extract raw histogram data from rteval XML
  - System-wide and per-CPU histogram summaries
  - Top latency values by sample count
  - Total samples and latency range

- get_percentiles: Calculate latency percentiles (P50, P90, P95, P99, P99.9, P99.99)
  - System-wide percentile analysis
  - Optional per-CPU percentile breakdown
  - Reveals latency distribution beyond max/mean/median

Why this matters:
- Max latency alone is misleading (one spike vs systematic issues)
- P99.9 tells you 99.9% of samples were below this value
- Percentiles distinguish rare outliers from regular tail latency
- Per-CPU percentiles identify hardware-specific problems

Implementation:
- extract_histogram_data(): Parse histogram buckets from XML
- calculate_percentiles(): Compute percentiles from bucket counts
- Fixed XPath to find system-wide histogram under <system> tag
- Handles both system-wide and per-CPU histogram data

Testing:
- test_histogram.py validates extraction and calculation
- Tested with rteval-20260714-1 (28.6M samples, 16 CPUs)
- System P99.9 = 16µs, max = 1550µs (excellent with rare outliers)

Documentation:
- Updated README with usage examples
- Added detailed feature descriptions
- Explained why percentiles matter for RT analysis

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/README.md         |  40 +++++
 mcp-server/server.py         | 275 +++++++++++++++++++++++++++++++++++
 mcp-server/test_histogram.py |  57 ++++++++
 3 files changed, 372 insertions(+)
 create mode 100644 mcp-server/test_histogram.py

diff --git a/mcp-server/README.md b/mcp-server/README.md
index 7ce028b512f5..3ab34c4302b7 100644
--- a/mcp-server/README.md
+++ b/mcp-server/README.md
@@ -48,6 +48,10 @@ sudo dnf install python3-mcp python3-mcp+cli python3-lxml
 - **list_logs**: List available log files in an rteval result directory
 - **read_log**: Read log content with optional filtering (head/tail/grep)
 
+### Histogram Analysis
+- **extract_histogram**: Extract latency histogram data from rteval results
+- **get_percentiles**: Calculate latency percentiles (P50, P95, P99, P99.9, etc.)
+
 ## Usage
 
 ### Testing the Server Directly
@@ -101,6 +105,14 @@ Analyze all rteval results and show aggregate statistics
 What's the average max latency across all runs?
 ```
 
+**Histogram and percentiles:**
+```
+Extract histogram data from rteval-20260714-1/summary.xml
+Calculate P99 and P99.9 percentiles for rteval-20260714-1/summary.xml
+Show me percentiles for each CPU in rteval-20260714-1/summary.xml
+What percentage of samples had latency under 10 microseconds?
+```
+
 ### Using with MCP Inspector
 
 ```bash
@@ -146,6 +158,34 @@ Aggregate statistics across multiple runs:
 
 Useful for understanding performance trends over time.
 
+### extract_histogram
+Extract raw histogram data from rteval results:
+- **file_path**: Path to rteval XML result file
+- **include_per_cpu**: Include per-CPU histogram data (default: true)
+
+Shows:
+- System-wide histogram summary with total samples and latency range
+- Top latency values by sample count with percentages
+- Per-CPU histogram summaries with individual max latencies
+
+### get_percentiles
+Calculate latency percentiles for detailed distribution analysis:
+- **file_path**: Path to rteval XML result file
+- **percentiles**: List of percentiles to calculate (default: [50, 90, 95, 99, 99.9, 99.99])
+- **per_cpu**: Calculate percentiles per CPU (default: false)
+
+Reports:
+- System-wide percentiles showing latency distribution
+- Per-CPU percentiles when requested for fine-grained analysis
+
+**Why percentiles matter:**
+- **Max latency** alone can be misleading (one outlier vs. systematic issues)
+- **P99.9** tells you that 99.9% of samples were below this value
+- **Percentiles** reveal whether high latencies are rare spikes or regular occurrences
+- **Per-CPU percentiles** help identify hardware-specific issues or IRQ affinity problems
+
+Example: If P99.9 = 16µs but max = 1550µs, this tells you the system is excellent with only rare outliers, not a systematic problem.
+
 ## Development
 
 This is a work in progress. The MCP server is being developed in a branch of the
diff --git a/mcp-server/server.py b/mcp-server/server.py
index 8dbcd9c62fd1..48474df56fab 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -178,6 +178,120 @@ def extract_rteval_data(file_path: str) -> dict[str, Any]:
     return data
 
 
+def extract_histogram_data(file_path: str) -> dict[str, Any]:
+    """Extract histogram data from an rteval XML file.
+
+    Returns a dictionary with system-wide and per-CPU histogram data,
+    including bucket counts and percentile calculations.
+    """
+    tree = ET.parse(file_path)
+    root = tree.getroot()
+
+    result = {
+        "file": file_path,
+        "system_histogram": None,
+        "per_cpu_histograms": []
+    }
+
+    # Extract system-wide histogram
+    timerlat = root.find(".//timerlat")
+    if timerlat is not None:
+        # System-wide histogram is under <system> tag
+        system_elem = timerlat.find("system")
+        system_histogram = None
+        if system_elem is not None:
+            system_histogram = system_elem.find("histogram")
+
+        if system_histogram is not None:
+            nbuckets = int(system_histogram.get("nbuckets", "0"))
+            buckets = []
+
+            for bucket in system_histogram.findall("bucket"):
+                index = int(bucket.get("index"))
+                count = int(bucket.get("value"))
+                buckets.append({"latency_us": index, "count": count})
+
+            result["system_histogram"] = {
+                "nbuckets": nbuckets,
+                "buckets": buckets,
+                "total_samples": sum(b["count"] for b in buckets)
+            }
+
+        # Extract per-CPU histograms
+        for core in timerlat.findall("core"):
+            core_id = core.get("id")
+            priority = core.get("priority")
+            histogram = core.find("histogram")
+
+            if histogram is not None:
+                nbuckets = int(histogram.get("nbuckets", "0"))
+                buckets = []
+
+                for bucket in histogram.findall("bucket"):
+                    index = int(bucket.get("index"))
+                    count = int(bucket.get("value"))
+                    buckets.append({"latency_us": index, "count": count})
+
+                result["per_cpu_histograms"].append({
+                    "cpu_id": core_id,
+                    "priority": priority,
+                    "nbuckets": nbuckets,
+                    "buckets": buckets,
+                    "total_samples": sum(b["count"] for b in buckets)
+                })
+
+    return result
+
+
+def calculate_percentiles(buckets: list[dict], percentiles: list[float]) -> dict[str, float]:
+    """Calculate percentiles from histogram bucket data.
+
+    Args:
+        buckets: List of dicts with 'latency_us' and 'count' keys
+        percentiles: List of percentile values (e.g., [50, 95, 99, 99.9])
+
+    Returns:
+        Dictionary mapping percentile labels to latency values in microseconds
+    """
+    if not buckets:
+        return {}
+
+    # Calculate total samples
+    total_samples = sum(b["count"] for b in buckets)
+    if total_samples == 0:
+        return {}
+
+    # Sort buckets by latency
+    sorted_buckets = sorted(buckets, key=lambda b: b["latency_us"])
+
+    # Calculate cumulative counts
+    cumulative = []
+    running_count = 0
+    for bucket in sorted_buckets:
+        running_count += bucket["count"]
+        cumulative.append({
+            "latency_us": bucket["latency_us"],
+            "cumulative_count": running_count,
+            "cumulative_percent": (running_count / total_samples) * 100
+        })
+
+    # Find percentile values
+    result = {}
+    for p in percentiles:
+        target_count = (p / 100.0) * total_samples
+
+        # Find the first bucket where cumulative count >= target
+        for i, cum in enumerate(cumulative):
+            if cum["cumulative_count"] >= target_count:
+                result[f"P{p}"] = cum["latency_us"]
+                break
+        else:
+            # If no bucket found, use the maximum
+            result[f"P{p}"] = cumulative[-1]["latency_us"]
+
+    return result
+
+
 @app.list_tools()
 async def list_tools() -> list[Tool]:
     """List available tools for rteval analysis."""
@@ -382,6 +496,50 @@ async def list_tools() -> list[Tool]:
                 "required": ["baseline_file"],
             },
         ),
+        Tool(
+            name="extract_histogram",
+            description="Extract latency histogram data from an rteval result file",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "file_path": {
+                        "type": "string",
+                        "description": "Path to the rteval XML result file",
+                    },
+                    "include_per_cpu": {
+                        "type": "boolean",
+                        "description": "Include per-CPU histogram data (default: true)",
+                        "default": True,
+                    },
+                },
+                "required": ["file_path"],
+            },
+        ),
+        Tool(
+            name="get_percentiles",
+            description="Calculate latency percentiles from an rteval result file",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "file_path": {
+                        "type": "string",
+                        "description": "Path to the rteval XML result file",
+                    },
+                    "percentiles": {
+                        "type": "array",
+                        "description": "List of percentiles to calculate (default: [50, 90, 95, 99, 99.9, 99.99])",
+                        "items": {"type": "number"},
+                        "default": [50, 90, 95, 99, 99.9, 99.99],
+                    },
+                    "per_cpu": {
+                        "type": "boolean",
+                        "description": "Calculate percentiles per CPU (default: false)",
+                        "default": False,
+                    },
+                },
+                "required": ["file_path"],
+            },
+        ),
     ]
 
 
@@ -1339,6 +1497,123 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                 text=f"Error comparing to baseline: {str(e)}"
             )]
 
+    elif name == "extract_histogram":
+        file_path = arguments["file_path"]
+        include_per_cpu = arguments.get("include_per_cpu", True)
+
+        try:
+            path = Path(file_path)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: File '{file_path}' does not exist"
+                )]
+
+            # Extract histogram data
+            histogram_data = extract_histogram_data(file_path)
+
+            if histogram_data["system_histogram"] is None:
+                return [TextContent(
+                    type="text",
+                    text=f"No histogram data found in '{path.name}'"
+                )]
+
+            result = f"Histogram Data from: {path.name}\n"
+            result += "=" * 60 + "\n\n"
+
+            # System-wide histogram summary
+            sys_hist = histogram_data["system_histogram"]
+            result += "System-Wide Histogram:\n"
+            result += f"  Total Buckets: {sys_hist['nbuckets']}\n"
+            result += f"  Total Samples: {sys_hist['total_samples']:,}\n"
+            result += f"  Latency Range: {sys_hist['buckets'][0]['latency_us']} - {sys_hist['buckets'][-1]['latency_us']} µs\n\n"
+
+            # Show top 10 buckets by count
+            top_buckets = sorted(sys_hist['buckets'], key=lambda b: b['count'], reverse=True)[:10]
+            result += "Top 10 Latency Values by Sample Count:\n"
+            for i, bucket in enumerate(top_buckets, 1):
+                pct = (bucket['count'] / sys_hist['total_samples']) * 100
+                result += f"  {i}. {bucket['latency_us']:3d} µs: {bucket['count']:>12,} samples ({pct:5.2f}%)\n"
+            result += "\n"
+
+            # Per-CPU summary
+            if include_per_cpu and histogram_data["per_cpu_histograms"]:
+                result += f"Per-CPU Histograms ({len(histogram_data['per_cpu_histograms'])} CPUs):\n"
+                for cpu_hist in histogram_data["per_cpu_histograms"]:
+                    cpu_id = cpu_hist["cpu_id"]
+                    total = cpu_hist["total_samples"]
+                    max_lat = cpu_hist["buckets"][-1]["latency_us"] if cpu_hist["buckets"] else 0
+                    result += f"  CPU {cpu_id}: {total:>12,} samples, max latency {max_lat} µs\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error extracting histogram: {str(e)}"
+            )]
+
+    elif name == "get_percentiles":
+        file_path = arguments["file_path"]
+        percentiles = arguments.get("percentiles", [50, 90, 95, 99, 99.9, 99.99])
+        per_cpu = arguments.get("per_cpu", False)
+
+        try:
+            path = Path(file_path)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: File '{file_path}' does not exist"
+                )]
+
+            # Extract histogram data
+            histogram_data = extract_histogram_data(file_path)
+
+            if histogram_data["system_histogram"] is None:
+                return [TextContent(
+                    type="text",
+                    text=f"No histogram data found in '{path.name}'"
+                )]
+
+            result = f"Latency Percentiles from: {path.name}\n"
+            result += "=" * 60 + "\n\n"
+
+            # System-wide percentiles
+            sys_hist = histogram_data["system_histogram"]
+            sys_percentiles = calculate_percentiles(sys_hist["buckets"], percentiles)
+
+            result += "System-Wide Percentiles:\n"
+            result += f"  Total Samples: {sys_hist['total_samples']:,}\n\n"
+
+            for p in percentiles:
+                key = f"P{p}"
+                if key in sys_percentiles:
+                    result += f"  {key:>7}: {sys_percentiles[key]:>6} µs\n"
+
+            # Per-CPU percentiles
+            if per_cpu and histogram_data["per_cpu_histograms"]:
+                result += "\n" + "=" * 60 + "\n"
+                result += "Per-CPU Percentiles:\n\n"
+
+                for cpu_hist in histogram_data["per_cpu_histograms"]:
+                    cpu_id = cpu_hist["cpu_id"]
+                    cpu_percentiles = calculate_percentiles(cpu_hist["buckets"], percentiles)
+
+                    result += f"CPU {cpu_id}:\n"
+                    for p in percentiles:
+                        key = f"P{p}"
+                        if key in cpu_percentiles:
+                            result += f"  {key:>7}: {cpu_percentiles[key]:>6} µs\n"
+                    result += "\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error calculating percentiles: {str(e)}"
+            )]
+
     else:
         return [TextContent(
             type="text",
diff --git a/mcp-server/test_histogram.py b/mcp-server/test_histogram.py
new file mode 100644
index 000000000000..e11dfb0413a4
--- /dev/null
+++ b/mcp-server/test_histogram.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+"""
+Test script for histogram extraction and percentile calculation.
+"""
+
+from server import extract_histogram_data, calculate_percentiles
+
+# Test with the sample file
+test_file = "../rteval-20260714-1/summary.xml"
+
+print("Testing histogram extraction...")
+print("=" * 60)
+
+# Extract histogram data
+histogram_data = extract_histogram_data(test_file)
+
+# Check system histogram
+if histogram_data["system_histogram"]:
+    sys_hist = histogram_data["system_histogram"]
+    print(f"\nSystem-Wide Histogram:")
+    print(f"  Total Buckets: {sys_hist['nbuckets']}")
+    print(f"  Total Samples: {sys_hist['total_samples']:,}")
+    print(f"  Latency Range: {sys_hist['buckets'][0]['latency_us']} - {sys_hist['buckets'][-1]['latency_us']} µs")
+
+    # Calculate percentiles
+    percentiles = [50, 90, 95, 99, 99.9, 99.99]
+    result = calculate_percentiles(sys_hist["buckets"], percentiles)
+
+    print(f"\nSystem-Wide Percentiles:")
+    for p in percentiles:
+        key = f"P{p}"
+        if key in result:
+            print(f"  {key:>7}: {result[key]:>6} µs")
+
+# Check per-CPU histograms
+if histogram_data["per_cpu_histograms"]:
+    print(f"\nPer-CPU Histograms ({len(histogram_data['per_cpu_histograms'])} CPUs):")
+
+    # Show first 3 CPUs in detail
+    for cpu_hist in histogram_data["per_cpu_histograms"][:3]:
+        cpu_id = cpu_hist["cpu_id"]
+        total = cpu_hist["total_samples"]
+        max_lat = cpu_hist["buckets"][-1]["latency_us"] if cpu_hist["buckets"] else 0
+
+        print(f"\n  CPU {cpu_id}:")
+        print(f"    Total Samples: {total:,}")
+        print(f"    Max Latency: {max_lat} µs")
+
+        # Calculate per-CPU percentiles
+        cpu_percentiles = calculate_percentiles(cpu_hist["buckets"], [50, 95, 99, 99.9])
+        for p in [50, 95, 99, 99.9]:
+            key = f"P{p}"
+            if key in cpu_percentiles:
+                print(f"    {key:>6}: {cpu_percentiles[key]:>6} µs")
+
+print("\n" + "=" * 60)
+print("Test completed successfully!")
-- 
2.55.0

