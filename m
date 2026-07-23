Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6526E165
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836095; cv=none; b=n9Y12DQtUBYdx6XTnmhc87QDA17/22pX/gX0YSEW0yfVJKNlS2K0xt20qJrKu+pyyv655ZDZsZFDorBJahveEmluOSI5XdehCu7+dZcLXPSQo4Y5Xb4t4Uoks/4XTMxx02LLFs5pXMtNCtp4TrnCdlZEyLVPQJXkNOyCDy0hw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836095; c=relaxed/simple;
	bh=dVDeuyr6Y1p+zlIIQHI65zTXW+rBLq+oz3Uqi3QvNpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMGkMJkLUpYftB2jjLifG1O74pf6fAJyTOfNTXrZOWYTvDPm65YsmwWrecqkSwkxXoDxaAQs3a3V9uwPEZHUUZrI1u34/kIwI0XfLPeX0Fye8tIuvP+pPGbDtBoE8cHZoGvgq9V0go8XG7VQliRhL/C9T2lqqm5HDyvr3bg3Qmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezVHQ2vz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezVHQ2vz"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51bfa429aa6so7874711cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836087; x=1785440887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZhKv0U8Eax3m4BLGFZSxhd32JqhGTgRxM2tyMObTwE=;
        b=ezVHQ2vzZOyIc6Nmjv9qXLIF9DT0JaFyYgIemnuhuznc68wJ+G9hAVpRvq+jj10ypW
         HKZodI8oItRjqlFxkBxGQhZz1uEBuB9ckMWQ9BOhqW0wXwAlt973/l57MrU2BnKmBsfX
         rGkd06kSWWDL0LRffKTWs3x/YNL72N8csALdqnr6SGAiO4FRopognMlE2j+SrV3Je5in
         c7Sl12exCqGtsI9yYYt2D9Uyq3XJ1O2hqJpvUrrug1mXxwYg4hMdqF0/8gehFmu565Eh
         SbksffQgIX1P2tExOw8q6W1gEgPM+KsNvnvZd8CFOBp80GXm0gIpssWuPfeIqiYCQiVC
         6Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836087; x=1785440887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZhKv0U8Eax3m4BLGFZSxhd32JqhGTgRxM2tyMObTwE=;
        b=DLhbOmdQPz16VPo/Lh+Ia7ttrAW/eAhUv4hM41S2kLKuLFlG8eRmY3RFZ2GMWBNzR6
         gVnVs6Mcc0e2NKG7tqN93z70+rbLrQgW54EAjbUXP3itDt8Z11SXhHhDHFoRbfHiTCHK
         tIpReK7H0uoRGYex+iXhwRLavX6X+OqxVTseYnVnop+eqg2ohmIxaYniHh/39ArAMlcJ
         3IBDcoxJn69cmL4/9llSTndo0W5j4Hzo0CsOsqFi1WFYHvIqiiCuK6Su9cVpYGqB1XX/
         /F31vwzJpc8IZ+gFtyHAB9nExrR7DlgpOTL8JeNr0Zd4PlCBw3IXlFzcpdDpzH3ul88t
         uPTQ==
X-Gm-Message-State: AOJu0YwzXK3j0i0P2UQc7LfPDWVcyaslulNohp4WTHHORV2wiCBWPuj5
	cEQ9psOuvHMM7LYku8iSa5JrBqVeCsx2xWrITtC+qO78LecNREL2vqPllIUB1g==
X-Gm-Gg: AR+sD10A4/m2bFVpSWZJiLqpNT1nMU9Phyu/DvylkeP6Xn4/UzkqKF6VixoHq55d5KA
	J3fgDJBx2hvj0tgP6lTcsVSSJbJ1DYX4+KZXeO2ZQbso8ZR9K2he9f9uqYKpuSu8UCePo/8uDAg
	yoSayJ58KOEejW9UxvBb8wsvIQ7kOQAI7o9wLWdTvoH2oshU4OEwLQ92x1+0e7PTxffLaETINzq
	MxcrA7LJO1y7zB61HJiqh7hMAxsSGD/N6zYjoraCGeJ8P3+OmDTVTMneexhkMcjDxlkHfYu7PD1
	qg4GCsFHw0xTlhqI0p97QA1paBqGVhDzQu0PIXOGZ/eSFiNA1VfKGG3Oc0pVlumcU9Db9WPCDQn
	N7enTSzKGblSEcJXSsHSC7SChZhqbubKJ7V76hGNJ4WBvpsuyJkZCJE1iKlmXp/Am/OtUpjGmnu
	vZFbMFUjvUNdjhaiN6dxAgngAiYOi0jzZLqetQfPiz/G4fTOf6t1KnxwLtC4ZdTKjAr15v4E4qT
	krAMgy+G2Y380GhpDs82iULpGt8sX7nP/I9wEuQUIWBldUbeaWcGlSHMARbwpafnzjGaS0=
