Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D56379C5E
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836095; cv=none; b=LvVddq5r10b3XKA07IKMeJMZLj4eUaqzhpVaMshDj9k6u0Du1kw/+khhwkOTkdPLInZ1mpsT/5Dtx9Q/AtZAuUDWVN80z9MgTylKtXDV40nWTk5zm0hoZoJkRKQJaATO7cZB0PZyLs1J6EB7xO7cEkdgBYc9dmW8y7lke1gQPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836095; c=relaxed/simple;
	bh=MjTxDgc7YJNwAh0CHvfgrwqVyortESPTJcHkuIIpy3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sP6+lWqtbD3kQdnF7zO2EzU23e6JsIw5ZMdRritNA5jr/qIU5e9+x5gr+i51IYJPI6L8P1ZcUpTnDxl2nc2Zhiz5oxGy71aEcgwgPyU1wBP21uh8jKbH0W/Y65hn6nMINy2h7xFqJCXtZeysN16h6mhzCbJsLYy2GyLU/ShnJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adhXs+WF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adhXs+WF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51bfad59921so9202211cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836088; x=1785440888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31yph5QbgU8qLt3VlWPW5vt/K87kjr6YU6NVRVzpqVU=;
        b=adhXs+WFGjYtmM0sWCRXVocIushwewnK8P+4mSlhVB8Okgh+uPZyVsLMOAIDt8rQt3
         Ga6597H8ANGXgiJkjszvaVEVo4aoJEPIODRa2DHSWmwiJ8Zp65tsDRLAagg3Bp/uB6CZ
         JDQ13n+zpq03hcC4XByqPnFZ5KINicNLUXJtDqe08AyBFtgFAg8Fadz3lYgfYPd5+5xq
         vXaKpiiDzHeUJXdA8x4jasJ8FUzwl3y6jHFhU53EhrZG3ecHUp7UkYmOoc/p9KhIRptl
         qWrz2QfGhBDqpxEN+XTc9BTdVaP2DKYoQUauCvab73kfI42psIyiyhRzMTFXq+rH+ZdY
         71sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836088; x=1785440888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31yph5QbgU8qLt3VlWPW5vt/K87kjr6YU6NVRVzpqVU=;
        b=ZKozvRhTtzE0LrKOCrBNhaY8/0H29lEHyq/eqozLM8UNHQ5P6iX6srQt8Rbcwe8n0W
         5gfGmoOdil5Hb9ng/M3rJraDECD1shH1/u0Un3ZjOtbAgBRaU1G+tK8INxBCqzKCgRt7
         wlCyutkQyj8HiNdsT01NGD/fgbxBRlNSRSCwgSnPC2q6t8shMR1Agqg/NQSOZE4Ekfn3
         YYsptlC1CdKImgGXF1PI7jHPfUKKS1vOJwClpACbevJ7wJ+MRbGU3DP3IS4o/2u/XXQG
         RlTWojmZxrlD199S6x4bhyj0LI0YoQ7g7xP/U711Z5w57dZIHLwfYAEE623M9acFxCCb
         EWJQ==
X-Gm-Message-State: AOJu0YwUWIN041JJzf94fqiwcR8NyWg9ZSegs3npQIQQmCNK6xYReRTX
	yZVXtf95K43oDX07WiT6mpgMWsZBW3fh8TTPWrELROeQP3k/VJEERbb6CVgiTA==
