Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989643D9525
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165497; cv=none; b=UpNQVK2if3IoOa8gw0tsnQZgr6UnwxDwoWAL0cwQFbloDrNujLdM4syiWUB95NGD3tckdP/rh9VbjSJli+zCwyM15xYMVuI3yQw9pFuMiJOOOZw+G0hC/m3lLumlZvvXrMRKUdEUtKUnTI3FUrjbCpsFeeflxIZOMA8LehzA4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165497; c=relaxed/simple;
	bh=h22Auf8WiAyHsfqukMT9UQhq7AvLT4adggylllfeJDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0k3worlB8trJBtxP24IP57FhFyJYDBaAXTgTYDo5LBJhj8rRUTWa/xqAkM/ikXubafDqaxMBVsMGocrkgHvOAttbzOklKQJGpq+jsKgFLB/dx8mDwlr0L7++6s/ldNY3J1CrTz5VIHaPhfVAOpSSdR2fzyD5oWigf8a0aIurrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkaBWxvw; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkaBWxvw"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafddso26213885a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789165489; x=1789770289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MmL7fVPpsXf2twMWhXa/d/hMsXODW5P2PUFD8ofdboM=;
        b=GkaBWxvwJwUE6mgk/mj49lZxZX+kHAkEM6Tv/+ErfxRXdHDBOZDFTPQ+qDFc7eEbog
         gY2mpt1kQbo7rV9+SgC5KgRcfiX6nnIn1J4vmLy2mNhxfC/QJQkrElHNc+tgd3+UiLeQ
         Bj2ls3Zdps7LJI8A2Ud58wHTjKFlVpEQ8m4jjqCBhuX4h8rvHqVy36b6B1zLvV4Rb3jK
         dIOd3fMGcXErTR96BU1LTDbjlL2K+tpNIwGFj4JVx0G7kJtISIS+//JBQac0xmOEsBow
         8YO+0MRX6FJCo4tUZ/TC99wQgBCMKbcD+36831apbz+ePP2nUk0z+g9eB4TE417WhKJG
         EC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789165489; x=1789770289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmL7fVPpsXf2twMWhXa/d/hMsXODW5P2PUFD8ofdboM=;
        b=oVwo7Ffq7U8oHZEGs4aQowlnP7uM7Eos5ULeAz/pf/tOprgqfg/q0vbxeW/jyq+YXc
         U283wUFeGxy+mDV0CuOJ6EtmSStpvu+DL/8MkEraZmwOCcFd2355U+9G1nPMH/HbmiZs
         FCSvJv/+taETFAlYgeXlheAr947e7vJOt8RK0ykVHmBEz1QvesTnKuMQbyZNcGPzyLu2
         TmLUTaoLp0Dp4JmahllQ+QWjmtlnDgAZRhWnMK4MJo+XvCeAoCZ3xnfRlPgcv1LmTCIO
         DTW9eZ2V9V/FxWUPjE+JUGHxtHHNTLX0glhruFcllGvAekEV56Rw+eV6Et9d+9t40i/2
         83BA==
X-Gm-Message-State: AFuF++lEqAYpcW+RpzF8Em7Cmh8yzFyY716SKbcF0Hy36o8822SHs5+B
	g2189RgBnrzJJtjrHPjK82GaHNWBkLGgJh7Za5aGHAhHfGiXRDqfBPKObI2DPA==
X-Gm-Gg: AYBFou0WG0voOQHwaWi9E/Kvm/ILOAfQV+2cmbpl43mUHm4csrGbPf8XcI01jbeJFCY
	gb8jEID9Efz+ZxJ9ZknA/Q3VBIBeISIu5CwMN4V5k26mtBmoP/svOEoOq2RA1VroK/8739296a/
	2yph3EMS56jWZ5dE3+CWSrUWuUdSnZMAjIRx4+UDkcqUFDBGUWji6IhgL6d1GwFPXrGvBHJHcqD
	j4or7pyxP/BUd7BXAHH+12dmFet6LFtXzyqj/ulMRfw2jdbKXXLiUyV1MhxSPfaTn6xDUuIM/p8
	0omaRuMrzq/g7kc8buy5/R5ZSo4V3omw8sB5oDl/pOmzzNyMQ5i1BHz8KC9QuD/eMYSm6l8yTqs
	Jg/P8G0WW+Sg8jauMC9M5d5XMf1wTdf0QEleaTlxXZuaUOUrTNzc9RE/nuZS4Pmb2REq+PIAFnq
	zT8I9je7sPs1F1VAIRkxnGvb1PybKInxv376rhPl2jb0kWfdBTY8Tclnjo16ZLDVeYNaVS9dp2w
	UT4JFi6yUOJSK9dsTj2sOvPjUdCHo+sJt5+B5rE7UMbSDBXRUn4TOQnHqIElIVk0uRPoEYsPGDm
	5ckGUqJ5ZOiwvsU3g2oytNQd6LTc7AIqNY0itjr9yCZ16cYGO3nh8+5HfiK9bA==
X-Received: by 2002:a05:620a:4688:b0:939:6ec8:6928 with SMTP id af79cd13be357-939ea098e1cmr834670985a.16.1789165488648;
        Fri, 11 Sep 2026 15:24:48 -0700 (PDT)
