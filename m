Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2BB3EC80B
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745465; cv=none; b=j/UfIpykkCcv13ebpV6LuS7PUEs4X0fkz7MQewDDltzsfQKHFl6J3mGUf6P13T2GT98xtTfUmHchGxiJHcmTSFq4RmYu9ZZlXa0d17m38avBpT4uJoRgZQRv5AptMAnWllucijls0cjm7+fZqd42d4lqS65R2YPP/zawpvVU8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745465; c=relaxed/simple;
	bh=fv7vU0kzy12c14cA8Fa5gj/pU50LoztDABvIcIdy3z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsPJSf5WC7Lxht6z9GzQjnWsy+bjefbCYsxuFDAW5LmYw80oEgbrln/sjFpkAeEuFbwdh/8ZcCQElEYRpVvI8mxAk2lWcX+UIi2llcYkDchl4LnmPg3so5V5s2j615G5fd0YLXNlNf3hnXxdrJa6uuyntS8ymL6t8d2U6xwKpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWJiAC8j; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWJiAC8j"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9061a795d76so14811876d6.3
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745463; x=1787350263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=napqoSDulLUbcm3mMwym2XV+EXXXY07HURPAWvnOdTU=;
        b=QWJiAC8jtfT71MgyI4/S+NODTDIiFnatodDPWO89V93IeP7UNumaMlKKGC0OznvFks
         DDfQRnL/VqLEVtUd7AYZlOL1t42oYHK081XLOEdBtfcym4h3/WCDbKNYKbnGp9CetcRW
         0pRm4U3VxvQhNrfPBz/Gd7V1bOsSFwMGTkLu33V+J+tlegBX24tN5fPd3TmwHSZ2V375
         qlwObOy1PTgU5VS8Rqndu2qyXjcQ7oaUTMXXhg7E2oC3p9FlrbbJco2JAzekTIpwGQQJ
         3yZgvT1BPtwpVNmwW9J86u270g6Ow4Ie+tJ7qiGCpfTSJryXu7BF9EwJUBPdYwgT4lLQ
         n8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745463; x=1787350263;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=napqoSDulLUbcm3mMwym2XV+EXXXY07HURPAWvnOdTU=;
        b=nCw2SBmxccobulHxKMH+aWYw1IS0NMy/qMvCamUiR3PVI3+JR1vSjzR+5hjDoE6exs
         B7S3PhLnLYnnZLdOVLNM8eAg0Ph+TDJtc9sKwC+81I9Mjf1GkdBjvZ/ERK8MJ8IZ6zFd
         o6e8QtB6xddFQ2rpVqBtrX3oJzWwrep0w68S9LJ7K6ZGI3OL+WxK2vtkv1R//z2Oc04m
         3YniA80KFRechZT2VtZ5cwRSij6IcKHWALcaI15Yi7xAmhI0tqbVSecpfvI52xdH7LlA
         Vy8mLvsVhpffeg+FSoOxLjk0FS75zLToIW712esMgALgg88MnSGR7O0FeZXF86E7Z57O
         O4QA==
X-Gm-Message-State: AOJu0YyF7nv26O9mS4IKCRK40oQ0bYPp+BItgJn6O8j3WWaIaHYlmf2l
	SXGvVzAa2v9XhMTXB0diPap2rn0q9JVhP5qf+M6Xt69dd9npLI7ZiTdjffCTjg==
X-Gm-Gg: AR+sD13IDp2ODGojfZtVknWnSfvZ3p9Ro4OS2uG4g+YzyyeVEnBnKbJwTiTyRQ8DClu
	D3KkjGuyaAxPMOIs1ZZvhZ6sCnegoijwN1+/m5NE+lxXuXRSChFmndVnW+GsM47s8DD1mdoEjTv
	jsyQPcwyqsohnbPcbEBFznDK9c2Tv+VGf5eY0zEtILKZF9AkT5x9n2oI/jtZuYBZEGHbpX6zZT8
	HEsw3FIcjbCv0CsBvf1mduFJnCm+uAATgyXmTLWrLbMyPZXYYSO+Q3brWxOCZrtmUVHSHW6zy9Z
	iHZjYQyaCTE5xnsW4Qp80Ugrj0W0w85MQS4Ws/x06bnW34xY8m8ri59gdd4arg9KXJn9Ce91ZJG
	r4M6DxQhy6MT29ZGnYmmz6mEPdERtfA50dW2TUrdUW7H4c7KTmH3891wlMZnX1QWudZqQ97GIIQ
	59nPxVgho9gGC+oQJa6Db8Dp9AM3UL6ORKX29xx0LSi5Tz9fCI+RP/ANSIJxJdN6MsFf//cc0VV
	YjVLBUFB0j2u3QM8kTvHH+AoFkO1mUsqqI+AEMkZLnBfPz+bo35JbQ=
