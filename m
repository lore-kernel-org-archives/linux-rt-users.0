Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0C48BD52
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Jun 2026 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515655; cv=none; b=kAAHvGFwMW9Fb/hoTX9zXNLAu+CSrib1WnvaGFztWp1p+059fsQ6I8rVJfCF2/rrota71OKxes7bytqrQxfx0lYkfSC6HQIqZltCMSxe/PUndezLK3Er2+FOgnjMalrvuEVwVI7hE0xjIUO1M2OAZo+s4bon0nEBWUeKkV4vlaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515655; c=relaxed/simple;
	bh=/b6myiCDvAVL3cqjCHmaHOT4wkDDgjhz/nmKeiJvo1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XnFWejuVbjLWUQX7eGKA2Nw+O+3KFmZ2iCLyzbJBf1zDNOrE5Ufvs3uxfpRhC+uRS+x36ftKsV0KY00eouRUxe7gUn5dRhUVG08RB5XYQW709IQ289XGQSq+sdjPKaYROnfySZGWCDwCVAXneiWJJC1s6q+FHuwwlDgd/iEBylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8iSqVLi; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8iSqVLi"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9157b949fc7so279172985a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Jun 2026 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780515653; x=1781120453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KKlSgWO8S2xsmLdd5F187qobWKBFzL3WwJHaX/D+Dvc=;
        b=q8iSqVLiia9CoQ8hkE/byM4rwmO7AH/QHpgD65s8eLyJy51tkeAiM17B18zMay+EtI
         jgq2G/0grxS3XhWi7WgFYIClLlZSWYRL0OTmosKASw5hyr9rU6q55UnIFEYFPy3zcOHU
         BenQ8UxYbuoiRdvlKb+rtrLWNHzclQoaNlK1KygGvhDEWkXZp2xdg7nyLHu1Z2VIuCFg
         FoPOBXTpJ4lwUNCJL7lMmZ6mxiyCTJLRoCvkwJmG/zL2rGYzEy+Zb7YUYMMfG7Omg6xv
         80ONvchflF1aVuxfIF0ivPZ62QkLkSncAsj2n3zkKUpEbJZTrD7X1nA9ly8W8TL5v0nS
         UWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780515653; x=1781120453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKlSgWO8S2xsmLdd5F187qobWKBFzL3WwJHaX/D+Dvc=;
        b=JavVexLFk35waGvhwuUXV1kKn/fjLFsY5aD0PsnrCGrQDVC9Skyg3asG/XVwfMAshf
         oRgV8p1PEVi+7Keo5Hl5rjjWOI6+1Vc19Ot8xwepGUDVJq+S7+QJ9S2PAEn3fUjbCc16
         NsuzVO6Txm1rjWMhnT/9xcVbfs7sVNoONzxT7A5d8tQmU5/9K7LcZZErlIjTJCivhqBw
         iLbFrzINMAXl6tWVKHZkTi1LbxMhor92mVH3g7ddfT+0SbJygIfjPxy0yB8p0nE6fObH
         lCheT70yxRZZaiJoT2vyaoLBaAhq4UJ/6EUodnn4dWpSghWCq7crTLDZBTch7W5hTlDv
         7VDA==
X-Gm-Message-State: AOJu0YyneHZwv0/yigwWIN7WL2RvxiKHRHmPHyTnnwzlpfpKB4ieuswk
	S/95a+wsth5B66hFhegGNUOBW0nsQlZYaIZjBGruy6rbsbL56myypcg/ennAAQ==
