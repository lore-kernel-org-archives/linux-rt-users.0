Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE843E6DD0
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745454; cv=none; b=bAjhPUu+NxpYqtwygiZ3b/PceWUP+0lIU88Lsvao6fU2pgHfcasodgd2gRzSniruHluTAV47QHkbr5XQMQixgBcfRqIhl/E/x00IHUq8PtA8mS4J/HV06YUo1glLDr6scri71TLNG/VM/ZLvQCQ1ZTloqHO9VDrOdHgHi1helrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745454; c=relaxed/simple;
	bh=3RO2EtxIV6IvzQLxMCARoX68wr1Nzxe5u5/cx1EwSy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxL619BjqKWJuSoi5BhNHGwxkZ7lnplqDbPlvY04QqOTe6Pq9CBQ8uy2byufqMQEPEZEI/K7h24QRz5rLOW4sTkc2r9jFvsVmFHzMVk6wKsyQA525OOWAGqGX89FtNMOanrhWWGp0siXRxciBjVYXPB0Nir7GNfWeojqhpV5xY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCnLrsN+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCnLrsN+"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so16268356d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745451; x=1787350251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lP7iGHAC/t6cW4zqVhikj0+bonuEruFISf3tKSd0n4Q=;
        b=OCnLrsN+eNCNXqDj1/cpT3Q0D29GoVx25WWZlaZWsJXvQ7wddi86ZEX18xBtJPzb/3
         VKWsF0ZbM58e53ob7KKktsIj6wztjcMc9YK6S17MaTN7jiX/pEW1I/WlkCX3dmMHciV/
         gafjY90X9UmSchVMEYfVdFNOO8yEoQ4LQawrgj5yvJYRYm+Sq3JkySySQw/iK0ZKIxzJ
         q14dS3ySXb+AfXWvvJIsWF8HhmBRc78MiF7JXfnbU63ePDJFBT7euMwoEJOTwt9SXqm4
         FK/o34BTQbebKsGcLa3CYX4QQZK8bMldUNeBJhetVQfZUhP2KBh6FSLCrNzLYyU/kLn3
         4Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745451; x=1787350251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lP7iGHAC/t6cW4zqVhikj0+bonuEruFISf3tKSd0n4Q=;
        b=NObjRHTl1K1tdHG/evoVOs7c/fC2F99boKG/aCkfUZYT3KWEgebKxBQt/XpL8a1lh0
         +9BlOg9RBtMJpxfOFFxgJcuNu5Qo8DphWxi4jgSrueX8IU0BTvch/DnW5oHpnlEQWhay
         WvutgU1fPvEVhI4HUtc4l3Pjb+uvv3YRqSFkJjfgeYfa1LbWlJt1PL0QQuNvFrnvoQX0
         WFZEQgyAWPRgRFzQ7xLqu1sQVfBJqsJnLnKizwboxtw3KLJjF5IDg199mBxrimUBsYao
         rPz3q+/iN6+cGUFZ2WW7cJj9ATGrP3zNPYsmuE/5mnjvlf4jh8grqigOUyKVIqm+1OMb
         8u5g==
X-Gm-Message-State: AOJu0YyxLcxQj51sVqIRgdV9VcF0dWkq5ycCb7VqrR1uR8sy2S+OfwMh
	8zRiv2rRYRlokFHU5FDnspND08ctB+U46lu/2YuNofz4w3Za5qJ1QV6d5yVA0A==
X-Gm-Gg: AR+sD13iw+liDn6DNUMaN2PY2W1jahNCV2cTXz1dntjsrlAi6ffSf1pclANNklWW0ZC
	XW0KI8UMkAOHuzntywtjWW/nHG8yYHSOOABS4ZaG/8taJku+ZEtIBUBRVoEhQ4vxRSGA5JhTayY
	W1nl8xnID1ylv3fpIn/h7PEJTlWfTsDUGLyN0TYEkNxrm2DwRSijJsO3sSco/qweoTKQU218lNl
	26cfKaUYlihcSDJd12XavgRSJsAtt8NKSoXiQb3lIVJ2r4m9wEYFAE0QcPffTh4haXuKaYSMWnZ
	4MogxK6DgWJ7ZNK530qEltUCyWpNSn+FCCKWokHlZcOaXr4CQNmH850rNmC/iehP3amYWyTk09h
	jOies2pNOS++Bu9kp20prY/IRvXOe756d0BNuakoOx8jeYdpy7uzcPOv+CLwRQsm896J43E44Dk
	FlmPsXSLD2Jo1CCL8edR3Xhwn6uc53xs9ldeBEIyxjptWFsOiKlSOJd0+hczMLWXcerFbCojyAx
	QAc2wpHXxigl3OjtHP8S5aW6+NiajaAf4YHi+H7BwdZz1KZBacfn9o=
