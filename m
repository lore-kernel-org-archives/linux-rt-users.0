Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64C3E3C53
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745480; cv=none; b=Bhfp8ZKGlYBh4aJHERsaQKqiK7tJ70UwApaiHZk/Cmp0e8C5PTxD7YvjooQK4QWa/arQXCWb4fsTZ+0BAxeBWwdPoIx2ZcEDqtar7NLPxIjMMG0DS//W2xBK0COcGrXJzDlzdWo8wcRWBQhrNx95blMxCRBPcKOVlswNVka/y1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745480; c=relaxed/simple;
	bh=1J2dUiD4uNm4mf0Uln74/VfLGA3V5/Y7U/pMNTEYubg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftikwdZMHBZ0Wk+ddLSyHTmwHxks9z2z4h/gt4nXg7Aq+AZ9UJPZ+UJZVZQB7f//lU+H6jGsHMGdeu3onEVJQX1jy9SIoC+WyKqsrdPdFM4tEiqhpRGRsQQdVlOrjQZ7jo3pt23UYmsWkhIG4Z7nN0Mm3iUilJ+IgXFpYT0yn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcnr/rAH; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcnr/rAH"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90a80860d35so13406266d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745477; x=1787350277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFRYMNJl8I11yZ/MoTDarFWzkTy/IqoXeUPem8xWlo0=;
        b=mcnr/rAHUrL0qNhxU1wVDz7wKpzgcjNPv6CDljHjc1jgTqnYZuATXVGOGpC4UtUPtc
         BLis7P34iP6AfNPE+Irn0iNqobuZOpvsBd9hRwKipjIyRSZe1qo4+P7AKlbRaKAtPm4P
         +hLImnlfKPx46vnEL7R9O6wRCvxkaNAQNJziNEUw5l2s3vYtUgHnLXHptEgMnFovVNoL
         ROAoaZ53TBVLhEa1QPxDZxEbm/gABeuLA3Tm7tuWkorkvsgfs5lDQd5h1m65gWN7A9Fc
         vugQ8XIdY+pB2XusE6jTIDUlsxu2DxiI+6G/VBFrtK9BwRT/ld3WaFuII9X0pMjW02Up
         phhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745477; x=1787350277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFRYMNJl8I11yZ/MoTDarFWzkTy/IqoXeUPem8xWlo0=;
        b=C6F37H57T8OyPXUDa57ixP/fKFgdrdnCnd60U4N93N/t6DntMY+eA4RCDn2mXmO+I+
         WNeLE9M5u9YBwpAszPUEdqUGgvrE38+Sq5WTLnHoTLXbAgw9N8MMgv03dG7trU1Q4rIb
         BKt+SQ1/ycJJU8GzaBXdK8kMGSz3pA+9IzXZRHA8iPJQudat/HfNVhgbPBjwjEM5fpGq
         IGnD3ab9Vza8j4LWrVFBSQQHFcQGSA8rhrh8/LvQBMbf7N6DEKlJ9Vnm1uD+Wj0DUOlw
         MQe+mocH9vWd6ExSz2iBiCmOdxybrfLAO1GHtt6sD1x11bu25XZTr2nk+1QPoGvy7br/
         ogbw==
X-Gm-Message-State: AOJu0YzcWnu+SXJWarhwPx+mQ12IYPZJiHf7KUtAlp8d/whKLloGHGQT
	3WxkRWXl9YLc7yNFbu8Ao91lEW/MsIlvHv2wzxRHCE7h3COJbXH0KAhLH5M7OQ==
X-Gm-Gg: AR+sD10vt/36g9ajCxrE7LUcgFlaHQRyB+NKtUBUJuWuwKmzOtwGmP8F+ZG0tKDPpAg
	aHyMDajFRDKBFrlV1D5HNmSkJwVGEcrGGbe7QNqA6OcOYgsN50/c212Ks8VvCyoMdh2Sr+WIN0l
	9hiNnA9YF9DiRiLo6kjPLGGA/00/XNqvWzhYjOM6QwfxaCgUGUCqXMi5kPZycsfJnwS5fsKBdmq
	k8zqLeDwpd5iTzAlvBqxbj+ZoID8J81wKAjAoG1jQUTMKCIDhd4ph4ihZQh719ukkOxvUoffI4Z
	J5cUCpferoTqvHfXv93IkBoA7xVLGxXMatijPJduI5zaDzxZ6fmq4RCOyMP1lkhLmLMHQn6MrTo
	8HR38+aRqUZZ8gaD5EzXIOlq9bLuTlABKmMqw4V+SSh2qTOcapgAvy7uBmfSar006OsSv7zFycZ
	ul0x106XEEW6Ji1E3UAOl4Rg5EVK37Qhuzu1lPR8u6OUiYr4h5ULHuNsRs5BVGqwipT0fIClIrI
	QGbR/Pt1QbpAlkA0xDIeiaD4wMpo6l7Srr+iSzP2lERz5nZB3h+Dmo=
