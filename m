Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9633E92BB
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745459; cv=none; b=Nl2IMDu/h/pk79aCfP4HdeJcyCg9UI5j1JclG+IBfbZ+1N465qGNnhLGXT1AQ1BYZ/+XaeGvtlYNDYgj9P4OOTrM/56G1y97S2nDnH/K/mwuKw6lmLqn1jS+6LSCFLB0TIiVzWY5C8P6C8kODL4+mn8szVV3Gd0vIdr/9dKuDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745459; c=relaxed/simple;
	bh=zwiutV9o3HTqt+pGJgizuFCufI3inv/+07JmHqtlrXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHBTQnKr5P+kkaL36jsbePuijVBrZ1ANS78rCy3Uw3vLxGAuoHZ5iqaj3w5268MYJ36vXwlsGrLrUn6m/FokllrTKZRc7A/kqPabRQ4awidkU75AfZn+1xMZKjD1QjqMHvEq7+N2AM1odp1roFmoZITByk20NK1rL7VkxwIZh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6BDO0C4; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6BDO0C4"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90a6b298889so11723716d6.3
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745457; x=1787350257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NNnjqrFDtylabZ7qekYLbArEcu767NJDzS0INqhJKtw=;
        b=A6BDO0C4w0Es8c4q1fF25UZdIkia0jiPuBeyBKc2Zx2cY1bV9mX6l25r0I28032f3m
         5AkWReAepfjU6x1Prw/J+QSlGIQFOzAtWHL4PA1RgIGr62MzSZUELsG3EUl+maYN1/JC
         fCihL6XMF8BvRJXMUVgTiYm3Pcqh18TUjbVpmVLLpnXuh2AlOyddwiGPPQeh2ZwCXMvs
         sJ7ukiKJC5vG9WQHyYP0OESAlmT+igh9OytOw523SFYatSQ59Z8Yz5oFfdFfderwzhOp
         9PfpdPA+qMGZ+5a3DQ5Y2RW0EVzHBtNx7ktMsisLGHnXLUoFb4NTOo3NqcIjGzrL0uLs
         eg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745457; x=1787350257;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNnjqrFDtylabZ7qekYLbArEcu767NJDzS0INqhJKtw=;
        b=i5cXwAWQSpRd0NhHASXVNZ1YH/SqfSxh2N8queZ17Jm1laAkT12xYsTyEOV8HcoIcp
         Aj+OOkrwEaJxEZ0NDV38rwOsGwto4GKEWVZliEkrQnWYitlIA5D8TVAoyE+LGh8iOK2u
         zisT5h/VeQE1wATGVIhM9e2FCduyW6N7TVHxuRPOyYpTprs2v6XuDkHgxLyJWwGD/OHx
         YysGlBVcrslv5QKouzU/52ZdWGlXTRHi9Uyck1Dy3H7savTB5rcY66llO7MTkzh6G/D7
         TRDXbjlrgS7RJTN5Sbx6mlKFyATioNJnXSl7w1XCNdXyxUdieVc4EVhYEtUpgi+D7oRk
         Hyng==
X-Gm-Message-State: AOJu0YxDw1MFsnjizy5XouWDSMpgy0c2q7lzcniRSpvVe5fYCeKBDNsa
	mbIlz0MyguAtGHtre9f1GVyOcQI6mlA02ZExVDgnnMUhVGoIYfR73ZGKvLh87g==
