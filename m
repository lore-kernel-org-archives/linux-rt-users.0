Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E523EB0E6
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745468; cv=none; b=Xw0LtVbLJw/VpcaVT+0fSVmbo+X8tKlVXYANjXGOpNXqFM/UA3TA9o70O51a25G4RzAJPUxjjpukyBcnGkSzPDaS9NyF0XF2/W522jHicNPy1YclTAYheTAl8z+++0WQ4jSbeduNu1SQ/yXucOcikHzd5uEsaHqtepWrZp5Jthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745468; c=relaxed/simple;
	bh=GLPlUVFbmeYOIhQoisc8oMDcPvesnxHBD56hWRETBhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r06yY6uLRgppN634Tgk04zJUGVk0Qn5EniKuL1MuATh7k4BltbLtPXP6+XyRr0zeDEjnYwRnOHcMZSPbWF0tQGZ1ib2INaPcrrvvVC4ULVix1aKHoIhGieAc0Dihgk0AFptiBInE9bBPIZkt17YAF6TsYazJ6n2ZatxmVA5+cPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1qV6W+f; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1qV6W+f"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8efef6533aaso8520526d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745466; x=1787350266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qb9PkHTbyywTxJYGu44l4A8+F28Ums1SQkwDyl3xPAE=;
        b=L1qV6W+f7BBgCLxsY/rpJjGpRwmLpZsvqP51ojeC+9Vko7tg8rXIHlXIKfoTAEsLVg
         I5TRa/M8yDNC3zRtY4/jcNj/F5vJVwQSRI5tnJG8Ti9ABzlqauT1ZvGsmY2pflXfrjfT
         Abjg9PquYf63CkFqvP5slyCb/1deaXMz9/yOeV2vfSfRmV1/8BC1Ty0az1/EEPAnvEUl
         ZAddJ/zrnIA+DRs16sNEUSS/plaErNQmCAuOvLDtZ8QWh5ZEwQVbJ4JchFOrAfJBZGDO
         +BjFYWgex9oemgH/nMO9V2Pwco0HtQzsm3o89NZC7kE9sFBrvFM3ZA/eyDlnOCXE6S7M
         5PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745466; x=1787350266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qb9PkHTbyywTxJYGu44l4A8+F28Ums1SQkwDyl3xPAE=;
        b=rM15Ln6NrtI41HBdGx9/hy2SMaKs3jxnUzM5JpFJeYHaTxnYt86gKd9hcmr7UHz28i
         TfVQSxzksyqzrJo7pvurVP2iGOELyAKa4W6ETIc74d7Pq7ikSz9dGRB+M+DyTjHjnIQU
         ispml5hFbmdkEIaSWJ6jD7hgQWGTPOVe8frVHr+A/NzcjQPSbl6bCKezFio+mW83qAMu
         iVYaNl6z2fm+mJnHp+jfL4x6ToK4lfzlTkChrK7VjXsBTLhBWzuVXVZ/wjI66fIcDCWm
         zKutYyoxkyvA4CE5tutGTOYF5PpU4ONSp89fzzTXHGpqvDxVmTtwfSPXQJLRBGaBcCtX
         i1jg==
X-Gm-Message-State: AOJu0YxK3S8WCdGOLmnggaNefkbyvsm/Z65EbV8GHbAS16hrfq0D56S1
	tipxtdCyjBUOhSKq+cgwGtChHbX5k0AA6UZDbGerH8PQofeVUnqNxKlqlKEehg==
X-Gm-Gg: AR+sD10id0HRGOdpOuxqK8lJIrdLO3kKZj+Sa1JiYQVP32ILKov5gcocC9B9ka39Lcb
	5jTOu4SGcXMvwqsbzCS6Wspz49kkrSb6oRpNyMHvgIpsn/CYlYKxt72BFQ/Ta5S1YysVcGhXcOI
	qD1FLPkVtOicpYq1DKwxwKsPj2LxcEYvQUBpMo5vTpEUBmo0VJ88giZZL5Uf88Je463B6Vyd2aW
	yt7Zz5zlTBmjBNCN3fQmxOpHd+m+YFQyXL+EkdfyJGb/1N3R95lHDad/GAbVd2vJrw1tU4JZ//W
	xXMRw16SbS9yezlFJDKiy6/VL+2fXc4D4NWiUkSuYYqSICsibzeWL6MCBMaMjE9kWnFXALDGmcs
	eTEtpsarhY5NxA2k5qxXgHpAIK2bPh4ajs37bgLm/fylhRL3VuHPnGCXg+/EcRhmDTzmEU5Tp3Z
	lc0OcEVw/tT83IXd8doWk3VEiWGy7It8mk481j6I/GRu7IVJulsGLCkIlvYsgSOkjdMZD/72ig8
	S1eHlHt+MCDZcd3CngNxDKZpT0YIH9mqzb9ceArbwtSvhR1xRWk6FU=
X-Received: by 2002:a05:6214:62b:b0:8f7:69b0:a4f with SMTP id 6a1803df08f44-90a91c5bb11mr102205966d6.2.1786745465760;
        Fri, 14 Aug 2026 15:11:05 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 12/23] rteval MCP: Fix glob patterns to find rteval result files
Date: Fri, 14 Aug 2026 18:10:11 -0400
Message-ID: <20260814221027.213574-13-jkacur@redhat.com>
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

Three MCP tools were using "*.xml" pattern which doesn't find rteval
result files in their subdirectories. Changed to "rteval-*/summary.xml"
to correctly locate rteval results.

Fixed tools:
- filter_results: Now finds rteval result files for kernel/date filtering
- find_best_worst: Now finds rteval result files for best/worst analysis
- compare_to_baseline: Now finds rteval result files for regression detection

The batch_analysis tool already had a configurable pattern parameter and
was working correctly.

This bug was discovered by the new integration test which validates that
all MCP tools work end-to-end through the MCP interface.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/server.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mcp-server/server.py b/mcp-server/server.py
index 48474df56fab..dc68b3a3ad47 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -1149,12 +1149,12 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                     text=f"Error: Directory '{directory}' does not exist"
                 )]
 
-            # Find all XML files
-            files = list(path.glob("*.xml"))
+            # Find rteval result files
+            files = list(path.glob("rteval-*/summary.xml"))
             if not files:
                 return [TextContent(
                     type="text",
-                    text=f"No XML files found in '{directory}'"
+                    text=f"No rteval result files found in '{directory}'"
                 )]
 
             # Parse and filter
@@ -1262,12 +1262,12 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                     text=f"Error: Directory '{directory}' does not exist"
                 )]
 
-            # Find all XML files
-            files = list(path.glob("*.xml"))
+            # Find rteval result files
+            files = list(path.glob("rteval-*/summary.xml"))
             if not files:
                 return [TextContent(
                     type="text",
-                    text=f"No XML files found in '{directory}'"
+                    text=f"No rteval result files found in '{directory}'"
                 )]
 
             # Parse and collect metrics
@@ -1380,11 +1380,11 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                     text=f"Error: Directory '{directory}' does not exist"
                 )]
 
-            files = list(path.glob("*.xml"))
+            files = list(path.glob("rteval-*/summary.xml"))
             if not files:
                 return [TextContent(
                     type="text",
-                    text=f"No XML files found in '{directory}'"
+                    text=f"No rteval result files found in '{directory}'"
                 )]
 
             # Build comparison report
-- 
2.55.0