X-Received: by 2002:a05:6214:4b0a:b0:900:6ec7:19d9 with SMTP id 6a1803df08f44-90a91c8ffdfmr125534616d6.3.1786745462704;
        Fri, 14 Aug 2026 15:11:02 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:02 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 10/23] rteval MCP: Reorganize tests into tests/ subdirectory
Date: Fri, 14 Aug 2026 18:10:09 -0400
Message-ID: <20260814221027.213574-11-jkacur@redhat.com>
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

Move test scripts from mcp-server/ to mcp-server/tests/ for better
organization following Python conventions.

Changes:
- Create tests/ directory
- Move test_histogram.py to tests/
- Move test_new_tools.py to tests/
- Update import paths to handle parent directory
- Update file paths to work from any execution location

Tests can now be run from:
- rteval/ : python3 mcp-server/tests/test_histogram.py
- rteval/mcp-server/ : python3 tests/test_histogram.py
- rteval/mcp-server/tests/ : python3 test_histogram.py

Implementation:
- Use sys.path.insert(0, str(Path(__file__).parent.parent)) to find server.py
- Use Path(__file__).parent.parent.parent for data file resolution
- Paths are resolved relative to script location, not cwd

Tested from all three directories successfully.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/{ => tests}/test_histogram.py |  13 ++-
 mcp-server/tests/test_new_tools.py       | 135 +++++++++++++++++++++++
 2 files changed, 145 insertions(+), 3 deletions(-)
 rename mcp-server/{ => tests}/test_histogram.py (82%)
 create mode 100644 mcp-server/tests/test_new_tools.py

