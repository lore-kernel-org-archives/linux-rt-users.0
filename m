Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6143E92BB
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745483; cv=none; b=nVpScsjrlw9pNUbsTUShfuLL29QERj6zKRYg0Lh49/GzueIT4QrRUDShLwu58JHKD1uM1jKmgh9g6Wt0Ub1jMNSkonaOc82V8RDXrvlrlR8SWwHPBQ+EX3TBOw5eJB2IIzalbUkcW2yOTnR9ERWLaziiDxwyaPB520C0y/8vvTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745483; c=relaxed/simple;
	bh=Y88tJSS9ym7fpQqcxSJ6EI4WFU1crkpoJAaAB1Lm8Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtgvsrk7Kfe5raOi+8TMa9ikn3Ko0MKkiNkPxseR1Dg4UQNpAyhrxDV3F6HA8ua/8fymlZFFFtcNmDDA5zCmgwmv1nRu8uwhv7GgzGkKzR5Sxz+/EAubx7dCyRwHU3SuaAZ/+ySVPXyHBR3D4/si9K1Gur1yfzwcBo1NwASFlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j20o6Y08; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j20o6Y08"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0cea8883so12533401cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745481; x=1787350281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+OghnyCFzDXJQ7CJjYwLD0nkrOOQZilFffHkOLPywZA=;
        b=j20o6Y08LIuXvTEZ91l+MILyWX6qyWGrTIvqRewI7SihHPJDw1WQmfnq33MbJGjae2
         Fc2FsgPYzPXVknXxTCgqTrmqcHkMRs0DT32NXINDrunE+JiOKn/Ef152WiV+hHdhTsmw
         bgspBJIjYul01XIMN89q21ZUewfcmgCIrDB5dUho5sQY/tAKzKNzhFjWkDMWPcGDyE6o
         EmcWKAPgpRunP6L+DL2HdIj0lbCO2Bgmz5RvpTRfiwMFGPNG5mS/BLMyYfrDBTZk0zZ8
         Eq0IYLlaVR6Y6R7k80aFWdG9u4UAbtOptB1Z4Ku6E85Lyrcgwjwt4Q16DlgR2KtTkUcm
         +qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745481; x=1787350281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+OghnyCFzDXJQ7CJjYwLD0nkrOOQZilFffHkOLPywZA=;
        b=dzYm2yc/yow5O0dc1QbslKHDf3Hun8b1fl6RsnDzCezXMrUHhdlBfnCeqcckZcl1pa
         WDDS7qQedlGhs14goKh1CO2H02pSbtq6Lfiys7ygGy+SlcspIoflEx8wibRBYM8x00Bc
         hgzRVjxWohDbTrOhi6tLfhCApTtwVFuhQ1KG+d95lRL9VSpMws8HteV4Jst0tBGy0pYd
         Gx6TEzON2WOPlXYkP843nfmX3B1HGv3OKvbEmLHD5PtT4VkSc2M0cRhTgO95z/ExZ6DQ
         aAK9ELzObIUGrHkupx/u+iqRXxqJtFLMyQKXGHZDqjEQbB1en0jDILFE970rH8jzXn1L
         qZrw==
X-Gm-Message-State: AOJu0YzqIIi6Fj++L5o3CHtK94ZpY11EIB98iW3NqJAwIVfYqfX9VSkf
	jwzGo7c4o0OuPCe0QTl/HGEhLUwh3ogX6A6eYdGVkVKQcYwqV5/CmwESohITrA==
X-Gm-Gg: AR+sD11Po3cKyV9ad35cxH91T9M3hz9cAxNM6Go935HE+xlAhI+pjfEJ2mayX6ekgH1
	5+zzhkbrp4xMvSVsTLi3mOwAhgr2tVHijFf62/bEUsN4MWKudQfnAmJKYRwSjcpOa9byX7ICQGp
	RqSqhLX0EhTBh6dhA+j/sag8Mz/uFDPaQizvdoYwX+XWWjeezkIS4tNYdV8e9Fzr8pYXqPGLUQU
	X/3oolLX58vMWxezqat7AI4CK6yFxj2CqbeW4l2G/bpX0HPoSVkCe4p1DrY057grvY9t8eTLiPc
	dAMCyIg8v7VMAvYstbV9KSw3N9StW/tKSGczSIBNnZWu6QxCNpcVJjcAN0FhCMz8HspqtCvQUip
	KJnZbymPPbn2FinE/O6naOkiYs+WKkhAAKTrCxtQzhOMrsM/tnX7OuBqcOYZavSc/lzvn7vrgxq
	NcjNmw9jOK2poJ4T7sGIa++onUX+WRzQ9xmxYNbnmsl8xy4fX16H9rw5cfzJF6lGFZeRh6i5jyV
	lGqvEyiwX48/cwOeoM3UeoSToSfdZVL+0qC9xOD3Sm/mncDHqFURXheAJgt9nFu9A==
