Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893583B95F9
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Feb 2026 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026393; cv=none; b=J5Yk2D7y2its0lwcNDrYSDK37ZM+/9NrTj6wh94z3lJqXrTM0qSUfBgsooO+3CQMKColiAeuSE7VsxHVJU5TA2uZ26X16G6pk2ZxLmj0JpN1QiVO42Yai9L/8U64O++0eGbBJjRJqBa8Cdbi353kLd4580wkcglSEKkTVdhljX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026393; c=relaxed/simple;
	bh=2ImHeLo2WOnwPOn7U+krPwZ46kWkTDgcb/GDz8mxBv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCilPOQyY8EE45WiY2rVT1QFmVYKsoa6A6IeyE6VcOLEVc28+vIHNbDCShDHS/hw8C1zE2YsiHoAfZOcBVczXJX/RT0lwlLcA+K3YA4RB/3oGdImRZ+xuxS9KTNLTHtLmAeRGyOqZLq67P21wf7QAIA0NH6LUTpGrKw7j5N/Tws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUPttYDp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r2Y7ml54; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUPttYDp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r2Y7ml54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772026389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FZk3KRlmMDSMH9kSyA3JPAdfsRreqqfaibvt5bltXrc=;
	b=cUPttYDp2H/WjBXkS14LycsteQ9dcYgQZeMs2y/rbduKpKUXdI9tHPP8Y+/tD2ehM0sTHJ
	M163KL6AdLuQdppTqjYYhS4L3bR94q9V0BQnhZrV7qkYK40pdeTqliaSSUXYweloFB9NbJ
	Z9frCATtiHWnWCwqmV1j2Sd7b/FJaT8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-P5ny6hoBMxSk_jQ6IDJBIg-1; Wed, 25 Feb 2026 08:33:08 -0500
X-MC-Unique: P5ny6hoBMxSk_jQ6IDJBIg-1
X-Mimecast-MFC-AGG-ID: P5ny6hoBMxSk_jQ6IDJBIg_1772026387
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4376761037bso819310f8f.1
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Feb 2026 05:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772026386; x=1772631186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZk3KRlmMDSMH9kSyA3JPAdfsRreqqfaibvt5bltXrc=;
        b=r2Y7ml54scGH+QHgnbdgZHG4DhaJdKA9P+Udw4u7Rh+pYimW3pBA/Wu+/9VdEqod7o
         0AUQOGgCk13Szg9R0Z1UyR91yBE1SL1lsTVecl13Ag/+Vljt+645Aaowj3EyEQW+HmZZ
         2Pr3n7Pwd6HKXC2Q+1BsRymQKe7uz07z2Ft+VbDrJR3Lgxx+fDj60N+wxoQniQLC+PKq
         hrr86E3IfOuam80xD/2ohJnxJ+DOuyV6Rc8KCR3qzi8CfjHBIwW2nnG1h4Z8p1IbYcva
         NU/UMaEppExeY07GbpHycdz/sYwbxtLFs8LRLRU2KEF1sB7xMz01MzwWdsrdk1CQgXT0
         RRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026386; x=1772631186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZk3KRlmMDSMH9kSyA3JPAdfsRreqqfaibvt5bltXrc=;
        b=d2aOFIUqdpzncqJj2CyvtJ/pnRYEXM2bZi7EHCuGtzrvQNblHxraifKFR3OLs2uiL3
         kY2D/E4ZMosYdZcxb+L/zjhPQQUJBvG/SnJszwTHNorYu/xaypgNnmJPq+uuYEvlaLGd
         zTLZ6GW7EW87Rnkrf1v3AuqoQnjQWFYLkS1pigLaQKtxPQa0mIotbX0ixzigNbGZBElL
         QwDDrpKdosb9emSfoz39RMIjn05Nr53SSDYQ8YqRmOFgkZ8PBiUW9Wwm68VZeUPDisYU
         YyMQcK6n/HI3F+cYv5RlyCULkP/TYd6OouEE4GohJiGKOZVUX/PntRKZhq4qqMJOGmZo
         I7OA==
X-Gm-Message-State: AOJu0YwmU1UG6rZUQ+LL6LjR97+LXTdLRS+w+646FfL8G+D5vFHnJN7E
	ToriAnW4iMidbV1Er3Q8zS4IfgLYiFmYXfCY6Fe0cuoociSO4kfKzkiLl0mXma1Br6PNvvERrW7
	GxAH/0iO+lVNcAD9MAehqu5fDNXL2h1G3H93YH1CprjyhpOb7NmDNq3kwHXY7JyY0n2Ti0/0HCQ
	gibOp3usMnmm8+73QB2S9bHusAvGvn9leOQcVpaJHqDs7udLzwMqAHV/0=
