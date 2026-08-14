Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE83E49F6
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745452; cv=none; b=XLii0yR4DMnoZedL1shqdpT7qAAiy3xVsZwYZuKYRj+Y6kYvySY32GtZX+1O1ZVK6icy4RtK5GdeIthVJU8cpWQlSzrSLMTOif8NkuauObbz+98J0lbC7axdD8KYPoCxooFnTihXdvuvjdCTEEWQ/NzjusC9H+t0E1H7HOij3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745452; c=relaxed/simple;
	bh=uplx1mQcHywrboOF82nwkkZfITBm3LcrU2sC+hN5F/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW+Itcp4HXrKeYFisbJJ3GYz6fX294AByTnLeOqc6mtGQp/hOy6Ykoe7Cpv2GSyMLbBL3Gx04SzhbUCebKotOqJ8e1dU5cbJNb7t2T+p9vao5u7jGR4x5eMzFjYYiQFIPUisf5dFXlsL/fixBlDXGsXDAHVCA3nyl9NGZ9JIA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt6PcRp7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt6PcRp7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52d56b08213so14440481cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745449; x=1787350249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZ2U19SDeyo2iy2aw7p6sf05d1L6hdDxVAswv8X+Bw4=;
        b=mt6PcRp7cPuFAOkqHogpztHI9C6OUK9Wo8aUzpPDuOZ1GqSxZ20EbQoMeRFufgo7a3
         PC+txE5lDg5sc+ZBAvQns2GJw8geugqAfJRkO0WP48hGZlQvBucTaKVh9J8tT70mTo4G
         y+TzGUe3PA37THRik0YAdb6SY+vUwzFKH39vEcRJXGxbdzwxtrh1CPFa/LNJ4jyp/SUR
         G0zDeozHMT0ffJWZLyXAy1Juleo0Es0Rd1ihxTu1zNYHUkaNAWamQwol/bCjp/hsMGxd
         R3/pQW+OasUYYX+/Cg898iZd/rRsifm0FfcSRNH4Ax3l5Nr7lovkucil/c1Qknozmarb
         Lg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745449; x=1787350249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZ2U19SDeyo2iy2aw7p6sf05d1L6hdDxVAswv8X+Bw4=;
        b=I6Ga29YD4lsXPdPODiF9gjb4jM+LNtwQOx5e18P0O+sXs1IlcfWKefuMW/9TinntDh
         qGWC6v6bojeCgKu9GXx6TcWZ62H6XX7KubzIl1Pj3vbukHGKn80JxsuPyK61EYMSEJNw
         t9cy+XNDisQ8eUDS5Rqw6stZoUBo3P6EvW6zwstZCvUe7AVZagtur6kElXwUMG9prEgZ
         6RK4iP+YlwACe6xQKjr5vwk2T5qpaupvzG62dqjzZ7nJ5npe3ialhDng2EqeSWjV44OJ
         5tEgqZYiUKWb43rtmDufr3Bkn0pX6i0ksXjwV21drZYZsu72y0+xPDr0AAcZDMEgzTX6
         KY4A==
X-Gm-Message-State: AOJu0YxspH94AEJ6kNsnaygP/oxs73jc/LfJ66NDWcUc13Lv7MOnsHbJ
	v1XwYkpQ38DsoRP0jR3pgPv2+9nWI+lSa4GbQpcBino3csDgKoueaKVPcSwS3A==
X-Gm-Gg: AR+sD10iiCDHMFXyJ+Pha4EzFw27Xg+FddKkKMEMWRIneWXFLYo1FQZ69cvLA4KGpu8
	USwIlQ/q7RRwRzEfKgNoiwCctCjYe2isXjEyMeNokxVn21639W9VVWkyE6nKMZMkvfnHScJ19jc
	UXoWEWPniSbkkvnAd/dKtZYu+GvSkEzKmNYnwbqc8+57+3w9Re2sPBcYb1H5pZm5Bg8uSDhxOnJ
	rWmqsxnTdcPkSTmqCPLjvkh6GSfF4kuI7R/VZHqZrI7dGQ4+u8k0G+2fJJ0Zj0M2vhQnPL+9WEb
	npAngnJtErOgMOw0GHVXO6i73FH62loFzdfYH6eVNcF372L2aRviUpDNKu9Wzxc/fLnfoElzMYq
	fsyactTkHdw5G+ht3hLtNvioF1AbZErI6uIOLUtp/f8wZ/w1nWm7KrYEXDKnr+rkZC0EKB5WwVi
	AB3l0/r0zJ1T/Cx7O3kGF9FAcl191F0S5jEiG0YlbEhCe5nlcNC8M5Ku2k4J8eIztaKM3rJ49Fi
	TOOfqcT5q2dsML/NhoX6vIE3S7sCjoQLxk3LjZ+1FTz0NnZK7txKw0=
X-Received: by 2002:ac8:594d:0:b0:51c:1f35:4638 with SMTP id d75a77b69052e-52d74ba523bmr156789051cf.21.1786745449336;
        Fri, 14 Aug 2026 15:10:49 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:10:47 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 01/23] rteval: Add prototype MCP server for result analysis