X-Gm-Gg: AR+sD11S7F+3sOPYlrBKS8HssUn3j+P54ShvmJQOCl4L/US1AsMbtVGrU8cBGoZEJQ4
	xTmc61pe96l1nP0Be2uUbTMvt1NKtzf7MIW9eW3yRyPT/KO123YAUviPoKzxDNWQNyxI9+qXSmD
	5vy6nTaA0fV1YATzZJ2OZ1fEQr321wdoMwvBmOicNhgdflUXRLkG4UiUceK2Tl9ZbI0S74xjYgn
	I+lzt6qg8V8IsdUQXrNOtAy2bFYFnpL8eBVO4Ouh4h7k9srmEJoCKWsPcSZY6XMnsoJjhIz+Af9
	lP/Xxla6O3dHGFQcV0CyV90TA9zphktURU2kItplN9Y/fB5yqFJ5d3a8EX9OGGYbMm5/QjDasow
	oZ+pAHllEWJnCztCPU/HcPaZqF6/tRsrsyFQ4LaUafOQIjykYrwB9fgdTwMhOUQkxlUdY8xy4mG
	Z971WlFAOhAjj9rHfFnTQalvVvAEC0zXjWjgt7htTcNcKtTjwnTJ/A/YY5+Zu6BCULfeHDEpdUM
	hUWdJN91kBi2Ny1cPXwcC1L1QOYBt3ERznSJmS6WHC19SyaHjVvOkIA33I137TGpQ==
X-Received: by 2002:a05:6214:20ec:b0:90a:3c0e:a686 with SMTP id 6a1803df08f44-90a91d03becmr108771766d6.8.1786745457082;
        Fri, 14 Aug 2026 15:10:57 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:10:56 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 06/23] rteval: mcp-server: Add rtla command line parser
Date: Fri, 14 Aug 2026 18:10:05 -0400
Message-ID: <20260814221027.213574-7-jkacur@redhat.com>
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

Add parse_rtla_command() function to parse rtla timerlat and cyclictest
command line parameters. Update parse_result tool to display parsed
parameters in a human-readable format, showing period, scheduling,
CPUs, thresholds, and other settings.

Also update .mcp.json to use absolute path for better reliability.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .mcp.json            |   2 +-
 mcp-server/server.py | 140 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/.mcp.json b/.mcp.json
index 1d0726d03acc..a4d5fc706f88 100644
--- a/.mcp.json
+++ b/.mcp.json
@@ -3,7 +3,7 @@
     "rteval": {
       "command": "python3",
       "args": [
-        "mcp-server/server.py"
+        "/home/jkacur/src/rteval/mcp-server/server.py"
       ],
       "env": {}
     }
diff --git a/mcp-server/server.py b/mcp-server/server.py
index 58de7fc660d5..d1ad5437a886 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -21,6 +21,94 @@ from mcp.types import Tool, TextContent
 app = Server("rteval-mcp-server")
 
 
+def parse_rtla_command(cmd_line: str) -> dict[str, str]:
+    """Parse rtla timerlat or cyclictest command line into parameters."""
+    params = {}
+
+    if not cmd_line:
+        return params
+
+    parts = cmd_line.split()
+    i = 0
+
+    while i < len(parts):
+        arg = parts[i]
+
+        # Period parameter
+        if arg in ['-p', '--period']:
+            if i + 1 < len(parts):
+                params['period'] = f"{parts[i + 1]} µs"
+                i += 2
+                continue
+
+        # Priority/scheduling parameter
+        elif arg in ['-P', '--priority']:
+            if i + 1 < len(parts):
+                prio = parts[i + 1]
+                # Parse format like "f:95" or "r:95"
+                if ':' in prio:
+                    policy, level = prio.split(':', 1)
+                    policy_name = {'f': 'FIFO', 'r': 'RR', 'o': 'OTHER'}.get(policy, policy)
+                    params['scheduling'] = f"{policy_name} priority {level}"
+                else:
+                    params['scheduling'] = prio
+                i += 2
+                continue
+
+        # CPU list parameter
+        elif arg in ['-c', '--cpus']:
+            if i + 1 < len(parts):
+                params['cpus'] = parts[i + 1]
+                i += 2
+                continue
+
+        # Exit/stop threshold
+        elif arg in ['-E', '--stop', '--stop-total']:
+            if i + 1 < len(parts):
+                params['exit_threshold'] = f"{parts[i + 1]} µs"
+                i += 2
+                continue
+
+        # DMA latency
+        elif arg.startswith('--dma-latency='):
+            value = arg.split('=', 1)[1]
+            params['dma_latency'] = value
+            i += 1
+            continue
+
+        # Duration
+        elif arg in ['-D', '--duration']:
+            if i + 1 < len(parts):
+                params['duration'] = parts[i + 1]
+                i += 2
+                continue
+
+        # Unit flags
+        elif arg in ['-u', '--us']:
+            params['unit'] = 'microseconds'
+            i += 1
+            continue
+        elif arg in ['-n', '--ns']:
+            params['unit'] = 'nanoseconds'
+            i += 1
+            continue
+
+        # Boolean flags
+        elif arg == '--no-summary':
+            params['summary'] = 'disabled'
+            i += 1
+            continue
+        elif arg == '--no-aa':
+            params['auto_analysis'] = 'disabled'
+            i += 1
+            continue
+
+        else:
+            i += 1
+
+    return params
+
+
 def extract_rteval_data(file_path: str) -> dict[str, Any]:
     """Extract key data from an rteval XML file for comparison."""
     tree = ET.parse(file_path)
