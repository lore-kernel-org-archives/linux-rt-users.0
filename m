Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0472954F87
	for <linux-rt-users@vger.kernel.org>; Fri, 12 Apr 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947893; cv=none; b=uQthdakXMOamwV2/dNRrfdEMvpP2SUX2qSGunTMzniltRiXpXnojQEQv+mNF5OCPSkvyCxoLJiwReYcp4rHjy5PVMFCPYUSU28UxIDjxNK6jLZmXHlxA/QUA3QZrFZb/0hjaTmyiFxwuxcZMx0eq6BMmQqudlcNRcsJD21dOxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947893; c=relaxed/simple;
	bh=zRf08E/euspiAsmAPxvlABO5dKqo06j0IfcivLx6Ttk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1RuZkkG7uCWvsQmIivluWLL15FPYYpBhRF1DoBe0E7GaymW9R14OAm105sNI9TIyWOv+ZJHz/7jdpAP7LmX7GkYimzNA+xy/jBqA7Xbn+9twXwmQlsxA8SYLNT4rUBvGXhcyhoEhZ0u3JR1nIUQ5nTUAP40TBmHlAi35+oHxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j146JWSO; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j146JWSO"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc73148611so1411583276.3
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Apr 2024 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712947890; x=1713552690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ne34t1ABkSiXU3G+sKa7u4BaZfKvUiRaV+hzM5X+GY=;
        b=j146JWSOh9OanqjklVDKE5WvXlHRQrs2eCaOOngEmXiKAdIZv9LjKNrz0Zmfrb/iUi
         Tr6yBONLw1XY5RRFrItkdaRHHy2kgDsrZDj/qwynIZutBWp+4ZZc+prKW+OkCzb3DFiE
         i24bT8ZU9J2zwmFSTe9rUYd5/HppR7EN6QyXCET8xn23hIZyUxZJhsFWo98YeFQgWGeg
         Ekh/9wP6N7UyzNIOoPjBraraCRXzz6HeoBFneHPajp3KosDIEKpaaCJLNFpGI7GKTwNj
         MKidUClaKL4nwszkzh4RxQVKQ8Den6ax0OYcsl1zZgcpZQmMPBELWe/no5uLEZt9I0uY
         Bd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947890; x=1713552690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ne34t1ABkSiXU3G+sKa7u4BaZfKvUiRaV+hzM5X+GY=;
        b=KJp8sxLVvn3Qq9GkTkPyk4faGGAIE50mNiRtnFGTUiHpBjtS62WDksmFBujI1aERA4
         STvHJq7r1DjdFpZ2Pd9mpCqZnn3yx7GA3ypCH8Wu1AGzZRnW073FVO5cf2WP/9zNm96Q
         e+XtVfpbj6rKopJOO6UPE0gnm9/tqiF2rtdOHjn0d0tPsce+zXsuH2v1DS1FoSCVEx0f
         YflfknCTPwgPuGv8y9NJ7+EnSGwOxZMVZX9tfUOCm7fY0QUNQ1e3jNypiR7HihR8GAwk
         3GuBem7YHQ+Ehw09yvbsEZQ9P1MT3Rkv4MP+ofGOmjWzJ4Z3Ikoa/4iJHPBMBR58rQcO
         g4CQ==
X-Gm-Message-State: AOJu0YyOknp5EPcjVWhPrsHmjn36AeEwjgz9aThcZpRBoxmv05R6dqwr
	VyYRq0UpNXa058d6LHusKcOORenWq00x2kA6JvgJBo0bcqA1YuxBeaCVPw==
X-Google-Smtp-Source: AGHT+IGj7qQcKoqIKcxN/8HWP+NrumRD+fC4KPqdEs2pcI/Tk4GCnNKWtzcNC6xEHeLf6nJIr1A8pA==
X-Received: by 2002:a25:dc06:0:b0:de0:f811:be41 with SMTP id y6-20020a25dc06000000b00de0f811be41mr3564579ybe.14.1712947890391;
        Fri, 12 Apr 2024 11:51:30 -0700 (PDT)
Received: from fionn.redhat.com ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id dj12-20020a056214090c00b0069b3bfdea09sm2628750qvb.60.2024.04.12.11.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:51:29 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveria <bristot@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rteval: Cyclictest.py: Make standalone file work again
Date: Fri, 12 Apr 2024 14:50:51 -0400
Message-ID: <20240412185052.87056-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make standalone Cyclictest.py work again for testing purposes
- remove unused parse_cpulist_from_config
- Instead of "import as", use "from" and the requested functionality
- Obtain the default buckets from the ModuleParameters to use if a
  number is not otherwise provided
- set the cpulist to "" if not otherwise provided
- add a few docstrings to functions
- obtain a default cpulist from online_cpus for the standalone test

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 722422589d62..671426e13c4d 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -16,10 +16,8 @@ import math
 import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
-from rteval.systopology import cpuinfo, parse_cpulist_from_config
-import rteval.cpulist_utils as cpulist_utils
-
-expand_cpulist = cpulist_utils.expand_cpulist
+from rteval.systopology import cpuinfo, SysTopology
+from rteval.cpulist_utils import expand_cpulist, collapse_cpulist
 
 class RunData:
     '''class to keep instance data from a cyclictest run'''
@@ -190,10 +188,11 @@ class Cyclictest(rtevalModulePrototype):
         # Create a RunData object per CPU core
         self.__numanodes = int(self.__cfg.setdefault('numanodes', 0))
         self.__priority = int(self.__cfg.setdefault('priority', 95))
-        self.__buckets = int(self.__cfg.setdefault('buckets', 2000))
+        default_buckets = ModuleParameters()["buckets"]["default"]
+        self.__buckets = int(self.__cfg.setdefault('buckets', default_buckets))
         self.__numcores = 0
         self.__cyclicdata = {}
-        self.__cpulist = self.__cfg.cpulist
+        self.__cpulist = self.__cfg.setdefault('cpulist', "")
         self.__cpus = [str(c) for c in expand_cpulist(self.__cpulist)]
         self.__numcores = len(self.__cpus)
 
@@ -393,14 +392,13 @@ class Cyclictest(rtevalModulePrototype):
         return rep_n
 
 
-
 def ModuleInfo():
     return {"parallel": True,
             "loads": True}
 
 
-
 def ModuleParameters():
+    """ default parameters """
     return {"interval": {"descr": "Base interval of the threads in microseconds",
                          "default": 100,
                          "metavar": "INTV_US"},
@@ -421,6 +419,7 @@ def ModuleParameters():
 
 
 def create(params, logger):
+    """ Instantiate a Cyclictest measurement module object """
     return Cyclictest(params, logger)
 
 
@@ -438,9 +437,7 @@ if __name__ == '__main__':
     cfg.AppendConfig('cyclictest', prms)
 
     cfg_ct = cfg.GetSection('cyclictest')
-    cfg_ct.reportdir = "."
-    cfg_ct.buckets = 200
-    # cfg_ct.breaktrace = 30
+    cfg_ct.cpulist = collapse_cpulist(SysTopology().online_cpus())
 
     runtime = 10
 
-- 
2.44.0

