Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22D4B9229
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405779; cv=none; b=tKAn0LXbpyTGGjHvFRk1l53ScXqqV7OR/ipzJ1QS6IHTzS6Mld7sHtn2xHdMphEtiMPSbdmQC/dK9qYZJTajGTlb6L9rc0D5e7gMePDUMUqQyBMfwOMGCE2Yz6WvKdXYB1QdzdZhGzFS/UrjkXN8h9gku1LLHZcK79r2xuNo8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405779; c=relaxed/simple;
	bh=+RrZpSQ+dpKWlsMm3ReciBrOlos2Vl+7eUpCTRCh0yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FekgboR3lbCtUUOoKJsRirUn5u3o95qiRxsHLtOZRPxI+09Qt6IK9hBtoWK1sWZcUH07QujEmY0HpPTxjAdWIwjsD+W4qmnF0nUEc9IR05EcVGOIXYVLqqHEZYPpOJvmq0yJXaLtpmJCGURXJoRXoa8leFm4QMe/eHPK6o2LdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1rkeZi0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpBkGrdb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1rkeZi0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpBkGrdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792405776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NoHbSvqJtX7bhXzwy5x29sQlsITPXaxb+KcAmo0EzCE=;
	b=e1rkeZi0fczSYYp4eYvzyyImr3i41ZR1AoBH4jb4YdglkmnUhr/PUqY1uqDgwpqcJ2TLwC
	CnXSxSMloBoyj2uWGMZhLVhiKG/6EPvjAFnp7kEX+5oDwZQ7hFQayqCWKl/spFNDhnqJhI
	z7uUXLKM3XSbUJd2rocI3ykGrDoZIRc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-LQeO09UyPi2moY2z4C1eiw-1; Mon, 19 Oct 2026 10:29:34 +0000
X-MC-Unique: LQeO09UyPi2moY2z4C1eiw-1
X-Mimecast-MFC-AGG-ID: LQeO09UyPi2moY2z4C1eiw_1792405773
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso13996045e9.1
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792405773; x=1793010573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NoHbSvqJtX7bhXzwy5x29sQlsITPXaxb+KcAmo0EzCE=;
        b=MpBkGrdbAciAGYdI2Cj5mtanP6ZrHzEjPVbBpo7uGnHPCyACzYB5ptDZ6Gsubyqxbl
         4gybcY+quf7kHVoVuSYYK8lx9+f+KliD2Gtr69bk5OfDP9stPqYmaSUwYmwTxryGAJo3
         kXsotJASXh/mjKy2feVhu12XSoIhzXuDosA0choSeIgKfaQyRLwgW3SM3elR8ek9z3JD
         nVEIbIS8/KkQUBJH5kuztAhL41bOZCcwW0nKMBRMuvtF4Tdav5j7Af7NJ/37+TxDtokq
         fInUCp3YxRe/tCJuHCAAoOCruFBP7fhrglc3ebzdLOcQKCpOVngzpHsiJEDh/t079cfO
         sA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405773; x=1793010573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NoHbSvqJtX7bhXzwy5x29sQlsITPXaxb+KcAmo0EzCE=;
        b=qqGidVyCg4WIUk7xLPO/tbom9e1dfMMwvsKLfy5ZUAVdOhATLV+NTjXdW0KQftt3Ax
         fwEJmzusDPDxu2eb5jB2GUGHE8ZUre0NumVCYcP1jlYZLpxTSN3d/6hwAMLVpaYAj+6B
         Q7uXhibufvsHYNKDSEibdimyWsk9t9vnCpydGaNO9uKF65OhnDFPq//uJZ1qrENiRAiV
         aRYAqKskoQ3UedT2E1ryX4cLxyLP2HZdPm4oiA3Rs5IkiSTgUzXV4lvDGDfhCCQ2nvxH
         1e1LhatcC1ZiIXyfVVB/WldMLiyPdVLW8GJoevod2DYlFa427DqZgTsiYCvhVsRPFI++
         ggTw==
