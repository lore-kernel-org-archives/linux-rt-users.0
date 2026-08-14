Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE633E92BB
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745472; cv=none; b=WDfu7WWSxZ8L3na23lVYz+umDPL0H7G2bhbfo+5VrKCjC2B3cosDqnEfxq6TGC6DgM6YP5X76G4rNQlBIRpT209lVTe+S2BtwdiilTdtGA/uFmhQhrzQydkKyl2lNAwnYbnD3BESe+lvq6d3PmTj6MX2FxrnWObh9iNdMB3H7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745472; c=relaxed/simple;
	bh=HFujGmNOipBZ9Eh1C9zTCZ6Wg16IxBuDaxTzGl4CRNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUqeksWV54SDGjfWvid6a+QtbVqd0wyhmy1PSmLUWB42gRFcG+uMzhPTZ93i3oOlO7H/OgrsDJR6UYw5W3rQ57p1XFAo3JTu8MVkDE1Z6NtdzWGEs43lgL0xOuAcPLwRMy/s9NcRidSkTKyTXzAUYLUcQjzYCa3tO5hybXdEUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD3kI1Mo; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD3kI1Mo"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-902fc790cd5so9743776d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745470; x=1787350270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FB9JOc3S7IdfuuB4e+4c5jkD9visaD4SgiHPMBifo5o=;
        b=JD3kI1Mo95K8khwc0yd/4+2WKwqlJCOhCaLXwbfI4DbUPRVU5XeyJhbyg4uUHBYQXt
         zG1cvR0+3dksXa4X/5we9y21o8dPYhIxMTJrUud7ZDxTKtwb9Iqi3E9ZW3B5O1Jkkva+
         yTTlYOAjwVJneJHCRXjeziJOfXofhJFxDrWiXODMIfjbBMhQJsqX/wJ1m2erfcEr/zlG
         9HTnlP4zbrvZJyaOr7wW9nWjRJEqRV449pgRX+2v+m3Vnp1jU1YaEiZ4q+5rsGVrE2Kb
         F56Q8XvPgKZj+A/PrXaYzTrYv4HjMBd0ViE+xFJjBlqsed+mYuI4+KvnIFNeFqA35R1Q
         SSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745470; x=1787350270;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FB9JOc3S7IdfuuB4e+4c5jkD9visaD4SgiHPMBifo5o=;
        b=fEHdlAcqFRWBdv1k529jP8Hl4ASbjxKVM9Is0B/e4lcYhuJ3EDq5uM5Nc2OiRxFquA
         yNI+Vtu/INGcVV+QSB98ipjEBL4VsYDIv/BNjBYJXp7puPSPHrJwOM1osUsIJvJJcnt0
         vix5hFEr15AJTzHYz97N2jXoaLSG6gRTX/N70LZ0S7hbCLQwcn9nnW/PTBoqQmiQPoF5
         p/qCSrZNqmBWDI4TLhSzOxgRM9+c42w0u8/pUyC14YxI/jfQLYacabI9FZNCX45aLK1W
         GhZfOOzviu2bTLAu68adeRculHJUarvIKt3nrWH4jY29H2EeOGx2fKK3n+f5gqnglpPB
         DvzA==
X-Gm-Message-State: AOJu0YxmS3GBl+zNxFOGYdq4D6yAnoeasDO1SwnOf2nuE0f1PllRCY64
	WTDn4boVNVPi/GnqdFtaVWDGNYrCcJ4V2NxGjLxS59BRSb94X7YP4p6cWsIDjg==
X-Gm-Gg: AR+sD10dLaMA8ALDEdyRC7cyVqxbUspAvu/RI9S6WtMXHQDlLpnYss7Phfbj4Jl7xIR
	782XY3UbPPZrUfib7m48uA5RWcSluPGQli6SQyTgX+ue611UlaD6dQEibtNvs5cF9lz2ozKH47F
	BrYqR6oNwOnZIOTI1C2+OAH5GV4nwaTspIw5WO2AD8w7e3k+aTIFkIGOlKyw+go4OB0TPeqll0U
	5/TWyLzRF3mOcQrktFaX2OSCoE0Iwd3oyjfEScDfNDTllvIm4bfUCTe+kvJlqcaU0cXySwL5E35
	zvQyjBc7u/vD7H+wYbc0xJtxav+3JXL37vNtOqVbQzA7GWKHFwx+Ku7puhfeHryGrdHKqckkiu9
	lxI9+fPJyfaMJRKVuFGhtlGOYdEISLPo2DQ7ZytliLU+PlPJdsI7r2szCkYvEBdMechxiFymFBF
	7u188FD1VNadZt6HPeo6rbMnSAClzdHazckZC8eowVEr96FT0mesKK7zPaYXmNNJMpCNVk1LVK7
	SLQJKs0dphi3yG/LDLFOFxrM2qJCQAVk4GnR3vqzcUbmc92CnBLErY=
X-Received: by 2002:ad4:4ee3:0:b0:8ef:cfdb:29ad with SMTP id 6a1803df08f44-90a91cd3e0bmr109224536d6.2.1786745470226;
        Fri, 14 Aug 2026 15:11:10 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:09 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 15/23] mcp-server: Add overflow bucket support and cyclictest compatibility
Date: Fri, 14 Aug 2026 18:10:14 -0400
Message-ID: <20260814221027.213574-16-jkacur@redhat.com>
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

Add support for the new overflow bucket feature in rteval XML output.
Overflow buckets track latency samples that exceeded the configured
histogram range (--buckets parameter).

