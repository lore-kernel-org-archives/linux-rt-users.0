Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B73E3C53
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745461; cv=none; b=jdvsSo0TtJTGWWNIqqilC/9iiVN9nKCG0lPqIQpgLBiE+zm/2QHGf00p/nei740xXk5IoO3zNgLYYzXV4bMwPlTfBIHbQwrN/VDWxz1OcHTFnV8jEimLtAqhQ9fL9mvKh4MrrNRALnmvN1osxgOT4U5Il48RKkERjzh4YzRU1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745461; c=relaxed/simple;
	bh=QfkTP+2LWknrYFU8eDi7E3rc5VVA1+SstpynxJbfqPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJnPSZXe85xrqaWMh6dW5HpsGEfH98VzCnmwuvbgU8nsp+XLd91RFnpTnhTvajpnSRO5kLNizLXeqVl4SkpOoG0cW8BcqG9Xyj1nOkEkUfKI483TU9jDpKJGgKP9hT000s2ctPUlctPcQM6DVmBTbLtH2L42jjcFupn8SVvi0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/27IctH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/27IctH"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-526f963372aso10007351cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745459; x=1787350259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CcCrSe2Z1z+ve/gprBgdrxHU94i849V0KPSHuDPhP6o=;
        b=q/27IctHp1BKQY2K7RjlI0kUx0nPlsHftY6jRmyWZS3Nk1XVT47rCoE0ijbZEwyMiz
         iq+hqfbXqnjNqEqrGBwE0Hqc9VFAlcpu0NDhNDQP7NTL0+CBvQgK0hG9Y5vbFQtZFeT2
         Hz5PTaKKO0ZByam77v5ny5awKUcwHzltg9Z2E7JSLuBWldujrgjb29Fo3Un5tjNhLnAy
         l2++4DQA8MKKlQKfMeFSE5fOd58KnT+hXh18CVwAf2EpIfWjpVrzH6gtgRqM6uweqL+Y
         IyeBnnmzfVJ6x0QlkreqhmKVI1U59Dyga/YXaIaSC88SaCmMhfGRjyyatCfAxWue2U11
         Qg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745459; x=1787350259;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcCrSe2Z1z+ve/gprBgdrxHU94i849V0KPSHuDPhP6o=;
        b=Mb7h2+f4t4pBcJdsgI7rWVMFprW4QrEjNxO5lF8cNRZ/y9l2a0hXSImChDyzBYoqJt
         qK5LASNaiZvfBHMTSNCGQTofH7+FELuYzdyDMppQeaOyS9sqmazVolzsloCrKJNovOeh
         ow8ZAbpVhiDxSRVsplJ08kG4TdKI4pl1qNrCrFD/KJJL0HVOX6M8H1qYo86QloPzG1eP
         HbBos/ZVk/sAU7Y6NVzEH1IIeeqHt7Yn/DK4ShR+G8p58LMLWQ9nVAXtwOo7PBVALBXa
         nYwt4IVYQMYM0GeTJkGNCcTmYtSdmhWuZiSVZilDM5RZEAs/eyL96/Vw2ZuLj81cvtYk
         A0xQ==
X-Gm-Message-State: AOJu0Yy1rBdkT2BODJKNgoS9xZJ3nlnL02SOsEq+khDsCoN1LHw4ggpS
	1jEGxMKtqmCVYNsAIhGMlzEGFlUS/pfI+kI0ZEnxIHEqX/5y2jP5h1CGxWT6Vg==
