Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5D4344DA8
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836088; cv=none; b=uUt/SCxSyeVybAVO1dPDbv5Rj+4uPG5ZM5G0tGfHfJv5Th+a91zokrefmS/STnikI6Q1R19fmZVSej9V6XJDatmNydMBgmATbZdXB7Vj8JmJaFUoeoqB6sAnMnNafa227mh/E+RbJ63PaUw1BOXBKciXsDmKLc9bCcURELH3xWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836088; c=relaxed/simple;
	bh=bXQ2aS8PbwotF5mkW8zR1OLU4Bx2eP/PX4tjHVQ/tDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVRgyruOin6YZAA7xmNc7F/E0EydzsB0AHLikgECyPsARzsSzesVW68bS4oiD4abgzU+o9PTyjcdh04of1eohnzTuoxF6D/UWRG4DCO2pj9FwMyjkoIpWc6OBsguYQHq4pgtD+FySo14gn7CwUFVw1UbiavJ5uAcECmpH1GavAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJOPv1TO; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJOPv1TO"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-527e352a167so11902511cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836081; x=1785440881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l9PIq/TBMy+vdWfKO9VXC280Xa0G9tSaCJaTLShfUug=;
        b=kJOPv1TO9iiT0IEXfEZNIMdDLAW3eSHbZyBifWM1iokkY5zXqEVwwIfrcAdLVyZLxU
         qAMvoSNeuJpBeB9jrThJ64JpRlEHqX5r5To/JYz9IHSCrvh3lY7GYZS3I7PQGvqtkUQx
         3xV+4m7xinX6zfnM77GF94/ULLJ0C/n5xzqFYDT50TGvhYyk3I1rcRTMubljuQ8QnZ9R
         9hzmOilu9GTGbjOnxLJrVzluIf5zetc6UsQpdWZqmxIXOCIxQhrt/c7O6lpAIlwyFIs4
         2HlH0BBIbPT3+qCPhIkovP/67XJPdxi1TPBTCjqmUGJ3TJiNKJZjlR/paQV3QrJbq5we
         K4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836081; x=1785440881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l9PIq/TBMy+vdWfKO9VXC280Xa0G9tSaCJaTLShfUug=;
        b=XnNJ+8toZnA+xWYDFliOVfkKayOQaXvWCOwAQ/jsLfOzEQw2hSMq1OxK/irKlt58f6
         7YZPgQwEw6zYVHSXwg0lK/FTrpZnySb/b3ALpmNygL9/8hFpfuWAfNZfIO+TQep2/vwU
         k6bs9dBcw0FqQSviEf/wks1ZHHJcMYh3WbHj/QEIxWhvax7o+mjehoIzPZYbi8GhvQgi
         b2uoN8D1MihJLsC7FETu4XMvIOUJiz+snl30Xw5Os0SpllsoiiPrmKgF63IPIVukGMxr
         C1xqWH+y3RyP6CzlI7yGzsFozjH00UDKfqKLBZouRjEO7R+xnm5VyE1unxbu7l4C/9bz
         v6Kw==
X-Gm-Message-State: AOJu0YxECtvvDMyvAihck9rwcBKbK4Ou9r45c6HtDK1cZ6Evn8097ltw
	J+lE+7LJG+6Cof8DQxjLZcByArnkzfBr0hlvjxsORmz6TAVxvNPhzJ+gHyQn2Q==
X-Gm-Gg: AR+sD10nBD9TOySA4CKr+C8P1dvMfUAuXsMcyJLSWcRqxhG5HVX8AQFIuVuKXICQZGo
	/bZG3lXMdVxJEvEnVWzKri/PgJDnCeW9QNhljMQcrsPS8MNihjYEVLWVr+lyJ4Nn66kV1mR4s+A
	6Dw77wlJoDJ0NzJQ97s7bqkN8XlKOITYghNc42QZivNOQdBbmrq2BLBDfsls4BtxEjM446hgTQ/
	+Sn9sQ+sLencnrSvyI2KNwOV8NbCDpUIsDR2j1iTluLeL8CwQLbJ6asNgEmmOiQsARVnENw6eWA
	HLlE/bcwXQdnnTd91BWhN13l2iC/647YySTB9zEHtCwuHXTzphlekRsb1mK7EkJ4rf3rSi9x2gc
	eR8S8FZvDbH13fHQaPf20s7tt7ZBbkxA/CI3+fdk/KYEKqP/8Ct93HzK4dn5raVCP4fvbh/xNO/
	ZOAV+gxQ9fYT0JcWRRIRcQje1shfUYWn5uB5M5CLkX88US6jXIKACAuuNxxb+tMvJ0cD1tkazkG
	fe6HYeb+Q02OWCCkaNdxg64U++M2Ci9PzvLv4O7+dQmCkK4j8jdbQnmk4ki
X-Received: by 2002:a05:622a:5e8b:b0:51c:b98a:2448 with SMTP id d75a77b69052e-5283dd942ffmr39801731cf.9.1784836081515;
        Thu, 23 Jul 2026 12:48:01 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4f3b8sm41402321cf.9.2026.07.23.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:48:01 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 1/6] rteval: Change test file licenses from GPL-2.0-only to GPL-2.0-or-later
Date: Thu, 23 Jul 2026 15:47:45 -0400
Message-ID: <20260723194751.625088-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723194751.625088-1-jkacur@redhat.com>
References: <20260723194751.625088-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All test files were incorrectly marked as GPL-2.0-only when they should
be GPL-2.0-or-later to match the rest of the codebase. This makes the
licensing consistent across all rteval source files.

Updated files:
- tests/README.md
- tests/test_cpusetmanager.py
- tests/test_process_blocklist.py
- tests/unittest-legacy.py

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md                 | 2 +-
 tests/test_cpusetmanager.py     | 2 +-
 tests/test_process_blocklist.py | 2 +-
 tests/unittest-legacy.py        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index cac4f0e4021f..1a79cd3f578b 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -166,7 +166,7 @@ Create a new test file following this pattern:
 
 ```python
 #!/usr/bin/env python3
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright 2026 John Kacur <jkacur@redhat.com>
 """
 Description of what this test module tests.
diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
index 6501b9a022d4..984e0f900edf 100644
--- a/tests/test_cpusetmanager.py
+++ b/tests/test_cpusetmanager.py
@@ -1,5 +1,5 @@
 #!/usr/bin/env python3
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright 2026 John Kacur <jkacur@redhat.com>
 """
 Unit tests for rteval CpusetManager functionality.
diff --git a/tests/test_process_blocklist.py b/tests/test_process_blocklist.py
index a568ea74478f..3c528c9607df 100644
--- a/tests/test_process_blocklist.py
+++ b/tests/test_process_blocklist.py
@@ -1,5 +1,5 @@
 #!/usr/bin/env python3
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright 2026 John Kacur <jkacur@redhat.com>
 """
 Unit tests for process blocklist functionality in rteval.
diff --git a/tests/unittest-legacy.py b/tests/unittest-legacy.py
index 00811d7454ef..9e5ba3d0e831 100644
--- a/tests/unittest-legacy.py
+++ b/tests/unittest-legacy.py
@@ -1,5 +1,5 @@
 #!/usr/bin/env python3
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2010 Red Hat, Inc. All rights reserved.
 #
 # Author: David Sommerseth <davids@redhat.com>
-- 
2.55.0