Changes to extract_histogram_data():
- Handle overflow buckets to prevent ValueError when parsing
  index="overflow" attributes
- Add cyclictest support (was timerlat-only)
- Track overflow_count and overflow_bucket in extracted data
- Display overflow warnings when samples exceeded histogram range
- Support both system-wide and per-CPU overflow tracking

This fixes crashes when parsing rteval results with overflow samples
and provides visibility into histogram sizing issues.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/server.py | 55 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/mcp-server/server.py b/mcp-server/server.py
index 6e4599e36eb1..a007c6a7f2f3 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -193,51 +193,74 @@ def extract_histogram_data(file_path: str) -> dict[str, Any]:
         "per_cpu_histograms": []
     }
 
-    # Extract system-wide histogram
-    timerlat = root.find(".//timerlat")
-    if timerlat is not None:
+    # Extract system-wide histogram - try timerlat first, then cyclictest
+    measurement = root.find(".//timerlat")
+    if measurement is None:
+        measurement = root.find(".//cyclictest")
+
+    if measurement is not None:
         # System-wide histogram is under <system> tag
-        system_elem = timerlat.find("system")
+        system_elem = measurement.find("system")
         system_histogram = None
         if system_elem is not None:
             system_histogram = system_elem.find("histogram")
 
         if system_histogram is not None:
             nbuckets = int(system_histogram.get("nbuckets", "0"))
+            overflow_count = int(system_histogram.get("overflow_count", "0"))
             buckets = []
+            overflow_bucket = None
 
             for bucket in system_histogram.findall("bucket"):
-                index = int(bucket.get("index"))
+                index_str = bucket.get("index")
                 count = int(bucket.get("value"))
-                buckets.append({"latency_us": index, "count": count})
+
+                # Handle overflow bucket specially
+                if index_str == "overflow":
+                    overflow_bucket = {"type": "overflow", "count": count}
+                else:
+                    index = int(index_str)
+                    buckets.append({"latency_us": index, "count": count})
 
             result["system_histogram"] = {
                 "nbuckets": nbuckets,
                 "buckets": buckets,
-                "total_samples": sum(b["count"] for b in buckets)
+                "total_samples": sum(b["count"] for b in buckets),
+                "overflow_count": overflow_count,
+                "overflow_bucket": overflow_bucket
             }
 
         # Extract per-CPU histograms
-        for core in timerlat.findall("core"):
+        for core in measurement.findall("core"):
             core_id = core.get("id")
             priority = core.get("priority")
             histogram = core.find("histogram")
 
             if histogram is not None:
                 nbuckets = int(histogram.get("nbuckets", "0"))
+                overflow_count = int(histogram.get("overflow_count", "0"))
                 buckets = []
+                overflow_bucket = None
 
                 for bucket in histogram.findall("bucket"):
-                    index = int(bucket.get("index"))
+                    index_str = bucket.get("index")
                     count = int(bucket.get("value"))
-                    buckets.append({"latency_us": index, "count": count})
+
+                    # Handle overflow bucket specially
+                    if index_str == "overflow":
+                        overflow_bucket = {"type": "overflow", "count": count}
+                    else:
+                        index = int(index_str)
+                        buckets.append({"latency_us": index, "count": count})
 
                 result["per_cpu_histograms"].append({
                     "cpu_id": core_id,
                     "priority": priority,
                     "nbuckets": nbuckets,
                     "buckets": buckets,
-                    "total_samples": sum(b["count"] for b in buckets)
+                    "total_samples": sum(b["count"] for b in buckets),
+                    "overflow_count": overflow_count,
+                    "overflow_bucket": overflow_bucket
                 })
 
     return result
@@ -1603,7 +1626,11 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
             result += "System-Wide Histogram:\n"
             result += f"  Total Buckets: {sys_hist['nbuckets']}\n"
             result += f"  Total Samples: {sys_hist['total_samples']:,}\n"
-            result += f"  Latency Range: {sys_hist['buckets'][0]['latency_us']} - {sys_hist['buckets'][-1]['latency_us']} µs\n\n"
+            result += f"  Latency Range: {sys_hist['buckets'][0]['latency_us']} - {sys_hist['buckets'][-1]['latency_us']} µs\n"
+            if sys_hist['overflow_count'] > 0:
+                overflow_pct = (sys_hist['overflow_count'] / (sys_hist['total_samples'] + sys_hist['overflow_count'])) * 100
+                result += f"  ⚠️  Overflow Samples: {sys_hist['overflow_count']:,} ({overflow_pct:.3f}%) - exceeded histogram range\n"
+            result += "\n"
 
             # Show top 10 buckets by count
             top_buckets = sorted(sys_hist['buckets'], key=lambda b: b['count'], reverse=True)[:10]
@@ -1620,7 +1647,9 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                     cpu_id = cpu_hist["cpu_id"]
                     total = cpu_hist["total_samples"]
                     max_lat = cpu_hist["buckets"][-1]["latency_us"] if cpu_hist["buckets"] else 0
-                    result += f"  CPU {cpu_id}: {total:>12,} samples, max latency {max_lat} µs\n"
+                    overflow = cpu_hist["overflow_count"]
+                    overflow_str = f", overflow: {overflow}" if overflow > 0 else ""
+                    result += f"  CPU {cpu_id}: {total:>12,} samples, max latency {max_lat} µs{overflow_str}\n"
 
             return [TextContent(type="text", text=result)]
 
-- 
2.55.0