X-Gm-Gg: AR+sD111VEvngOoCwTyWg+wKppgU9o3+8M/GDPlXP+2L+2ydvFo93drrGbnoESzwZQq
	2tuxULKpgrSFr5Lft1kM8j8Nnz08T3myMmccmBMH8suMrHSoA00eMPkjVpZ5ok1dSoDU3ToQBFj
	l62ca9InCiSARWg9jkXXYHOaK8cSFAmEzw78ROGs8QUaDsDuyGjNHrKMj5DE3sbDcQQliwxqvFx
	EBYfNNRaFdxrfJmsS5B2a/x6WkALlCw+hE02mmkZPbgd8vOjH7GMdOK1AGWFUhrp3mPcvOdwi09
	gx4QSsysyB5RpfsYXvbUA+7M7ODEu1/klV/z+cOVyo1nw0zTvuNCU+CnY/1xuPafMt7am9mB5r8
	4Wu+4Q8Amt0Tv0swfyAtBaCm6w5skoW6ykbluU7B4EK6zI1veVNX019lM4w2mP5IujEDE9JTNCN
	CGPiqrtPjfo9n1OV3MGhbGE2FCemzdAMchNXoCCkSoMDdT5OhXrbeo2L5tBRc6wuhO35nO4vAnF
	kC9jzDRro/EBqUJKxltVujwYjKAAH5azqbaaT2su4oa4VBht8Lgs4hD2nVX14aJ3w==
X-Received: by 2002:a05:622a:230b:b0:51f:636c:8eae with SMTP id d75a77b69052e-52d85361b08mr120830931cf.14.1786745458942;
        Fri, 14 Aug 2026 15:10:58 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:10:58 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 07/23] rteval: mcp-server: Add batch analysis tool
Date: Fri, 14 Aug 2026 18:10:06 -0400
Message-ID: <20260814221027.213574-8-jkacur@redhat.com>
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

Add batch_analysis tool to analyze multiple rteval result files at once.
The tool scans directories for result files, parses each one, and aggregates
statistics across all runs.

Features:
- Directory scanning with pattern matching (*.xml by default)
- Optional recursive subdirectory search
- Individual file summaries showing date, kernel, duration, and latencies
- Aggregate statistics: date range, max/mean latencies (min/max/average)
- Error handling for unparseable files

This enables quick analysis of multiple test runs to identify trends,
compare results over time, and spot outliers.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/server.py | 174 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/mcp-server/server.py b/mcp-server/server.py
index d1ad5437a886..aa8cfe1102d9 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -273,6 +273,30 @@ async def list_tools() -> list[Tool]:
                 "required": ["log_path"],
             },
         ),
+        Tool(
+            name="batch_analysis",
+            description="Analyze multiple rteval result files and aggregate statistics",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "directory": {
+                        "type": "string",
+                        "description": "Directory to search for rteval results (default: current directory)",
+                    },
+                    "pattern": {
+                        "type": "string",
+                        "description": "File pattern to match (default: *.xml)",
+                        "default": "*.xml",
+                    },
+                    "recursive": {
+                        "type": "boolean",
+                        "description": "Search subdirectories recursively (default: false)",
+                        "default": False,
+                    },
+                },
+                "required": [],
+            },
+        ),
     ]
 
 
@@ -715,6 +739,156 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                 text=f"Error reading log file: {str(e)}"
             )]
 
