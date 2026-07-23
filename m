Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD38345EBD
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836092; cv=none; b=XlwMMA+WRlCHgOHcQOVf5JRcyIogZ2F+IXl/fcGuK9tg0Laao9/aRNcD9t1Hoi/C9cJQhUGznQkiA6gbxEPXC+lnFkQeJ1BTwklLHeTzl2Bxz2yw/GJp7TcblBMqtg/343LrCmw2IbScCBEOTp58df+sDBG2MXMYTvTyZyzMTnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836092; c=relaxed/simple;
	bh=kd7TTKeDsgdC/2CziQvPlvI9+0zWgeaFzD9xCrcYbXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfzVkf26JvWRkNOphmiunUvPUYhlDmlYl9+WkZZ3mfwTuJCp2Vow2oGkz9UG+AEOl94T8uia/FzDkfZXka9LTfrCxGyiBc1Uf54qhVT+lBlytUzKTN0D1sBOQmZ5zUPcbGnj19mYs8HAeyl0C4JqGllu6y9s7/VH8705gwBOdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqcthfn+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqcthfn+"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2cce930cso10158951cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836085; x=1785440885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDvYCxe+M05dFWjleM5g2nwvs4WxsvqsRuSSw7hPZUY=;
        b=Hqcthfn+R2/Jg4g56iX7mVp091AjvzjEDHDgOIw5OufY2kMHgckvGALO+MV7ZajLBz
         2DvTP8YFiswD3yTBuUto4SeVFbD5AhsNDlGHs0h41xgcPr8OoRMExTvIgylFnikhl9Do
         LXWaWAyEGChy7Oai3WI4rm4LHnrs3TPflvm2v3jkacL5LskLPu0W95l1uIjys6h2vtdN
         56fI+iyrRa2+8mgppDcyRzgHjXuxDeFuNWrGn14VDagM6lDt/XzpbDZlkcRWr8oWrLMf
         Z3Kv6jCvz19jOykkxIbyOLWL4L02MEwN2JlnD0B3vPWsR2MzFmdr79jV7fzwNuF2I9kt
         lOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836085; x=1785440885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zDvYCxe+M05dFWjleM5g2nwvs4WxsvqsRuSSw7hPZUY=;
        b=pOQu/OSgb5FbfNwVBLzJkuyuzIDSsTbOeeoTkM6H7nwdYxT/SRVsyDM/g/hh/ZaRFG
         zy5f8RJyDQUpUQdsI/CU2tA2r3PjLL820zqiEkfsDv87FwwOsGPBztXegPpv+z1zvcYf
         GhZBOejEFCwrEQbLAsEbUuY7TXvdc41WWueyb2sBdcWxbFNY0ZyqS2AhcW2KQLKr/LEn
         ZUVWIV7Vq1f073CNx3MOwHRvijrrU1JWAhemiRfCFvdwiAM7oJTrC6V7zBluwyaLaOAz
         waUsTqcgXGy/AH80aFYwobXL3cFUNrCOzeagUx8BS7u1WeOlht7wWqYRHnVkGtEhcuE6
         FTUw==
X-Gm-Message-State: AOJu0Yz22AS92J9jlTMFsEixBVgNyFdaS/5itTEqfMlN7NO6qmmda35d
	FvW2PeYfQCc3MAf5oaUe6w22eE3Vy05cH+SaCB9ZTKTcw3MPsZ0mz+xx4OMCdw==
X-Gm-Gg: AR+sD11bB+CW6OXrLJyoKIRKaLaflPczVShCemEQOvgRAIElhHV2Sl//kJtm43Uh/OD
	hRzUcp50UD/WZeAZ+aR0fIlbOvrOgqpDQuQ+q+3c39NgkViJ4fr4flTiQftQdj8kBcFukyu7I4G
	jZGy9HQ/3oGHXiIDLPzLQJYKonL7cLPGOsQypLJPjuWj33npnmYMiUbKloYdvYu6N+v0TJu/VD9
	9PvfN+7Qz5P6WsXhBnT7MfelEkOI2eXbUXjKRFUzDr9er5XEOs8FfWQDD5oD/YJ0uymgvjvczRD
	YLQnRyr4q1bYS7o0LGU0lYO3gWs+GLZJvIjYyuEOhR0b7a2tmCe0GOFChcs/VFEDkijoygy3upn
	wXOOHUwwD215V17QFq4TsnZxFEzzKGKmyz63z1gIcbE43liS5rpXdj0ncfGI3EvihuKIF9B34Ru
	lwUUWn+tL2Aft8Lk4MStclA7cDuNFyD6GQjQoTNQSMSd6zSNWonUgDRHdmW6dshj00JhwR1b0nB
	qJlPvWhLXL169yLpcg7ZuWt6I024LaSxOgt7QLLuqv69pzCM74cwuyN4BKq
X-Received: by 2002:a05:622a:2595:b0:51c:1fa1:80da with SMTP id d75a77b69052e-5283df4fdfemr45156291cf.40.1784836084624;
        Thu, 23 Jul 2026 12:48:04 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4f3b8sm41402321cf.9.2026.07.23.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:48:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 3/6] cyclictest: Add overflow bucket to handle latencies exceeding histogram range
Date: Thu, 23 Jul 2026 15:47:48 -0400
Message-ID: <20260723194751.625088-5-jkacur@redhat.com>
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