diff --git a/mcp-server/test_histogram.py b/mcp-server/tests/test_histogram.py
similarity index 82%
rename from mcp-server/test_histogram.py
rename to mcp-server/tests/test_histogram.py
index e11dfb0413a4..e60119ffc36d 100644
--- a/mcp-server/test_histogram.py
+++ b/mcp-server/tests/test_histogram.py
@@ -3,16 +3,23 @@
 Test script for histogram extraction and percentile calculation.
 """
 
+import sys
+from pathlib import Path
+
+# Add parent directory to path to import server module
+sys.path.insert(0, str(Path(__file__).parent.parent))
 from server import extract_histogram_data, calculate_percentiles
 
-# Test with the sample file
-test_file = "../rteval-20260714-1/summary.xml"
+# Find test file relative to script location
+# From tests/ -> mcp-server/ -> rteval/
+script_dir = Path(__file__).parent
+test_file = script_dir.parent.parent / "rteval-20260714-1" / "summary.xml"
 
 print("Testing histogram extraction...")
 print("=" * 60)
 
 # Extract histogram data
-histogram_data = extract_histogram_data(test_file)
+histogram_data = extract_histogram_data(str(test_file))
 
 # Check system histogram
 if histogram_data["system_histogram"]:
diff --git a/mcp-server/tests/test_new_tools.py b/mcp-server/tests/test_new_tools.py
new file mode 100644
index 000000000000..d623dba72d74
--- /dev/null
+++ b/mcp-server/tests/test_new_tools.py
@@ -0,0 +1,135 @@
+#!/usr/bin/env python3
+"""Test the new query/filter tools."""
+
+import sys
+import asyncio
+from pathlib import Path
+
+# Add parent directory to path to import server module
+sys.path.insert(0, str(Path(__file__).parent.parent))
+from server import extract_rteval_data
+
+
+async def test_find_best_worst():
+    """Test the find_best_worst functionality."""
+    print("Testing find_best_worst logic...")
+    print("=" * 60)
+
+    # Search for XML files relative to script location
+    # From tests/ -> mcp-server/ -> rteval/
+    directory = Path(__file__).parent.parent.parent
+    metric = "maximum"
+    count = 3
+
+    files = list(directory.glob("*.xml"))
+
+    print(f"Found {len(files)} XML files")
+
+    # Parse and collect metrics
+    results_with_metrics = []
+    for file_path in files:
+        try:
+            data = extract_rteval_data(str(file_path))
+
+            # Extract the requested metric
+            metric_value = None
+            for mtype in ["timerlat", "cyclictest"]:
+                if mtype in data["measurements"]:
+                    metric_data = data["measurements"][mtype].get(metric)
+                    if metric_data:
+                        try:
+                            metric_value = float(metric_data["value"])
+                            break
+                        except ValueError:
+                            pass
+
+            if metric_value is not None:
+                results_with_metrics.append((data, metric_value))
+                print(f"  {Path(data['file']).name}: {metric_value:.2f} µs")
+
+        except Exception as e:
+            print(f"  Error parsing {file_path.name}: {e}")
+            continue
+
+    if not results_with_metrics:
+        print(f"No results found with {metric} metric")
+        return
+
+    # Sort by metric value
+    results_with_metrics.sort(key=lambda x: x[1])
+
+    print(f"\nBEST {min(count, len(results_with_metrics))} Results (lowest {metric}):")
+    print("-" * 60)
+    for i, (data, metric_val) in enumerate(results_with_metrics[:count], 1):
+        print(f"{i}. {Path(data['file']).name}")
+        print(f"   {metric.capitalize()}: {metric_val:.2f} µs")
+        if "kernel" in data["system_info"]:
+            print(f"   Kernel: {data['system_info']['kernel']}")
+
+    print(f"\nWORST {min(count, len(results_with_metrics))} Results (highest {metric}):")
+    print("-" * 60)
+    for i, (data, metric_val) in enumerate(reversed(results_with_metrics[-count:]), 1):
+        print(f"{i}. {Path(data['file']).name}")
+        print(f"   {metric.capitalize()}: {metric_val:.2f} µs")
+        if "kernel" in data["system_info"]:
+            print(f"   Kernel: {data['system_info']['kernel']}")
+
+
+async def test_filter_results():
+    """Test the filter_results functionality."""
+    print("\n\nTesting filter_results logic...")
+    print("=" * 60)
+
+    # Search for XML files relative to script location
+    directory = Path(__file__).parent.parent.parent
+    kernel_pattern = "7.0"
+
+    files = list(directory.glob("*.xml"))
+
+    print(f"Filtering for kernel pattern: {kernel_pattern}")
+    print(f"Searching {len(files)} XML files\n")
+
+    # Parse and filter
+    filtered = []
+    for file_path in files:
+        try:
+            data = extract_rteval_data(str(file_path))
+
+            # Apply kernel filter
+            if kernel_pattern and kernel_pattern.lower() not in data["system_info"].get("kernel", "").lower():
+                continue
+
+            filtered.append(data)
+
+        except Exception:
+            continue
+
+    print(f"Filtered Results ({len(filtered)} of {len(files)} files matched):\n")
+
+    for data in filtered:
+        print(f"{Path(data['file']).name}:")
+        if "date" in data["run_info"]:
+            print(f"  Date: {data['run_info']['date']}")
+        if "kernel" in data["system_info"]:
+            print(f"  Kernel: {data['system_info']['kernel']}")
+
+        # Show key metrics
+        for mtype in ["timerlat", "cyclictest"]:
+            if mtype in data["measurements"]:
+                meas = data["measurements"][mtype]
+                if "maximum" in meas:
+                    print(f"  Max latency: {meas['maximum']['value']} {meas['maximum']['unit']}")
+                if "mean" in meas:
+                    print(f"  Mean latency: {meas['mean']['value']} {meas['mean']['unit']}")
+                break
+        print()
+
+
+async def main():
+    """Run all tests."""
+    await test_find_best_worst()
+    await test_filter_results()
+
+
+if __name__ == "__main__":
+    asyncio.run(main())
-- 
2.55.0

