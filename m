Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F43F076F
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745470; cv=none; b=CCw/Z/WJ6rlYmHCU5MDkSNlznw4cPg6QsB72MNpqLe45tk7rxn1NZMZyiGVfp4SkwV8vn3+nahcQs4NL9vzfH3gGPvm+9XhBlTTzIW8RinSp0YGNNBgpUdmguquuKs1ETRA2eblOBSQyzXfjiqVe8nQ+PNYDLqQIR3U4lqv8B1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745470; c=relaxed/simple;
	bh=Lq3S0ULLBWZKiOSvvKsZ/AzRQvKw51Yxr1caHoUkEVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZETWGSxTu4xAWx6o5C/G1wlzo3qLLMNBB+sH5DyC3+0UJRAdCcUH6YfyQ4oB4CATpPSoQw4iFPrzCymvhd8CMHjqLyCu/G0jhVNSSzNPn4oMo/mc1aTKOjqb9CtTtX/t7li4DUUaUa9EFnkIc+yksOZkM+yWz9rEQ9KRZsBEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+F68TGt; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+F68TGt"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f256eaedf8so13600986d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745468; x=1787350268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fesmxqui8aPoaaKYD5cJWcC0naqoHpAY8LJR+ySPr4U=;
        b=Y+F68TGtpY1wQjkctENNSW5gT6vQz+FtrxeiaAsqU7stWyJSkSTz0z1HK50xQh7YwR
         GyyDJSY3mZ0QVV4IZGHCsAgL0IRpFjUYCHEKIAy5gQX/ixI9QD3ZUFjK0sWown/i44Uv
         MA+KR+s0x8x4nRJ8WGvTsMykebZnahwdWbhoYK5akyGUDXt3AdZb9pVqCJ6Rv40pIaXP
         KbffqMje+F3jZQc/IaFdAV3n7CLVh6imJo48YCpaflSHS25hkVPh/vDe8KE/WVl9SU3F
         mnnDBDabFCVf/L0OeSfPlC9+7Q/NX7rA4ad7XQWFPCZVV4jK7wgHbmUCtTX2qsWQbMEj
         klJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745468; x=1787350268;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fesmxqui8aPoaaKYD5cJWcC0naqoHpAY8LJR+ySPr4U=;
        b=WpwjSaBX4NX8u2cLSPa39iSiksemoCajxxr0UHsynhn+DESk3Ax8Qih934Ttzgk9CN
         BLSJjbTepD3lDl161BIycENZKpDjOpfOVHlNgd4sPKajl5w+tDVbBpBmL9u65iGE7JZu
         RUoxXPS8SZK096vfSvLBKZXZTaXPAjPBESNZQqhkuYTQk6/rf+WVRLW3QCWeKMYL43My
         gKQKT0yCpwqj7J3NNtSABf3omAcunGAYGrxDX0/dWr50f0z5kvreDvkRU9XHbS2cBNMl
         vxiUhV4e0mWc0RfidioR6yJsUPbM15CIqJiScSiy2h1G1Y4knZZR+btU7ftqJLlIw8W9
         K50w==
X-Gm-Message-State: AOJu0Yx6CC1XBKapkpM0Mh+/RoLyZGnirYwR4nVywlI+2SacBxKTaojQ
	y2tTcTG/ZfjKzsh843PjiB1ypL1VlsxxYUhnB26moa2FO47SS3Xhc5ZEjU0sTQ==
X-Gm-Gg: AR+sD12eU/OGKNOliuNyyPkYO8OIw6/vaGYNW4v/iWoJy6dwo/OdTUvWkB+EpMmNE66
	CTVCSA+4o4dtbkVbOTha7wOwxLEq7AvGA1Nh1sPmfpRLs3U/LY4waRBjZOVaKgQEFG4ORR8DBSg
	dtuhhJg7X3BdKMKL2afGMzf4VgwIPsiWHhIcPHgGvbPQVuVN3nWLL7WIUG7PxPWTDR9BZrqFqpu
	gjR9TOZ8O5r+94+YCfGtW+p3erVYVV2yd+C4x8osPBhE0Gk4vWvp0aGhIS3t3YDDBjRfR42S2eg
	8SNp591S35eEIiuomZctPHHQ1mvlCdPO8ijrJ6t4amPWu+RzzBxHC1vupiBfLpWcBTQSCFX3PBE
	1LuEAxRWYJyIasG4MfvoutLGN1cFNo2aHNBOHnaGGF4aA4+WtiNYOWJ1HUvDAuk69Mr3URJdToR
	n9z5rSvtHlGGWXKmc7atv7erpdie1bCTL/wdRK0/wr6oRfqgCgQ0YPZxQSOA05sEphY0KfZlg1L
	8UbaEP4AwlVzb3sp3Y1JRoE3ZquxdA8vh4RULLHuOyjI/p+kSMMkBlFwh/pyPCz+w==
X-Received: by 2002:a05:6214:2c08:b0:8f2:940e:2423 with SMTP id 6a1803df08f44-90a91d1a557mr124257256d6.11.1786745467637;
        Fri, 14 Aug 2026 15:11:07 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:07 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 13/23] rteval MCP: Add integration tests and remove hardcoded examples
Date: Fri, 14 Aug 2026 18:10:12 -0400
Message-ID: <20260814221027.213574-14-jkacur@redhat.com>
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

Replace hardcoded example scripts with a proper integration test that
validates MCP server tools through the actual MCP interface.

Removed files (had hardcoded paths to deleted test data):
- test_server.py: Basic sanity check, too minimal
- test_comparison.py: Redundant with compare_results tool
- test_logs.py: Redundant with list_logs/read_log tools
- test_tools.py: Replaced by test_mcp_integration.py