X-Gm-Gg: Acq92OHwjgW7kw9I174zYmdzkeG7+E3bFIWNIGuOzeYGP+4zpcHdAohD5XT1YSR+De/
	ZAmZFFRTJES1VR51zSewzMeEEt/V/+zf0oxIjswWsXdSGxpHRXLGg9ijiER4zWPjd7huWs3ODDX
	xog/9eZNbRNxegcEf7rpeVnzHe2A/13OAt2eJQm5vA29bZbSR9XtqTCZR/v2M8rYMgYHjP2S8TS
	cpMPf8XrYdVPTTnPChoakNH7f2y/plfBuVkfR2kz4aQCwY7pJKZesolOjOX7JkNHn+xPNFLGzsb
	tzQFXTJArrNHZmqCU43QlLZ/MqONC4Ige5Gv4awOy+pGU2UTdkLlso/i3d8/Vh+MipHVwFIJXJt
	AH5yIO1A6n2MvsMjWVqOyua/9WmoXV0wdTHO97H0PmhiM0JQaESayG7vTLlJOW7cJOpUBuLXKs6
	NjF2gmuEC95yhT9/qYKyu7iDK2iXe2UjsWfwh8FEvpPHrvWsu6+ZXmK+otUK3bhFB7pMgtJ9B7+
	NGk69aPr/vjbt18a6DhoGoyRb69TA==
X-Received: by 2002:a05:620a:6846:b0:915:8ff7:e4fc with SMTP id af79cd13be357-9158ff7e880mr562538785a.33.1780515653126;
        Wed, 03 Jun 2026 12:40:53 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21d2c1sm365907185a.11.2026.06.03.12.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:40:50 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH] rteval: Fix timerlat module for rtla short option parsing bug
Date: Wed,  3 Jun 2026 15:40:34 -0400
Message-ID: <20260603194034.160983-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtla-7.1.0-rc6 has a bug parsing multi-character short options with
attached arguments (e.g., -p100, -c0-15, -E100). This causes the
timerlat measurement module to fail when invoking rtla with these
option formats.

Change the timerlat module to use space-separated arguments instead
of attached arguments:
  - Before: -p100 -c0-15 -E100 -T1000
  - After:  -p 100 -c 0-15 -E 100 -T 1000

This ensures compatibility with both affected rtla versions and
future versions where the bug is fixed. The space-separated format
works correctly in all versions once the upstream fix is applied.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 03faa08639d5..a3219e216296 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -236,10 +236,14 @@ class Timerlat(rtevalModulePrototype):
         self._setReady()
 
     def _WorkloadPrepare(self):
-        self.__interval = 'interval' in self.__cfg and f'-p{int(self.__cfg.interval)}' or ""
-        self.__cmd = ['rtla', 'timerlat', 'hist', self.__interval, '-P', f'f:{int(self.__priority)}', '-u']
-        self.__cmd.append(f'-c{self.__cpulist}')
-        self.__cmd.append(f'-E{self.__buckets}')
+        # Use space-separated arguments to avoid rtla short option parsing bug
+        # with attached arguments (e.g., -p100 vs -p 100)
+        self.__cmd = ['rtla', 'timerlat', 'hist']
+        if 'interval' in self.__cfg:
+            self.__cmd.extend(['-p', str(int(self.__cfg.interval))])
+        self.__cmd.extend(['-P', f'f:{int(self.__priority)}', '-u'])
+        self.__cmd.extend(['-c', self.__cpulist])
+        self.__cmd.extend(['-E', str(self.__buckets)])
         self.__cmd.append('--no-summary')
         # Disable auto-analysis
         self.__cmd.append('--no-aa')
@@ -251,13 +255,13 @@ class Timerlat(rtevalModulePrototype):
             self.__cmd.append(f'--dma-latency={dma_latency}')
 
         if self.__cfg.stoptrace:
-            self.__cmd.append(f"-T{int(self.__cfg.stoptrace)}")
+            self.__cmd.extend(['-T', str(int(self.__cfg.stoptrace))])
 
         if self.__cfg.trace:
             if not self.__cfg.stoptrace:
                 self._log(Log.WARN, f'Ignoring trace={self.__cfg.trace}, because stoptrace not invoked')
             else:
-                self.__cmd.append(f'-t={self.__cfg.trace}')
+                self.__cmd.extend(['-t', self.__cfg.trace])
 
         self._log(Log.DEBUG, f'self.__cmd = {self.__cmd}')
 
-- 
2.54.0

