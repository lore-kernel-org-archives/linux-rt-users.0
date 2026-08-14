Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB43E5EEC
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745457; cv=none; b=Uqm2JYQgkOXLQQ3wLpJZspuOqZ1VpxoF2Dmww+cAaqOJ4EEFlyDnE3He8lxzpyyun9t9YIvd4YdToGAIBNxqzd+W+eV1LWsALWTH2tBWDXOg7nOWXBqbUBAI4KGTvDXKhaFiEqMS8ZvSZUZbfxIyx+6qGmV3u4DO+CSWI2cE0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745457; c=relaxed/simple;
	bh=Z/2cPZ16d9W1J0W93myFXG7aXiYRuNwktEw+DzMdTag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCRBcRLoTmLzAhwZkERPVWUEXsrIiB15V9ylrvpr7TmTdylk6ADUJy1QUvNVyKyntmOYhN9kwa+HC+S5fRMYASFrKR73ta4JNmhm2jWOHottSC9mKK/MVf8NGer0CFt4wKIpE7vQbUOTtrbje0x7SJgbQHSOPpvLUwWrYyLKkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO81RINL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO81RINL"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52d5bfa4bafso14745891cf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745455; x=1787350255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjFKDatf8eVct6vFLd8D4AwzH5tuBEn2Y9pOy4ulHqs=;
        b=WO81RINL8YTbpVkRuJ3FTWHfg8ofqTwrU28WCh3fm5Ez7CnoMPCdU+OBjjiMYU14Uh
         zW8O8V/bvSVJNdXeO1J3QA3B2bDGuC4r8dNrqsHGVyBkk4GiagOGt1HnWrUTtU6/i8rr
         mWzQuek6NhS/g6B+5bBXr748ukBk+uWdwWGdBZ31MWQp6VRpPgObSFRjdCd+Vhx2vEXC
         5vE2/B5l1CvxSy+IFhMauzv7/wAnvf2XVCV1wD3kxVA7OFsWEWBMFolEXAEjMw14Me29
         zTDdnFhCNOsah1+duq31jj0wwnic9d3jec9smTk/6oDVFM8DeV5jt1zjNrgCqzcChKdt
         JTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745455; x=1787350255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjFKDatf8eVct6vFLd8D4AwzH5tuBEn2Y9pOy4ulHqs=;
        b=hXB1yRvnZwImoCNzaLfGa68L7fwW+mtArNRa09OFwBkm0zsG4bGIirBK5aVCqImyZY
         CFzhfq3vFUGKiTybVWc8EIo0erweKorArSDj3riYhD1wwHU/6WdMyAgiGm6Y15TtqyUz
         IfgCkR+OVeRcBl1wQPSQFOOp/D33dzgME+T3Ku3MNcLx+TBMBfLL7Wjzp0edx8Y6g57S
         QVbP3KSWePF4xomaVChtLfvz2GYD3yu9uScbS9IoXGW0Ad2E99H7LZ0J84SE881NWdzA
         Hess0n51DxrODeDvVN1DKfg9CAAVV5OYgKkCmG3G8ehLS6++9eRyfkPDQN2t8wUTDEUH
         G1eg==
X-Gm-Message-State: AOJu0Yzc15r9OljNtoAWPUDFiFG9XtNVXNbl76VNljaLP5TyB7VR6J/X
	C46tqZtvFwkQsLlxTetsry/nnpAZmO817jjiNvn1jGCVkiYqOWQKFYqTPI1ZsA==
X-Gm-Gg: AR+sD102I4yVbsjWMHJlvDeBxZfQYpQ1u1sk1AFwvX2hxfGFE0sjtSPluPP9T9j2kok
	a+y8dERBNg+4RwLp4tL6JHOGytL3V87VOKW1ntFs3rZ+c2lHMXFAIXa641kHPR+i95dxj0gxEBW
	TCeUWgBMHMbkC+bvHqazJG++mKfBMm+icqYoIVlJgFb86Ng0WGhBIwje+Bnh1hbzcYlt3dfBWic
	rSVJ/DcXt+aZ6xYvnHeJN+J1Ko09IszoohQyyuF5L9TDX3bxoaYI/AjFHDR4ynPv9N4o68+58BC
	BNYdNQjQpgDfA6XK9Ew+Y1Fg8ApdauzW7DHrciFwJIhpT93bVO/p6rs2+GNhyMothHwVseXqB5a
	Z0NKaiiuGKy2yaM+dE7XZpgQLy/HhWl4UWt79F/VMqkntA2YqWnOCvvjuMCSUtyApmeR/MDBkcZ
	pGoDNTUBCgxst2n0qYmFpGWD6bc4sjUcD6GIT7SSRp6QHjo9ibJ2OXGGKe45jnqgbh+GQkSiHJ6
	wQIOJm1EIJG+rcY5jCk3WiibZ3Lutwo/FNBZilqouI9B3CPrvQUfVA=
