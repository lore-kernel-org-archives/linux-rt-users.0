Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF83F12C2
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745474; cv=none; b=mF2/F8D1Ng5j5BxryCjTtIs8qbpomxzZIc22lYQhCWW7SOOUkWJO/ppRBRYcGN05Vyf2vocuC1zaLpNUVrqxjgOv5eP42gV0bGOEB/39Ypve4/dFyg2+84fy3TXAILwaUz3OtMWSOYhqllUeiwCb7EDpeSOkxKDq1eMm33q7fBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745474; c=relaxed/simple;
	bh=uTDpxmaur0/pBATmKHja6YEnCRMPYpERs4LiDc6Pd5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLYOGYnaJey/StpOfosn9Tbb5FoqqTmG2RvCtfnPh81jwNhcqh5rFj/7tx2huis/ZenYZKpVe4sUn+Ef8DAEMHw22X9Z9qrWrmxoctfLZ18gjz1Kv5ccigw+7ws2iV7kbnqTkQ9mCFQkul4V6EZIhQkr3smFI8fjbPBWlrAHq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qBM9Et++; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBM9Et++"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e7632b193so100509185a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745471; x=1787350271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aYBCMo/IKK5BpYHN8DmBVKTlnuAhXkoaL1VpeSNyjsM=;
        b=qBM9Et++T+4Kqk6UiJV3RuoaFERXEzPXSdcoq3x3VPmXrPyAUEmF/RXI6FSQh4t/u4
         oV1CrpU0J+cYAMWh4w0gZUmDBYRAOXotsf8er5BmxgSwapha/qhpaHtQfCJwLpLCoaqA
         eBtMize4oy4FkXi5tyQQmDpiyLz4RwbomThs+fRLPtx29h9rbStNLlGtI32OIq/BaNmw
         2ylTkmo0DDHjSuQZ8BQVh3lHX4wmBsqR2v6EY/MaKDsRulKZKX8N8P+eBE6Rk92+vk5O
         pDcLTJ11yKPDVWlxDQLEHtiDqMmqvlrZKfJi+BLLxIO6XTFAKtDYsbMCCqwXXkHagdXY
         ESMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745471; x=1787350271;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYBCMo/IKK5BpYHN8DmBVKTlnuAhXkoaL1VpeSNyjsM=;
        b=bNCigxsexIDFTHxUSuseME74MneXsP98TgmGzTiR+zkPg8GqI4m+sSLxf4kTLH9pHy
         DaGxqv1vN2XKKK7f4T/lGpqqdYcRnx+itjHPmp7GFklkJzX3LZeH6I4jyYUUl1bUE84l
         BJEZxx4oiQq9XFR8h7XLG+M8ueJnlrMClFE1ZsPrAt6O3E/E5iXB5bD4TLbcL6JZRE0g
         CqSOxXqwhK6d8KFEgn6itGArWX+YbQ+MKVGr67nivhX3gg6v9LqhS5smaF7sBvwppkuH
         eJVkLDP3n7PpST/vCPcrDsX+utTHMEKgcoyIIuHz5bzB/WYB96Cl9FS36/SmbkdtTB/W
         ssOg==
X-Gm-Message-State: AOJu0Yyk56INI3UVY5YAcDNKCtlu/zdtzVCLpobckPpPRxvgaO99BQ+s
	CV0Pu3wEUn6pSKnchU7Td1RCP+OqnQCtvBEM2NPMundPsv52J0dOKH6dABhzyg==
X-Gm-Gg: AR+sD10BVzp3jvI4pBqd6Gz5W9DEBEqNCtg1bo3y0lQvmS1vghDmTUFrEBiugMdYwPm
	KrYL4au1YeUTcJiHaj5mY+xDY0r9Y2MxILe0tVLrFLx8Dnkz4SDazbnR8i7wXPQogdXUqzpqICO
	ef+TdNZhvb9Ee2X0+d+xJZHLiOo6efxmrFFfYLAwwu/Ccq0d2zB6PGGETEjR+JiFL2i7zqjU2vW
	3M0yGEeniPeT/3/BLPYNvjypaJAj+hywdtGPC8l3+Df3X+NNFOsFqLLvPmvVPznECDvUr3vvb6V
	PNepRCndLIjei9Q49IrPtu9/t5aRkQofHSIrglSGCqJpTiq2UilXMwkrU9gQqz4TzWk6/7gxnr6
	ygKKKjqoHm0Rs+s2cYIx/X6+m+uit3eNvg/l/7kBcZD7+SQxsIvWPS6UK9Q+ubgfjk+fjXbFw22
	Hkz63D2h+t5ka+3jtGiJEchA/GDimhstZnlRfie1YXJBkCghjSq3v3hRBdpXDzqfD081LjxEs/M
	vFMrxGcJJ5f9auId2/tI9FTPppEFzW91YGNFHEvsQdVtbsZhu4DIBs=
