Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC8388890
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Jun 2026 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433240; cv=none; b=pYDAYpYLYoBc5MoNi9eqdfYAG+faUbhOGDdyI4Vtt5raUJIUD0hroLEGU2q14PrGTJNfrWBPufe4Dve9TpbLNex9kuheR0EYH/1p6txddFLrMjAA1sHdYhUYDNoFUNvrL4fWv4ZQ4IvbmLwSlRh8CPh3l4iAByLChjM9qLMHekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433240; c=relaxed/simple;
	bh=093pRUykfL9qjPh2BpnjSo06KLemJqufsH+ggsaGut8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSDElwq+UgcG4831ldssuDk5qu94SiASU+U+mobI9PvaQgtpC1ZkX//1sOMo4XUj7yDBy9n4ST3uM6YD2x6ZhF5s0WkMtbzYM3L3hCthWND75xFzrNgvejP+qiHF9UGRREbPEy6XudqUeQDWPDYg/pKL2ZuksI1aRTOIy7g1ABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgFKnreF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgFKnreF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9153e2708aeso419936385a.0
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Jun 2026 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433239; x=1781038039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yw2/4LJlP4GPrICnvnzFIIMcdWbKAvEzd1P/feNmxVc=;
        b=GgFKnreFnXiUK94NH6TuhbSDCAD94ag32bPT6tZ2HtapubzwubAL0X34IPaG+bwu/U
         Zoaq74HL8Jm07l8fV1mqjvnRZiYVPZ5P7pPONNwWsN0EgbYfipojWuNctkqTu1ANhVPk
         dR7uKFL+F4BpTZ4ZdWt8F0CMlq17pqCFYUsPqM7W8Nj9m0Yf1eGB0kF74lUEbga5fYaU
         3iYl4b4gD68CtmGwI6MVahU2YKVe6YndPyLWq730YJEmngCnf1N18LCY7BioOVVVHF1q
         FHaad42ppdAEYpJ4OXYmQMxGagTmgEP7gVc0HUzxEMmphiWFdkRbysN9bursWzDGtj9i
         uAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433239; x=1781038039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yw2/4LJlP4GPrICnvnzFIIMcdWbKAvEzd1P/feNmxVc=;
        b=NENyoxYpREP42OHNRfx0iqYmCs3iCRsfjCc1DB/D6b7qRetJAvPYyDAHKgUmG+0HsN
         5hkGle67OrCaQEntSjnBYJqjtOy2qFDU6BVoS4KjtcHVb4uHOCYp85e466tcxxJHB2+T
         SJdEVlfLTusgfxTsAEaT8oqE1EUHU/NYBVPBSuHqR2Fk7R2ciTCnx9pEHAW63h2C1rmQ
         cqRmspHym5pJtsGWrVyv2ZKx2fTUWyfSaRBI8dxBIxbyhKs0GptXStTVuH1j1qtTkSpS
         il3cyztworIzm3vdf0PgbgG5BuIZZbqRZ8qUaRRv73imc9r7nzkRvTtibx2un8iYLOrw
         GHuA==
X-Gm-Message-State: AOJu0YzDylQQvy+MzHMLATvLoE06Kwy7xx/nBEkAWy0wdCm2mOdgukk9
	RCVqALCP+OY5oQwW9WfpSrDx0di7RHv71ShYUAOCi5tusElxLmEuUG/cf21Mlg==
X-Gm-Gg: Acq92OFMlIanTae4y+yycMXwofLwKoycMCAuXuNgrfemWspKxPO0Fy2sMBm8VnKIayJ
	JBDAzrQI/ddgMj2olI0JTtv4ZstwsVY0TCgJll6ZIdvJerT39PtcL3DyJJkbvfftafB6WxXIq3t
	TLDp05p5YERfyjXIf+D7UITHWUhcaRrgo1is+mtuswRB6MZMumNvCnd9a+atydyZdoA0YVku+WL
	7HBap5QXQ5e8+z2q5vn1uEXTxN1hn2IUm65ek3juH+Z8nLkVzEemBt7Spu/Trm7M7DzUhg+FJ/8
	x+KdOO6IanUnjFWoWAtGS/sOIcX7W+cZDMQfhc1Ys4qehNUlxDLyQ0czV1JUIfRUcmIJpn+6pU8
	vGOa0EVuaALkTiFiuBpw6pmLD/clLUbd08RU1Im5lpkE88ODGC6HoRoEkXcAbrmolriILNh1CQE
	mRQjuczxyeHkka/ZNzQdCFDeJ0AhR/3kR0KrFXLmJccyPO6VLAQ10UJ6A9uilL45Pg7tmHlzghE
	fW1UDyqiWOdp9Exw8l1r0pYciaxvH/wRPBKyVxD
X-Received: by 2002:a05:620a:1a08:b0:913:dcd2:f132 with SMTP id af79cd13be357-9158a7d26d8mr116565285a.40.1780433238486;
        Tue, 02 Jun 2026 13:47:18 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21f871sm50291385a.12.2026.06.02.13.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:47:18 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 2/2] rteval: Add -L/--logging support to cyclictest measurement module
