Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D5303A01
	for <linux-rt-users@vger.kernel.org>; Tue,  6 Jan 2026 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690633; cv=none; b=S0CtqPlgeZbkjRxpvg+zfLkXDUelnp6L/x2Hnq+v6COBj0DzZDJMyD/3DkoYgr/r78LuaYGVTYym4RUu2BrwISJxH1VL8Sl9tUlfIxqWJgDQNBzipsil8eRUj6oC+/lrkihjap87+q70bgvIkjx41yqr1E354lYsw4G0zbXtWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690633; c=relaxed/simple;
	bh=ZIZYa5apZyaz9fNx75bGHTpZSvKEDMdLGinoWKM4dIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QeXPM+dKl5KwR/nvtlA6dj4rb+4Gffe66nvbRm1loG6zWXbi9aYp/Wp8FjJ/oh9bkTmdbsaKKaNqzc00RS8kqYsVZD7tpZh4OeeHo4nojRhsxbv4mvYnLsBMsrf/ZeH1NU7p1gAUx5wfTAs1trqlUoO9N0yRKzxCCL0TSHn8aKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnKjlLF+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/OBQ7MW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnKjlLF+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/OBQ7MW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767690630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dkv3PfJhTpPk6qv/Dx+mKwvyrKzjn33U8oDFqMCT1Vs=;
	b=XnKjlLF+ROQpCyww+GFWL8BDqGmH7YwbWuyWWdBRhlOhwaPLYOW+cvzpetr8CG+KjvcN/R
	2a9SiqREF4V4FnyLKukt6pzpC/CfRG05qo4Xjgi+xArXtkIqU1VoqtuBSBPGog4cmWJydb
	MI4/sRiyD7uXd4pTQrzR1ddlg2TWgYU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-h56U80Q8Pky0miXg8BxwGQ-1; Tue, 06 Jan 2026 04:10:29 -0500
X-MC-Unique: h56U80Q8Pky0miXg8BxwGQ-1
X-Mimecast-MFC-AGG-ID: h56U80Q8Pky0miXg8BxwGQ_1767690629
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47a97b785bdso5222395e9.3
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Jan 2026 01:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767690628; x=1768295428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkv3PfJhTpPk6qv/Dx+mKwvyrKzjn33U8oDFqMCT1Vs=;
        b=Z/OBQ7MWvaNUQPZwAddABLnqDDgH1KxIZcHGyOQy76jZxeXVA2zVBUGWu6YG7GSpqp
         kp6WBZaquj6+yFNIvMNydw6CH15OpNW+ZNOy2/seuqGyb8f9aKOMGPKtFG4Le/OtA/v1
         tpfG2+RnbQO0Xbntp19+u+95vJb0fPZKtR7sZeK4TF5/2oAUWYiAmP49sOazsDQg1mVE
         kWufoVyFwdmZ274bA2vJXuIFmTXi3Et1+yZP6sGjm3JAPp1LXCGEC0/sDg3iH/ER+uyS
         T08hpg+rcwpmvTztJghkagLpQ4FeIDgncOHRX5RSqauCcFcnyH5zY3gTM4EoZwhDxtha
         kNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690628; x=1768295428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkv3PfJhTpPk6qv/Dx+mKwvyrKzjn33U8oDFqMCT1Vs=;
        b=s0AdGAjbtJkt8jcXQPpC5ULF4gT08W05hNLsPKZtisy464kXVR2WOorRIB/GC2g3T4
         vVRhx+PnKTsky1WHed2RtY89Kcvz4J4aN6kSJP/wHwFOb0TvaSHGGaiota+8lcRKGnvj
         L/acJoXvcjB2EgjcJqbBUCpLHttzUsJMZTtM16ZwHIu6TAFGzuPU/VVh7C/Gx2fic0Xd
         484JExiLA9WMTMldmPWGRfdfQS+IyYtjcK8ThuNulptX5QT+oyuhyFdu8Xo8W1DEJ8Cm
         FwT+M7zyjkWFoQLEjA3MT7AwXrejKW+HJQsx1RYWAyoQe/0inRqV+Wpfhnra/jg45JB8
         EFaw==
X-Gm-Message-State: AOJu0Yy1fpWZk5E/QXnsTky47DWSiDnCw1aCn8Lz6HwwfK/HhkHKF4rf
	jkAcYoEmm3uxxIZOZ4OxakZyn4pIByBZAHT8ig3MSQKPJ4Ejgsrx0ROromhxCCyOKdiHHDqqNsn
	1R5uKZ8XEMmDj6xWbjkM4Rc6EytlBsWmsxy8jvNssNqFfesmtj0VR+XYcdZaILUHGL15+0BqSEJ
	kj3k29RMt+6zpCJGk1ajBDRcUTLlundZyvlYnlMloqClozTMYiFopG1mw=
X-Gm-Gg: AY/fxX7NG608u/OiwVrUU6WUIAz3oZW/ge3+MCUwpBpLGNrs+iyLKRz/SPdwX2T/aqK
	xIxIVydjpbjB9kbfCDFaoZjZKaX0gziF8A67MeIgYoIhL+Bf6yBx5VcTX/bKiJSnzIl11E/TJTI
	8nxgQpJPLSQ0eoT18qKUxmBJYAa+I/djBRiGrzrouIdG2r3t02YIbWNXwXqpWsf4frAYxFpLs+a
	VpIlmh6yYsMny6zYAZ7az9NnxFwY7R8YVZSI4q10ZSWXWQCJWu7NBbNkP9/g4AUPs9peu3K8ba2
	ab/vSu2dtE+2z37tGqDeZ879C4wUFVYfHO4T8dD2j5euaPGkMSwTCo65aBvVouj4UPEczaols/E
	IIPQWdH4/QjlYD2T2Cn3vuQ2o
X-Received: by 2002:a05:600c:8b43:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-47d7f09b70bmr24085335e9.21.1767690628200;
        Tue, 06 Jan 2026 01:10:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ0ZEeBubCXqImq55WVLd8psRaXfcO6lXToULa5m14ALkNeRG9QEK1lKhPDawL1jmp6LfRwA==
X-Received: by 2002:a05:600c:8b43:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-47d7f09b70bmr24084945e9.21.1767690627716;
        Tue, 06 Jan 2026 01:10:27 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e23c:600:cadf:120:2b7f:a706])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7fad5f7asm14106835e9.2.2026.01.06.01.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:10:27 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
Cc: Bart Wensley <bwensley@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v2] rt-tests: hwlatdetect: Add MTBF calculation
Date: Tue,  6 Jan 2026 11:10:23 +0200
Message-ID: <20260106091023.1375803-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
starts and stops, not by the system’s failure behavior, which adds
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

---

Changed in v2:
- Use another more stable calculation of MTBF

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 68f312db639f..6d9db9aec933 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -19,6 +19,7 @@
 debugging = False
 quiet = False
 watch = False
+first = last = 0
 
 
 def debug(dstr):
@@ -306,6 +307,10 @@     def detect(self):
                 pollcnt += 1
                 val = self.get_sample()
                 while val:
+                    global first, last
+                    if not first:
+                        first = val.timestamp
+                    last = val.timestamp
                     self.samples.append(val)
                     if watch:
                         val.display()
@@ -527,6 +532,9 @@     def cleanup(self):
     exceeding = detect.get("count")
     info(f"Samples exceeding threshold: {exceeding}")
 
+    if exceeding > 1:
+        info(f"MTBF: {(float(last)-float(first))/ (exceeding - 1):.3f} seconds")
+
     if detect.have_msr:
         finishsmi = detect.getsmicounts()
         total_smis = 0
-- 
2.52.0