X-Received: by 2002:ac8:5952:0:b0:52d:771a:231f with SMTP id d75a77b69052e-52d8542108fmr99767081cf.12.1786745471343;
        Fri, 14 Aug 2026 15:11:11 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:10 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 16/23] mcp-server: Make tests generic and add Makefile integration
Date: Fri, 14 Aug 2026 18:10:15 -0400
Message-ID: <20260814221027.213574-17-jkacur@redhat.com>
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

Make MCP server tests more robust by using dynamic test data discovery
instead of hardcoded file paths. This allows tests to run with any
available rteval result files.

Test improvements:
- Use glob patterns to find any rteval-*/summary.xml files
- Automatically select the most recent test data
- Add clear error messages when no test data is available
- Exit cleanly with instructions to generate test data

Makefile integration:
- Add mcp-tests target to run all MCP server tests
- Update help output to document new test target
- Add to .PHONY declarations

Tests now work with any available rteval data and provide helpful
feedback when data is missing.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                               | 10 +++++++++-
 mcp-server/tests/test_histogram.py     | 13 ++++++++++++-
 mcp-server/tests/test_per_cpu_stats.py | 13 ++++++++-----
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 57b37334136a..869d42d7eb11 100644
--- a/Makefile
+++ b/Makefile
@@ -60,6 +60,13 @@ unit-tests:
 	@echo "Running unit tests..."
 	./tests/run_tests.sh
 
+mcp-tests:
+	@echo "Running MCP server tests..."
+	@echo "These tests require rteval result files to be present"
+	@echo ""
+	$(PYTHON) mcp-server/tests/test_histogram.py
+	$(PYTHON) mcp-server/tests/test_per_cpu_stats.py
+
 tests: unit-tests
 
 test-all:
@@ -135,6 +142,7 @@ help:
 	@echo "        runit:            do a short testrun locally [default]"
 	@echo "        tests:            run unit tests (alias for unit-tests)"
 	@echo "        unit-tests:       run unit tests"
+	@echo "        mcp-tests:        run MCP server tests (requires rteval result files)"
 	@echo "        test-all:         run ALL tests including root-required tests (requires root)"
 	@echo "        e2e-tests:        run end-to-end tests"
 	@echo "        regression-tests: run regression tests for measurement modules (requires root)"
@@ -157,4 +165,4 @@ tags:
 cleantags:
 	rm -f tags
 
-.PHONY: tests unit-tests test-all e2e-tests regression-tests cpuset-tests uninstall
+.PHONY: tests unit-tests mcp-tests test-all e2e-tests regression-tests cpuset-tests uninstall
diff --git a/mcp-server/tests/test_histogram.py b/mcp-server/tests/test_histogram.py
index e60119ffc36d..a7e47c3cd2d0 100644
--- a/mcp-server/tests/test_histogram.py
+++ b/mcp-server/tests/test_histogram.py
@@ -13,7 +13,18 @@ from server import extract_histogram_data, calculate_percentiles
 # Find test file relative to script location
 # From tests/ -> mcp-server/ -> rteval/
 script_dir = Path(__file__).parent
-test_file = script_dir.parent.parent / "rteval-20260714-1" / "summary.xml"
+rteval_dir = script_dir.parent.parent
+
+# Find any rteval result directory with summary.xml
+test_files = list(rteval_dir.glob("rteval-*/summary.xml"))
+if not test_files:
+    print("ERROR: No rteval result files found in", rteval_dir)
+    print("Please run rteval to generate test data first.")
+    sys.exit(1)
+
+# Use the most recent file
+test_file = sorted(test_files)[-1]
+print(f"Using test file: {test_file.parent.name}/summary.xml\n")
 
 print("Testing histogram extraction...")
 print("=" * 60)
diff --git a/mcp-server/tests/test_per_cpu_stats.py b/mcp-server/tests/test_per_cpu_stats.py
index d7544a18ce41..673cc89f0b08 100644
--- a/mcp-server/tests/test_per_cpu_stats.py
+++ b/mcp-server/tests/test_per_cpu_stats.py
@@ -14,15 +14,18 @@ async def main():
     print("Testing get_per_cpu_stats tool")
     print("=" * 60)
 
-    # Find test data
+    # Find test data - use any available rteval result
     rteval_dir = Path(__file__).parent.parent.parent
-    test_file = rteval_dir / "rteval-20260714-1" / "summary.xml"
+    test_files = list(rteval_dir.glob("rteval-*/summary.xml"))
 
-    if not test_file.exists():
-        print(f"✗ Test file not found: {test_file}")
+    if not test_files:
+        print(f"✗ No rteval result files found in {rteval_dir}")
+        print("Please run rteval to generate test data first.")
         sys.exit(1)
 
-    print(f"\nUsing test file: {test_file.name}\n")
+    # Use the most recent file
+    test_file = sorted(test_files)[-1]
+    print(f"\nUsing test file: {test_file.parent.name}/summary.xml\n")
 
     # Test 1: Basic per-CPU stats (sorted by maximum)
     print("1. Basic per-CPU stats sorted by maximum latency...")
-- 
2.55.0