@@ -292,7 +380,31 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
             if timerlat is not None:
                 result += "Timerlat Measurements:\n"
                 cmd_line = timerlat.get("command_line", "")
-                result += f"  Command: {cmd_line}\n\n"
+                result += f"  Command: {cmd_line}\n"
+
+                # Parse and display command parameters
+                params = parse_rtla_command(cmd_line)
+                if params:
+                    result += "\n  Parsed Parameters:\n"
+                    if 'period' in params:
+                        result += f"    Period: {params['period']} (-p)\n"
+                    if 'scheduling' in params:
+                        result += f"    Scheduling: {params['scheduling']} (-P)\n"
+                    if 'cpus' in params:
+                        result += f"    CPUs: {params['cpus']} (-c)\n"
+                    if 'exit_threshold' in params:
+                        result += f"    Exit threshold: {params['exit_threshold']} (-E)\n"
+                    if 'dma_latency' in params:
+                        result += f"    DMA latency: {params['dma_latency']} (--dma-latency)\n"
+                    if 'duration' in params:
+                        result += f"    Duration: {params['duration']} (-D)\n"
+                    if 'unit' in params:
+                        result += f"    Unit: {params['unit']}\n"
+                    if 'summary' in params:
+                        result += f"    Summary: {params['summary']}\n"
+                    if 'auto_analysis' in params:
+                        result += f"    Auto-analysis: {params['auto_analysis']}\n"
+                result += "\n"
 
                 stats = timerlat.find(".//statistics")
                 if stats is not None:
@@ -308,7 +420,31 @@ async def call_tool(name: str, arguments: Any) -> list[TextContent]:
             if cyclictest is not None:
                 result += "Cyclictest Measurements:\n"
                 cmd_line = cyclictest.get("command_line", "")
-                result += f"  Command: {cmd_line}\n\n"
+                result += f"  Command: {cmd_line}\n"
+
+                # Parse and display command parameters
+                params = parse_rtla_command(cmd_line)
+                if params:
+                    result += "\n  Parsed Parameters:\n"
+                    if 'period' in params:
+                        result += f"    Period: {params['period']} (-p)\n"
+                    if 'scheduling' in params:
+                        result += f"    Scheduling: {params['scheduling']} (-P)\n"
+                    if 'cpus' in params:
+                        result += f"    CPUs: {params['cpus']} (-c)\n"
+                    if 'exit_threshold' in params:
+                        result += f"    Exit threshold: {params['exit_threshold']} (-E)\n"
+                    if 'dma_latency' in params:
+                        result += f"    DMA latency: {params['dma_latency']} (--dma-latency)\n"
+                    if 'duration' in params:
+                        result += f"    Duration: {params['duration']} (-D)\n"
+                    if 'unit' in params:
+                        result += f"    Unit: {params['unit']}\n"
+                    if 'summary' in params:
+                        result += f"    Summary: {params['summary']}\n"
+                    if 'auto_analysis' in params:
+                        result += f"    Auto-analysis: {params['auto_analysis']}\n"
+                result += "\n"
 
                 stats = cyclictest.find(".//statistics")
                 if stats is not None:
-- 
2.55.0

