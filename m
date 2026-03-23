Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2383B9DA9
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Mar 2026 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281863; cv=none; b=agfxut9DpF+pvfhQnRIzSMqfFWMBPgBulCFlrEYm7/j1Z7SixfZ/D944u/iRVXypRfU58Q7MH9TZB4LJJQF3omal/krk3G5ntS8+Bv3OWziRoGp+lR1oW5VtrHiircHYuperNszSlM5yNd2K+/TZ/TFJGA/KO21yK9j8zNklhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281863; c=relaxed/simple;
	bh=DUTRim1gkOpqNa86qOO8yHFUmjbltzZQ7g84pwEmtsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2T2wioP09dysMuBrr3ulYUMoqJdEi+7SWusXDR4zMN8SulO/w72d1lUTgTnhADy8rulvzd1JQdMrrvaRICA/nYxrN5AVVpxQnnEHxi6Fg9v3MoLvop+0wrCLNdyTctjVBiiexiLiymY7h9p+HvmNdtehPo35FtgAVxgsE+B1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkXMnI+m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXvXTMdA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkXMnI+m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXvXTMdA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774281860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aAZ+ll8wR3axZ5I+o7tUoMf2NNV+fYFyR3NYPILNm0U=;
	b=JkXMnI+mtW36LWCgvJMzcIGF8z/9daUJf/0Ta+904xlo3fN1tN7IXimiF9KQz0JIU/XBDI
	DgdpgCZxNIcQRGrlIu74EAUSDhEo4J1L+USarPw6A9tevr+h/4bbrWlpY7/+wdjs77hUek
	gaRs/JbeDuDC/6AzSxVFblgOP0R2Xbc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-C7PUd4mNM3KVpehFsl1VgA-1; Mon, 23 Mar 2026 12:04:19 -0400
X-MC-Unique: C7PUd4mNM3KVpehFsl1VgA-1
X-Mimecast-MFC-AGG-ID: C7PUd4mNM3KVpehFsl1VgA_1774281858
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-483786a09b1so5941115e9.3
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Mar 2026 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774281857; x=1774886657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAZ+ll8wR3axZ5I+o7tUoMf2NNV+fYFyR3NYPILNm0U=;
        b=TXvXTMdANrXuPsSOuVXk2fTnLjVwUDyoJ97KIvS6ZU6qWlx1LrR2cgo/eH3jeULpKV
         QnrlgztO2h7xDGL/rH42UKVHhP+cxxyAY9Lljf6Ck1hqajLRWn8oA9Mr+1a3c2yWjKKZ
         qa62cn5IbtEh1KiUNYj1NTwG2Qw/pWXdLvSpzxOiDZr+IFlr1PM5DMEaYnwHrNdY19Es
         a4KKcLipT+CgdNF/ZVKWn9nf07zZuWV3qw+30RDugzvo2YqxsPMI3tpnXuW3Ve5KRTrS
         VdPdpIyD2xNUdeXG0lXTdwSVTliEP9/KujAtVo6G0pAOn5on3Pr82u8UKGXweIgJ/1mM
         RRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281857; x=1774886657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAZ+ll8wR3axZ5I+o7tUoMf2NNV+fYFyR3NYPILNm0U=;
        b=FSjh7vBIUbJyD45MV26I50heqBHsr3oi57HTN5pk8bfLh8VdOgp8qgnw2vPnksoySB
         tFzYaK3pBKelo16w+h+//SJZtKwz0nErlvJmJOhHpszAm2IerZuI3KwElAPsc3ML6W/z
         QREMeS68rxA3uU5F/pQ4Md6EZsCjBBQNOMoWIMIEIDQXRQgthqIyo83ZnwdElNTdiJt9
         Atjj8KUeGOFGizNgFWzoRIv4BWGWMvNklUo+XBJOty6lBjnWUSi29WBEiBekgrR3mATg
         Lk79nbxZGHxk9YECahJhsM5R/WDU2/mGjSlDCKD8nx0D2OwqQ24tAhJyQJE2XZ2//6yV
         Rdkg==