X-Received: by 2002:a05:6214:1d2e:b0:90a:8c6d:fd1d with SMTP id 6a1803df08f44-90a91df905dmr107415476d6.30.1786745477029;
        Fri, 14 Aug 2026 15:11:17 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:16 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 20/23] mcp-server: Add Makefile for running tests
Date: Fri, 14 Aug 2026 18:10:19 -0400
Message-ID: <20260814221027.213574-21-jkacur@redhat.com>
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

Add a local Makefile in the mcp-server directory to simplify running
tests. This keeps the MCP server tests isolated since the MCP server
may be an optional package that not all users will have installed.

The Makefile provides:
- make test: Run all tests
- make test-new-tools: Query/filter tools tests
- make test-integration: MCP integration tests
- make test-histogram: Histogram extraction tests
- make test-per-cpu: Per-CPU statistics tests
- make help: Show available targets
- make clean: Clean Python cache files

Updated README.md to document the Makefile-based test workflow,
replacing the outdated reference to test_tools.py which no longer
exists.

The Makefile can be invoked from the mcp-server directory or from
the project root using: make -C mcp-server test

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/Makefile  | 51 ++++++++++++++++++++++++++++++++++++++++++++
 mcp-server/README.md | 21 ++++++++++++++++--
 2 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 mcp-server/Makefile

diff --git a/mcp-server/Makefile b/mcp-server/Makefile
new file mode 100644
index 000000000000..7f06dc85b9fc
--- /dev/null
+++ b/mcp-server/Makefile
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for rteval MCP Server tests
+#
+# Copyright 2026 John Kacur <jkacur@redhat.com>
+
+PYTHON := python3
+TEST_DIR := tests
+
+.PHONY: all help test test-new-tools test-integration test-histogram test-per-cpu clean
+
+all: test
+
+help:
+	@echo "rteval MCP Server - Test targets:"
+	@echo ""
+	@echo "  make                   - Run all tests (default)"
+	@echo "  make test              - Run all tests"
+	@echo "  make test-new-tools    - Run query/filter tools tests"
+	@echo "  make test-integration  - Run MCP integration tests"
+	@echo "  make test-histogram    - Run histogram extraction tests"
+	@echo "  make test-per-cpu      - Run per-CPU statistics tests"
+	@echo "  make clean             - Clean Python cache files"
+	@echo ""
+
+test: test-new-tools test-integration test-histogram test-per-cpu
+	@echo ""
+	@echo "All tests completed successfully"
+
+test-new-tools:
+	@echo "Running query/filter tools tests..."
+	@cd $(TEST_DIR) && $(PYTHON) test_new_tools.py
+
+test-integration:
+	@echo "Running MCP integration tests..."
+	@cd $(TEST_DIR) && $(PYTHON) test_mcp_integration.py
+
+test-histogram:
+	@echo "Running histogram extraction tests..."
+	@cd $(TEST_DIR) && $(PYTHON) test_histogram.py
+
+test-per-cpu:
+	@echo "Running per-CPU statistics tests..."
+	@cd $(TEST_DIR) && $(PYTHON) test_per_cpu_stats.py
+
+clean:
+	@echo "Cleaning Python cache files..."
+	@find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
+	@find . -type f -name '*.pyc' -delete
+	@find . -type f -name '*.pyo' -delete
+	@echo "Clean completed"
diff --git a/mcp-server/README.md b/mcp-server/README.md
index 6d6a9eb257dd..370aa0e9ca71 100644
--- a/mcp-server/README.md
+++ b/mcp-server/README.md
@@ -69,10 +69,27 @@ sudo dnf install python3-mcp python3-mcp+cli python3-lxml
 
 ## Usage
 
-### Testing the Server Directly
+### Testing the Server
+
+The MCP server includes a test suite to verify functionality:
 
 ```bash
-python3 test_tools.py
+cd mcp-server
+
+# Run all tests
+make test
+
+# Run individual test suites
+make test-new-tools      # Query/filter tools
+make test-integration    # MCP integration tests
+make test-histogram      # Histogram extraction
+make test-per-cpu        # Per-CPU statistics
+
+# Show available targets
+make help
+
+# Clean Python cache files
+make clean
 ```
 
 ### Using with Claude Code
-- 
2.55.0