X-Received: by 2002:a05:6214:459b:b0:8ee:fbc5:8110 with SMTP id 6a1803df08f44-90a91e850e0mr118051366d6.32.1786745451287;
        Fri, 14 Aug 2026 15:10:51 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:10:49 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 02/23] rteval: Implement compare_results functionality in MCP server
Date: Fri, 14 Aug 2026 18:10:01 -0400
Message-ID: <20260814221027.213574-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814221027.213574-1-jkacur@redhat.com>
References: <20260814221027.213574-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add full comparison logic to the compare_results tool. The tool now:

- Extracts structured data from both rteval XML files
- Compares system information (kernel, OS, architecture)
- Compares run durations
- Compares timerlat/cyclictest statistics with detailed metrics
- Calculates differences and percentage changes
- Handles both timerlat and cyclictest measurement types

Added helper function extract_rteval_data() to parse XML files
and extract key information in a structured format for easy comparison.

Tested with two rteval 3.11 runs showing consistent results:
- Maximum latency: 3499 vs 3495 us (-0.11%)
- Mean latency: 4.22 vs 4.22 us (+0.09%)

This enables users to track performance trends and identify regressions
across multiple test runs.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/server.py | 200 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 194 insertions(+), 6 deletions(-)

diff --git a/mcp-server/server.py b/mcp-server/server.py
index a3ca9e3c5783..40c11dfecb34 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -21,6 +21,75 @@ from mcp.types import Tool, TextContent
 app = Server("rteval-mcp-server")
 
 
+def extract_rteval_data(file_path: str) -> dict[str, Any]:
+    """Extract key data from an rteval XML file for comparison."""
+    tree = ET.parse(file_path)
+    root = tree.getroot()
+
+    data = {
+        "file": file_path,
+        "rteval_version": root.get("version", "unknown"),
+        "run_info": {},
+        "system_info": {},
+        "measurements": {}
+    }
+
+    # Run information
+    runinfo = root.find("run_info")
+    if runinfo is not None:
+        data["run_info"] = {
+            "days": int(runinfo.get("days", "0")),
+            "hours": int(runinfo.get("hours", "0")),
+            "minutes": int(runinfo.get("minutes", "0")),
+            "seconds": int(runinfo.get("seconds", "0")),
+        }
+        date_elem = runinfo.find("date")
+        time_elem = runinfo.find("time")
+        if date_elem is not None and time_elem is not None:
+            data["run_info"]["date"] = date_elem.text
+            data["run_info"]["time"] = time_elem.text
+
+    # System information
+    sysinfo = root.find("SystemInfo")
+    if sysinfo is not None:
+        uname = sysinfo.find("uname")
+        if uname is not None:
+            for elem in ["baseos", "node", "arch", "kernel"]:
+                node = uname.find(elem)
+                if node is not None:
+                    if elem == "kernel":
+                        data["system_info"]["kernel"] = node.text
+                        data["system_info"]["is_RT"] = node.get("is_RT", "0") == "1"
+                    else:
+                        data["system_info"][elem] = node.text
+
+    # Timerlat measurements
+    timerlat = root.find(".//timerlat")
+    if timerlat is not None:
+        data["measurements"]["timerlat"] = {}
+        stats = timerlat.find(".//statistics")
+        if stats is not None:
+            for stat in stats:
+                data["measurements"]["timerlat"][stat.tag] = {
+                    "value": stat.text,
+                    "unit": stat.get("unit", "")
+                }
+
+    # Cyclictest measurements
+    cyclictest = root.find(".//cyclictest")
+    if cyclictest is not None:
+        data["measurements"]["cyclictest"] = {}
+        stats = cyclictest.find(".//statistics")
+        if stats is not None:
+            for stat in stats:
+                data["measurements"]["cyclictest"][stat.tag] = {
+                    "value": stat.text,
+                    "unit": stat.get("unit", "")
+                }
+
+    return data
+
+
 @app.list_tools()
 async def list_tools() -> list[Tool]:
     """List available tools for rteval analysis."""
@@ -227,12 +296,131 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
         file1 = arguments["file1"]
         file2 = arguments["file2"]
 
