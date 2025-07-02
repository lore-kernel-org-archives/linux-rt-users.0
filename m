Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93D2750EF
	for <linux-rt-users@vger.kernel.org>; Wed,  2 Jul 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461092; cv=none; b=bD1TXAu4I322CgCss1Ev8D7wVoH3MfIoJHU6JI/UJI54Bn8ZlOy9sN23fQoZpjwsPLI5NtZ0xVxymkZ5nMMJfPzvSIdCvFE/0F89hjy8YUTA6fDcv26qDTJkNWdXoQA9oIMnBGkig7oXEUE1nLPSPVCCPJA46vJEn1179w9LjY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461092; c=relaxed/simple;
	bh=IkBOhna6unUiSAg+16mwqQekp0QPnbPL1HGpXg8V0z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BC+UzlqQmP/MoSfPwr4kRJ5ZjyAJSX4eMwC+phEXlTL2HvEB8s1YpQxWO+f9tZWPTwC3yJvjsRmX3miO5mlTuMofmo4k5QCGgEVfs4BoIzA4EVbGRJyYdW763+Cdoa7ksseYZT8TzudUaSwZc8+qJOwp+bG2+y7rTCIEl3PPFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45377776935so51859715e9.3
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Jul 2025 05:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751461089; x=1752065889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pp0wU9vtWWROO0fMRAQ9KDgeYc103hmOUpge0+TbNtw=;
        b=WWLt2GL5zK6ohf32e3EQYp0EmZztNF7ajvkalMUMvO9YhFyLRnsfmHk1BLMX4rIgKg
         c+A6mBB3wcIA6VdWG2XCn/U+70ufvv7/u6Ee2b7sua47S/3mFPrzTDluGyZg+czgoEvz
         iL79852DDxFKK17wdE8OnwQtFSqNft61WFsWolUTL9GAqTTnnXEsxnVNE8Asj/13xo3T
         jjOI1/S0jsb6Q6h+XWSNVyShxsRaB8HHbdnxTQNu4rH015/oSnBqu6VgUzu0mLkhSm6I
         FLUmn90hJvKi1JBMiVxIyA8l3aLD6s3zANMX++xun699B7PSd+Pu4FLxePVfTXL2xO6j
         lJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCVXwVIgJbaicqD50ewCZ04+PEnqCZB1uPSBCYNuu+lDsCZmSvY58oZ3DG1MnsMsztOu8XCZXtsTqRw2hJupXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKgnFy7SB7p4Sf4pOUQHRPjRBV/eGlMidxErimoJMR1FiD7rO
	qhAIVesKF0+nufJqPgqulsbFfzJo3Ma4JtDNrnoJJfsDMojG16Ukz+e+Ihj6pHUK
X-Gm-Gg: ASbGncsPRRi04CA4ldUMf5V68e+k1wGn1CU8YkYgFUqlazwJNfjJwlGDcTwus8niXU1
	r3I1yZ5creMEHjNXf+p1P8gipwH49YioXonF0vWSjUWaHS+AXaVGM53s2BC1CQ5ZRHnN5umx+Cx
	1QCh5DSMo7fGNA8BalLmGTo5imysAp9JsDYx20S6kpkojRTccxIzKm8PLOHbn4H8W+a6NuUBkiO
	9FkYuhgrWP3sOwEI6LpiLC6CK3mcoz9y1YD0Oq/oH3Tbo4QOu1/f7Mwfb3PGmBAuBYKlhS66zO9
	slnEwyKTlBigPilOlJGfsqSWiNSjOgjn4hY1WMgLkr2Gs7sZZAvcvpFJO+tMURPh02FUo95qXKt
	KFoA=
X-Google-Smtp-Source: AGHT+IHVckqNzkvylaJOpCF0NKD1zUVy0OYysmCEMsROGRUrjKf/S7NHxJ6V37Ahsdtavduqp7rddQ==
X-Received: by 2002:a05:6000:210d:b0:3a6:d7e9:4309 with SMTP id ffacd0b85a97d-3b200865a30mr1551650f8f.29.1751461088352;
        Wed, 02 Jul 2025 05:58:08 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa8aasm15830189f8f.27.2025.07.02.05.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:58:07 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v1] rt-tests: hwlatdetect: Add actual duration and MTBF
Date: Wed,  2 Jul 2025 15:57:55 +0300
Message-ID: <20250702125755.2141212-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Mean Time Between Failures (MTBF) - a valuable statistical metric
for evaluating hardware noise and its correlation with configuration.
Add the actual duration used for the MTBF calculation.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 68f312db639f..570460c9ddae 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -298,6 +298,7 @@     def get(self, field):
 
     def detect(self):
         self.samples = []
+        start = time.time()
         testend = time.time() + self.testduration
         pollcnt = 0
         self.start()
@@ -314,6 +315,7 @@     def detect(self):
         except KeyboardInterrupt as e:
             print("interrupted")
         self.stop()
+        self.act_duration = time.time() - start
         return self.samples
 
     def get_sample(self):
@@ -515,6 +517,7 @@ def microseconds(sval):
     detect.detect()
 
     info("test finished")
+    info(f"Duration: {detect.act_duration:.3f} seconds")
 
     max_latency = detect.get("max")
     if max_latency == 0:
@@ -527,6 +530,9 @@ def microseconds(sval):
     exceeding = detect.get("count")
     info(f"Samples exceeding threshold: {exceeding}")
 
+    if exceeding:
+        info(f"MTBF: {detect.act_duration / exceeding:.3f} seconds")
+
     if detect.have_msr:
         finishsmi = detect.getsmicounts()
         total_smis = 0
-- 
2.48.1

