Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40893E49FB
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745456; cv=none; b=skCWE1baVMveO5mphjRqZiHW/dyvvB/UvbedU2B18LOo2wS4GdP1UTQxH2ugXoyflX/Wh8dkLS5ji1yDakTj9L4+w2Suuul76QlLoXX5V9JBbiEuKimNFzckmbdAPTp8iHTrvF3sNbi7hBWJamS/TLd2lNZX1qXC5MSjjMZTLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745456; c=relaxed/simple;
	bh=QG+QvpAh+N9HazEq28zEQ5QJ50JJt869jijwUV5KptQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkufMA3zdSuOnSB4052z27SvjjKDYiClgpUbZRao0k6sTnQtFMdkP0VmgA4SZJ3J4KHxZquzVfLFtW+bbZkV39lcW9iOFJf8Tyrbf+QxGAcFYDLmFXP9a9C3xo3g5i3jXgD55ljBA/TfdwgsgiTJqNhxp0tzBgLjuUwFn8HjGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hojIpox9; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hojIpox9"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-526f963372aso10007031cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745454; x=1787350254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XnTl0KFA0nAZGTjcGARWgEpX30rggt/bDKWTtFiD30=;
        b=hojIpox9FZUXBB8cSSZEQ5q/ZFSkI3PMqTmNpqmr7bIzAVD+l0HNDrGgqwusTvnKbJ
         xtzpdq10ZyIjS5/sj+dko3T9BmqHflowx9uilM0t6dQhrf4bsw5ATtBUyEgtd0T1iJvS
         +EpgaZHdesJRKRYRDwZq7KKFLUsK0yeeZj7PmOegljVi5wzBxTN+B2yp5x2QfhRfltQu
         pAqYoesCee+R2qbPP2MzEvUNIVietji53ap4a+AM8rWlUcubJbuKyDqrQoTMOEtpbVsd
         qzY9zmKRFNebjlG92aD6LTKRhodXGXI5D3y3+UC9KDKqzfPo1A4+pp2BBdPPeAqrYVkr
         7cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745454; x=1787350254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XnTl0KFA0nAZGTjcGARWgEpX30rggt/bDKWTtFiD30=;
        b=c5JQVxOSymXWwureANyjoNEW7UmSDRf+VHon/Mh3K3+vXg9MMOO4skUnWsVmVxX9cR
         gFdmBET9iGtqD8jV1IqTJAo8bvAY1sTwf9/AK1lFx3sr3n5tFoytDiJK9VK4FG/FQVup
         MOIs/Imo/o1CTn1uOePepozE8a1awoDwscj8fn3iTDOO2kOkSp4S4UACqGu6pxM6XwmX
         bmiIwn4kn1pYBqg6GC0GMyJHKX+4+YpQM1kApISosZnr1NyJXVnmkT7rZCPDb6ffBDOZ
         PMJtRhB1gpvjohJrgT34aVnsvw9/U6KmHQzIjteRGzLj53iLkS/9RcpxT1TPYDPsT6Jp
         +b5A==
X-Gm-Message-State: AOJu0Yz3/Z+azopZaSmlaSQh3V43dvmIQ5OKPzod3iTU250QGHP5mdjX
	XImgnyvrF/YZB9M966KYF4rHvPZ8h4RVxDaJ0yIrU7VRc6StocWCDUV7ESQ9CA==
X-Gm-Gg: AR+sD12EsuGpU3bO8eNAjKDeg4llNA92tqqszPydLXx0lEUifmEdyk08FRn79FeLsik
	CcD1xPCEsks8oe03YhVt8TQDAJcXYZ0bJcibaiCP+x5oxcbdzYPHkWQNTQlkTBfhLZjRKALO8Ts
	qghmoc6LjKoHvyF7oOi72u80/ic5UG7qmZcf/j+mPUUtzLyHODHUVh7xhMcEg2iMpSZqzmlN9Il
	wygDQE3+qdsBDLKPHQ9M3tNYktKTkUWBO5zInSawBpsJkIi8jSvtvpNT6tYNzWF6Ocw9dNmYS9k
	byRBn2XA9voBkeQR6JyI1YP7GAv5dZp2AEbHst6aF1pw9IVpfcjKTxBvj8QNzAtahx/H0me+k55
	23OQZwHBkQJ+LKEEHkTT9Rt8lJgqiKTEmLwCbm1XWWmW263PQMw5eKbRR5svJ4FWkEecwQwq3GB
	bsYgB3W9q3s4s+KgdAv70oUK0QIqUQLaej6uEAgf0YkzCrr1LUmGItjExnrS6w4jfxg1pVlwEtc
	zs8NDbIjxSYfIzPbIYwBtJgvL/lK1GtimsC8KCkItfVy71tBymbbNE=
X-Received: by 2002:a05:622a:4d4c:b0:528:601:301e with SMTP id d75a77b69052e-52d85439fdbmr115153001cf.26.1786745453791;
        Fri, 14 Aug 2026 15:10:53 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:10:52 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 03/23] rteval: Add log file access tools to MCP server
Date: Fri, 14 Aug 2026 18:10:02 -0400
Message-ID: <20260814221027.213574-4-jkacur@redhat.com>
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

Add two new tools for accessing rteval log files:

1. list_logs - Lists all log files in an rteval result directory
   - Groups by stdout and stderr
   - Shows file sizes and paths
   - Helps discover what logs are available

