Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495793F076F
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745466; cv=none; b=NmTw+ducnX5fPRu4eJWzh9nurDExMj1So/k3dcb+ELVHHvH7gsDWCJQm+SDA+hlGlBmKznAE16nkNL/fQN2cNXTcGM2Ks4QnbWh4PMqt1ucKJ8U16ELW4ZoFSG3yR6RUfLcVzXpMoGITygaTVVwhC+UW1I0Fgyd8fKAlzwV4Bzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745466; c=relaxed/simple;
	bh=hlCmrb2ovBVLPTvZMO6S6+4PUNEgFEB5tDVdYBphlfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0o6sHIBYvAUbBt/8UPFmIDNLyfhdJBHp+y7TzGm8ah1Ag1PKJuuN9atp6paPv4MjYWGxPLE/nNbBiRlQysLMZmCDoSTHRAh73Dmbcgx2yJfg4yqnpCTUnmgWNqY8zfcJLBQLnwzPTYL6R40xUqPVxPSORKnHS18CTRbow6TYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mg8Z3MbB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg8Z3MbB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2cce930cso15055021cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745464; x=1787350264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=th51qClmzIQxSn+RZIB0lYt1VEC0QcDI8FFhXhkt40g=;
        b=mg8Z3MbBUEsd2bVywlGTI4HxqD/SENYxZBSzrNSCGHdMBrHvxv4URQ3V6nYj0zOTAb
         aRQvESZ74lqotDFJu2rtje74ObFLwzL5ozynnEbbwFo3oL0b/M0OviHCy7FUHETwvzu8
         fU1Nxg5EPqE8xEMZf+ZEUR6fXWrk3rH3y5Fz+1X0kMvNmyEfTpzrNXY+PwPIe5OlBJk2
         UxZ+GI9fvBFtTRIjJYo6MKv3vHsDllc0j7ccbpZjiuWBGN2UUvHiUFdvMXF5aliUA5VO
         ccMfIVmHcbrlShWe7KQK8BRnu+p9zrkkN9LyUlfxyUXv6GWr6euzDqBaGRriMgP3WkIt
         ccEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745464; x=1787350264;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=th51qClmzIQxSn+RZIB0lYt1VEC0QcDI8FFhXhkt40g=;
        b=tSFxD89L70GMsdw0uJWHsJGoccoh6yD0tR2Dxc8YcNyNMkXrR5AO2Pv2Ol9++Fewoy
         9+YmkRCOKr13cVmzps3nP3pdIuPJywb9x5r1Sg7oWmJwrT4VZode4JVSf5p6OVyX7Ivp
         PrnkV8/x8v7R/PW97BHhFq4X+T9jw2LcV1IrZ+1KemAIkFWYlgzyMdVykJptMvN6B3YR
         aPiYcx6gtx0WCGVJkM6u5W79F6JPyKg6qB3aY3EHqhLaM7exs4eE6YugMFZe+i/D7bT9
         sXoSdSHfr5vDp3ngBdyOUfpxkDC+hwYAqY41gblQNCb/nL11rPpje+/xq/9d3dJR3RxY
         oGZQ==
X-Gm-Message-State: AOJu0Yy64EW+64aiaN9jnr7KKwCMNkEfsENm4nbVNLT6AymT6U1S6Q5x
	pBUDxib+i/8BxdKurmR7feOiNj2dZKoW0nqDHKoNr9SFn7DifVW7LU/xDOKPSg==
X-Gm-Gg: AR+sD11pa5A584KOt42e01YpwOinMXBVYbnHd0VKY+xqoBmSrJ60dwbng/tFnGHgP4Y
	5tY/QuItjw0zApAK3T2AzfWVYm2hz9/tt/JANWMycmRCD3n6R049pDbxNGFuhoClgysKVfH6lIF
	nHYPuC0Q8L0CtuNWEdqMks9lnvui4PvycEvbFLvWzkAjuP1lMKXnJe1cKMkKufiJjGaFlj5wKV9
	U0PQQOW6HPzxjDIb0R1OYu9V0hlwAFCCvzFnSOPzJXQxmEMn7pLC0ri4Yq6gc/0Nze11jFM0uxa
	QeL3wU75iKRiFC/Y3PPOHZiCCp9biqPFIrDDCntm7mFdvCzdbGECaKNbsUSnqs3h83egs1aArD6
	efL7TI/czlFa4XbQO2GsFnfG/IbOnCmMTx6fgeEOAOctDGcn+MOiYVjIE3bScjtQSxPajJcC2t9
	5ABKAz3TSjZXuzUDU+A0o+f/jNIg20F+W9n7M+5sIMnnGUK7d+hsyRn9SCIt80xDAtRlGsmCbjy
	4M5cdAK5yrct47xlvvvTQXkdTngH7yp+y6Y4oWLwnHYevr8ZnG3veA=
X-Received: by 2002:a05:622a:34c:b0:52d:7a63:f608 with SMTP id d75a77b69052e-52d85446139mr98503941cf.20.1786745463949;
        Fri, 14 Aug 2026 15:11:03 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 11/23] rteval MCP: Fix test_new_tools.py to find rteval result files
Date: Fri, 14 Aug 2026 18:10:10 -0400
Message-ID: <20260814221027.213574-12-jkacur@redhat.com>
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

Update glob pattern from "*.xml" to "rteval-*/summary.xml" to correctly
locate rteval result files in their subdirectories.

The original test looked for XML files directly in the top-level directory,
but rteval stores results in subdirectories like rteval-20260714-1/summary.xml.

Changes:
- test_find_best_worst: Use rteval-*/summary.xml pattern
- test_filter_results: Use rteval-*/summary.xml pattern

Testing:
- Successfully finds 13 rteval result files
- Works from both rteval/ and rteval/mcp-server/ directories
- Shows best/worst results correctly (1355µs to 3499µs range)
- Filters by kernel version correctly (12 of 13 match "7.0")

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/tests/test_new_tools.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcp-server/tests/test_new_tools.py b/mcp-server/tests/test_new_tools.py
index d623dba72d74..cc6456960785 100644
--- a/mcp-server/tests/test_new_tools.py
+++ b/mcp-server/tests/test_new_tools.py
@@ -21,7 +21,7 @@ async def test_find_best_worst():
     metric = "maximum"
     count = 3
 
-    files = list(directory.glob("*.xml"))
+    files = list(directory.glob("rteval-*/summary.xml"))
 
     print(f"Found {len(files)} XML files")
 
@@ -84,7 +84,7 @@ async def test_filter_results():
     directory = Path(__file__).parent.parent.parent
     kernel_pattern = "7.0"
 
-    files = list(directory.glob("*.xml"))
+    files = list(directory.glob("rteval-*/summary.xml"))
 
     print(f"Filtering for kernel pattern: {kernel_pattern}")
     print(f"Searching {len(files)} XML files\n")
-- 
2.55.0