Date: Tue,  2 Jun 2026 16:47:02 -0400
Message-ID: <20260602204702.227969-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602204702.227969-1-jkacur@redhat.com>
References: <20260602204702.227969-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements file logging for the cyclictest measurement module, matching
the functionality available in timerlat and load modules.

When rteval is run with the -L/--logging flag, cyclictest will now save
cyclictest's stdout to a file in workdir/logs/:
- cyclictest.stdout - raw histogram output from cyclictest

This is useful for:
- Debugging cyclictest output parsing issues
- Investigating unexpected behavior
- Analyzing historical test data

Changes:
- Add _logging config flag (default: False)
- Add __reportdir config to locate logs directory
- Add __open_logfile() helper method (uses O_RDWR to support read+write)
- Conditionally use real log files vs temp files in _WorkloadPrepare()
- Handle reading from both file descriptors and temp files in _WorkloadCleanup()
- Close files appropriately based on type (os.close vs .close())
- Conditional seek only for temp files (file descriptors start at position 0)

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 49 +++++++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 8a5123e8af33..a120a552da11 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -212,6 +212,10 @@ class Cyclictest(rtevalModulePrototype):
                                               logfnc=self._log)
         self.__cyclicdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
 
+        # Logging configuration
+        self._logging = self.__cfg.setdefault('logging', False)
+        self.__reportdir = self.__cfg.setdefault('reportdir', os.getcwd())
+
         self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
         self.__started = False
         self.__cyclicoutput = None
@@ -219,6 +223,13 @@ class Cyclictest(rtevalModulePrototype):
         self.set_latency_test()
 
 
+    def __open_logfile(self, name):
+        """Open a log file in the reportdir/logs directory"""
+        logdir = os.path.join(self.__reportdir, "logs")
+        if not os.path.exists(logdir):
+            os.makedirs(logdir)
+        return os.open(os.path.join(logdir, name), os.O_CREAT|os.O_RDWR|os.O_TRUNC)
+
     @staticmethod
     def __get_debugfs_mount():
         ret = None
@@ -264,8 +275,11 @@ class Cyclictest(rtevalModulePrototype):
         elif self.__cfg.threshold:
             self.__cmd.append(f"-b{int(self.__cfg.threshold)}")
 
-        # Buffer for cyclictest data written to stdout
-        self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
+        # Setup output file - use actual log file if logging enabled, otherwise temp file
+        if self._logging:
+            self.__cyclicoutput = self.__open_logfile("cyclictest.stdout")
+        else:
+            self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
 
 
     def _WorkloadTask(self):
@@ -284,7 +298,10 @@ class Cyclictest(rtevalModulePrototype):
                 fp.write("0")
                 fp.flush()
 
-        self.__cyclicoutput.seek(0)
+        # Seek to beginning - only needed for temp files, file descriptors start at position 0
+        if not self._logging:
+            self.__cyclicoutput.seek(0)
+
         self.__cyclicprocess = subprocess.Popen(self.__cmd,
                                                 stdout=self.__cyclicoutput,
                                                 stderr=self.__nullfp,
@@ -345,9 +362,22 @@ class Cyclictest(rtevalModulePrototype):
         # Parse histogram output - use try/finally to ensure _setFinished() is always called
         # This prevents hangs if parsing fails due to partial output (RHEL-140898)
         try:
-            self.__cyclicoutput.seek(0)
-            for line in self.__cyclicoutput:
-                line = bytes.decode(line)
+            # Read output - handle both file descriptors and temp files
+            if self._logging:
+                # For file descriptors, read the entire file content
+                os.lseek(self.__cyclicoutput, 0, os.SEEK_SET)
+                output_data = os.read(self.__cyclicoutput, 10*1024*1024)  # Read up to 10MB
+                output_lines = output_data.decode('utf-8', errors='replace').splitlines(keepends=True)
+            else:
+                # For temp files, use seek and iterate
+                self.__cyclicoutput.seek(0)
+                output_lines = self.__cyclicoutput
+
+            for line in output_lines:
+                if isinstance(line, bytes):
+                    line = bytes.decode(line)
+                elif not isinstance(line, str):
+                    line = str(line)
                 if line.startswith('#'):
                     # Catch if cyclictest stopped due to a breaktrace
                     if line.startswith('# Break value: '):
@@ -395,6 +425,13 @@ class Cyclictest(rtevalModulePrototype):
             # Always signal completion to avoid hangs
             self._setFinished()
             self.__started = False
+
+            # Close output file - use os.close for file descriptors, .close() for temp files
+            if self._logging:
+                os.close(self.__cyclicoutput)
+            else:
+                self.__cyclicoutput.close()
+
             os.close(self.__nullfp)
             del self.__nullfp
 
-- 
2.54.0