Received: from Cumhall.redhat.corp (bras-base-rdwyon0604w-grc-05-70-53-55-174.dsl.bell.ca. [70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e811cffdsm346442085a.46.2026.09.11.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:24:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH] rteval: Add SPDX and copyright headers to test files
Date: Fri, 11 Sep 2026 18:24:41 -0400
Message-ID: <20260911222441.640222-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several files under tests/ were missing an SPDX-License-Identifier tag
and/or a copyright line. Add the GPL-2.0-or-later identifier where it was
absent and a copyright line to the files authored in this tree, using the
existing no-dash "Copyright YEAR John Kacur" style already present in the
other unit tests. Years reflect each file's initial commit.

The tests/e2e/*.t and engine.sh files are intentionally left untouched:
they already carry an SPDX tag and are authored by someone else, so their
copyright line is not ours to add.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/cpusets/test-cpusets.sh                         | 3 +++
 tests/regression/mock-cyclictest-partial-output.py    | 2 ++
 tests/regression/mock-rtla-timerlat-partial-output.py | 2 ++
 tests/regression/test-cyclictest-error-handling.sh    | 2 ++
 tests/regression/test-timerlat-error-handling.sh      | 2 ++
 tests/run_tests.sh                                    | 1 +
 tests/test_core_sharing_validation.py                 | 1 +
 tests/test_cpulist_class.py                           | 2 ++
 tests/test_measurement_module_selection.py            | 1 +
 9 files changed, 16 insertions(+)

diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
index bc7fd90e0e37..5e1293532aca 100755
--- a/tests/cpusets/test-cpusets.sh
+++ b/tests/cpusets/test-cpusets.sh
@@ -1,4 +1,7 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 John Kacur <jkacur@redhat.com>
+#
 # test-cpusets.sh - Automated testing for rteval cpuset integration
 #
 # Note: 'set -e' is intentionally NOT used here. This suite tracks results
diff --git a/tests/regression/mock-cyclictest-partial-output.py b/tests/regression/mock-cyclictest-partial-output.py
index 6bfc2a4ec41a..a3289a712eff 100755
--- a/tests/regression/mock-cyclictest-partial-output.py
+++ b/tests/regression/mock-cyclictest-partial-output.py
@@ -1,4 +1,6 @@
 #!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 John Kacur <jkacur@redhat.com>
 """
 Mock cyclictest that produces partial/malformed histogram output
 to test rteval's error handling improvements (RHEL-140898)
diff --git a/tests/regression/mock-rtla-timerlat-partial-output.py b/tests/regression/mock-rtla-timerlat-partial-output.py
index 63f9d89af2d9..0d3156f2d03a 100755
--- a/tests/regression/mock-rtla-timerlat-partial-output.py
+++ b/tests/regression/mock-rtla-timerlat-partial-output.py
@@ -1,4 +1,6 @@
 #!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 John Kacur <jkacur@redhat.com>
 """
 Mock rtla timerlat that produces partial/malformed histogram output
 to test rteval's error handling improvements (RHEL-140898)
diff --git a/tests/regression/test-cyclictest-error-handling.sh b/tests/regression/test-cyclictest-error-handling.sh
index 861e74480054..728d84656dcc 100755
--- a/tests/regression/test-cyclictest-error-handling.sh
+++ b/tests/regression/test-cyclictest-error-handling.sh
@@ -1,4 +1,6 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 John Kacur <jkacur@redhat.com>
 #
 # Test script for cyclictest error handling (RHEL-140898)
 # Tests that rteval handles partial/malformed cyclictest output gracefully
diff --git a/tests/regression/test-timerlat-error-handling.sh b/tests/regression/test-timerlat-error-handling.sh
index 7f2c99069e96..9161d36ac3ba 100755
--- a/tests/regression/test-timerlat-error-handling.sh
+++ b/tests/regression/test-timerlat-error-handling.sh
@@ -1,4 +1,6 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 John Kacur <jkacur@redhat.com>
 #
 # Test script for timerlat error handling (RHEL-140898)
 # Tests that rteval handles partial/malformed rtla output gracefully
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index c241ddc11adf..d00121e8651b 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -1,5 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 John Kacur <jkacur@redhat.com>
 #
 # Test runner for rteval unit tests
 #
diff --git a/tests/test_core_sharing_validation.py b/tests/test_core_sharing_validation.py
index 3c229a47e722..383b028516c1 100755
--- a/tests/test_core_sharing_validation.py
+++ b/tests/test_core_sharing_validation.py
@@ -1,5 +1,6 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 John Kacur <jkacur@redhat.com>
 #
 # Unit test for core sharing validation with mocked isolated CPUs
 #
diff --git a/tests/test_cpulist_class.py b/tests/test_cpulist_class.py
index bcb92e4a719d..c16934077052 100644
--- a/tests/test_cpulist_class.py
+++ b/tests/test_cpulist_class.py
@@ -1,4 +1,6 @@
 #!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 John Kacur <jkacur@redhat.com>
 """Test script for the new CpuList class"""
 
 import sys
diff --git a/tests/test_measurement_module_selection.py b/tests/test_measurement_module_selection.py
index 2216cc668297..db860eb23df2 100755
--- a/tests/test_measurement_module_selection.py
+++ b/tests/test_measurement_module_selection.py
@@ -1,5 +1,6 @@
 #!/usr/bin/python3
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2025 John Kacur <jkacur@redhat.com>
 #
 # Unit test for --measurement-module command-line argument
 #
-- 
2.55.0

