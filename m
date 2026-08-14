Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E37E3EB0E6
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745486; cv=none; b=V3+Hyue1Stb76xtWktUMsJfR85gm9gmB1Uz+P2pLN3OXcQ7xxQTozE1OMDq8vsTmGW+m8124ERbKG/4Q1kx4/bLNe44X9VR/jJfR3x71RiXzYNRY3u/TDZ5eRWuK4exFhb3hEleya4XgEZb1RBvTk4AcO6NzyS33aMqVRfrxxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745486; c=relaxed/simple;
	bh=5956DtGIxKIesW1r15Ot5zvGSpvuZhSWqNPj4bWalr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hq107dRHdwbbUJaGMPd1kqYGJC8xTSNLfvsH5aUuCnGOJo+YpAqgRpSfn4ut8g8teQHg8pozL0/9A6oVSzB80cH3vkvQSKzUFwp/rf49A+RXOEsVLLvcAKskO0zfGaMzfLWkI02CPKq6XwzwBPF3D4GYbSyyK0KEuf6SxujeW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk1rqMqi; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk1rqMqi"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so7622946d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745474; x=1787350274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpL6+iTgN3ZlZtZZEf+yiAvYoXTS4R5gzJACD7xQjgA=;
        b=lk1rqMqiWS2yMrQTovNnippIPqwTbScoXd5Rm0iAUAOKhEmPxuEd51QhcZFmM6qBhe
         eemJ6GkEZ2NuM07Zyo+YfdDn2a9jlzWb5H8T82sixYwDB0zP3iGjY+DgnD8Fs7HpzqLs
         LY5ZISqbF6+ys4hdUkpxAOrI7G47ABBEi2CxULeue0WKLWDpKevtgZlwDD9ySnfihgfk
         o8ytZnWo6RrxAS/21RY+T6ZZGJfr2CaH1ssISb0yRFEZxMhiqGenmf7QOCCNjZaVLMmk
         NGfVH5IMX9PczfDOvjzElC6Q05MvSRWOpMAqcsbeW28i081+A8OWpA17Hdwkbo/k6ciC
         8fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745474; x=1787350274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lpL6+iTgN3ZlZtZZEf+yiAvYoXTS4R5gzJACD7xQjgA=;
        b=bpXDEN1qenQwRlEjJ8oogZekwbQYoS/gSWZ0VH+ifja+2i2Ur/NOr7/tFBvkDsoGN3
         CcgZ7vz+cROb942dsEskX4Q3JFUvTVbhRLSd06mrYYc0OxgoYmNzqYlaVnSu46a0FaoR
         Z7fi23sSVZ3O9ocS7Z4QRNV8nwYtdPiDKmXGG/eNs22boBUMuT75eoqi1ebf5NWPhbR+
         VzCZFgF6cFA2cpW5KEGS+31SopEEM6gNYF9OGFKZowDZleK6MieaFTuLv5AQsW6hXjH+
         OB+3H+LzgKJ62xsf2ex1N+1TDsuDmkGaf5giWprkHlYVgg52Bo3/xnnqLT3sGe5Z1iCk
         4T2Q==
X-Gm-Message-State: AOJu0Yzdfr1biqEvglkEDdpqC5uC2k/owym1eYe13lJgfrLeV9Uk5JST
	Rf4PgDiYKZ2o1YNigKx3ilXNOI5x2J63CYG668xD51kl3M7WiVECcqNCEGOVtA==