X-Gm-Message-State: AFq9FYKNqBPy/ZJyZZNwQvZeXWqrWO6HMpIejiwX2gIAcLPlBwXwp8AE
	1H3a8x6/sy0lt2oMZtnloA/bVFmcCJbupeV+su2yaCY0nHsOq3oIqb8cpKC9Ii1hIGw94UFSPBY
	qQFeJfDyEIISj2ksjyCRYqPBDZerFPMpo3krLI+n64trz38WWOFMJaLpivDI6Lti6BXqr
X-Gm-Gg: AYBFou1vTNj5ulz2ymq7ylFscJDG4nXBDqV3e+mF6ygS+Tx8+pNzbySx6Tv0CIubM3a
	9BZ+7B8yfjlj8jl+235O0BiEbD541/VNUbbapgg92s0bLmH/T9FDOue6SkQSUdbn71VbimJhSwd
	IrnS0C0pS8y3DbkQazIhoPto8s6ebx6maklV3B51f9lsGZhde5Qrc/ufKofYfifgX5JJuRs/1Bj
	n8cG2MPtQYesHPE0+W17aXs+U+TvTOdi7qOE+gNxNypSgk+C6LMM8nUx1C8UUzrb7EGl/rPzFsL
	Am3lA/V4MxEx6Cxjd8Muj96h686fEeyFhG1G7835BNtY/0/dJ4MX1GQso7Xbo58+pa1SrVeTqN5
	PUV8sT42j4a1vPICo
X-Received: by 2002:a05:600c:8b65:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a1d75f2574mr166847805e9.5.1792405773368;
        Mon, 19 Oct 2026 03:29:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8b65:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a1d75f2574mr166847505e9.5.1792405772922;
        Mon, 19 Oct 2026 03:29:32 -0700 (PDT)
Received: from cshulyup.raanaii.csb ([2a00:a041:e223:1b00:cde9:6812:f4a4:646])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ad6245sm272689255e9.3.2026.10.19.03.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:29:32 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Bart Wensley <bartwensley@gmail.com>,
	Crystal Wood <crwood@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH v2] rt-tests: hwlatdetect: Restore tracing parameters
Date: Mon, 19 Oct 2026 13:29:09 +0300
Message-ID: <20261019102909.3339372-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwlatdetect leaves tracing parameters changed after a run. These
parameters can affect later tests. When --cpu-list is omitted,
hwlatdetect reuses the existing tracing_cpumask.

Save the CPU mask, current tracer, threshold, window and width before
changing them. Restore them during cleanup, including after SIGTERM or
an unhandled exception. Leave tracing disabled, as before.

Add a shell test for successful and failing runs, SIGTERM handling,
--cpu-list changes.

Assisted-by: Codex:GPT-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
v2:
Restore tracing parameters unconditionally
as suggested by Crystal Wood and Bart Wensley
---
 src/hwlatdetect/hwlatdetect.8       |  2 ++
 src/hwlatdetect/hwlatdetect.py      | 18 +++++++++-
 src/hwlatdetect/test_hwlatdetect.sh | 52 +++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100755 src/hwlatdetect/test_hwlatdetect.sh

diff --git a/src/hwlatdetect/hwlatdetect.8 b/src/hwlatdetect/hwlatdetect.8
index 560ff7cc0cc9..0a0c531502f9 100644
--- a/src/hwlatdetect/hwlatdetect.8
+++ b/src/hwlatdetect/hwlatdetect.8
@@ -57,6 +57,8 @@ The hwlatdetector script manages the mounting/unmounting of the
 debugfs as well as interacting with the ftrace hwlatdetector
 If the debugfs is already mounted then hwlatdetector will not
 unmount it after a run.
+The previous CPU mask, tracer, threshold, window, and width are
+restored after the test.
 
 .SH OPTIONS
 .TP
diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index ee1e0171210d..0e9e3568f5ee 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -8,9 +8,11 @@
 # (C) 2009 Clark Williams <williams@redhat.com>
 
 import abc
+import atexit
 import errno
 import os
 import os.path
+import signal
 import subprocess
 import sys
 import time
@@ -183,6 +185,7 @@     def c_states_on(self):
         """ close the file descriptor and re-enable c-states """
         if self.dma_latency_handle:
             os.close(self.dma_latency_handle)