X-Gm-Gg: AR+sD13ItSdgkJNaEUWlQp3HrnvIRhD1Ty0pEM/2Wvy4umjgUzN8SlSGhwzux5x8m4r
	xyC3Qa8TrwLMFBZdwNBSLLmRJjYcOY2Odm+etEokcyNj+gWF2UwqNtKAwrr97pfcnYvX91juSUw
	mCgR0wsTT2/D9mj2LVR5WsxzqITDSmNIutLAgmhE7ujEET/jDVaS0hnYc8BTFBDDpDfBSrwOrQA
	vCKyBQ8ssGbCucQ/DekY51eMbYOhR1ffgKA/f/29vzwjQ75Hdw64gd59yaY06H2TOkdz9I03XXS
	wiTV4ao3iiCKx9hrDbMO9IXPVe3Uie+EdES/TEm9g/9oktRVR/YnZY7DjjRUNYyASaXvI8szA1d
	ZHJpEUe3ufgdX0kw17pg7xzHnf16CDpw9MY8w0U7baRMzQ75nHl8kONQsbmrHXXTnCebrf6fNsN
	nODgi7AtmPfbxEFdtBnYLQUTv4mVOuqOi3sp3z0h21qd0Gs7tUz8E9Ns9n1FlfqQ3ZIHtBH9Gic
	/Pl4ODoHmxtvigPiytwf4QwKwwWvYpvAScXAZ8F7DDnF5sc9Yyd5T3GJ/Rh
X-Received: by 2002:a05:622a:5cd:b0:51c:1532:ae93 with SMTP id d75a77b69052e-5283ddf5785mr42887781cf.26.1784836087741;
        Thu, 23 Jul 2026 12:48:07 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4f3b8sm41402321cf.9.2026.07.23.12.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:48:07 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 5/6] rteval: Refactor timerlat parsing and fix max line duplication bug
Date: Thu, 23 Jul 2026 15:47:50 -0400
Message-ID: <20260723194751.625088-7-jkacur@redhat.com>
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

Extract max and overflow parsing into dedicated helper methods
(_parse_max_latencies and _parse_histogram_overflows) for better code
organization and consistency with cyclictest.py structure.

Fix bug where rtla timerlat's ALL: section contains a second max: line
with only 3 aggregate values (IRQ, Thread, User maxima across all cores).
This second max: line was incorrectly being parsed as core 0 data,
overwriting the correct per-core maximum values from the first max: line.

The first max: line contains per-core data (48 values for 16 cores with
3 columns each), while the second is an aggregate summary. Add max_parsed
flag to track parsing state and only parse the first occurrence.

When stoptrace is disabled, break after parsing the first max: line since
all needed histogram data has been collected. When stoptrace is enabled,
continue parsing to capture trace analysis data but skip the duplicate
max: line.

Enable rtla timerlat summary output (remove --no-summary) to get accurate
max values from the summary line rather than calculating from histogram
buckets, which are capped at the bucket range.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 90 +++++++++++++++++---------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 1201302d47b4..f983cedf0daa 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -256,6 +256,54 @@ class Timerlat(rtevalModulePrototype):
             os.makedirs(logdir)
         return os.open(os.path.join(logdir, name), os.O_CREAT|os.O_RDWR|os.O_TRUNC)
 
+    def _parse_max_latencies(self, line):
+        """Parse the max: line from rtla timerlat output"""
+        if not line.startswith('max:'):
+            return
+
+        try:
+            vals = line.split()
+            if not vals or vals[0] != 'max:':
+                return
+
+            for i, core in enumerate(self.__cpus):
+                # timerlat has 3 columns per core: IRQ, Thread, User
+                # Take the maximum of the 3 values as the overall max for this core
+                if i*3 + 3 < len(vals):
+                    irq_max = int(vals[i*3+1])
+                    thr_max = int(vals[i*3+2])
+                    usr_max = int(vals[i*3+3])
+                    core_max = max(irq_max, thr_max, usr_max)
+
+                    self.__timerlatdata[core].update_max(core_max)
+                    self.__timerlatdata['system'].update_max(core_max)
+        except (IndexError, ValueError) as e:
+            self._log(Log.DEBUG, f"Error parsing max line: {e}")
+
+    def _parse_histogram_overflows(self, line):
+        """Parse the over: line from rtla timerlat output"""
+        if not line.startswith('over:'):
+            return
+
+        try:
+            vals = line.split()
+            if not vals or vals[0] != 'over:':
+                return
+
+            for i, core in enumerate(self.__cpus):
+                # timerlat has 3 columns per core: IRQ, Thread, User
+                # Calculate total overflow for this core
+                if i*3 + 3 < len(vals):
+                    irq_overflow = int(vals[i*3+1])
+                    thr_overflow = int(vals[i*3+2])
+                    usr_overflow = int(vals[i*3+3])
+                    total_overflow = irq_overflow + thr_overflow + usr_overflow
+
+                    self.__timerlatdata[core].set_overflow_count(total_overflow)
+                    self.__timerlatdata['system'].add_overflow_samples(total_overflow)
+        except (IndexError, ValueError) as e:
+            self._log(Log.DEBUG, f"Error parsing overflow line: {e}")
+
     def _WorkloadSetup(self):
         self.__timerlat_process = None
 
