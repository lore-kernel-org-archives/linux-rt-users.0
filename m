Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB045A299
	for <linux-rt-users@vger.kernel.org>; Sun, 11 Oct 2026 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747018; cv=none; b=TKkacusJ5wyMGSiPDkW5MIBOMzVYkReOIBh2t9Bz3yj5yW+RXTXiuTBohd0gRtEcBX//Qbnf9t4X63TzrbFHgG3IsP/0H67yyj5j8AN1S1rMLO1+3ywnTS371KKBB6rD5kkk7yxk9L18HiaYD7KYIy2zgfgFGWUpnqDbEzEAK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747018; c=relaxed/simple;
	bh=vmZIHUSgSmg0o7AaB444HWc451yB+RhsKpsy5P/+Cfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVtRTxlbkScvH4jMdEhWlq4AT+m+moXmgJ19D/cJ7Lip+oK4RColcinlQxqe+msWkJxlWeXv+ZO3qSsoRDWVpdEqWaDv4gPwNJQ6IvD300sxK8E40hw8bSqGN7y/IO92uUlR7/ddHxrLnA4XkDseA+qpjcJ/zkfX8Jx7wCCKSCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGfpQUND; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqhzUkjs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGfpQUND";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqhzUkjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791747012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=96kuyfTUoTYI+dD0/dzvOD0gJHOa530FGghh53J/IXw=;
	b=FGfpQUNDvDjSq5DkoNxBr+EGbGcFcPn+dHNQUAJwjH625/9v9Eormuz8QMEnxJeIToeocM
	GMSe0fDhKdrrKrZXPYI/wtDDACYc7usQgR0P6wq/kVijGNev6HaYt1svUMJG6g3yiwVz/G
	cSScCkEXKwuhk3Oy2cq+jmeZO65FNLk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-yM_ya-dAMlqzCOE_MuRSMQ-1; Sun, 11 Oct 2026 19:30:10 +0000
X-MC-Unique: yM_ya-dAMlqzCOE_MuRSMQ-1
X-Mimecast-MFC-AGG-ID: yM_ya-dAMlqzCOE_MuRSMQ_1791747010
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a19df2328cso4475765e9.3
        for <linux-rt-users@vger.kernel.org>; Sun, 11 Oct 2026 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791747009; x=1792351809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=96kuyfTUoTYI+dD0/dzvOD0gJHOa530FGghh53J/IXw=;
        b=dqhzUkjs1l4sY8UXLVTnVviPVkosECJWMvT1/Jaqce3tUxg6xmh3cief2OYgqTni8B
         RSbTJsns2Dwub3eUdbdz2pRQtaYYcR3BB/P8NOGuyZjmqeoAbcjYnrfI66VCxIcmlaIr
         wVUnswYnPtNSgvIfbSnKifhuJcL2G2QivEhxpDH+dMzNt2gIZf2zZXYNCQzVxoA311K5
         27emx0Bj7S9JOhGnTjkclifRKuawjldGi4zedGVPJRsNGaJ+j3yPj7hj7ExwQo3LO04/
         g4f5IZsb+VNe0//O9e2jhaqZg+oSbzHk4CYK6UlB16CMGOv//QO3LVx5eZeTsRhU/hxu
         lf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791747009; x=1792351809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96kuyfTUoTYI+dD0/dzvOD0gJHOa530FGghh53J/IXw=;
        b=QuOFrqoXMuG/itcvU9yPW+MT2c4AplDWP2InzET8MMECJ/XvaDS9rq+TfYptyUW5hc
         m8nkWKHEkVT1wEeu/btaCKbg4Uq/kWuZyMexJAUtWLMlNYz5e+eFpfviEpWX7fzLCoiz
         K2gj+OZcZ2ulsbThauGXyHMRXYefbriENSdUzsQS1fHM0mJZf/uJYCZnvxZuLxgtfIUT
         huOnmCIEdNc6KrlmTNuPkGSIyd57thGgk+oo+fGoBnXERl3XoX67sis6fzztfxuhAqA7
         PrcmRXemxKuHXT9gScXzLsyKvy85Qw1yv82cKS/cRAIX799WeZvv5X13v4ODgySsS85D
         npLg==