Date: Fri, 14 Aug 2026 18:10:00 -0400
Message-ID: <20260814221027.213574-2-jkacur@redhat.com>
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

Add a Model Context Protocol (MCP) server to provide tools for querying
and analyzing rteval test results. This is a first prototype focused on
multi-run analysis rather than single-result querying.

The MCP server provides three initial tools:
- list_results: Discover rteval XML files in a directory
- parse_result: Extract key metrics from rteval output
- compare_results: Compare two result files (placeholder)

The parser correctly handles rteval 3.11 XML format including:
- Run information (duration, timestamp)
- System information (OS, kernel, architecture)
- Timerlat and cyclictest measurement statistics

Target users are QE engineers and developers who run rteval regularly
for RT kernel validation, performance regression testing, and CI/CD.

Tested with rteval 3.11 output on Fedora 43.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/DEPENDENCIES.md |  25 ++++
 mcp-server/README.md       |  40 ++++++
 mcp-server/server.py       | 256 +++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 mcp-server/DEPENDENCIES.md
 create mode 100644 mcp-server/README.md
 create mode 100755 mcp-server/server.py

diff --git a/mcp-server/DEPENDENCIES.md b/mcp-server/DEPENDENCIES.md
new file mode 100644
index 000000000000..e139bd7df718
--- /dev/null
+++ b/mcp-server/DEPENDENCIES.md
@@ -0,0 +1,25 @@
+# Dependencies
+
+## Fedora Packages
+
+Install these packages on Fedora:
+
+```bash
+sudo dnf install python3-mcp python3-mcp+cli
+```
+
+- **python3-mcp** - Base MCP SDK for building the server
+- **python3-mcp+cli** - CLI tools for development and testing
+
+## Python Dependencies
+
+For parsing rteval results:
+- **lxml** - XML parsing (should already be available on Fedora as `python3-lxml`)
+
+```bash
+sudo dnf install python3-lxml
+```
+
+## Optional
+
+- **python3-mcp+rich** - For enhanced terminal output (optional)
diff --git a/mcp-server/README.md b/mcp-server/README.md
new file mode 100644
index 000000000000..c5f6936b40d2
--- /dev/null
+++ b/mcp-server/README.md
@@ -0,0 +1,40 @@
+# rteval MCP Server
+
+An MCP (Model Context Protocol) server for querying and analyzing rteval test results.
+
+## Purpose
+
+This MCP server provides tools to:
+- List and discover rteval result files
+- Parse rteval XML/JSON output
+- Compare multiple test runs
+- Query historical performance data
+- Analyze latency trends across runs
+
+## Target Users
+
+System administrators, QE engineers, and developers who run rteval regularly for:
+- Real-time kernel validation
+- Performance regression testing
+- CI/CD pipelines
+- System certification
+
+## Current Status
+
+**Prototype/Development** - This is a first attempt at building an MCP server for rteval.
+The initial focus is on multi-run analysis rather than single-result querying.
+
+## Installation
+
+```bash
+pip install -r requirements.txt
+```
+
+## Usage
+
+TBD - Server configuration and client usage instructions to be added.
+
+## Development
+
+This is a work in progress. The MCP server is being developed in a branch of the
+main rteval repository and may be split into a separate repository later.
diff --git a/mcp-server/server.py b/mcp-server/server.py
new file mode 100755
index 000000000000..a3ca9e3c5783
--- /dev/null
+++ b/mcp-server/server.py
@@ -0,0 +1,256 @@
+#!/usr/bin/env python3
+"""
+rteval MCP Server
+
+An MCP server for querying and analyzing rteval test results.
+Provides tools to list, parse, and compare rteval XML result files.
+"""
+
+import os
+import sys
+from pathlib import Path
+from typing import Any
+from xml.etree import ElementTree as ET
+
+from mcp.server import Server
+from mcp.server.stdio import stdio_server
+from mcp.types import Tool, TextContent
+
+
+# Initialize the MCP server
+app = Server("rteval-mcp-server")
+
+
+@app.list_tools()
+async def list_tools() -> list[Tool]:
+    """List available tools for rteval analysis."""
+    return [
+        Tool(
+            name="list_results",
+            description="List rteval result files in a directory",
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
+                },
+                "required": [],
+            },
+        ),
+        Tool(
+            name="parse_result",
+            description="Parse an rteval XML result file and extract key metrics",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "file_path": {
+                        "type": "string",
+                        "description": "Path to the rteval XML result file",
+                    },
+                },
+                "required": ["file_path"],
+            },
+        ),
+        Tool(
+            name="compare_results",
+            description="Compare two rteval result files",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "file1": {
+                        "type": "string",
+                        "description": "Path to the first rteval XML result file",
+                    },
+                    "file2": {
+                        "type": "string",
+                        "description": "Path to the second rteval XML result file",
+                    },
+                },
+                "required": ["file1", "file2"],
+            },
+        ),
+    ]
+
+
+@app.call_tool()
+async def call_tool(name: str, arguments: Any) -> list[TextContent]:
+    """Handle tool calls."""
+
+    if name == "list_results":
+        directory = arguments.get("directory", ".")
+        pattern = arguments.get("pattern", "*.xml")
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
+            files = list(path.glob(pattern))
+
+            if not files:
+                return [TextContent(
+                    type="text",
+                    text=f"No files matching '{pattern}' found in '{directory}'"
+                )]
+
+            # Sort by modification time (newest first)
+            files.sort(key=lambda f: f.stat().st_mtime, reverse=True)
+
+            result = f"Found {len(files)} rteval result file(s) in '{directory}':\n\n"
+            for f in files:
+                mtime = f.stat().st_mtime
+                size = f.stat().st_size
+                result += f"  {f.name}\n"
+                result += f"    Path: {f.absolute()}\n"
+                result += f"    Size: {size:,} bytes\n"
+                result += f"    Modified: {Path(f).stat().st_mtime}\n\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error listing results: {str(e)}"
+            )]
+
+    elif name == "parse_result":
+        file_path = arguments["file_path"]
+
+        try:
+            path = Path(file_path)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: File '{file_path}' does not exist"
+                )]
+
+            # Parse XML
+            tree = ET.parse(file_path)
+            root = tree.getroot()
+
+            # Extract basic information
+            result = f"rteval Result Summary for: {path.name}\n"
+            result += "=" * 60 + "\n\n"
+
+            # Extract rteval version
+            rteval_version = root.get("version", "unknown")
+            result += f"rteval version: {rteval_version}\n\n"
+
+            # Run information
+            runinfo = root.find("run_info")
+            if runinfo is not None:
+                result += "Run Information:\n"
+                result += f"  Duration: {runinfo.get('days', '0')} days, "
+                result += f"{runinfo.get('hours', '0')} hours, "
+                result += f"{runinfo.get('minutes', '0')} minutes, "
+                result += f"{runinfo.get('seconds', '0')} seconds\n"
+
+                date_elem = runinfo.find("date")
+                time_elem = runinfo.find("time")
+                if date_elem is not None and time_elem is not None:
+                    result += f"  Started: {date_elem.text} {time_elem.text}\n"
+                result += "\n"
+
+            # System information
+            sysinfo = root.find("SystemInfo")
+            if sysinfo is not None:
+                uname = sysinfo.find("uname")
+                if uname is not None:
+                    result += "System Information:\n"
+                    for elem in ["baseos", "node", "arch", "kernel"]:
+                        node = uname.find(elem)
+                        if node is not None:
+                            if elem == "kernel":
+                                is_rt = node.get("is_RT", "0")
+                                result += f"  {elem}: {node.text} (RT: {'Yes' if is_rt == '1' else 'No'})\n"
+                            else:
+                                result += f"  {elem}: {node.text}\n"
+                    result += "\n"
+
+            # Timerlat measurements
+            timerlat = root.find(".//timerlat")
+            if timerlat is not None:
+                result += "Timerlat Measurements:\n"
+                cmd_line = timerlat.get("command_line", "")
+                result += f"  Command: {cmd_line}\n\n"
+
+                stats = timerlat.find(".//statistics")
+                if stats is not None:
+                    result += "  Statistics:\n"
+                    for stat in stats:
+                        unit = stat.get("unit", "")
+                        unit_str = f" {unit}" if unit else ""
+                        result += f"    {stat.tag}: {stat.text}{unit_str}\n"
+                result += "\n"
+
+            # Cyclictest measurements (if present instead of timerlat)
+            cyclictest = root.find(".//cyclictest")
+            if cyclictest is not None:
+                result += "Cyclictest Measurements:\n"
+                cmd_line = cyclictest.get("command_line", "")
+                result += f"  Command: {cmd_line}\n\n"
+
+                stats = cyclictest.find(".//statistics")
+                if stats is not None:
+                    result += "  Statistics:\n"
+                    for stat in stats:
+                        unit = stat.get("unit", "")
+                        unit_str = f" {unit}" if unit else ""
+                        result += f"    {stat.tag}: {stat.text}{unit_str}\n"
+                result += "\n"
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
+                text=f"Error reading result file: {str(e)}"
+            )]
+
+    elif name == "compare_results":
+        file1 = arguments["file1"]
+        file2 = arguments["file2"]
+
+        # For now, just return a placeholder
+        # This would need actual comparison logic based on rteval structure
+        return [TextContent(
+            type="text",
+            text=f"Comparison tool not yet implemented.\nWould compare:\n  {file1}\n  {file2}\n"
+        )]
+
+    else:
+        return [TextContent(
+            type="text",
+            text=f"Unknown tool: {name}"
+        )]
+
+
+async def main():
+    """Run the MCP server."""
+    async with stdio_server() as (read_stream, write_stream):
+        await app.run(
+            read_stream,
+            write_stream,
+            app.create_initialization_options(),
+        )
+
+
+if __name__ == "__main__":
+    import asyncio
+    asyncio.run(main())
-- 
2.55.0