X-Received: by 2002:a05:622a:2c2:b0:51c:98f:f288 with SMTP id d75a77b69052e-5283edce89bmr39273611cf.25.1784836086699;
        Thu, 23 Jul 2026 12:48:06 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4f3b8sm41402321cf.9.2026.07.23.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:48:05 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 4/6] rteval: Improve overflow bucket handling and add timerlat support
Date: Thu, 23 Jul 2026 15:47:49 -0400
Message-ID: <20260723194751.625088-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723194751.625088-1-jkacur@redhat.com>
References: <20260723194751.625088-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This improves the overflow bucket implementation by using cyclictest's
native overflow tracking instead of manual bucket clamping, and extends
overflow support to the timerlat measurement module.

Changes to cyclictest module:
- Parse "# Histogram Overflows:" line from cyclictest output
- Remove manual bucket clamping logic (cyclictest handles this)
- Improve SIGINT timeout handling with progressive waits (10s->5s->2s)
- Create dedicated overflow bucket with index="overflow" attribute
- Remove overflow_bucket attribute (no longer needed)

Changes to timerlat module:
- Parse "over:" line from rtla timerlat hist output
- Track overflow per-core and accumulate for system-wide totals
- Add overflow_samples to statistics output
- Improve SIGINT timeout handling matching cyclictest
- Create dedicated overflow bucket with index="overflow" attribute
- Log warnings when overflow occurs

Changes to XSL stylesheet:
- Display total overflow count in summary section
- Display per-core overflow samples in statistics output

This provides consistent overflow handling across both measurement
modules, giving users meaningful statistics even when latency spikes
exceed the histogram range.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 75 +++++++++++++++-------
 rteval/modules/measurement/timerlat.py   | 79 +++++++++++++++++++++++-
 rteval/rteval_text.xsl                   | 30 ++++++++-
 3 files changed, 159 insertions(+), 25 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 8371aa2e2aa5..b193330e27e0 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -39,7 +39,6 @@ class RunData:
         self.__mad = 0.0
         self._log = logfnc
         self.__overflow_samples = 0  # Track samples that exceeded bucket range
-        self.__bucket_limit = None   # Maximum bucket index
 
     def __str__(self):
         retval = f"id:         {self.__id}\n"
@@ -63,28 +62,24 @@ class RunData:
         if value < self.__min:
             self.__min = value
 
-    def set_bucket_limit(self, limit):
-        """Set the maximum bucket index for overflow handling"""
-        self.__bucket_limit = limit
+    def set_overflow_count(self, count):
+        """Set overflow count from cyclictest output"""
+        self.__overflow_samples = count
+
+    def add_overflow_samples(self, count):
+        """Add to overflow count (for system-wide accumulation)"""
+        self.__overflow_samples += count
 
     def get_overflow_count(self):
         """Get the number of samples that exceeded the bucket limit"""
         return self.__overflow_samples
 
     def bucket(self, index, value):
-        """Add samples to histogram bucket, clamping overflow to the last bucket"""
-        # Track the actual max before clamping
+        """Add samples to histogram bucket"""
+        self.__samples[index] = self.__samples.setdefault(index, 0) + value
         if value:
             self.update_max(index)
             self.update_min(index)
-
-        # Clamp to bucket limit if set (overflow bucket)
-        if self.__bucket_limit is not None and index >= self.__bucket_limit:
-            if value:
-                self.__overflow_samples += value
-            index = self.__bucket_limit - 1  # Use last bucket as overflow bucket
-
-        self.__samples[index] = self.__samples.setdefault(index, 0) + value
         self.__numsamples += value
 
     def reduce(self):
@@ -193,7 +188,6 @@ class RunData:
             hist_n = rep_n.newChild(None, 'histogram', None)
             hist_n.newProp('nbuckets', str(len(self.__samples)))
             if self.__overflow_samples > 0:
