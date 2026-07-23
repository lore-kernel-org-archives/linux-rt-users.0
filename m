Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9D248886
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836096; cv=none; b=UdvDZbWXeD2Oy1rlFOdGnslyplXZYhld8ymPJ4YFj8nWW1pvpmIXXJz9jz4FkJQmpZukiWSRBnXhqE9Zgz+jmXw7slzwmt6y6cNhbClJ58tUWlzp4SEHoV451/EhymkmVGcdayuye/3BPIjqAloiK9q6XKEXva4tKkLU0hThR1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836096; c=relaxed/simple;
	bh=kiQvjgZLzUwgRInuL0dZoWQwhpaHObb8SRfQTy81Py4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oU0uCqVDLaTxXvVwou/8LSmo80CbdSRM+7pQTAV1viFNVQ3xxbp0Cf74K+WN2v1NSGnC92sUup7qUtTIMZ34tDN2Qrur/frWkJFXfKIMMMMIwO8BiJ4TGty9bS6hg+CnlGkXICZ4uWHWDn8lsoN0hFF3tP/6zxNA4z1PMK/CQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngdSfFRH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngdSfFRH"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-930f618435cso107569685a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836089; x=1785440889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hXHESGOHF+F83ufGrifdovHo/1VVYfdQr76VWY3kgU=;
        b=ngdSfFRHnwxMSqgu0PYsc2Wxsge10fba/3DYEy7M4v1G0CCGfUl3gfeIcDcJ6UOe6d
         GM26eDJcZOKnugk22cvHWk9xfNOCuunBHrd5PZKP9ElWuNN8U3k9NjVgqVRoTPTDWHzy
         6imBsuvuwKQdB+/3ajMiCcKATtN24BgyeX85g1roYMd2ADihrL4kkeJ+Az40CGt3t7xD
         hFJXW0E4arGZTe1wSlNhC5lOrnQ5MZ+rmr9BFf4Uu5ppGPULEY+GDj3Pc2+sdIVLcGUX
         PNM35pux5XEAsBVN9bvxnrNl2/w4PihT1P6+t3Z7lViM3nOhfOC8eCRJOuWs/iwNq1Ud
         ctEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836089; x=1785440889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7hXHESGOHF+F83ufGrifdovHo/1VVYfdQr76VWY3kgU=;
        b=WmLhBQ1/CXGbEp2zL8bLiF7GqJmjQ9RbiCxVWHwngfHlZqQuGFBETBGK69rqmH6Pwo
         Fl/cO6WKaj4iOYAaRUVUmYMhNYa/N4R+bToAxwFeUaJ5RKWv+0h8ekGaFIAe1ird6bmu
         +HlGJjv/6loCpBa3bdFlj+GErd/9tPNI727VBMFo39o8J9tU8/g4nkV5p50aIID0LyKi
         TMrHU4o33KiSyIPmOHMrXRzcXWTy+lxVwnBI31eeGcF/kHb9Q0rVbt+jTfk/7hfebpiz
         R7VMAGnTPsMlJLoE4+fH54VggkMIUJnsysGYjDWH1U5ppNGgkJBaOVdApGDUmV5vRpPs
         8Gzw==
X-Gm-Message-State: AOJu0YyEz8Anan9tn8/vCTtCRq2+49mMfmU9NAw8b0/uBZ8qc3g27N1c
	HiTkxOtog8PpPDlJipL4YLMAH6Crs0GCAyG2oikGwZE83s4T0IxV41ssZEmN4w==
X-Gm-Gg: AR+sD12EauknYvwJpi0O+RKoLURF2uZtYZg4kTogTX9WtyNJ/PcxQrVvKeW0qKdtFbh
	BE7kNHrjiApQ3o55qYQmbQNW/Hf/6iyAbKCKwPi/RZbqy8WCaGy15vsbhVCSQ4RjwgEqVuvo/um
	e9K39xchFM+nAufjduYCWvtdyArlDs2CqHd71vtRE2ypdzU7RP9TSmxec4sWqxf3bezo+iimSeS
	FxgzwCelxy3zdrLbsLG4daekqlSSj6qvR/B/M8snmYo4Y0RLAGJ2HgtK5txJeiCB0470Bdo0AgK
	FP5S7U+nsserGjnNbkgPkoteVDx4a7uyhvcdDG1wOahvlmxPSq4mF8sNT3HYEyVuu7uVzdWL00i
	Qm+UaMD0+t0I+PdN/ZJFM+KmowRIh77m4UMdWnYvBL4DDO2BOfXoIwAKvDlGZPE4i5yuaUD1OYL
	HHb7VRcQpOFMZm1AaazBChK8VSM4Xx4/0aYJbvHMq/JnncStFUZWEnm9WPKjr1/3/jIXeimkMXY
	+4oAOl1cESZVYcW5DMwC2ZsHAoMlmEY+Aq/u7OYqBgIh03IBkv+PD9ZGGaX
X-Received: by 2002:ac8:5f4d:0:b0:51c:7b12:5ffe with SMTP id d75a77b69052e-5283dfcfc71mr43183341cf.74.1784836088610;
        Thu, 23 Jul 2026 12:48:08 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4f3b8sm41402321cf.9.2026.07.23.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:48:08 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 6/6] rteval: Reduce verbose debug logging in timerlat stoptrace parsing
Date: Thu, 23 Jul 2026 15:47:51 -0400
Message-ID: <20260723194751.625088-8-jkacur@redhat.com>
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

Comment out verbose debug logging that dumps entire data structures
during stoptrace parsing. These were useful during initial development
but create excessive output now that the feature is stable.

Commented logs can be easily re-enabled for debugging if needed:
- Full self.__stdata dictionary dump
- Per-item cpu/key/value logging during XML generation
- Complete posttrace output dump

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index f983cedf0daa..735141e6796d 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -653,7 +653,7 @@ class Timerlat(rtevalModulePrototype):
         rep_n.addChild(stoptrace_invoked_n)
 
         if self.stcpu != -1:
-            self._log(Log.DEBUG, f'self.__stdata = {self.__stdata}')
+            # self._log(Log.DEBUG, f'self.__stdata = {self.__stdata}')
             for cpu in self.__stdata:
                 # This is  Max timerlat IRQ latency from idle
                 # With no other data from that cpu, so don't create a
@@ -663,7 +663,7 @@ class Timerlat(rtevalModulePrototype):
                 stoptrace_n = libxml2.newNode('stoptrace_report')
                 stoptrace_n.newProp("CPU", str(cpu))
                 for k, v in self.__stdata[cpu].items():
-                    self._log(Log.DEBUG, f"cpu={cpu}, k={k}, v={v}")
+                    # self._log(Log.DEBUG, f"cpu={cpu}, k={k}, v={v}")
                     if isinstance(v, tuple):
                         latency = str(v[0])
                         percent = str(v[1])
@@ -687,8 +687,8 @@ class Timerlat(rtevalModulePrototype):
                         cpu_n.newProp('unit', 'us')
                 rep_n.addChild(stoptrace_n)
 
-            self._log(Log.DEBUG, f'timerlat: posttrace = \n{self.__posttrace}')
-            self._log(Log.DEBUG, 'timerlat: posttrace END')
+            # self._log(Log.DEBUG, f'timerlat: posttrace = \n{self.__posttrace}')
+            # self._log(Log.DEBUG, 'timerlat: posttrace END')
             for cpu in self.__stdata:
                 for k, v in self.__stdata[cpu].items():
                     if isinstance(v, tuple):
-- 
2.55.0