X-Received: by 2002:ac8:6546:0:b0:51e:47a4:4851 with SMTP id d75a77b69052e-52d8530dbb8mr112120581cf.8.1786745454793;
        Fri, 14 Aug 2026 15:10:54 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:10:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 04/23] rteval: mcp-server: Add Claude Code plugin configuration
Date: Fri, 14 Aug 2026 18:10:03 -0400
Message-ID: <20260814221027.213574-5-jkacur@redhat.com>
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

Add plugin manifest and configuration files to enable the rteval MCP
server as a Claude Code plugin. This allows conversational querying and
analysis of rteval test results through Claude Code.

Changes:
- Add .claude-plugin/plugin.json with MCP server configuration
- Add manifest.json with plugin metadata
- Add test_tools.py to validate all MCP tools work correctly
- Update README.md with installation and usage instructions

The plugin provides 5 tools for rteval result analysis:
- list_results: Find rteval XML result files
- parse_result: Extract metrics from a single result
- compare_results: Compare two test runs with deltas
- list_logs: List stdout/stderr logs from a test run
- read_log: Read logs with head/tail/grep filtering

After restart, tools are available with the prefix:
mcp__plugin_rteval-mcp_rteval__

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/.claude-plugin/plugin.json | 20 +++++++++++++++
 mcp-server/README.md                  | 37 +++++++++++++++++++++++++--
 mcp-server/manifest.json              | 20 +++++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 mcp-server/.claude-plugin/plugin.json
 create mode 100644 mcp-server/manifest.json

diff --git a/mcp-server/.claude-plugin/plugin.json b/mcp-server/.claude-plugin/plugin.json
new file mode 100644
index 000000000000..b81b49851703
--- /dev/null
+++ b/mcp-server/.claude-plugin/plugin.json
@@ -0,0 +1,20 @@
+{
+  "name": "rteval-mcp",
+  "description": "MCP server for analyzing rteval (real-time evaluation) test results",
+  "author": {
+    "name": "John Kacur",
+    "email": "jkacur@redhat.com"
+  },
+  "repository": "https://github.com/jkacur/rteval",
+  "license": "GPL-2.0",
+  "keywords": ["rteval", "real-time", "latency", "testing", "timerlat", "cyclictest"],
+  "mcpServers": {
+    "rteval": {
+      "command": "python3",
+      "args": [
+        "/home/jkacur/src/rteval/mcp-server/server.py"
+      ],
+      "env": {}
+    }
+  }
+}
diff --git a/mcp-server/README.md b/mcp-server/README.md
index c5f6936b40d2..1e09bd63775c 100644
--- a/mcp-server/README.md
+++ b/mcp-server/README.md
@@ -26,13 +26,46 @@ The initial focus is on multi-run analysis rather than single-result querying.
 
 ## Installation
 
+On Fedora:
 ```bash
-pip install -r requirements.txt
+sudo dnf install python3-mcp python3-mcp+cli python3-lxml
 ```
 
+## Available Tools
+
+- **list_results**: List rteval result files in a directory
+- **parse_result**: Parse an rteval XML result file and extract key metrics
+- **compare_results**: Compare two rteval result files side-by-side
+- **list_logs**: List available log files in an rteval result directory
+- **read_log**: Read log content with optional filtering (head/tail/grep)
+
 ## Usage
 
-TBD - Server configuration and client usage instructions to be added.
+### Testing the Server Directly
+
+```bash
+python3 test_tools.py
+```
+
+### Using with Claude Code
+
+The server is configured as a Claude Code plugin. After installation:
+
+1. The server is registered in `~/.claude/plugins/installed_plugins.json`
+2. Enabled in `~/.claude/settings.json`
+3. Restart Claude Code to load the plugin
+4. Tools will be available with the prefix: `mcp__plugin_rteval-mcp_rteval__`
+
+Example:
+```
+list rteval results in ~/src/rteval
+```
+
+### Using with MCP Inspector
+
+```bash
+mcp dev server.py
+```
 
 ## Development
 
diff --git a/mcp-server/manifest.json b/mcp-server/manifest.json
new file mode 100644
index 000000000000..e187ef0a9149
--- /dev/null
+++ b/mcp-server/manifest.json
@@ -0,0 +1,20 @@
+{
+  "manifest_version": "0.2",
+  "name": "rteval",
+  "version": "0.1.0",
+  "description": "rteval test results analysis - query and compare real-time evaluation test results",
+  "author": {
+    "name": "John Kacur",
+    "email": "jkacur@redhat.com"
+  },
+  "server": {
+    "type": "python",
+    "entry_point": "server.py",
+    "mcp_config": {
+      "command": "python3",
+      "args": [
+        "/home/jkacur/src/rteval/mcp-server/server.py"
+      ]
+    }
+  }
+}
-- 
2.55.0