-                hist_n.newProp('overflow_bucket', str(self.__bucket_limit - 1))
                 hist_n.newProp('overflow_count', str(self.__overflow_samples))
             keys = list(self.__samples.keys())
             keys.sort()
@@ -205,6 +199,13 @@ class RunData:
                 b_n.newProp('index', str(k))
                 b_n.newProp('value', str(self.__samples[k]))
 
+            # Add dedicated overflow bucket if overflow occurred
+            if self.__overflow_samples > 0:
+                b_n = hist_n.newChild(None, 'bucket', None)
+                b_n.newProp('index', 'overflow')
+                b_n.newProp('value', str(self.__overflow_samples))
+                b_n.newProp('type', 'overflow')
+
         return rep_n
 
 
@@ -232,14 +233,12 @@ class Cyclictest(rtevalModulePrototype):
             self.__cyclicdata[core] = RunData(core, 'core', self.__priority,
                                               logfnc=self._log)
             self.__cyclicdata[core].description = info[core]['model name']
-            self.__cyclicdata[core].set_bucket_limit(self.__buckets)
 
         # Create a RunData object for the overall system
         self.__cyclicdata['system'] = RunData('system',
                                               'system', self.__priority,
                                               logfnc=self._log)
         self.__cyclicdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
-        self.__cyclicdata['system'].set_bucket_limit(self.__buckets)
 
         # Logging configuration
         self._logging = self.__cfg.setdefault('logging', False)
@@ -377,19 +376,51 @@ class Cyclictest(rtevalModulePrototype):
         except (IndexError, ValueError) as e:
             self._log(Log.WARN, f"Error parsing max latencies: {e}")
 
+    def _parse_histogram_overflows(self, line):
+        if not line.startswith('# Histogram Overflows:'):
+            return
+
+        try:
+            line = line.split(':')[1]
+            vals = [int(x) for x in line.split()]
+
+            # First N values are per-core overflow counts
+            for i, core in enumerate(self.__cpus):
+                if i < len(vals):
+                    overflow_count = vals[i]
+                    self.__cyclicdata[core].set_overflow_count(overflow_count)
+                    self.__cyclicdata['system'].add_overflow_samples(overflow_count)
+        except (IndexError, ValueError) as e:
+            self._log(Log.WARN, f"Error parsing histogram overflows: {e}")
 
     def _WorkloadCleanup(self):
         if not self.__started:
             return
 
         # Send SIGINT and wait for graceful exit
-        # Limit attempts to avoid infinite loop (RHEL-140898)
+        # Use wait(timeout) to return immediately when process exits
         max_attempts = 5
         attempt = 0
         while self.__cyclicprocess.poll() is None and attempt < max_attempts:
             self._log(Log.DEBUG, f"Sending SIGINT (attempt {attempt + 1}/{max_attempts})")
             os.kill(self.__cyclicprocess.pid, signal.SIGINT)
-            time.sleep(2)
+
+            # Use longer timeout on first attempt to allow histogram output to complete
+            # Subsequent attempts use shorter timeouts
+            if attempt == 0:
+                timeout = 10  # First attempt: 10 seconds for histogram output
+            elif attempt == 1:
+                timeout = 5   # Second attempt: 5 seconds
+            else:
+                timeout = 2   # Remaining attempts: 2 seconds
+
+            try:
+                self.__cyclicprocess.wait(timeout=timeout)
+                break  # Process exited gracefully
+            except subprocess.TimeoutExpired:
+                # Process still running after timeout, will try again
+                pass
+
             attempt += 1
 
         # Check if process exited
@@ -431,6 +462,8 @@ class Cyclictest(rtevalModulePrototype):
                             self._log(Log.WARN, f"Error parsing break value: {e}")
                     elif line.startswith('# Max Latencies: '):
                         self._parse_max_latencies(line)
+                    elif line.startswith('# Histogram Overflows:'):
+                        self._parse_histogram_overflows(line)
                     continue
 
                 # Skipping blank lines
@@ -508,10 +541,10 @@ class Cyclictest(rtevalModulePrototype):
             rep_n.addChild(abrt_n)
 
         # Let the user know if max latency overshot the number of buckets
-        if self.__cyclicdata["system"].get_max() > self.__buckets:
+        if self.__cyclicdata["system"].get_max() >= self.__buckets:
             overflow_count = self.__cyclicdata["system"].get_overflow_count()
             self._log(Log.WARN, f'Max latency({self.__cyclicdata["system"].get_max()}us) exceeded histogram range({self.__buckets}us)')