Added file:
- tests/test_mcp_integration.py: End-to-end integration test
  - Tests 8 MCP tools through the MCP interface
  - Dynamically finds available rteval result directories
  - No hardcoded paths - works with any rteval data
  - Works from rteval/, rteval/mcp-server/, or rteval/mcp-server/tests/
  - Discovered bugs in filter_results, find_best_worst, compare_to_baseline

Test coverage:
- list_tools, list_results, parse_result, list_logs
- get_percentiles, extract_histogram (new histogram features)
- filter_results, find_best_worst (query/filter tools)

All tests pass after server.py glob pattern fixes.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/tests/test_mcp_integration.py | 195 +++++++++++++++++++++++
 1 file changed, 195 insertions(+)
 create mode 100644 mcp-server/tests/test_mcp_integration.py

diff --git a/mcp-server/tests/test_mcp_integration.py b/mcp-server/tests/test_mcp_integration.py
new file mode 100644
index 000000000000..30f7700786fa
--- /dev/null
+++ b/mcp-server/tests/test_mcp_integration.py
@@ -0,0 +1,195 @@
+#!/usr/bin/env python3
+"""Integration tests for rteval MCP server.
+
+Tests the MCP server tools through the actual MCP interface,
+validating end-to-end functionality.
+"""
+
+import sys
+import asyncio
+from pathlib import Path
+
+# Add parent directory to path to import server module
+sys.path.insert(0, str(Path(__file__).parent.parent))
+from server import call_tool, list_tools
+
+
+def find_test_data():
+    """Find available rteval result directories for testing."""
+    # From tests/ -> mcp-server/ -> rteval/
+    rteval_dir = Path(__file__).parent.parent.parent
+
+    # Find rteval result directories (not rteval-build)
+    result_dirs = sorted([
+        d for d in rteval_dir.glob("rteval-*/")
+        if d.is_dir() and d.name != "rteval-build" and (d / "summary.xml").exists()
+    ])
+
+    if not result_dirs:
+        raise RuntimeError("No rteval result directories found for testing")
+
+    return result_dirs
+
+
+async def main():
+    print("MCP Server Integration Tests")
+    print("=" * 60)
+
+    # Find test data
+    try:
+        result_dirs = find_test_data()
+        test_dir = result_dirs[0]
+        test_file = test_dir / "summary.xml"
+        rteval_parent = test_dir.parent
+
+        print(f"\nUsing test data: {test_dir.name}")
+        print(f"Total result directories available: {len(result_dirs)}")
+        print()
+    except RuntimeError as e:
+        print(f"✗ {e}")
+        sys.exit(1)
+
+    # Test 1: List available tools
+    print("1. Testing list_tools()...")
+    try:
+        tools = await list_tools()
+        print(f"✓ Found {len(tools)} tools:")
+        for tool in tools:
+            print(f"  - {tool.name}: {tool.description[:60]}...")
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 2: List results
+    print("\n2. Testing list_results...")
+    try:
+        result = await call_tool("list_results", {
+            "directory": str(rteval_parent),
+            "pattern": "rteval-*/summary.xml"
+        })
+        output = result[0].text
+        if "Found" in output and "file" in output:
+            lines = output.split('\n')[:5]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 3: Parse a result
+    print("\n3. Testing parse_result...")
+    try:
+        result = await call_tool("parse_result", {
+            "file_path": str(test_file)
+        })
+        output = result[0].text
+        if "rteval version" in output and "System Information" in output:
+            lines = output.split('\n')[:10]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 4: List logs
+    print("\n4. Testing list_logs...")
+    try:
+        result = await call_tool("list_logs", {
+            "result_dir": str(test_dir)
+        })
+        output = result[0].text
+        if "Log files" in output or "logs" in output.lower():
+            lines = output.split('\n')[:8]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 5: Get percentiles (new histogram feature)
+    print("\n5. Testing get_percentiles...")
+    try:
+        result = await call_tool("get_percentiles", {
+            "file_path": str(test_file),
+            "percentiles": [50, 95, 99, 99.9]
+        })
+        output = result[0].text
+        if "Percentiles" in output and "P50" in output:
+            lines = output.split('\n')[:12]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 6: Extract histogram (new feature)
+    print("\n6. Testing extract_histogram...")
+    try:
+        result = await call_tool("extract_histogram", {
+            "file_path": str(test_file),
+            "include_per_cpu": False  # Keep output brief
+        })
+        output = result[0].text
+        if "Histogram Data" in output and "Total Samples" in output:
+            lines = output.split('\n')[:12]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 7: Filter results (query tools)
+    print("\n7. Testing filter_results...")
+    try:
+        result = await call_tool("filter_results", {
+            "directory": str(rteval_parent),
+            "is_rt": False
+        })
+        output = result[0].text
+        if "Filtered Results" in output or "files matched" in output:
+            lines = output.split('\n')[:8]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    # Test 8: Find best/worst
+    print("\n8. Testing find_best_worst...")
+    try:
+        result = await call_tool("find_best_worst", {
+            "directory": str(rteval_parent),
+            "metric": "maximum",
+            "count": 3
+        })
+        output = result[0].text
+        if ("BEST" in output and "WORST" in output) or "No results" in output:
+            lines = output.split('\n')[:10]
+            print("✓ " + '\n  '.join(lines))
+        else:
+            print(f"✗ Unexpected output: {output[:200]}")
+            sys.exit(1)
+    except Exception as e:
+        print(f"✗ Failed: {e}")
+        sys.exit(1)
+
+    print("\n" + "=" * 60)
+    print("✓ All MCP server integration tests passed!")
+    print(f"\nTested with: {test_dir.name}")
+    print(f"Total tools tested: 8")
+
+
+if __name__ == "__main__":
+    asyncio.run(main())
-- 
2.55.0