+    elif name == "batch_analysis":
+        directory = arguments.get("directory", ".")
+        pattern = arguments.get("pattern", "*.xml")
+        recursive = arguments.get("recursive", False)
+
+        try:
+            path = Path(directory)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: Directory '{directory}' does not exist"
+                )]
+
+            # Find matching files
+            if recursive:
+                files = list(path.rglob(pattern))
+            else:
+                files = list(path.glob(pattern))
+
+            if not files:
+                return [TextContent(
+                    type="text",
+                    text=f"No files matching '{pattern}' found in '{directory}'"
+                )]
+
+            # Parse each file and collect data
+            results = []
+            parse_errors = []
+
+            for file_path in files:
+                try:
+                    data = extract_rteval_data(str(file_path))
+                    results.append(data)
+                except Exception as e:
+                    parse_errors.append(f"{file_path.name}: {str(e)}")
+
+            if not results:
+                error_msg = "Failed to parse any result files"
+                if parse_errors:
+                    error_msg += ":\n" + "\n".join(parse_errors)
+                return [TextContent(type="text", text=error_msg)]
+
+            # Build output
+            result = f"Batch Analysis of {len(results)} rteval Result(s)\n"
+            result += "=" * 60 + "\n\n"
+
+            if parse_errors:
+                result += f"Warning: Failed to parse {len(parse_errors)} file(s)\n\n"
+
+            # Individual file summaries
+            result += "Individual Results:\n"
+            result += "-" * 60 + "\n"
+
+            max_latencies = []
+            mean_latencies = []
+            dates = []
+
+            for data in results:
+                file_name = Path(data["file"]).name
+                result += f"\n{file_name}:\n"
+
+                # Date
+                if "date" in data["run_info"] and "time" in data["run_info"]:
+                    date_str = f"{data['run_info']['date']} {data['run_info']['time']}"
+                    result += f"  Date: {date_str}\n"
+                    dates.append(date_str)
+
+                # Duration
+                ri = data["run_info"]
+                if any(k in ri for k in ["days", "hours", "minutes", "seconds"]):
+                    result += f"  Duration: {ri.get('days', 0)}d {ri.get('hours', 0)}h "
+                    result += f"{ri.get('minutes', 0)}m {ri.get('seconds', 0)}s\n"
+
+                # System
+                if "kernel" in data["system_info"]:
+                    result += f"  Kernel: {data['system_info']['kernel']}"
+                    if "is_RT" in data["system_info"]:
+                        result += f" (RT: {'Yes' if data['system_info']['is_RT'] else 'No'})"
+                    result += "\n"
+
+                # Measurements - timerlat
+                if "timerlat" in data["measurements"]:
+                    meas = data["measurements"]["timerlat"]
+                    if "maximum" in meas:
+                        max_val = meas["maximum"]["value"]
+                        max_unit = meas["maximum"]["unit"]
+                        result += f"  Max Latency: {max_val} {max_unit}\n"
+                        try:
+                            max_latencies.append(float(max_val))
+                        except ValueError:
+                            pass
+                    if "mean" in meas:
+                        mean_val = meas["mean"]["value"]
+                        mean_unit = meas["mean"]["unit"]
+                        result += f"  Mean Latency: {mean_val} {mean_unit}\n"
+                        try:
+                            mean_latencies.append(float(mean_val))
+                        except ValueError:
+                            pass
+
+                # Measurements - cyclictest
+                elif "cyclictest" in data["measurements"]:
+                    meas = data["measurements"]["cyclictest"]
+                    if "maximum" in meas:
+                        max_val = meas["maximum"]["value"]
+                        max_unit = meas["maximum"]["unit"]
+                        result += f"  Max Latency: {max_val} {max_unit}\n"
+                        try:
+                            max_latencies.append(float(max_val))
+                        except ValueError:
+                            pass
+                    if "mean" in meas:
+                        mean_val = meas["mean"]["value"]
+                        mean_unit = meas["mean"]["unit"]
+                        result += f"  Mean Latency: {mean_val} {mean_unit}\n"
+                        try:
+                            mean_latencies.append(float(mean_val))
+                        except ValueError:
+                            pass
+
+            # Aggregate statistics
+            result += "\n" + "=" * 60 + "\n"
+            result += "Aggregate Statistics:\n"
+            result += "-" * 60 + "\n\n"
+
+            result += f"Total files analyzed: {len(results)}\n"
+
+            if dates:
+                result += f"Date range: {min(dates)} to {max(dates)}\n"
+
+            if max_latencies:
+                result += f"\nMaximum Latencies:\n"
+                result += f"  Lowest max: {min(max_latencies):.2f} µs\n"
+                result += f"  Highest max: {max(max_latencies):.2f} µs\n"
+                result += f"  Average max: {sum(max_latencies) / len(max_latencies):.2f} µs\n"
+
+            if mean_latencies:
+                result += f"\nMean Latencies:\n"
+                result += f"  Lowest mean: {min(mean_latencies):.2f} µs\n"
+                result += f"  Highest mean: {max(mean_latencies):.2f} µs\n"
+                result += f"  Average mean: {sum(mean_latencies) / len(mean_latencies):.2f} µs\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error in batch analysis: {str(e)}"
+            )]
+
     else:
         return [TextContent(
             type="text",
-- 
2.55.0