-            self._log(Log.WARN, f'{overflow_count} samples clamped to overflow bucket at index {self.__buckets - 1}')
+            self._log(Log.WARN, f'{overflow_count} samples stored in overflow bucket')
             self._log(Log.WARN, "Consider increasing buckets parameter for better resolution")
 
         rep_n.addChild(self.__cyclicdata["system"].MakeReport())
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index b0e20a72ef38..1201302d47b4 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -39,6 +39,7 @@ class TLRunData:
         self.__mode = 0.0
         self.__median = 0.0
         self.__range = 0.0
+        self.__overflow_samples = 0  # Track samples that exceeded bucket range
 
     def update_max(self, value):
         """ highest bucket with a value """
@@ -50,6 +51,18 @@ class TLRunData:
         if value < self.min:
             self.min = value
 
+    def set_overflow_count(self, count):
+        """Set overflow count from rtla timerlat output"""
+        self.__overflow_samples = count
+
+    def add_overflow_samples(self, count):
+        """Add to overflow count (for system-wide accumulation)"""
+        self.__overflow_samples += count
+
+    def get_overflow_count(self):
+        """Get the number of samples that exceeded the bucket limit"""
+        return self.__overflow_samples
+
     def bucket(self, index, val1, val2, val3):
         """ Store results index=bucket number, val1=IRQ, val2=thr, val3=usr """
         values = val1 + val2 + val3
@@ -158,8 +171,15 @@ class TLRunData:
             n = stat_n.newTextChild(None, 'standard_deviation', str(self.__stddev))
             n.newProp('unit', 'us')
 
+            # Report overflow samples if any
+            if self.__overflow_samples > 0:
+                n = stat_n.newTextChild(None, 'overflow_samples', str(self.__overflow_samples))
+                n.newProp('info', f'{self.__overflow_samples} samples exceeded histogram range')
+
         hist_n = rep_n.newChild(None, 'histogram', None)
         hist_n.newProp('nbuckets', str(len(self.__samples)))
+        if self.__overflow_samples > 0:
+            hist_n.newProp('overflow_count', str(self.__overflow_samples))
 
         keys = list(self.__samples.keys())
         keys.sort()
@@ -171,6 +191,13 @@ class TLRunData:
             b_n.newProp('index', str(k))
             b_n.newProp('value', str(self.__samples[k]))
 
+        # Add dedicated overflow bucket if overflow occurred
+        if self.__overflow_samples > 0:
+            b_n = hist_n.newChild(None, 'bucket', None)
+            b_n.newProp('index', 'overflow')
+            b_n.newProp('value', str(self.__overflow_samples))
+            b_n.newProp('type', 'overflow')
+
         return rep_n
 
 class Timerlat(rtevalModulePrototype):
@@ -323,13 +350,30 @@ class Timerlat(rtevalModulePrototype):
             return
 
         # Send SIGINT and wait for graceful exit
-        # Limit attempts to avoid infinite loop and double-SIGINT issues (RHEL-140898)
+        # Give timerlat time to write complete histogram (including 'over:' line)
+        # Use wait(timeout) to return immediately when process exits
         max_attempts = 5
         attempt = 0
         while self.__timerlat_process.poll() is None and attempt < max_attempts:
             self._log(Log.DEBUG, f"Sending SIGINT (attempt {attempt + 1}/{max_attempts})")
             os.kill(self.__timerlat_process.pid, signal.SIGINT)
-            time.sleep(2)
+
+            # Use longer timeout on first attempt to allow histogram output to complete
+            # Subsequent attempts use shorter timeouts
+            if attempt == 0:
+                timeout = 10  # First attempt: 10 seconds for histogram output
+            elif attempt == 1:
+                timeout = 5   # Second attempt: 5 seconds
+            else:
+                timeout = 2   # Remaining attempts: 2 seconds
+
+            try:
+                self.__timerlat_process.wait(timeout=timeout)
+                break  # Process exited gracefully
+            except subprocess.TimeoutExpired:
+                # Process still running after timeout, will try again
+                pass
+
             attempt += 1
 
         # Check if process exited
@@ -459,7 +503,29 @@ class Timerlat(rtevalModulePrototype):
                     #print(line)
                     continue
                 elif line.startswith('over:'):
