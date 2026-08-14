Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169343F164C
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745478; cv=none; b=IbiC0OyOwJmPl47CUeijw8QnfEzFuLQO5lDjhmySS9baCRjzyLPaOy0qOmoFjITO4vNtk3Wa3TvwmgMt0xUMP407wq6AcRLqJGgIshXTykCQH9iCyturOLNBRCs+INNjedl//9gdRrnVgDI2tuaESOmhq5UiEWJ6byErNmLtR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745478; c=relaxed/simple;
	bh=iHY73mO32iD6lxc/vFDwB4+MJRlMtN1pU3tt0mc/bFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEgyaCo4MiGbLYbTCKwv96nB/VgBK9gQVy37SO7CSR3TuyMQwLjj9dw4Ye1nA0DPwbHTqJREwFzDX3mjtGGKM8WolF/daGkBAjECxzRKR5wZVLCKX/JxgBaTIxV7vCz8J7HDHGDD1Ncwxrv6WRaSNFbWhPFpfmQvhukhrxrxziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvyPrV1K; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvyPrV1K"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f032b47e3cso8346806d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745476; x=1787350276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=762JhbEnBcVcrAmSt4vNdhoZ3vGt7UGXtX8ChqhxTr8=;
        b=QvyPrV1KVFtLlf3mD0tc3Wrd8uNsiiycda1mLUPI6Xc3vddK134Q7cv6TTVnWJfcuP
         pLLMsM2qgWA0O75L1+pBlBX1h4mUF1ayO2a9PexH1ZHaBAh6crEJHcafz/85Qb1mUP5Q
         MUuRiNsd9ooAdBf4DZe49P0ql7A28OLF9HaS/aFUSpUVpYeljEK5t7VbBBNinu+jC0kg
         BoM2K3adf+AVc0QZ2gFT+XfTn6dUhEnswSldaID39AnyPwfNJj1a8nCyXs3jOD84PVdI
         1LXFWkyJV/F2fLRVMis+qOQzcRO/KDznIkGuCoQIxWpiTAU6oQJeHIZQVhPgtycqnDuJ
         nNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745476; x=1787350276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=762JhbEnBcVcrAmSt4vNdhoZ3vGt7UGXtX8ChqhxTr8=;
        b=Eid7llrq9JUicSkZvTa/GfjUU5CsHIWfFykQRrJxrNeB9OuhbNrRTgzKHME/lgqVJV
         pAM4mAo7YM1E6yl+sQiomoHxIrcvFB4xLpLx2R9nkRyiALfAfaxl+FtAf0ciFgiMvQKO
         ojc/lYlxlP1v3g8HsyjvqjonQfQAaqfsDD8+V0wGJfksLUNlc0IMz10BXHNeeAmAY6CU
         3+eQFQp7BkOWnytirlMEjQi9qxPo7MdJ5tOgD1NmTARjgaQufYmg1J7oLUSBIo1hLTSm
         fSqoa/ZDC0tGkkFoCLrxlnB3mSZfYYkExNrLCLKYuu1OLNZxdYyvrTAlJvFJMiMs0YAn
         ZRug==
X-Gm-Message-State: AOJu0Yxo3P9BoYqKAYgQy9O4D5Qa2q/8DDR1b+t5s2uxSwAB/m5fMvFN
	Y9ArUCSUH1W78d2Huov7srLCXU4/2kOo+7s/bi7caA9dEOr6s29w/he+jZNbTw==
X-Gm-Gg: AR+sD12o1Zw+dx3Sj1w4wjnDLmE+9/a/cA5CuEUgP3Wg76Lc4O15UWC5tsuQ9rO9GQA
	kdzIUOTy9nBAzQCiK8O5GjmHlJ4licb7fTMHq4FS377+yW3jNqHTpnh29qlpGnnj+mL8EBjubOb
	7OfM84Jf45sBk2GedC1w5MouvOvSl+Xi1rrUyJS0Z/jecfUTEIGAZhq46fW9mMNJga3w9p3oa8/
	6+ds/blLBbGlbBHmr61Ej9yUSZIZ2xofNRqOHuXr4ZmV3KhXwCzzT7HqTSq7GETe5+XiqvUWJFC
	T8C7CXIj0+3tsSBpkQquhGw+gDR3W3CWKCEbiw2Y7M8sgkVuCa8BFHr/1rUWPqAMZXcrghgO7sO
	/hgKbBjtBGUmBlroN1pP8hGspq6YS3EN5YSCKtgj7Njelmp24JMpB7tBESkIFxr4Tdep7DPVO1w
	yAIuEZnJ5dAcmUy3rlrVQYC8Z5VW7gudmWn0Jd7BZ+igKlJcoeRhp3g6X99PWujJpqaxtdjl9tz
	Yb0/fgRj0k4HaXpCbF6UtDwOE92XvpKYKk63gQG+X2JEaqLP0Xx4MlH9Z9lhupRNQ==
X-Received: by 2002:a05:6214:509e:b0:908:7fb7:70a8 with SMTP id 6a1803df08f44-90a91cfcdf0mr110511126d6.7.1786745476031;
        Fri, 14 Aug 2026 15:11:16 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:15 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 19/23] mcp-server: Add GPL-2.0-or-later license headers to all files