-        # For now, just return a placeholder
-        # This would need actual comparison logic based on rteval structure
-        return [TextContent(
-            type="text",
-            text=f"Comparison tool not yet implemented.\nWould compare:\n  {file1}\n  {file2}\n"
-        )]
+        try:
+            # Check if files exist
+            if not Path(file1).exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: File '{file1}' does not exist"
+                )]
+            if not Path(file2).exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: File '{file2}' does not exist"
+                )]
+
+            # Extract data from both files
+            data1 = extract_rteval_data(file1)
+            data2 = extract_rteval_data(file2)
+
+            # Build comparison report
+            result = "rteval Results Comparison\n"
+            result += "=" * 60 + "\n\n"
+
+            result += f"File 1: {Path(file1).name}\n"
+            result += f"File 2: {Path(file2).name}\n\n"
+
+            # Compare system information
+            result += "System Comparison:\n"
+            result += "-" * 60 + "\n"
+
+            sys1 = data1.get("system_info", {})
+            sys2 = data2.get("system_info", {})
+
+            for key in ["baseos", "node", "arch", "kernel", "is_RT"]:
+                val1 = sys1.get(key, "N/A")
+                val2 = sys2.get(key, "N/A")
+                if val1 != val2:
+                    result += f"  {key}:\n"
+                    result += f"    File 1: {val1}\n"
+                    result += f"    File 2: {val2}\n"
+                else:
+                    result += f"  {key}: {val1}\n"
+            result += "\n"
+
+            # Compare run durations
+            result += "Run Duration:\n"
+            result += "-" * 60 + "\n"
+
+            run1 = data1.get("run_info", {})
+            run2 = data2.get("run_info", {})
+
+            def format_duration(info):
+                return f"{info.get('days', 0)}d {info.get('hours', 0)}h {info.get('minutes', 0)}m {info.get('seconds', 0)}s"
+
+            result += f"  File 1: {format_duration(run1)}\n"
+            result += f"  File 2: {format_duration(run2)}\n\n"
+
+            # Compare measurements (timerlat or cyclictest)
+            meas1 = data1.get("measurements", {})
+            meas2 = data2.get("measurements", {})
+
+            # Determine which measurement type to compare
+            measurement_type = None
+            if "timerlat" in meas1 and "timerlat" in meas2:
+                measurement_type = "timerlat"
+            elif "cyclictest" in meas1 and "cyclictest" in meas2:
+                measurement_type = "cyclictest"
+
+            if measurement_type:
+                result += f"{measurement_type.capitalize()} Statistics Comparison:\n"
+                result += "-" * 60 + "\n"
+
+                stats1 = meas1.get(measurement_type, {})
+                stats2 = meas2.get(measurement_type, {})
+
+                # Key metrics to compare
+                for metric in ["samples", "minimum", "maximum", "mean", "median", "standard_deviation"]:
+                    if metric in stats1 and metric in stats2:
+                        val1_data = stats1[metric]
+                        val2_data = stats2[metric]
+
+                        val1 = val1_data["value"]
+                        val2 = val2_data["value"]
+                        unit = val1_data.get("unit", "")
+
+                        result += f"  {metric}:\n"
+                        result += f"    File 1: {val1} {unit}\n"
+                        result += f"    File 2: {val2} {unit}\n"
+
+                        # Calculate difference for numeric values
+                        try:
+                            num1 = float(val1)
+                            num2 = float(val2)
+                            diff = num2 - num1
+                            if diff > 0:
+                                result += f"    Difference: +{diff:.2f} {unit} (File 2 is higher)\n"
+                            elif diff < 0:
+                                result += f"    Difference: {diff:.2f} {unit} (File 2 is lower)\n"
+                            else:
+                                result += f"    Difference: No change\n"
+
+                            # Calculate percentage change for non-zero values
+                            if num1 != 0 and metric != "samples":
+                                pct_change = ((num2 - num1) / num1) * 100
+                                result += f"    Percent change: {pct_change:+.2f}%\n"
+
+                        except (ValueError, TypeError):
+                            pass
+
+                        result += "\n"
+            else:
+                result += "Measurement Comparison: Different measurement types used\n"
+                result += f"  File 1: {', '.join(meas1.keys())}\n"
+                result += f"  File 2: {', '.join(meas2.keys())}\n\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except ET.ParseError as e:
+            return [TextContent(
+                type="text",
+                text=f"Error parsing XML file: {str(e)}"
+            )]
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error comparing results: {str(e)}"
+            )]
 
     else:
         return [TextContent(
-- 
2.55.0