X-Received: by 2002:a05:622a:4cc3:b0:516:d83d:b28 with SMTP id d75a77b69052e-52d74b6ea9fmr188596691cf.17.1786745480742;
        Fri, 14 Aug 2026 15:11:20 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:20 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 22/23] mcp-server: Restructure as Python package with dynamic paths
Date: Fri, 14 Aug 2026 18:10:21 -0400
Message-ID: <20260814221027.213574-23-jkacur@redhat.com>
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

Restructure the MCP server into a standard Python package to enable
both development and system installation scenarios.

Directory and file changes:
- Rename mcp-server/ to rteval_mcp/ (Python package naming convention)
- Rename server.py to rteval_server.py (avoid naming conflicts)
- Add __init__.py with package metadata
- Add __main__.py to enable 'python3 -m rteval_mcp' execution
- Create rteval-mcp-server wrapper script for command-line execution
- Update all test imports from 'server' to 'rteval_server'

Configuration files now use relative paths instead of hardcoded paths:
- manifest.json: ./rteval_mcp/rteval-mcp-server
- .claude-plugin/plugin.json: ./rteval_mcp/rteval-mcp-server

The wrapper script dynamically calculates paths:
- Finds its own location using BASH_SOURCE
- Sets PYTHONPATH only when running from git (detects .git directory)
- For system installations, relies on standard site-packages location

This approach supports both development from git (./rteval-cmd pattern)
and future system packaging without path conflicts.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .../.claude-plugin/plugin.json                |  6 ++--
 {mcp-server => rteval_mcp}/DEMO.md            |  0
 {mcp-server => rteval_mcp}/DEPENDENCIES.md    |  0
 {mcp-server => rteval_mcp}/Makefile           |  0
 {mcp-server => rteval_mcp}/README.md          |  4 +--
 rteval_mcp/__init__.py                        | 13 ++++++++
 rteval_mcp/__main__.py                        | 33 +++++++++++++++++++
 {mcp-server => rteval_mcp}/manifest.json      |  8 ++---
 rteval_mcp/rteval-mcp-server                  | 21 ++++++++++++
 .../server.py => rteval_mcp/rteval_server.py  |  0
 .../tests/test_histogram.py                   |  4 +--
 .../tests/test_mcp_integration.py             |  4 +--
 .../tests/test_new_tools.py                   |  4 +--
 .../tests/test_per_cpu_stats.py               |  4 +--
 14 files changed, 82 insertions(+), 19 deletions(-)
 rename {mcp-server => rteval_mcp}/.claude-plugin/plugin.json (79%)
 rename {mcp-server => rteval_mcp}/DEMO.md (100%)
 rename {mcp-server => rteval_mcp}/DEPENDENCIES.md (100%)
 rename {mcp-server => rteval_mcp}/Makefile (100%)
 rename {mcp-server => rteval_mcp}/README.md (99%)
 create mode 100644 rteval_mcp/__init__.py
 create mode 100644 rteval_mcp/__main__.py
 rename {mcp-server => rteval_mcp}/manifest.json (70%)
 create mode 100755 rteval_mcp/rteval-mcp-server
 rename mcp-server/server.py => rteval_mcp/rteval_server.py (100%)
 rename {mcp-server => rteval_mcp}/tests/test_histogram.py (95%)
 rename {mcp-server => rteval_mcp}/tests/test_mcp_integration.py (98%)
 rename {mcp-server => rteval_mcp}/tests/test_new_tools.py (97%)
 rename {mcp-server => rteval_mcp}/tests/test_per_cpu_stats.py (97%)