Date: Fri, 14 Aug 2026 18:10:18 -0400
Message-ID: <20260814221027.213574-20-jkacur@redhat.com>
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

Add SPDX license identifiers and copyright notices to ensure GPL
compatibility with the rest of rteval. The MCP server code is part of
rteval and must be licensed under GPL-2.0-or-later to be compatible
with the main project.

Changes:
- Add GPL-2.0-or-later SPDX identifier to all Python files
- Add copyright notice: Copyright 2026 John Kacur <jkacur@redhat.com>
- Add UTF-8 encoding declaration to all Python files
- Add License section to README.md with GPL boilerplate

All files now follow the same licensing pattern as the rest of rteval,
with proper SPDX identifiers in the header comments.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/DEPENDENCIES.md               |  8 ++++++++
 mcp-server/README.md                     | 11 +++++++++++
 mcp-server/server.py                     |  7 +++++++
 mcp-server/tests/test_histogram.py       |  7 +++++++
 mcp-server/tests/test_mcp_integration.py |  7 +++++++
 mcp-server/tests/test_new_tools.py       |  7 +++++++
 mcp-server/tests/test_per_cpu_stats.py   |  7 +++++++
 7 files changed, 54 insertions(+)

diff --git a/mcp-server/DEPENDENCIES.md b/mcp-server/DEPENDENCIES.md
index e139bd7df718..d8501916d628 100644
--- a/mcp-server/DEPENDENCIES.md
+++ b/mcp-server/DEPENDENCIES.md
@@ -1,3 +1,11 @@
+<!--
+SPDX-License-Identifier: GPL-2.0-or-later
+
+rteval MCP Server - Dependencies
+
+Copyright 2026 John Kacur <jkacur@redhat.com>
+-->
+
 # Dependencies
 
 ## Fedora Packages
diff --git a/mcp-server/README.md b/mcp-server/README.md
index 81252964f1eb..6d6a9eb257dd 100644
--- a/mcp-server/README.md
+++ b/mcp-server/README.md
@@ -2,6 +2,17 @@
 
 An MCP (Model Context Protocol) server for querying and analyzing rteval test results.
 
+## License
+
+SPDX-License-Identifier: GPL-2.0-or-later
+
+Copyright 2026 John Kacur <jkacur@redhat.com>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
 ## Purpose
 
 This MCP server provides tools to:
diff --git a/mcp-server/server.py b/mcp-server/server.py
index 8fbe7836facd..7a4c4f598af1 100755
--- a/mcp-server/server.py
+++ b/mcp-server/server.py
@@ -1,4 +1,11 @@
 #!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   rteval MCP Server - tools for analyzing rteval results
+#
+#   Copyright 2026   John Kacur <jkacur@redhat.com>
+#
 """
 rteval MCP Server
 
diff --git a/mcp-server/tests/test_histogram.py b/mcp-server/tests/test_histogram.py
index a7e47c3cd2d0..917afb1aac93 100644
--- a/mcp-server/tests/test_histogram.py
+++ b/mcp-server/tests/test_histogram.py
@@ -1,4 +1,11 @@
 #!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   rteval MCP Server tests - histogram and percentile tools
+#
+#   Copyright 2026   John Kacur <jkacur@redhat.com>
+#
 """
 Test script for histogram extraction and percentile calculation.
 """
diff --git a/mcp-server/tests/test_mcp_integration.py b/mcp-server/tests/test_mcp_integration.py
index 7f137b81d51b..0b5f2954a16f 100644
--- a/mcp-server/tests/test_mcp_integration.py
+++ b/mcp-server/tests/test_mcp_integration.py
@@ -1,4 +1,11 @@
 #!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   rteval MCP Server tests - integration tests
+#
+#   Copyright 2026   John Kacur <jkacur@redhat.com>
+#
 """Integration tests for rteval MCP server.
 
 Tests the MCP server tools through the actual MCP interface,
diff --git a/mcp-server/tests/test_new_tools.py b/mcp-server/tests/test_new_tools.py
index cc6456960785..a81b23bbffbb 100644
--- a/mcp-server/tests/test_new_tools.py
+++ b/mcp-server/tests/test_new_tools.py
@@ -1,4 +1,11 @@
 #!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   rteval MCP Server tests - query/filter tools
+#
+#   Copyright 2026   John Kacur <jkacur@redhat.com>
+#
 """Test the new query/filter tools."""
 
 import sys
diff --git a/mcp-server/tests/test_per_cpu_stats.py b/mcp-server/tests/test_per_cpu_stats.py
index 673cc89f0b08..6ec07dbf39fe 100644
--- a/mcp-server/tests/test_per_cpu_stats.py
+++ b/mcp-server/tests/test_per_cpu_stats.py
@@ -1,4 +1,11 @@
 #!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   rteval MCP Server tests - per-CPU statistics
+#
+#   Copyright 2026   John Kacur <jkacur@redhat.com>
+#
 """Test the get_per_cpu_stats tool."""
 
 import sys
-- 
2.55.0

