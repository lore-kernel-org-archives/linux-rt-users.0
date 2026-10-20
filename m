Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519431;
	b=ybV52j0SmFyCq51wYtwBxI3gsE+jBeQE6zdVH9EI+T031tjEUvrqaog/LK9BCzKvuDG3
	 OmH/cMX2ri6/MQ7KO79IYMc1AwSwLJjtiMWnDKEfd9dQyZdIxcF3mJzKWbRu2TryEJZia
	 uOUgvM0kt/R78KaTJkSOn/K8RhPi5+pQCFqDJRU9W/VJUxK4FFJQ0+xgRD2nLpmxAz5qN
	 e/XhcDDBzfR3bzd9f4UvpKKQF8GfgD5bzAN3w5DLbJ26X925zeOJ9v0cgVOzFoGDJ8EE+
	 mqn62lj5H/U5jBTP9SEZZk824Z6OdIgT9qM7C3XB0m/erVG8+RN+0bm+z/b46JxWOSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519431;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lUE9KEHqsEtSAU/tC/97GkE5EwJfk5LVJdmYokjZu9s=;
	b=hB1+wB2pbDKCxgjTEWdHn/hn3cPTet3Fj0zKNSl1F5+dd0GZUge4BuJ/sTOYoiLyoVky
	 QQFLpdh+YWrsfL0j/FKpvld0rHSIklwC6es1U5LsMmAQ1CeyJtBIrf4+m+8Go8anNY6uZ
	 zMiSXYq5OjjW9pwMquS6pKAGCL7d8HE7CWsdiaqR3JzYkRLOPnsnYhdDXSqCqCmrYUhXY
	 zyhtz38qXEr/8/iRbEvfFL32Z534jILhiUPj+GHkYzwYVUIIn1YyEyluxk8fS90vSsG7y
	 4es1f9r6znU/Hcm4yW0//2NTETPjyB5SHhfvpbFYU4AnuvrxopW+x626IZlbgWc9A3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TNH71oOH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DJqb9pwP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF09606A31A
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Oct 2026 18:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF09606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TNH71oOH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DJqb9pwP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792519429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lUE9KEHqsEtSAU/tC/97GkE5EwJfk5LVJdmYokjZu9s=;
	b=TNH71oOHRm0oc6M1ljtwJFblhhfo8POtPhbSfvRoTpgO90v3g+iDMWy32z8T/SDHz6RVM+
	33Tc6TmEsIHQ2umYkoaPE4ZLtD5eizLws54Hm3J+wx5po0uAmn7TnJTNH8HRZWRXh04Ac9
	BdOj4Qi4wRol8koqvEu+YSs50rYWwDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-3zr1a5c0N8WBSw_gf9KV5A-1; Tue, 20 Oct 2026 18:03:48 +0000
X-MC-Unique: 3zr1a5c0N8WBSw_gf9KV5A-1
X-Mimecast-MFC-AGG-ID: 3zr1a5c0N8WBSw_gf9KV5A_1792519427
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so28369815e9.3
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Oct 2026 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792519427; x=1793124227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lUE9KEHqsEtSAU/tC/97GkE5EwJfk5LVJdmYokjZu9s=;
        b=DJqb9pwPD4xWbN3fYpdf4FLOQIaf8AxB4MhQYRG50ChkU5fv1bNVW7AaIieGMBCJ3O
         56/kloCWouvj2pjnh893sYMlLv9SX7wat8AdPRBpzccklQ8AqpgYUUM+xn+BUB+zH4Q0
         GJiU6y6yV/HVgccQyFRfXSRNYDIiN2YeZarNXILHzLKjnGcuVe8hQXi7QYuuGeU5Ujh3
         iMV0Xnn1CsUbEUqOVvuHspLYnu6zbVC2lumbbEZM65N+dhQQhH6B9wf8oy0q63gtLFk3
         U4rj5z7sTNjdXYiFGG2oO3PuHsIz19i/DRWURP2+a0FCdK4pj4N8Fm0icYr+Iz6m68hu
         AbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519427; x=1793124227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lUE9KEHqsEtSAU/tC/97GkE5EwJfk5LVJdmYokjZu9s=;
        b=l3jxLc+LOUu1Q7UnU0Cdhh4v5CEcR7Zz8HmDFTZVsoWk7Jd+CD53b9ZbgZ5t92aFpx
         sKJdePcdlFykbiFO1AaI7RoJG5YtBbQ22qQuUz7sue8HYkjRddP4UcdWPIMVcaSPaPFv
         ZRvgcXLjgQsnf+xGKJZou8YPPLPRlbriA3m0idbl32frxASNfxyMsisunBJSRmNSIbGK
         C7s+Qx73netRP8I0pPWa8IL0ZD3hckxdGula2INlzAqe367KkdGrSEESk/8vK59oMGlJ
         6khicdefPa6C3X2pvMEIV6L8rd7YyBbJrYbkNHXwJbiVrbhZ90RvDouFpdXP30Un4/fR
         yh/Q==