X-Gm-Gg: AR+sD13YJ2GNMoMRel/WXs5ivoFThpLRUVKZRm+DbFBR0qNyLzc/5eX8nm7tiNx3a/0
	VIrWV08RRBp98UoByaIU6kRbQYcNc1GEGRMjQTkHc+BVcscNw5qvsKwXI2zlccgTjJGMbURm1TW
	pc6Rjy18OKHhiBi9fq4AJbNxpDZoGOKXGfdzrP0hir0fS9lHNzflLDGzZn57lOw2oKS9mWYzrJN
	lmPnixP77sy3oMXlAcEDhaYOW1iLTnx8xEszaBAiWyEke+RUf7YEEpb2dz2pgTaKJiLWEUHQH6o
	m4Cznterg7rDAIsyEnsN8rPqYFf+KcXdJMPm1C9cQ1KSeWfGUgTbMNnB8oJk/DADcuXG2L0L/rd
	PKD2OzuC3veGsOAoKQUzstGquoxxPjWdNzImgKb6HEJVtQUJA01OrvkvGGslf2IUxP1OQJxG1ry
	auLd3aPNCWNDrb9u1Rx7lnf3PBNnUe27hpdq5F2TCfeh0VdiYfvMYOe4yPxPVeiFLyXfD4Liwaf
	TqRj8NbgzLMsK+myiw+3hxZ2QtGdJ54cCK6BTm52BYzAgq+K5jnZis6qhPldPpuUQ==
X-Received: by 2002:a05:6214:3d10:b0:8f3:13e4:739d with SMTP id 6a1803df08f44-90a91c5c304mr119578396d6.7.1786745474122;
        Fri, 14 Aug 2026 15:11:14 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 18/23] mcp-server: Rename server from rteval to rteval-mcp
Date: Fri, 14 Aug 2026 18:10:17 -0400
Message-ID: <20260814221027.213574-19-jkacur@redhat.com>
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

Rename the MCP server name from "rteval" to "rteval-mcp" to avoid
naming conflicts and follow MCP server naming conventions.

This updates:
- Server name in .mcp.json configuration
- Plugin metadata in manifest.json and plugin.json
- Tool prefix documentation in README (from mcp__plugin_rteval-mcp_rteval__
  to mcp__rteval-mcp__)

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .mcp.json                             | 7 +++----
 mcp-server/.claude-plugin/plugin.json | 2 +-
 mcp-server/README.md                  | 2 +-
 mcp-server/manifest.json              | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/.mcp.json b/.mcp.json
index a4d5fc706f88..5e1a5d789c9b 100644
--- a/.mcp.json
+++ b/.mcp.json
@@ -1,11 +1,10 @@
 {
   "mcpServers": {
-    "rteval": {
+    "rteval-mcp": {
       "command": "python3",
       "args": [
         "/home/jkacur/src/rteval/mcp-server/server.py"
-      ],
-      "env": {}
+      ]
     }
   }
-}
+}
\ No newline at end of file
diff --git a/mcp-server/.claude-plugin/plugin.json b/mcp-server/.claude-plugin/plugin.json
index b81b49851703..c3469c048524 100644
--- a/mcp-server/.claude-plugin/plugin.json
+++ b/mcp-server/.claude-plugin/plugin.json
@@ -9,7 +9,7 @@
   "license": "GPL-2.0",
   "keywords": ["rteval", "real-time", "latency", "testing", "timerlat", "cyclictest"],
   "mcpServers": {
-    "rteval": {
+    "rteval-mcp": {
       "command": "python3",
       "args": [
         "/home/jkacur/src/rteval/mcp-server/server.py"
diff --git a/mcp-server/README.md b/mcp-server/README.md
index ce4cfdda4781..81252964f1eb 100644
--- a/mcp-server/README.md
+++ b/mcp-server/README.md
@@ -71,7 +71,7 @@ The server is configured as a Claude Code plugin. After installation:
 1. The server is registered in `~/.claude/plugins/installed_plugins.json`
 2. Enabled in `~/.claude/settings.json`
 3. Restart Claude Code to load the plugin
-4. Tools will be available with the prefix: `mcp__plugin_rteval-mcp_rteval__`
+4. Tools will be available with the prefix: `mcp__rteval-mcp__`
 
 Example queries:
 ```
diff --git a/mcp-server/manifest.json b/mcp-server/manifest.json
index e187ef0a9149..6127dcd26774 100644
--- a/mcp-server/manifest.json
+++ b/mcp-server/manifest.json
@@ -1,6 +1,6 @@
 {
   "manifest_version": "0.2",
-  "name": "rteval",
+  "name": "rteval-mcp",
   "version": "0.1.0",
   "description": "rteval test results analysis - query and compare real-time evaluation test results",
   "author": {
-- 
2.55.0