-                    #print(line)
+                    # Parse overflow counts: 3 values per CPU (IRQ, Thread, User)
+                    vals = line.split()
+                    if not vals or vals[0] != 'over:':
+                        continue
+                    try:
+                        for i, core in enumerate(self.__cpus):
+                            # timerlat has 3 columns per core: IRQ, Thread, User
+                            # Calculate total overflow for this core
+                            if i*3 + 3 < len(vals):
+                                irq_overflow = int(vals[i*3+1])
+                                thr_overflow = int(vals[i*3+2])
+                                usr_overflow = int(vals[i*3+3])
+                                total_overflow = irq_overflow + thr_overflow + usr_overflow
+
+                                self.__timerlatdata[core].set_overflow_count(total_overflow)
+                                self.__timerlatdata['system'].add_overflow_samples(total_overflow)
+
+                                # If overflow occurred, max latency is at least the bucket limit
+                                if total_overflow > 0:
+                                    self.__timerlatdata[core].update_max(self.__buckets)
+                                    self.__timerlatdata['system'].update_max(self.__buckets)
+                    except (IndexError, ValueError) as e:
+                        self._log(Log.DEBUG, f"Error parsing overflow line: {e}")
                     continue
                 elif line.startswith('count:'):
                     #print(line)
@@ -603,6 +669,13 @@ class Timerlat(rtevalModulePrototype):
                         rep_n.addChild(max_timerlat_n)
             return rep_n
 
+        # Let the user know if max latency overshot the number of buckets
+        if self.__timerlatdata["system"].max >= self.__buckets:
+            overflow_count = self.__timerlatdata["system"].get_overflow_count()
+            self._log(Log.WARN, f'Max latency({self.__timerlatdata["system"].max}us) exceeded histogram range({self.__buckets}us)')
+            self._log(Log.WARN, f'{overflow_count} samples stored in overflow bucket')
+            self._log(Log.WARN, "Consider increasing buckets parameter for better resolution")
+
         rep_n.addChild(self.__timerlatdata['system'].MakeReport())
         for thr in self.__cpus:
             if str(thr) not in self.__timerlatdata:
diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index da7084289f87..a6829119170b 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -163,7 +163,23 @@
           <xsl:text>not present</xsl:text>
         </xsl:otherwise>
     </xsl:choose>
-    <xsl:text>&#10;&#10;</xsl:text>
+    <xsl:text>&#10;</xsl:text>
+
+    <!-- Display total overflow samples if present -->
+    <xsl:if test="Measurements/cyclictest/system/statistics/overflow_samples or Measurements/timerlat/system/statistics/overflow_samples">
+      <xsl:text>   Total Overflows: </xsl:text>
+      <xsl:choose>
+        <xsl:when test="Measurements/cyclictest/system/statistics/overflow_samples">
+          <xsl:value-of select="Measurements/cyclictest/system/statistics/overflow_samples"/>
+        </xsl:when>
+        <xsl:when test="Measurements/timerlat/system/statistics/overflow_samples">
+          <xsl:value-of select="Measurements/timerlat/system/statistics/overflow_samples"/>
+        </xsl:when>
+      </xsl:choose>
+      <xsl:text> samples exceeded histogram range</xsl:text>
+      <xsl:text>&#10;</xsl:text>
+    </xsl:if>
+    <xsl:text>&#10;</xsl:text>
 
     <!-- Display core sharing warnings if present -->
     <xsl:if test="SystemInfo/CPUtopology/CoreSharingWarnings/warning">
@@ -321,6 +337,12 @@
       <xsl:value-of select="standard_deviation"/>
       <xsl:value-of select="standard_deviation/@unit"/>
       <xsl:text>&#10;</xsl:text>
+
+      <xsl:if test="overflow_samples">
+        <xsl:text>            Overflow samples:  </xsl:text>
+        <xsl:value-of select="overflow_samples"/>
+        <xsl:text>&#10;</xsl:text>
+      </xsl:if>
     </xsl:if>
     <xsl:text>&#10;</xsl:text>
   </xsl:template>
@@ -428,6 +450,12 @@
       <xsl:value-of select="standard_deviation"/>
       <xsl:value-of select="standard_deviation/@unit"/>
       <xsl:text>&#10;</xsl:text>
+
+      <xsl:if test="overflow_samples">
+        <xsl:text>            Overflow samples:  </xsl:text>
+        <xsl:value-of select="overflow_samples"/>
+        <xsl:text>&#10;</xsl:text>
+      </xsl:if>
     </xsl:if>
     <xsl:text>&#10;</xsl:text>
   </xsl:template>
-- 
2.55.0

