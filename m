Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98819202630
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524352; cv=none; b=E2DO5/mrEdhFdCE80EhN3N6vJv3lUxy6BVKWDTWyV9Z6lFK+jC/fKh2b+fDducJrFqHuefv0b3fWdqLOBpnPj56kBbe1s/PeG+7X4ExY8WuB8rWeUcOYL7ZhL3kRgqJZhA/dzg/hR4s0NWTPmacP62PLvvBVSOGWyXzyZ7XmeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524352; c=relaxed/simple;
	bh=wAz2JPynRT6hAOngkwyYHupKzYrekCb/ujLha2FTJZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpmPx8b0712mhy1AHvaNMf5zj/B6OgyFtxSaHVXuJSMU321ooCjwllCWY9LVMdVoDSKah1x52le685TO1tmXJq54dgRgG/ii7JKYW4rNUgSs9fR/oioQLBQqb+oyzYHgJt2NentnTW0jB+D4LUm8GtxqKkG3WQbd2FESMRCaoU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSl2t/d+; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSl2t/d+"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b14f3927ddso497571085a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731524349; x=1732129149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qKLt4nWbVdMaeumhogwRq4Hp+EFaZDzUlkQCjcS0508=;
        b=FSl2t/d+piXn6F1qKH+HhUGzy16k5iVhH2dXBitQ/T0lCDa8WTALBoEDnLVptb+Qy6
         XwpfmwbkMD8E6FBlwPMUB65ey4UP3+NhwP+ZY/2QpncIsxnXUOhvJJjBLkJkK2fv+9Tg
         11ZIozEWrRkdUo4iKyXuumlM7TvG4Kq4u0ftVMo1Fvd47lxXyTdLD+w/tJupZGPkPH6c
         ndgDwpFVlhWDKVjCBOm6Fq61mqpR3PcWzuQgB3xvhDKwt1oqmDaUBfcUcbgs1W5BTr99
         e8sEnZq0vNG+fpBAwELhHI9pAHa8CZ6a1QCdET09VVYg3OrQ3O2JD2nZT8loOwtTxjfW
         2x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524349; x=1732129149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKLt4nWbVdMaeumhogwRq4Hp+EFaZDzUlkQCjcS0508=;
        b=RRd5fKs4Qgu1W7OA/mFMOdtFmWtj3BrLWUiBu3DyudNMgU2QoAxmBJ/QqDTYB0VxIB
         7gseUt/eH7W0zgFp6NxDqZCewOnIrapGYtrAWL3dO0MvqJqnSSmW6Eo7dA+i5x+bjrEb
         ++JfMIDGpelpM89Q+zJebR3On9DWtRUQJdua61Vrycr7BB0dqEkyWThDepSmBrEVik8/
         RzirlvfICU8niRMClO1FKNEKIDAZ6TQGMhueWT+GbDFgJlRXaUHl4lf73qWH1l8LpbDh
         sGFrgxkTmmvgUdeJUhamAClW8XYz8cslbMmbWa4ljLpWZihfNopxkODSBBFWtDo278l1
         aaTQ==
X-Gm-Message-State: AOJu0YzkG8zxTy73o5K6w48eufKcjelaOVIUe7kkTI5PBJcNrHmn1E47
	bNO3s8mCmPvSVrgMjbjVJQpuEiUUqDNCB0ELR1VUEhF1w30A0RVkz1o3fQ==
X-Google-Smtp-Source: AGHT+IGnl0PoFhhUGZgkGYgjkAWeGjdU8NZsZzEX/bXX9yOg+yv+3ZN4t8gymjoc8K15gsfuWIM5Aw==
X-Received: by 2002:a05:620a:2a0d:b0:7af:ceed:1a4a with SMTP id af79cd13be357-7b331f1e490mr2613423185a.43.1731524348689;
        Wed, 13 Nov 2024 10:59:08 -0800 (PST)
Received: from fionn.redhat.com ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2ea6bsm721031785a.16.2024.11.13.10.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:59:08 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: timerlat: Add --timerlat-interval
Date: Wed, 13 Nov 2024 13:58:43 -0500
Message-ID: <20241113185843.177666-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the option --timerlat-interval to the rteval timerlat measurement
module.

This corresponds to the --cyclictest-interval in the cyclictest
measurement module.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index df42777d4a3e..3fcdb5ff2819 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -226,7 +226,8 @@ class Timerlat(rtevalModulePrototype):
         self._setReady()
 
     def _WorkloadPrepare(self):
-        self.__cmd = ['rtla', 'timerlat', 'hist', '-P', f'f:{int(self.__priority)}', '-u']
+        self.__interval = 'interval' in self.__cfg and f'-p{int(self.__cfg.interval)}' or ""
+        self.__cmd = ['rtla', 'timerlat', 'hist', self.__interval, '-P', f'f:{int(self.__priority)}', '-u']
         self.__cmd.append(f'-c{self.__cpulist}')
         self.__cmd.append(f'-E{self.__buckets}')
 
@@ -499,7 +500,10 @@ class Timerlat(rtevalModulePrototype):
 
 def ModuleParameters():
     """ default parameters """
-    return {"priority": {"descr": "Run rtla timerlat with this priority",
+    return {"interval": {"descr": "Base interval or period of threads in microseconds",
+                         "default": 100,
+                         "metavar": "INTV_US"},
+            "priority": {"descr": "Run rtla timerlat with this priority",
                          "default": 95,
                          "metavar": "PRIO" },
             "buckets":  {"descr": "Number of buckets",
-- 
2.47.0