X-Gm-Message-State: AFq9FYKP7LGvtLfSKjCYT9qf8rmvv4sMpPC/LxlaSHW3pEq4dX1o10Ik
	UKQ+WSBjkDpDmHDY/Wn6eYkJt6iDlKOjM+SCV3HEG+EwLUguu4weD4TYar+dD/bMT5O3J0dF3Bx
	Ko6W8rbX134Kaldh00TsHZ+f0mgVTqdceKAwR0ffnJ1Uq68KwjmlpZ0/vmsP/xbg1B6/w
X-Gm-Gg: AYBFou3SnQxK0AbrgIQQfduhnEg8D9kHp075TXfimBnYt0Y46cs6XPOKIKyyeTkqXVD
	uVQc01L7m3+TjwteWmJQA4otIbjUgopM666PV/j1wvNv8t4hEAap4gUyht5aHg7UAuVi9kh3nmK
	+DlFbz+lQMF9diw5uNyzKYZZC3nqoGOhizf/+3X29wj0g8+S54qahpxF3S7etH/fLz0f0T6SSZZ
	w0CDBKA9tXF6X9Ix+z6ceNyBwLSXnJoZSlITrOfNUNcWC24iJGEXUgXLHunT4wlX0zn3lC1ZN++
	MLFKkLPZsosXWRotxX069ZT+DeQ2cotzMgBNVQ6cIeQyclg1ewqrN3JSYOVvgsmTpr0ynIKFyNP
	1D39EDRSREAFoNZ/4
X-Received: by 2002:a05:600c:3d8f:b0:4a1:e31f:e86b with SMTP id 5b1f17b1804b1-4a1e31ff798mr183517705e9.28.1792519426822;
        Tue, 20 Oct 2026 11:03:46 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8f:b0:4a1:e31f:e86b with SMTP id 5b1f17b1804b1-4a1e31ff798mr183517025e9.28.1792519426340;
        Tue, 20 Oct 2026 11:03:46 -0700 (PDT)
Received: from cshulyup.raanaii.csb ([2a00:a041:e223:1b00:cde9:6812:f4a4:646])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1b227dsm4079605e9.6.2026.10.20.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:03:45 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Bart Wensley <bartwensley@gmail.com>,
	Crystal Wood <crwood@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH v3] rt-tests: hwlatdetect: Restore tracing parameters
Date: Tue, 20 Oct 2026 21:03:39 +0300
Message-ID: <20261020180339.1062486-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwlatdetect leaves tracing parameters changed after a run. These
parameters can affect later tests. When --cpu-list is omitted,
hwlatdetect reuses the existing tracing_cpumask.

Save the CPU mask, current tracer, threshold, window and width before
changing them. Restore them during cleanup, including after SIGTERM or
an unhandled exception. Leave tracing disabled, as before.

Assisted-by: Codex:GPT-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
v3:
Let atexit own cleanup and remove the explicit cleanup call
as suggested by Crystal Wood.

v2:
Restore tracing parameters unconditionally
as suggested by Crystal Wood and Bart Wensley
---
 src/hwlatdetect/hwlatdetect.8       |  2 ++
 src/hwlatdetect/hwlatdetect.py      | 18 ++++++++--
 src/hwlatdetect/test_hwlatdetect.sh | 52 +++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)
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
index ee1e0171210d..53584a0c0d42 100755
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
 
@@ -605,5 +620,4 @@     def cleanup(self):
     if not watch:
         detect.display()
 
-    detect.cleanup()
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