+            self.dma_latency_handle = None
             debug("c-states enabled")
 
     @abc.abstractmethod
@@ -323,6 +326,10 @@     def __init__(self):
         self.samples = []
         self.first = None
         self.last = None
+        fields = ("cpumask", "current_tracer", "threshold", "window", "width")
+        self.saved = {f: self.get(f).strip() for f in fields}
+        atexit.register(self.cleanup)
+        signal.signal(signal.SIGTERM, lambda sig, _: sys.exit(128 + sig))
         self.set("enable", 0)
         self.set('current_tracer', 'hwlat')
 
@@ -388,7 +395,15 @@     def display(self):
 
     def cleanup(self):
         self.set("tracing_on", "0")
-        self.set("current_tracer", "nop")
+        self.c_states_on()
+        debug("Restoring previous configuration")
+        old = self.saved
+        self.set("current_tracer", old["current_tracer"])
+        self.set("width", 0) # must be always width <= window
+        self.set("window", old["window"])
+        self.set("width", old["width"])
+        self.set("cpumask", old["cpumask"])
+        self.set("threshold", old["threshold"])
         if not self.debugfs.umount():
             raise RuntimeError("Failed to unmount debugfs")
 
@@ -606,4 +621,5 @@     def cleanup(self):
         detect.display()
 
     detect.cleanup()
+    atexit.unregister(detect.cleanup)
     sys.exit(maxlatency > hardlimit)
diff --git a/src/hwlatdetect/test_hwlatdetect.sh b/src/hwlatdetect/test_hwlatdetect.sh
new file mode 100755
index 000000000000..187536f95264
--- /dev/null
+++ b/src/hwlatdetect/test_hwlatdetect.sh
@@ -0,0 +1,52 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+set -o errexit
+
+out=
+trap 'echo -e "FAIL: ${BASH_SOURCE[0]}:${LINENO}: $BASH_COMMAND -> $?\noutput:\n$out" >&2' ERR
+
+[[ $(id -u) == 0 ]]
+
+d=$(dirname -- "${BASH_SOURCE[0]}")
+
+tracing=/sys/kernel/debug/tracing
+mask=$tracing/tracing_cpumask
+settings=("$mask" "$tracing/current_tracer" "$tracing/tracing_thresh"
+	"$tracing/hwlat_detector/window" "$tracing/hwlat_detector/width")
+all=$(PYTHONPATH="$d" python3 -B -c '
+from hwlatdetect import group_sep
+m = 0
+for part in open("/sys/devices/system/cpu/online").read().strip().split(","):
+    a, *b = map(int, part.split("-"))
+    for i in range(a, (b[0] if b else a) + 1):
+        m |= 1 << i
+print(group_sep(f"{m:x}"))
+')
+
+out=$("$d/hwlatdetect.py" --duration 1 --hardlimit 999 2>&1)
+[[ $out == *"test finished"* ]]
+
+! out=$("$d/hwlatdetect.py" --duration 1 --threshold 0 --hardlimit 0 2>&1)
+[ $? -eq 0 ]
+[[ $out == *"test finished"* ]]
+
+echo $all > $mask
+baseline=$(cat "${settings[@]}")
+
+! out=$("$d/hwlatdetect.py" --cpu-list 1 --duration 1 2>&1)
+[[ $out == *"test finished"* ]]
+[[ $(cat "${settings[@]}") == "$baseline" ]]
+
+rc=0
+out=$(timeout --signal=TERM 2 \
+	"$d/hwlatdetect.py" --cpu-list 1 --duration 60 2>&1) || rc=$?
+[[ $rc -eq 124 ]]
+[[ $out == *"Starting test"* ]]
+[[ $(cat "${settings[@]}") == "$baseline" ]]
+
+! out=$("$d/hwlatdetect.py" --cpu-list 1 --duration 1 2>&1)
+[[ $out == *"test finished"* ]]
+[[ $(cat "${settings[@]}") == "$baseline" ]]
+
+echo Passed
-- 
2.56.0