X-Gm-Message-State: AFq9FYLNj0JjmUux0t/cmuFV/T4LyOe2UFTWppeLXbUsXC8gqLF7YcuM
	Mxxokur1KmTh3Ls8YUS7k8PfWsAplRaHCegRgj05+VHs/yLu6pZX57x//5KwBCPSkghu6S2CJ1j
	/x+PWEgR86e2bgSzz1XUmsCSF7FZpdAj6mhpr3QCsqnYhbiXrX8vyCGCX0g51ysxxEJAmt47u5t
	Nq
X-Gm-Gg: AYBFou34TNI88c76ov8FWvshWAqA5TGyWThVnq1QLn8Mjq9ejqonQLq3fk7zg35bYj6
	T6XF8qqeHfGrxTdqZvf67pfmftYcXS1BHkBlBKCxI6AnN25FyzK6FHBD3Nf4sPI3JdTrZzjZqzY
	+hEkqQaKokI71AuQFVfT2i82TkNECofoliInuYpuXglOA2fldG6X7macVa7DtDpkCvc3PBC99wQ
	I0PEzZZ12b/VYVNr3CZGFOJ0MmPe3wTMZ7k17KveHLC3mFs6oAZNXg3GOwBG3C3Mn0ZDRodcLNN
	262Nwd7YAno6kgDlFaNPyS8W3Xaa8C718ugegoqJ+Eit5cKdFfsDrd4mGY96kS3ej6EAgtsy5Ci
	Wh10rVx1e4/eceBIZ
X-Received: by 2002:a05:600c:3b2a:b0:4a0:2540:b46 with SMTP id 5b1f17b1804b1-4a18e4aca94mr133639655e9.12.1791747009540;
        Sun, 11 Oct 2026 12:30:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3b2a:b0:4a0:2540:b46 with SMTP id 5b1f17b1804b1-4a18e4aca94mr133639365e9.12.1791747008979;
        Sun, 11 Oct 2026 12:30:08 -0700 (PDT)
Received: from cshulyup.raanaii.csb ([2a00:a041:e223:1b00:cde9:6812:f4a4:646])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18d12fe04sm146536145e9.4.2026.10.11.12.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:30:08 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH v1] rt-tests: hwlatdetect: Restore tracing parameters on request
Date: Sun, 11 Oct 2026 22:29:59 +0300
Message-ID: <20261011192959.2122274-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.55.0
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

Add --restore to save the CPU mask, current tracer, threshold, window
and width before changing them. Restore them during cleanup, including
after SIGTERM or an unhandled exception. Leave tracing disabled, as
before, and keep the default cleanup behavior.

Add a shell test for successful and failing runs, SIGTERM handling,
--cpu-list changes, and restoration of the tracing settings.

Assisted-by: Codex:GPT-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.8       |  4 +++
 src/hwlatdetect/hwlatdetect.py      | 31 +++++++++++++++--
 src/hwlatdetect/test_hwlatdetect.sh | 54 +++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100755 src/hwlatdetect/test_hwlatdetect.sh

diff --git a/src/hwlatdetect/hwlatdetect.8 b/src/hwlatdetect/hwlatdetect.8
index 560ff7cc0cc9..5c16a94ebd04 100644
--- a/src/hwlatdetect/hwlatdetect.8
+++ b/src/hwlatdetect/hwlatdetect.8
@@ -92,6 +92,10 @@ behavior is to print to standard output
 .B \-\-cpu-list=CPU-LIST
 Specify the CPUs for hwlat thread to move across.
 .TP
+.B \-\-restore
+Restore the previous CPU mask, tracer, threshold, window, and width after
+the test.
+.TP
 .B \-\-debug
 Turn on debug prints
 .TP
diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index ee1e0171210d..5f49a9730ec8 100755
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
@@ -314,7 +317,7 @@     def translate(self, field):
             return os.path.join(path, field)
         return os.path.join(path, Tracer.__field_translation[field])
 