2. read_log - Reads content from log files with filtering options
   - head: Read first N lines
   - tail: Read last N lines
   - grep: Search for pattern in log
   - Default: Shows first 100 lines
   - Handles large files gracefully (timerlat.stdout can be 1.5MB+)

These tools are useful for debugging issues like the timerlat warnings
we encountered, allowing users to examine load and measurement logs
without manual file access.

Tested with rteval-20260605-2 logs directory containing 8 log files
(hackbench, kcompile, timerlat stdout/stderr).

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/server.py | 157 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/mcp-server/server.py b/mcp-server/server.py
index 40c11dfecb34..58de7fc660d5 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -145,6 +145,46 @@ async def list_tools() -> list[Tool]:
                 "required": ["file1", "file2"],
             },
         ),
+        Tool(
+            name="list_logs",
+            description="List available log files in an rteval result directory",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "result_dir": {
+                        "type": "string",
+                        "description": "Path to rteval result directory (e.g., rteval-20260605-1)",
+                    },
+                },
+                "required": ["result_dir"],
+            },
+        ),
+        Tool(
+            name="read_log",
+            description="Read content from an rteval log file",
+            inputSchema={
+                "type": "object",
+                "properties": {
+                    "log_path": {
+                        "type": "string",
+                        "description": "Path to the log file",
+                    },
+                    "tail": {
+                        "type": "integer",
+                        "description": "Read last N lines (optional)",
+                    },
+                    "head": {
+                        "type": "integer",
+                        "description": "Read first N lines (optional)",
+                    },
+                    "grep": {
+                        "type": "string",
+                        "description": "Search for pattern in log (optional)",
+                    },
+                },
+                "required": ["log_path"],
+            },
+        ),
     ]
 
 
@@ -422,6 +462,123 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
                 text=f"Error comparing results: {str(e)}"
             )]
 
+    elif name == "list_logs":
+        result_dir = arguments["result_dir"]
+
+        try:
+            dir_path = Path(result_dir)
+            if not dir_path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: Directory '{result_dir}' does not exist"
+                )]
+
+            logs_dir = dir_path / "logs"
+            if not logs_dir.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: Logs directory not found in '{result_dir}'"
+                )]
+
+            log_files = sorted(logs_dir.glob("*"))
+
+            if not log_files:
+                return [TextContent(
+                    type="text",
+                    text=f"No log files found in '{logs_dir}'"
+                )]
+
+            result = f"Log files in {logs_dir}:\n\n"
+
+            # Group by type (stdout vs stderr)
+            stdout_files = [f for f in log_files if f.name.endswith('.stdout')]
+            stderr_files = [f for f in log_files if f.name.endswith('.stderr')]
+
+            if stdout_files:
+                result += "Standard Output Logs:\n"
+                for f in stdout_files:
+                    size = f.stat().st_size
+                    result += f"  {f.name}\n"
+                    result += f"    Size: {size:,} bytes\n"
+                    result += f"    Path: {f}\n"
+                result += "\n"
+
+            if stderr_files:
+                result += "Standard Error Logs:\n"
+                for f in stderr_files:
+                    size = f.stat().st_size
+                    result += f"  {f.name}\n"
+                    result += f"    Size: {size:,} bytes\n"
+                    result += f"    Path: {f}\n"
+                result += "\n"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error listing logs: {str(e)}"
+            )]
+
+    elif name == "read_log":
+        log_path = arguments["log_path"]
+        tail = arguments.get("tail")
+        head = arguments.get("head")
+        grep = arguments.get("grep")
+
+        try:
+            path = Path(log_path)
+            if not path.exists():
+                return [TextContent(
+                    type="text",
+                    text=f"Error: Log file '{log_path}' does not exist"
+                )]
+
+            # Read the file
+            with open(path, 'r', errors='replace') as f:
+                lines = f.readlines()
+
+            total_lines = len(lines)
+
+            # Apply filters
+            if grep:
+                lines = [line for line in lines if grep in line]
+                result = f"Log file: {path.name}\n"
+                result += f"Filtered by: '{grep}'\n"
+                result += f"Matching lines: {len(lines)} / {total_lines}\n"
+                result += "=" * 60 + "\n"
+            else:
+                result = f"Log file: {path.name}\n"
+                result += f"Total lines: {total_lines}\n"
+                result += "=" * 60 + "\n"
+
+            if tail:
+                lines = lines[-tail:]
+                result += f"(showing last {tail} lines)\n\n"
+            elif head:
+                lines = lines[:head]
+                result += f"(showing first {head} lines)\n\n"
+            elif not grep:
+                # Default: show first 100 lines if no filter specified
+                if len(lines) > 100:
+                    lines = lines[:100]
+                    result += f"(showing first 100 of {total_lines} lines)\n\n"
+
+            result += "".join(lines)
+
+            # Warn if file was very large
+            if total_lines > 10000 and not (tail or head or grep):
+                result += f"\n\n[Note: File has {total_lines} lines. "
+                result += "Consider using --tail, --head, or --grep to filter]"
+
+            return [TextContent(type="text", text=result)]
+
+        except Exception as e:
+            return [TextContent(
+                type="text",
+                text=f"Error reading log file: {str(e)}"
+            )]
+
     else:
         return [TextContent(
             type="text",
-- 
2.55.0

