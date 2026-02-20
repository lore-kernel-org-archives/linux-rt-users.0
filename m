Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7436656A
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Feb 2026 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611920; cv=none; b=RP+tu34L5spwpSgY4+NkylQpv871TB2/+0Pg4yfLPQfNkm7ojgHLopH0aq49NJYtbqbYXAc6wz9LjLvlDd1PUoAr3OvvzG0ytGxf01w/qo/GIKy1QvJ/ytrl6m4ocYlinDRWJZmVblJq7FktkXcXaKMx07U6H6UodgUdTch1EtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611920; c=relaxed/simple;
	bh=bXnPvUBBnchKR/afipn+rcGgoystNzMVxkFIvfsz9rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsbH+/8W/SiX7UN+dyKFYV4nwwT/AKNiTT1tq7fuC9/fJHt5QONgX/ns9nn5cAWnUSzjvsP/41m9Hn3Sk2RXXfGK+bFiO9M60ktJDNFsxa7FcL0FR82YzQXypwb14YLtQF6zY7E+UaBQw2Zd/TcAqwwz7D6MOc8lgPySO24j1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYQXoAYS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEfNWk2X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYQXoAYS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEfNWk2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771611915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cKA0CANTuRDg964iepP+Mi92a8ds/udyY+mDmh9Ot+0=;
	b=JYQXoAYSCy7fnA5Rs1WLkjxsmECNugOhuFbRdhzmbsHZW7fOycyIIRHsphi92aPXZYgLJx
	bz5a1aml25p4i1X5rL6qHv8k7HmfmnV7TYu1PvJIlXea7MacSwzHd+hm+GF/DmB6OzWf/O
	gXysFQLRI16HwRAepVDVA6bFNvpiJLw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-7OX5v-SWOw6O0fkQYO5-Xg-1; Fri, 20 Feb 2026 13:25:14 -0500
X-MC-Unique: 7OX5v-SWOw6O0fkQYO5-Xg-1
X-Mimecast-MFC-AGG-ID: 7OX5v-SWOw6O0fkQYO5-Xg_1771611913
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435add03f12so1595921f8f.3
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Feb 2026 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771611913; x=1772216713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cKA0CANTuRDg964iepP+Mi92a8ds/udyY+mDmh9Ot+0=;
        b=SEfNWk2Xv11OIQbfmFRjdPa59YeUwrFlEGHATadAjFgqLbh1kEvT7ZdwO1WYICEnad
         VvWr9VCLKsEofobIkS84wblEkLGvsxi4rp6JzzV2GBFPwXAJlFOK0gyAhn8yp51X+FjR
         gmbYYmnx3ROgLK4U6inh5MulaYDlKF+cTjqNAuJBala/JDP/BnnDqrY3UsZKgkNBmKu4
         dxyLjlYkA/uxEVfsc4JfkqKbl55rARAxDlyZF9WGahi85FC56rc7PjRIVj6sPu646kzs
         RkBkCb9q8DvMm3E1i/Nb4X0JuEjhUKn5KT0l0xMSwk73lyBq6dm86HalSAOO3t8coQyu
         +37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771611913; x=1772216713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKA0CANTuRDg964iepP+Mi92a8ds/udyY+mDmh9Ot+0=;
        b=O5mfq9Kic9jSRwmRzufE9W459FcYViZvtzlu8gRIxgBNKzDyP61H5s4AUPX/8ztRn2
         kaSO+dalOQg1WOU2kG8F2J/KEqSrEUrjXr009G9nMqfDRSDLYSS+JzgDV9/5vf6Vt/Mk
         Tqw8+u/590A1dkK8n+Dq9Nz9VatbfKXPa0kgnBHsuZExofuZ1mhoq16W39JDpr7lYLM0
         KNtnGAMTMBRuyleMLD8+5OQScHilXZTDgjzkijfQ7TbElb3HAjZEaPoNEzaAKr1lXz4Z
         TbtLeKTwd1Aj7cKSEeNCwpe2QAfOdvqA7+8h0cTMyOV+c4UlM+P8tCK3TCUVvP6HPrGY
         vkaQ==
X-Gm-Message-State: AOJu0YycCch+JIwYhX5rsmG5c/0fGmxzcRD7HfUQmdWbdEeoQ3nmC/2q
	vHDSMiQc+Z5VVpVm6SvQwsIBkSfinpsK6zRnj3IQxfsYVDUbjuIHNQbTNzoz0/yKwvdm9yCNIov
	/4Sb90lwSgwNvuTM6qgV0m95fx/zfeEn6sZQalFaU7cGhSO8YNxVuVLaWPn1JA6UWfSwPb1mnPc
	+VM+/IFQluTgkXZbJRz7yf4r8U1TLZT4kNLP8S1pKkaVFMTDQCXP9UDyc=
X-Gm-Gg: AZuq6aKNEl0L1g+Lov1TWBUXNFY19tteZR5sBcovs7Adjo8BJunkiwJJwJLrVZke/5K
	8i/fZPEfppXBHGHBJpotzNWKedTdgOrwOGSuYKFolkZZpZSFyU0p6j7e1vYEsHYb5OPUlajhAIr
	2zzP2485WNevfQgZnBCBYUPGkiYz0Vuqj6CxdKvK+cheyUOShkx7bw1iKkR4UzwCKEnxQK0lEXa
	E7sG6+/3iiltLYv0ei1cxrxgDvautRnBM4TF7LKiEEBkFMv2j/lDrrRUIb+kyXWSdqoW+WDViuG
	XSwhJXopu5IyZ1wqrttky2qAZfrvmwKrjWYDycxQ0bPP5MQzAqnoPeClX1zcsI1nM8MEy2gZ8li
	e4jlmUsBf9/WM0MD17KVYsqIX
X-Received: by 2002:a05:6000:230b:b0:437:71cc:a246 with SMTP id ffacd0b85a97d-4396f153cd2mr1777564f8f.10.1771611912793;
        Fri, 20 Feb 2026 10:25:12 -0800 (PST)
X-Received: by 2002:a05:6000:230b:b0:437:71cc:a246 with SMTP id ffacd0b85a97d-4396f153cd2mr1777513f8f.10.1771611912362;
        Fri, 20 Feb 2026 10:25:12 -0800 (PST)
Received: from localhost ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8209sm58255009f8f.30.2026.02.20.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 10:25:11 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Bart Wensley <bwensley@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v3] rt-tests: hwlatdetect: Add MTBF calculation
Date: Fri, 20 Feb 2026 20:24:29 +0200
Message-ID: <20260220182428.75379-2-costa.shul@redhat.com>
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
minus one):

MTBF = (timestamp of last failure - timestamp of first failure)
/ (number of failures - 1)

In hwlatdetect, the failures are called samples.

This metric enables meaningful comparison of real-time performance
consistency across different test runs, hardware configurations, and
kernel versions.  It can be considered a KPI for real-time stability,
relevant for certification and SLA evaluation.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---

v3:
- Fix formatting
- Make first and last instance variables
v2:
- Use another more stable calculation of MTBF
---
 src/hwlatdetect/hwlatdetect.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 38671724f3e3..bb12019ef2d6 100755
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
@@ -559,6 +563,9 @@     def cleanup(self):
     exceeding = detect.get("count")
     info(f"Samples exceeding threshold: {exceeding}")
 
+    if exceeding > 1:
+        info(f"MTBF: {(float(detect.last) - float(detect.first)) / (exceeding - 1):.3f} seconds")
+
     if detect.have_msr:
         finishsmi = detect.getsmicounts()
         total_smis = 0
-- 
2.53.0