-    def __init__(self):
+    def __init__(self, restore=False):
         super().__init__()
         path = self.debugfs.getpath('tracing/hwlat_detector')
         if not os.path.exists(path):
@@ -323,6 +326,12 @@     def __init__(self):
         self.samples = []
         self.first = None
         self.last = None
+        self.saved = None
+        if restore:
+            fields = ("cpumask", "current_tracer", "threshold", "window", "width")
+            self.saved = {f: self.get(f).strip() for f in fields}
+            atexit.register(self.cleanup)
+            signal.signal(signal.SIGTERM, lambda sig, _: sys.exit(128 + sig))
         self.set("enable", 0)
         self.set('current_tracer', 'hwlat')
 
@@ -388,7 +397,18 @@     def display(self):
 
     def cleanup(self):
         self.set("tracing_on", "0")
-        self.set("current_tracer", "nop")
+        if self.saved:
+            self.c_states_on()
+            debug("Restoring previous configuration")
+            old = self.saved
+            self.set("current_tracer", old["current_tracer"])
+            self.set("width", 0) # must be always width <= window
+            self.set("window", old["window"])
+            self.set("width", old["width"])
+            self.set("cpumask", old["cpumask"])
+            self.set("threshold", old["threshold"])
+        else:
+            self.set("current_tracer", "nop")
         if not self.debugfs.umount():
             raise RuntimeError("Failed to unmount debugfs")
 
@@ -472,6 +492,9 @@     def cleanup(self):
                         dest="cpulist",
                         help="the CPUs for hwlat thread to move across")
 
+    parser.add_argument("--restore", action="store_true",
+                        help="restore tracing settings after the test")
+
     parser.add_argument("--debug", action="store_true", default=False,
                         dest="debug",
                         help="turn on debugging prints")
@@ -499,7 +522,7 @@     def cleanup(self):
         quiet = True
         debugging = False
 
-    detect = Tracer()
+    detect = Tracer(restore=args.restore)
 
     if args.threshold:
         t = microseconds(args.threshold)
@@ -606,4 +629,6 @@     def cleanup(self):
         detect.display()
 
     detect.cleanup()
+    if args.restore:
+        atexit.unregister(detect.cleanup)
     sys.exit(maxlatency > hardlimit)
diff --git a/src/hwlatdetect/test_hwlatdetect.sh b/src/hwlatdetect/test_hwlatdetect.sh
new file mode 100755
index 000000000000..f2d990cbfdfc
--- /dev/null
+++ b/src/hwlatdetect/test_hwlatdetect.sh
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+set -o errexit
+
+[[ $(id -u) == 0 ]]
+
+d=$(dirname -- "${BASH_SOURCE[0]}")
+
+tracing=/sys/kernel/debug/tracing
+mask=$tracing/tracing_cpumask
+settings=("$mask" "$tracing/current_tracer" "$tracing/tracing_thresh"
+	"$tracing/hwlat_detector/window" "$tracing/hwlat_detector/width")
+original=$(cat $mask)
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
+trap 'echo $original > $mask' EXIT
+out=
+trap 'echo -e "FAIL: ${BASH_SOURCE[0]}:${LINENO}: $BASH_COMMAND -> $?\noutput:\n$out" >&2' ERR
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
+! out=$("$d/hwlatdetect.py" --cpu-list 1 --duration 1 --restore 2>&1)
+[[ $out == *"test finished"* ]]
+[[ $(cat "${settings[@]}") == "$baseline" ]]
+
+rc=0
+out=$(timeout --signal=TERM 2 \
+	"$d/hwlatdetect.py" --cpu-list 1 --duration 60 --restore 2>&1) || rc=$?
+[[ $rc -eq 124 ]]
+[[ $out == *"Starting test"* ]]
+[[ $(cat "${settings[@]}") == "$baseline" ]]
+
+! out=$("$d/hwlatdetect.py" --cpu-list 1 --duration 1 2>&1)
+[[ $out == *"test finished"* ]]
+[[ $(tr -d ',' < $mask | sed 's/^0*//') == 2 ]]
+
+echo Passed
-- 
2.55.0