Previously, when maximum latency exceeded the configured histogram range
(buckets parameter), rteval would skip generating statistics entirely and
return an error. This was problematic, for example when running on non-RT
systems where occasional latency spikes are expected.

This commit implements an overflow bucket mechanism:

- Samples exceeding the histogram range are clamped to the last bucket
- The actual maximum latency is still tracked and reported
- Overflow sample count is tracked and reported in XML output
- Statistics are now generated even when max > buckets
- Error messages changed to warnings with overflow information

Benefits:
- Users get statistics even with latency spikes on non-RT systems
- No need to guess the right bucket size in advance
- Clear indication when overflow occurs via warnings and XML metadata
- XML output includes overflow_samples count and overflow_bucket index

Example XML output when overflow occurs:
  <statistics>
    ...
    <overflow_samples info="42 samples exceeded histogram range">42</overflow_samples>
  </statistics>
  <histogram nbuckets="3500" overflow_bucket="3499" overflow_count="42">
    ...
  </histogram>

This addresses the issue where rteval would fail to produce useful data,
for example when running on non-RT kernels with occasional high latency spikes.
---
 rteval/modules/measurement/cyclictest.py | 38 +++++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index eee315d270f8..8371aa2e2aa5 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -38,6 +38,8 @@ class RunData:
         self.__range = 0.0
         self.__mad = 0.0
         self._log = logfnc
+        self.__overflow_samples = 0  # Track samples that exceeded bucket range
+        self.__bucket_limit = None   # Maximum bucket index
 
     def __str__(self):
         retval = f"id:         {self.__id}\n"
@@ -61,11 +63,28 @@ class RunData:
         if value < self.__min:
             self.__min = value
 
+    def set_bucket_limit(self, limit):
+        """Set the maximum bucket index for overflow handling"""
+        self.__bucket_limit = limit
+
+    def get_overflow_count(self):
+        """Get the number of samples that exceeded the bucket limit"""
+        return self.__overflow_samples
+
     def bucket(self, index, value):
-        self.__samples[index] = self.__samples.setdefault(index, 0) + value
+        """Add samples to histogram bucket, clamping overflow to the last bucket"""
+        # Track the actual max before clamping
         if value:
             self.update_max(index)
             self.update_min(index)
+
+        # Clamp to bucket limit if set (overflow bucket)
+        if self.__bucket_limit is not None and index >= self.__bucket_limit:
+            if value:
+                self.__overflow_samples += value
+            index = self.__bucket_limit - 1  # Use last bucket as overflow bucket
+
+        self.__samples[index] = self.__samples.setdefault(index, 0) + value
         self.__numsamples += value
 
     def reduce(self):
@@ -166,8 +185,16 @@ class RunData:
             n = stat_n.newTextChild(None, 'standard_deviation', str(self.__stddev))
             n.newProp('unit', 'us')
 
+            # Report overflow samples if any
+            if self.__overflow_samples > 0:
+                n = stat_n.newTextChild(None, 'overflow_samples', str(self.__overflow_samples))
+                n.newProp('info', f'{self.__overflow_samples} samples exceeded histogram range')
+
             hist_n = rep_n.newChild(None, 'histogram', None)
             hist_n.newProp('nbuckets', str(len(self.__samples)))
+            if self.__overflow_samples > 0:
+                hist_n.newProp('overflow_bucket', str(self.__bucket_limit - 1))
+                hist_n.newProp('overflow_count', str(self.__overflow_samples))
             keys = list(self.__samples.keys())
             keys.sort()
             for k in keys:
@@ -205,12 +232,14 @@ class Cyclictest(rtevalModulePrototype):
             self.__cyclicdata[core] = RunData(core, 'core', self.__priority,
                                               logfnc=self._log)
             self.__cyclicdata[core].description = info[core]['model name']
+            self.__cyclicdata[core].set_bucket_limit(self.__buckets)
 
         # Create a RunData object for the overall system
         self.__cyclicdata['system'] = RunData('system',
                                               'system', self.__priority,
                                               logfnc=self._log)
         self.__cyclicdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
+        self.__cyclicdata['system'].set_bucket_limit(self.__buckets)
 
         # Logging configuration
         self._logging = self.__cfg.setdefault('logging', False)
@@ -480,9 +509,10 @@ class Cyclictest(rtevalModulePrototype):
 
         # Let the user know if max latency overshot the number of buckets
         if self.__cyclicdata["system"].get_max() > self.__buckets:
-            self._log(Log.ERR, f'Max latency({self.__cyclicdata["system"].get_max()}us) exceeded histogram range({self.__buckets}us). Skipping statistics')
-            self._log(Log.ERR, "Increase number of buckets to avoid lost samples")
-            return rep_n
+            overflow_count = self.__cyclicdata["system"].get_overflow_count()
+            self._log(Log.WARN, f'Max latency({self.__cyclicdata["system"].get_max()}us) exceeded histogram range({self.__buckets}us)')
+            self._log(Log.WARN, f'{overflow_count} samples clamped to overflow bucket at index {self.__buckets - 1}')
+            self._log(Log.WARN, "Consider increasing buckets parameter for better resolution")
 
         rep_n.addChild(self.__cyclicdata["system"].MakeReport())
         for thr in self.__cpus:
-- 
2.55.0

