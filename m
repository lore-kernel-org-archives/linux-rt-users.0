Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC621A3150
	for <linux-rt-users@vger.kernel.org>; Wed,  2 Jul 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446847; cv=none; b=N8fanEGmcIXdRtLvUYKGdi7TixULtB6NmwxoEbTxdqxvH6RVKtuBjffvM29eBQEhUQen7gpEWyBWTgMmqMt5XZ271czToAvKFr87zm7u3ZAQRdyn18CLWzp+G9j7euB8tDUp8MqBzL/Cir8FyroFWrbkbOksOhXE43bZepRLCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446847; c=relaxed/simple;
	bh=f2cZyh89ROQwIj+OixwhJbJWHw8J6SlTO6cTwRmMsi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mI/+q+kMZ4Bvh5js6D0UejbHIITPreOkfs9L7bhBcsPNinsVk8H/JSXwK8EgvU7C8atwBkpGcyWEBwoNyRnspGYp0P+C2EjZkrX3/WBUN0mEyC8ltSHV4QFChLR4XQeGdb7eKGLX0YOALsMgY0kRlPlRA4vNKNg64ADqvF+JOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45310223677so29745865e9.0
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Jul 2025 02:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446841; x=1752051641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z+0Gus2nmlZIhba6xFQ3k0ya3vGHSGJLuRd+o+Bfxk=;
        b=WoOqyvdn6hi0OwSh/7B+XY8kBA6ctc9odq6tAV/GNn3T2ml0PuFzi7yyxCm8Bww8lT
         wsWMCtkAo8l4ts7UoUNA78i/ZZXGB5nhknEqecbCYzOg0H7QVDb+UZ6gsXxrMesR+tw5
         nAvBQIwsRVjtU9T/e6G205AxrylgJ6TcFbY32rl5BTFiHEgyiavPo5Mng4IcRLz9/xCT
         eKOB93MHS72W73mSZLP+ucyLQaZfTde0fqRkPpjhthLpYVmx82vWQnxyVm7hkUXUZkRh
         hUaKzkz+2Rosltfc94dgnDdX3I4xcTG+oOoS26TbHLVouH4EozG+YCrklBQ4+f0l57xU
         bI1A==
X-Forwarded-Encrypted: i=1; AJvYcCUYpxlwu4nwMk42tvoihZuSWn5F+d1ge7ToZ/NKyYGekw1IWVFwsVaPYbksMWsjZjqeBOwlVbOEOPD0yOo59Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QGNAJ3H+xzOJPVXt6VZslYGlCYhyiW79AS1nc+aeMvTHenqU
	fdp+ry2cTAN1o9imK/xfqJMHmIz1mGFGW2RQwghh/nigBAK3/Or6VrkTeffluBVQ
X-Gm-Gg: ASbGncuhNv16DaJqsyScsi2/9n32x4ZdUyKSl1po/7/cgYpKBfTvRZegPFTxtZpw00c
	HGmLlDImYU0X+l6OcteGkZFIRHu1ueIetiF34p6FX0gnqvT8oPyAMDhqKkvwI/WA6BaqRXJXVsf
	tTV9qju02K7PA79o00L1UuCTXvrB0NKDqLHI9z+mCTugOGn1kwxfFo/v7Q4uTr5xHWY3aMIBNAU
	v6fUTYRyPtL5xC7oqJxVEEzEst06t+0oCInQX0tdRw/5NK+nJUdsk33EwMNHTm+1J66THOePuyY
	P+2wbJ0pG0Zg8cxq6DII1iqFQBt0q8VGqm4oqmg/O8r1OoG27RNqR0JY7aiYfY8YUMvMlFbGEtk
	pFyE=
X-Google-Smtp-Source: AGHT+IHzAn1EmZppK6B27E2/O5Eh7lyrBuYKpC22Wjdn1K8GjQJpm0Yjn0uvtQaplEtiql2ThcEeTA==
X-Received: by 2002:a05:600c:c096:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-454a3a312a6mr13766605e9.24.1751446841401;
        Wed, 02 Jul 2025 02:00:41 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45388888533sm204669145e9.21.2025.07.02.02.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:00:40 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v1] rt-tests: hwlatdetect: Add field count to samples output
Date: Wed,  2 Jul 2025 12:00:17 +0300
Message-ID: <20250702090017.1949657-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel commit b396bfdebffc ("tracing: Have hwlat ts be first instance
and record count of instances") adds field `count`.

Add processing of `count` field to hwlatdetect.py.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 68f312db639f..af9852cc95e8 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -38,6 +38,17 @@ def group_sep(num_hex):
     return ','.join([num_hex[max(i - 8, 0):i] for i in range(len(num_hex), 0, -8)][::-1])
 
 
+def key_values(fields):
+    """ Extract key:value pairs from a list of fields and return them as a dictionary """
+    return {
+        k: v
+        for field in fields
+            if ':' in field
+                for k, v in [field.split(":", 1)]
+                    if k and v
+    }
+
+
 #
 # Class used to manage mounting and umounting the debugfs
 # filesystem. Note that if an instance of this class mounts
@@ -242,19 +253,21 @@     def detect(self):
 
     class Sample:
         'private class for tracer sample data'
-        __slots__ = 'cpu', 'timestamp', 'inner', 'outer'
+        __slots__ = 'cpu', 'timestamp', 'inner', 'outer', 'count'
 
         def __init__(self, line):
             fields = line.split()
+            kv = key_values(fields)
             self.cpu = int(fields[1][1:-1])
             i, o = fields[6].split('/')
             ts = fields[7][3:]
             self.timestamp = str(ts)
             self.inner = int(i)
             self.outer = int(o)
+            self.count = int(kv["count"])
 
         def __str__(self):
-            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
+            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}, count:{self.count}"
 
         def display(self):
             """ convert object to string and print """
@@ -286,7 +299,7 @@     def set(self, field, val):
 
     def get(self, field):
         if field == "count":
-            return len(self.samples)
+            return sum(s.count for s in self.samples)
         if field == "max":
             max = 0
             for values in self.samples:
-- 
2.48.1