@@ -271,7 +319,7 @@ class Timerlat(rtevalModulePrototype):
         self.__cmd.extend(['-P', f'f:{int(self.__priority)}', '-u'])
         self.__cmd.extend(['-c', self.__cpulist])
         self.__cmd.extend(['-E', str(self.__buckets)])
-        self.__cmd.append('--no-summary')
+        # self.__cmd.append('--no-summary')  # Commented out to get max: line for accurate overflow max values
         # Only disable auto-analysis if not using stoptrace (stoptrace needs it for trace analysis output)
         if not self.__cfg.stoptrace:
             self.__cmd.append('--no-aa')
@@ -405,6 +453,7 @@ class Timerlat(rtevalModulePrototype):
             blocking_thread_detected = False
             softirq_interference_detected = False
             irq_interference_detected = False
+            max_parsed = False  # Track if we've already parsed the max: line
 
             for line in output_lines:
                 if isinstance(line, bytes):
@@ -503,29 +552,7 @@ class Timerlat(rtevalModulePrototype):
                     #print(line)
                     continue
                 elif line.startswith('over:'):
-                    # Parse overflow counts: 3 values per CPU (IRQ, Thread, User)
-                    vals = line.split()
-                    if not vals or vals[0] != 'over:':
-                        continue
-                    try:
-                        for i, core in enumerate(self.__cpus):
-                            # timerlat has 3 columns per core: IRQ, Thread, User
-                            # Calculate total overflow for this core
-                            if i*3 + 3 < len(vals):
-                                irq_overflow = int(vals[i*3+1])
-                                thr_overflow = int(vals[i*3+2])
-                                usr_overflow = int(vals[i*3+3])
-                                total_overflow = irq_overflow + thr_overflow + usr_overflow
-
-                                self.__timerlatdata[core].set_overflow_count(total_overflow)
-                                self.__timerlatdata['system'].add_overflow_samples(total_overflow)
-
-                                # If overflow occurred, max latency is at least the bucket limit
-                                if total_overflow > 0:
-                                    self.__timerlatdata[core].update_max(self.__buckets)
-                                    self.__timerlatdata['system'].update_max(self.__buckets)
-                    except (IndexError, ValueError) as e:
-                        self._log(Log.DEBUG, f"Error parsing overflow line: {e}")
+                    self._parse_histogram_overflows(line)
                     continue
                 elif line.startswith('count:'):
                     #print(line)
@@ -537,16 +564,21 @@ class Timerlat(rtevalModulePrototype):
                     #print(line)
                     continue
                 elif line.startswith('max:'):
-                    #print(line)
+                    # Only parse the first max: line (per-core data)
+                    # Skip subsequent max: lines (like the ALL: section)
+                    if not max_parsed:
+                        self._parse_max_latencies(line)
+                        max_parsed = True
+                        # Max line is the last histogram data we need
+                        # If stoptrace is enabled, continue parsing for trace analysis
+                        # Otherwise stop to avoid the ALL: section
+                        if not self.__cfg.stoptrace:
+                            break
                     continue
                 elif line.startswith('timerlat hit stop tracing'):
                     self.__stoptrace = True
                     self.__posttrace += line
                     continue
-                elif line.startswith('ALL:'):
-                    # We should only see 'ALL:' without timerlat --no-summary
-                    # print(line)
-                    continue
                 else:
                     #print(line)
                     pass
-- 
2.55.0