diff --git a/mcp-server/.claude-plugin/plugin.json b/rteval_mcp/.claude-plugin/plugin.json
similarity index 79%
rename from mcp-server/.claude-plugin/plugin.json
rename to rteval_mcp/.claude-plugin/plugin.json
index c3469c048524..e48d8c95c655 100644
--- a/mcp-server/.claude-plugin/plugin.json
+++ b/rteval_mcp/.claude-plugin/plugin.json
@@ -10,10 +10,8 @@
   "keywords": ["rteval", "real-time", "latency", "testing", "timerlat", "cyclictest"],
   "mcpServers": {
     "rteval-mcp": {
-      "command": "python3",
-      "args": [
-        "/home/jkacur/src/rteval/mcp-server/server.py"
-      ],
+      "command": "./rteval_mcp/rteval-mcp-server",
+      "args": [],
       "env": {}
     }
   }
diff --git a/mcp-server/DEMO.md b/rteval_mcp/DEMO.md
similarity index 100%
rename from mcp-server/DEMO.md
rename to rteval_mcp/DEMO.md
diff --git a/mcp-server/DEPENDENCIES.md b/rteval_mcp/DEPENDENCIES.md
similarity index 100%
rename from mcp-server/DEPENDENCIES.md
rename to rteval_mcp/DEPENDENCIES.md
diff --git a/mcp-server/Makefile b/rteval_mcp/Makefile
similarity index 100%
rename from mcp-server/Makefile
rename to rteval_mcp/Makefile
diff --git a/mcp-server/README.md b/rteval_mcp/README.md
similarity index 99%
rename from mcp-server/README.md
rename to rteval_mcp/README.md
index 370aa0e9ca71..fc54c8074754 100644
--- a/mcp-server/README.md
+++ b/rteval_mcp/README.md
@@ -74,7 +74,7 @@ sudo dnf install python3-mcp python3-mcp+cli python3-lxml
 The MCP server includes a test suite to verify functionality:
 
 ```bash
-cd mcp-server
+cd rteval_mcp
 
 # Run all tests
 make test
@@ -157,7 +157,7 @@ Which CPUs have the most variable latency?
 ### Using with MCP Inspector
 
 ```bash