X-Gm-Gg: ATEYQzwI3xP0sHt9ShoipnAQGlaFR+ZRPV+yJbPHgw+GbNW8OmtPW7TORNSZ1lcUxev
	N9TfqIkL8fV9sUfG8pJ+HcHKfglQNS3GEwLUJeHyZw8fzVmsRRMVmsZyR58GohIhUcRxPhx/hNS
	6c1dpzqbcfI3D1NhZrTVwEOpq20rHw7QdI+FXxuXb5g/XZnl3r8xGJA7F01uY0dpwwclHaGn9Kq
	Bg8YsB2VbQZoxy9H5saa96F0kHGDkzSKnTjk3QL2rFglh1z7MjLxLWLtRtySE5FrUxTmTmCHmsJ
	RfkP9MbkX9JPHEbaZQ1oXBBx1Bgd24oUfIsk7bBs57LVsI0lk0stMULNIVKUElY3FgGFefJFo1E
	yNzDa5em3VJbXfBnkvM9wUhmfeIH4tGpEowxQlA==
X-Received: by 2002:a05:600c:3e10:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-483bd7429a1mr57532295e9.11.1772026386414;
        Wed, 25 Feb 2026 05:33:06 -0800 (PST)
X-Received: by 2002:a05:600c:3e10:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-483bd7429a1mr57531735e9.11.1772026385910;
        Wed, 25 Feb 2026 05:33:05 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f1a3fsm78962195e9.3.2026.02.25.05.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:33:05 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v4] hwlatdetect: Add MTBF calculation
Date: Wed, 25 Feb 2026 15:32:32 +0200
Message-ID: <20260225133232.756608-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hwlatdetect reports the number of latency spikes but provides no
information about their frequency distribution over time. This makes it
difficult to compare results - a test with 10 spikes over 1 hour is very
different from 10 spikes over 24 hours, but both show 'spikes = 10'.

Add Mean Time Between Failures (MTBF) calculation to quantify spike
frequency.

By definition MTBF = total operating time / number of failures.

When the failure interval is large relative to test duration, this
formula is biased.  For example, imagine stable periodic failures.  The
total operating time will include time before the first failure and
after the last failure.  These intervals are determined by when the test
starts and stops, not by the system's failure behavior, which adds
measurement bias.  The resulting MTBF will vary between runs even for
stable periodic failures.

To reduce this bias, calculate MTBF using only the time between the
first and last failure, divided by the number of intervals (failures
minus one).

Additionally, hwlatdetect only samples during the 'width' period within
each 'window' cycle. The non-sampling periods contribute to the error
margin. The MTBF is therefore adjusted by multiplying it by the ratio
of window to width:

MTBF = (timestamp of last failure - timestamp of first failure) * window
/ ((number of failures - 1) * width)

In hwlatdetect, the failures are called samples. The failure count is
the sum of counters from all samples.

This metric enables meaningful comparison of hardware latency across
different test runs, hardware configurations, and kernel versions.  It
can be considered a KPI for real-time stability, relevant for
certification and SLA evaluation.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---

v4: Adjust MTBF by multiplying by the ratio of window to width
v3:
- Fix formatting
- Make first and last instance variables
v2:
- Use another more stable calculation of MTBF
---
 src/hwlatdetect/hwlatdetect.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 38671724f3e3..abfbb954fe75 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -306,6 +306,8 @@     def __init__(self):
             raise DetectorNotAvailable("hwlat", "hwlat tracer not available")
         self.type = "tracer"
         self.samples = []
+        self.first = None
+        self.last = None
         self.set("enable", 0)
         self.set('current_tracer', 'hwlat')
 
@@ -338,6 +340,8 @@     def detect(self):
                 pollcnt += 1
                 val = self.get_sample()
                 while val:
+                    self.first = self.first or val.timestamp
+                    self.last = val.timestamp
                     self.samples.append(val)
                     if watch:
                         val.display()
@@ -559,6 +563,11 @@     def cleanup(self):
     exceeding = detect.get("count")
     info(f"Samples exceeding threshold: {exceeding}")
 
+    if exceeding > 1:
+        mtbf = ((float(detect.last) - float(detect.first)) * int(detect.get('window'))
+                / ((exceeding - 1) * int(detect.get('width'))))
+        info(f"MTBF: {mtbf:.3f} seconds")
+
     if detect.have_msr:
         finishsmi = detect.getsmicounts()
         total_smis = 0
-- 
2.53.0