X-Gm-Message-State: AOJu0YzqHji6AVoFSAu1qcqwGIfXieBMGBMDXpv+cl8RD2DMsG6NsGaP
	7swqnL3zVJmP+aN84R12YILCxdemDiI3g8zfMgB9ukHKWD77MU+KFXy6AOj3ucWgqlMKmvwhmI9
	5k5sgHOL9Z0bjRxVNAGdFrUdp5sGvtv8eugkKnhkP84823mjlqEwJOo6CLL6kYraRuRN8LMEkAf
	e4yKganWVEFL0Ww2K7lFfHgZT69I5fYVQ2fzTEHYWtUKasw4hyDwLkqFo=
X-Gm-Gg: ATEYQzya29Vulcpm3ULRgHG9RgkxYuSvD/diyr+a7S6eNrlGAxQrhJG4BClhbiiJuz7
	3cmd9M3EV/97IusMtTzzamU/urlmwcE+1G5TcziVnMyVaqyxBTB5rFgxSWc/WL9Jfk4jHoM5eit
	ZCvEjDZTYaVLKPg+VDXZrZMu8zYFM88zJ3ynslqEw8Cv1Q+CpTE0Xz5Nd8zT4qXvUYRmvlS9w8G
	qO2K6hAFOAVVkfGG1u8p+0R77N9l2wcuR7av1lfSmp1QsWGT4j4c8W6eb/5NRoiMmNkaqTM1ByU
	qO+aSdDbilBDOsuEzPr4fbozfteNImPJ5Q5MuRZzI84A8j93lkSpehJzq3WNMT0wqhNUsqMkq/2
	5W0STJ6Ul4FdhFjD6QK6GcttZsmEPISkUD7g=
X-Received: by 2002:a05:600c:45c7:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-486feddb6d8mr169566615e9.15.1774281857477;
        Mon, 23 Mar 2026 09:04:17 -0700 (PDT)
X-Received: by 2002:a05:600c:45c7:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-486feddb6d8mr169565415e9.15.1774281856408;
        Mon, 23 Mar 2026 09:04:16 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fc4d90f4sm398635265e9.1.2026.03.23.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:04:15 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v1] rt-tests: hwlatdetect: Add --time-format argument
Date: Mon, 23 Mar 2026 18:03:46 +0200
Message-ID: <20260323160346.230639-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add --time-format argument to customize timestamp output format using
strftime directives. By default raw timestamps are output for
backward compatibility.

Add %n directive processing for nanoseconds (9 digits) since strftime
doesn't support it.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 18ca930487f0..34fe5af4844a 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -14,6 +14,7 @@
 import subprocess
 import sys
 import time
+from datetime import datetime
 
 version = "0.8"
 debugging = False
@@ -255,6 +256,7 @@     def detect(self):
         'private class for tracer sample data'
         __slots__ = 'cpu', 'timestamp', 'delta', 'inner', 'outer', 'count'
         prev = float('nan')
+        time_format = None
 
         def __init__(self, line):
             fields = line.split()
@@ -284,8 +286,17 @@         def __init__(self, line):
             self.outer = int(o)
             self.count = int(kv["count"]) if "count" in kv else None
 
+        def format_timestamp(self):
+            """Format timestamp with %n (nanoseconds) support.
+            Float precision is safe for microseconds until year 2242 (2^33 seconds)."""
+            if not self.time_format:
+                return self.timestamp
+            t, ns = self.timestamp.split('.')
+            return datetime.fromtimestamp(float(f"{t}.{ns[:6]}")).strftime(self.time_format.replace('%n', ns))
+
         def __str__(self):
-            s = f"ts: {self.timestamp}, delta:{self.delta:.6f}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
+            s = f"ts: {self.format_timestamp()}"
+            s += f", delta:{self.delta:.6f}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
             return s if self.count is None else s + f", count:{self.count}"
 
         def display(self):
@@ -472,6 +483,9 @@     def cleanup(self):
                         dest="watch",
                         help="print sample data to stdout as it arrives")
 
+    parser.add_argument("--time-format",
+                        help="strftime format for timestamps (e.g. %%H:%%M:%%S.%%n)")
+
     args = parser.parse_args()
 
     # need these before creating detector instance
@@ -525,6 +539,8 @@     def cleanup(self):
     if args.watch:
         watch = True
 
+    Tracer.Sample.time_format = args.time_format
+
     reportfile = args.report
 
     if args.cpulist:
-- 
2.53.0