-mcp dev server.py
+mcp dev rteval-mcp-server
 ```
 
 ## Complete Tool Usage Guide
diff --git a/rteval_mcp/__init__.py b/rteval_mcp/__init__.py
new file mode 100644
index 000000000000..390f2bd0f8c0
--- /dev/null
+++ b/rteval_mcp/__init__.py
@@ -0,0 +1,13 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   rteval MCP Server package
+#
+#   Copyright 2026   John Kacur <jkacur@redhat.com>
+#
+"""rteval MCP Server - tools for analyzing rteval results."""
+
+__version__ = "0.1.0"
+__author__ = "John Kacur"
+__email__ = "jkacur@redhat.com"
diff --git a/rteval_mcp/__main__.py b/rteval_mcp/__main__.py
new file mode 100644
index 000000000000..2a027c57b0c9
--- /dev/null
+++ b/rteval_mcp/__main__.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   rteval MCP Server entry point
+#
+#   Copyright 2026   John Kacur <jkacur@redhat.com>
+#
+"""Entry point for running rteval MCP server as a module."""
+
+import sys
+import asyncio
+from pathlib import Path
+
+# Add package directory to path for development mode
+package_dir = Path(__file__).parent
+sys.path.insert(0, str(package_dir))
+
+from rteval_server import app, stdio_server
+
+
+async def main():
+    """Run the MCP server."""
+    async with stdio_server() as (read_stream, write_stream):
+        await app.run(
+            read_stream,
+            write_stream,
+            app.create_initialization_options()
+        )
+
+
+if __name__ == "__main__":
+    asyncio.run(main())
diff --git a/mcp-server/manifest.json b/rteval_mcp/manifest.json
similarity index 70%
rename from mcp-server/manifest.json
rename to rteval_mcp/manifest.json
index 6127dcd26774..a04732245efa 100644
--- a/mcp-server/manifest.json
+++ b/rteval_mcp/manifest.json
@@ -9,12 +9,10 @@
   },
   "server": {
     "type": "python",
-    "entry_point": "server.py",
+    "entry_point": "rteval-mcp-server",
     "mcp_config": {
-      "command": "python3",
-      "args": [
-        "/home/jkacur/src/rteval/mcp-server/server.py"
-      ]
+      "command": "./rteval_mcp/rteval-mcp-server",
+      "args": []
     }
   }
 }
diff --git a/rteval_mcp/rteval-mcp-server b/rteval_mcp/rteval-mcp-server
new file mode 100755
index 000000000000..34ce8a4d0e43
--- /dev/null
+++ b/rteval_mcp/rteval-mcp-server
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# rteval MCP Server wrapper script
+#
+# Copyright 2026 John Kacur <jkacur@redhat.com>
+#
+# This wrapper executes the rteval MCP server as a Python module.
+# It works for both development (local git) and installed (system) versions.
+
+# Find the directory containing this script
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+# Parent directory is where Python should search for rteval_mcp module
+PARENT_DIR="$(dirname "$SCRIPT_DIR")"
+
+# Only set PYTHONPATH if running from a git development tree
+if [ -d "${PARENT_DIR}/.git" ]; then
+    export PYTHONPATH="${PARENT_DIR}:${PYTHONPATH}"
+fi
+
+exec python3 -m rteval_mcp "$@"
diff --git a/mcp-server/server.py b/rteval_mcp/rteval_server.py
similarity index 100%
rename from mcp-server/server.py
rename to rteval_mcp/rteval_server.py
diff --git a/mcp-server/tests/test_histogram.py b/rteval_mcp/tests/test_histogram.py
similarity index 95%
rename from mcp-server/tests/test_histogram.py
rename to rteval_mcp/tests/test_histogram.py
index 917afb1aac93..c15763663958 100644
--- a/mcp-server/tests/test_histogram.py
+++ b/rteval_mcp/tests/test_histogram.py
@@ -13,9 +13,9 @@ Test script for histogram extraction and percentile calculation.
 import sys
 from pathlib import Path
 
-# Add parent directory to path to import server module
+# Add parent directory to path to import rteval_server module
 sys.path.insert(0, str(Path(__file__).parent.parent))
-from server import extract_histogram_data, calculate_percentiles
+from rteval_server import extract_histogram_data, calculate_percentiles
 
 # Find test file relative to script location
 # From tests/ -> mcp-server/ -> rteval/
diff --git a/mcp-server/tests/test_mcp_integration.py b/rteval_mcp/tests/test_mcp_integration.py
similarity index 98%
rename from mcp-server/tests/test_mcp_integration.py
rename to rteval_mcp/tests/test_mcp_integration.py
index 0b5f2954a16f..543f4ea7c249 100644
--- a/mcp-server/tests/test_mcp_integration.py
+++ b/rteval_mcp/tests/test_mcp_integration.py
@@ -16,9 +16,9 @@ import sys
 import asyncio
 from pathlib import Path
 
-# Add parent directory to path to import server module
+# Add parent directory to path to import rteval_server module
 sys.path.insert(0, str(Path(__file__).parent.parent))
-from server import call_tool, list_tools
+from rteval_server import call_tool, list_tools
 
 
 def find_test_data():
diff --git a/mcp-server/tests/test_new_tools.py b/rteval_mcp/tests/test_new_tools.py
similarity index 97%
rename from mcp-server/tests/test_new_tools.py
rename to rteval_mcp/tests/test_new_tools.py
index a81b23bbffbb..b178146d3e4d 100644
--- a/mcp-server/tests/test_new_tools.py
+++ b/rteval_mcp/tests/test_new_tools.py
@@ -12,9 +12,9 @@ import sys
 import asyncio
 from pathlib import Path
 
-# Add parent directory to path to import server module
+# Add parent directory to path to import rteval_server module
 sys.path.insert(0, str(Path(__file__).parent.parent))
-from server import extract_rteval_data
+from rteval_server import extract_rteval_data
 
 
 async def test_find_best_worst():
diff --git a/mcp-server/tests/test_per_cpu_stats.py b/rteval_mcp/tests/test_per_cpu_stats.py
similarity index 97%
rename from mcp-server/tests/test_per_cpu_stats.py
rename to rteval_mcp/tests/test_per_cpu_stats.py
index 6ec07dbf39fe..851cbd710165 100644
--- a/mcp-server/tests/test_per_cpu_stats.py
+++ b/rteval_mcp/tests/test_per_cpu_stats.py
@@ -12,9 +12,9 @@ import sys
 import asyncio
 from pathlib import Path
 
-# Add parent directory to path to import server module
+# Add parent directory to path to import rteval_server module
 sys.path.insert(0, str(Path(__file__).parent.parent))
-from server import call_tool
+from rteval_server import call_tool
 
 
 async def main():
-- 
2.55.0

