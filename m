Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E93F12C2
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745484; cv=none; b=n+c8qgP8uAHm940WR7yX7Z+TwP94+56s9vf/nVkssgNr8yH/j+ojMp26NGZ4Jq3UFgSHLDWVGoDsCNnNgzncM5fc5vdbqHcFoBCO6nXj/AVGRF7SazEBjANvKF8SSswhiJW4paCxp83vFuPtKv8I5eJI1AGdAravAZqNoQZF5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745484; c=relaxed/simple;
	bh=1Ci6fgAhoKjHqqePC6wwHBg99xpWbbcOFt2yMWxoC6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOKP7B2CH6Kume8ul7ATL9/4gq6VyKRcb0E9CuD0JPmqic/jG2LAvqbJ+ZJu5nYQKeBbjYUdTYGEpmoBmcZnvso6/fyn8CTR3eUt04oez4DoJPD0hXK+N83S9WnbrV/ZFLb4fEbNdQCt+JK80j5Den3K0q6SfpH+5SafYIiZsTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+E3VVri; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+E3VVri"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c149c5722so10411971cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745482; x=1787350282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qDLwMRPupKo0rcUN+C7xQXr1LRxUR0f4BCbKPxoZSc=;
        b=G+E3VVriggX/NPwunzCdp0LEvaFcMMi42Xiu44AnCbYDtIBGSwQP0QsDCuHs5485Y7
         mBq4069iIDKc0A3tcQ+n7VBThvJmaJvHmtk5mjdeyGhU3vbIuc1KDt8gHDKBfu+SaDXQ
         E54VXXqpB23kjkTkIsHa8q5WpxTpfeyBKLQCWpYU0e3d0Hiy/0JoMgCfBhvfgyNto5q7
         JA2hVj/HV0UPcxgBua8FS3S27iv+wEDIJBHc8oIVvKrIvGoJ8CjisoyqLktHd9lt91V3
         XvNfWc66s2rkunD5wHCOOznnCL58z/iKaCDHZhnV5/1WlSghVf0BuOSfE0AC14gqxp6+
         VeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745482; x=1787350282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2qDLwMRPupKo0rcUN+C7xQXr1LRxUR0f4BCbKPxoZSc=;
        b=BYzMePMSljbgdQJM1NgxaEG3Efsnx0jzlEd9KMHHBW1n7rZfPTDUhSzCY0WleLUzXw
         yNESrhQI2x6VdpD9fyaMLoGra3WvZkS2j0F2GanUEIMDcd9FFtpxHyKMR0zc4efOIJKB
         mvrgeT1XecPo8cJKbXsQkEYhW/c4nnlJllBAMZ2/oCTWR69FGj0S33kB49vVGDbAYW+G
         hii7cOZEktZ2+cjr49RoxzKJIwClQVddEuZOxlNTY64jztBaaNtg0+epSI1jS0g2UHyD
         IG7xqwMbQymKktVij0RzKpPWdDBTRM7sBZe00ZFN1ff5LQpDmfGO3kFrdagMbVoccCLw
         KFiQ==
X-Gm-Message-State: AOJu0Yw1x8M4fUTOiSCoilr1J8VjVFapMmKDN4KumAErge4hRNWFwNf8
	T78O7hWWZ4po8J69HzlktP1nJ4ARUXbcvuIgXL4bKGdd3blXHFeKp2k5EccksA==
X-Gm-Gg: AR+sD121P2gIoceekf2ElmUGV96A6ffH0sUqHcm+h6h05aGK82XG3pETph/9raDPaqg
	KrRzADpibBkp4ZCF4BOWJ/PGSd87ezeemRhTTtWo2cO6EcBK73328npaGuFJWyqaR3FFo+YGVzs
	mg0iS3nm3Sx+ghUVpTynWokPAwsyPdDdOEa43j8DoQUN/d5p5dlANEkkL7n3TEZadzwtk4DOaWU
	w/iY/cq0sfIs/5GwVp2F8moX5IpPhFrel8MOywoMGw7l4/QGvRbQsVhdGkDpaV21TswGwTyoYHr
	OsxBUs1BQPVUA8aGgRxd/iUPsVgQ6y0fTYrDziJIUi/9hv6BQRIM5FVpjpJvJAzm1LdsjgxQs8G
	B1lxnsTXx7bUVFoxRgVk4hfL5ZY3Fc2rnikVZhNAqp/WcVsYYj+NVUcahHI8m9R3xcWHYRyxnuh
	0Xee9coJayS4pHfhY+j43n294Kyw8VkF4/mrYlNjZB3a5ZxmmQlraKfm83q6hIios+JFtzuP1hg
	E5jyo1ot3VSF5Qtr6YKSIFF4DJTVdZonR/zhD/YM7EDOQA2rRLFQNM=
X-Received: by 2002:ac8:5f95:0:b0:52d:6f91:86e with SMTP id d75a77b69052e-52d74b6c8c2mr173591441cf.15.1786745481689;
        Fri, 14 Aug 2026 15:11:21 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:21 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 23/23] mcp-server: Use relative path in .mcp.json and add example for installation
Date: Fri, 14 Aug 2026 18:10:22 -0400
Message-ID: <20260814221027.213574-24-jkacur@redhat.com>
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

Change .mcp.json to use a relative path (./rteval_mcp/rteval-mcp-server)
instead of an absolute path. This allows developers to work from any git
checkout location without hardcoded paths.

Add mcp.json.example for packagers and system installations. This file
documents how to configure the MCP server when rteval-mcp-server is
installed to a system path like /usr/bin. Packagers can install this
example to /usr/share/doc/rteval/ or similar location.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .mcp.json        |  5 +----
 mcp.json.example | 11 +++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 mcp.json.example

diff --git a/.mcp.json b/.mcp.json
index 5e1a5d789c9b..5fe18084cf68 100644
--- a/.mcp.json
+++ b/.mcp.json
@@ -1,10 +1,7 @@
 {
   "mcpServers": {
     "rteval-mcp": {
-      "command": "python3",
-      "args": [
-        "/home/jkacur/src/rteval/mcp-server/server.py"
-      ]
+      "command": "./rteval_mcp/rteval-mcp-server"
     }
   }
 }
\ No newline at end of file
diff --git a/mcp.json.example b/mcp.json.example
new file mode 100644
index 000000000000..093188fc323c
--- /dev/null
+++ b/mcp.json.example
@@ -0,0 +1,11 @@
+{
+  "_comment": "Example MCP server configuration for rteval-mcp",
+  "_installation": "When rteval is installed system-wide, this file should be copied to ~/.config/mcp/mcp.json or merged with existing MCP configuration",
+  "_usage": "The rteval-mcp-server command will be installed to /usr/bin or a similar system path",
+
+  "mcpServers": {
+    "rteval-mcp": {
+      "command": "rteval-mcp-server"
+    }
+  }
+}
-- 
2.55.0

