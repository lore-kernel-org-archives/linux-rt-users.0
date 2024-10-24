Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B281FE0E7
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Oct 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793321; cv=none; b=i7lJGrPjQo9MCiclDc5L5Hfs4OJr7uhc7/MVOuHl58iDN4O7ic1pSjCzGAgqNRiiGV6Lg5jdzV1RN7kQCrrTJau+N2IV0e4LIRLHWTOJCN6etH3P8uXRrCPS3Xe8AItEKJOtP5BdTpIq3ZcV3tUBeBWGFDRdjxI1wWa/Kh4hXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793321; c=relaxed/simple;
	bh=KjjalHJTTSkj/E9JY06RccfpVPVUrsNRcaMYrHn4wpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVOkLOk69xFHrJKlCOUPkJKCC9Wm2D7JSP2IJ5/M+2soKN5Vx9bUcDygmD0m4HrtZ8F7VQH+Kml+gVOU6dNjHEpZrlqB/T10cxD/Vlk/jmIYBkODbpgO7gAtw1HyCjrnDwPPOTVh2au/Ny64NTKfqeBtfK3/WYN4EZKN8LbF9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrRvBMh4; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrRvBMh4"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460a23ad00eso20555811cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Oct 2024 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729793317; x=1730398117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/zx2ovMB0SQIThMRzoVOdiaiVNdGuTQyue3h+6eSPaU=;
        b=TrRvBMh4FfIA8CAb9XvfXrNRoOEoYKBiO+HkszTpW059jo1OvaGl3+ehdbaiIlKNeO
         HPTBzmZXapUA4G8U7da56Zr9uI2ouFz0WYsumUWTDq/1CO1PRv1Oc79JoLbtKZC3d+R/
         K5pDWlX8NkZ2IqOjc6GiUk2OcIbPwh+S+ARtldqOvMym7pAy17GtFD9OgZudjp4R/Soj
         urnhzq1WzQ0S42hiIbkHFA43pY+rU92hPGykCaQBfIGzG54yaDiPWkE/7xB0NNcisUjp
         H93RKZ6rgsXkRnBQsNaDtkuNcZPrbTYCEbee4HGEeYDeCar5f6mblAvzTBjE6Vvz0+fA
         aiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793317; x=1730398117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zx2ovMB0SQIThMRzoVOdiaiVNdGuTQyue3h+6eSPaU=;
        b=BVnEp/UX2cO3g5vrQrP7Tne+L2oSj95IWMXVpgJA/E8XEhj/cJWC79vhf+wSBqvWda
         otvMCYKDGmno0ZqyfztjHxALfcv/NY4K7pK04PwTV9VqsjHh7AbYMnxxYjqMM7GHt+hw
         iMlqJFrt1GaWxWJ1Ea5+tqCvut2XhG9TLK67sbVwj/MDqH5IlfVqReNKyPtKhwkZMcfV
         32nUMzPzLhErCALgkGdjCa0X3wLPMQWp6uIaGxMcc8KlegYSfFtjVdMa4BJ0SSVbpJ0f
         ZNQWmnKSzGOKLPqDN+qqgxxqSnmbkP2V/7xNGFuIQXdTCB71tQfwsr3C4SeFCrNbDj25
         ybAg==
X-Gm-Message-State: AOJu0YwEomEQE3Z6uC52+Mgeee1iJi0JUFjGtAJzSvoKrvtV7uc/yQlI
	S0zWsNEjKz9t0jVkPqxjTN+NuJRnoqB/Bo7ZA33D4rftSMM5bQoVi9RhpQ==
X-Google-Smtp-Source: AGHT+IEmRqOG8TQMwC3vX898XX8eWqHSWW7NtfKGm18Ztpe9ZytqkrzNuSiRXa1VdK/EwwCktPrJpQ==
X-Received: by 2002:ac8:7f55:0:b0:461:1593:9234 with SMTP id d75a77b69052e-46125251ce9mr46963921cf.1.1729793317148;
        Thu, 24 Oct 2024 11:08:37 -0700 (PDT)
Received: from fionn.home ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3dab83fsm54121801cf.88.2024.10.24.11.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:08:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rteval: Change constant name to uppercase
Date: Thu, 24 Oct 2024 14:08:12 -0400
Message-ID: <20241024180813.48368-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change constant name earlystop to EARLYSTOP
add "from err" when re-raising RuntimeError

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/__init__.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 8ded374d287e..7c13e84e03bf 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -28,7 +28,7 @@ from rteval import version
 
 RTEVAL_VERSION = version.RTEVAL_VERSION
 
-earlystop = False
+EARLYSTOP = False
 
 stopsig = threading.Event()
 def sig_handler(signum, frame):
@@ -106,7 +106,7 @@ class RtEval(rtevalReport):
             if not onlyload or self.__rtevcfg.logging:
                 self.__reportdir = self._make_report_dir(self.__rtevcfg.workdir, "summary.xml")
         except Exception as err:
-            raise RuntimeError(f"Cannot create report directory (NFS with rootsquash on?) [{err}]]")
+            raise RuntimeError(f"Cannot create report directory (NFS with rootsquash on?) [{err}]]") from err
 
         params = {'workdir':self.__rtevcfg.workdir,
                   'reportdir':self.__reportdir and self.__reportdir or "",
@@ -131,7 +131,7 @@ class RtEval(rtevalReport):
 
 
     def __RunMeasurement(self):
-        global earlystop
+        global EARLYSTOP
 
         measure_start = None
         try:
@@ -186,7 +186,7 @@ class RtEval(rtevalReport):
                 stopsig.wait(min(stoptime - currtime, 60.0))
                 if not self._measuremods.isAlive():
                     stoptime = currtime
-                    earlystop = True
+                    EARLYSTOP = True
                     self.__logger.log(Log.WARN,
                                       "Measurement threads did not use the full time slot. Doing a controlled stop.")
 
@@ -214,7 +214,7 @@ class RtEval(rtevalReport):
 
         except RuntimeError as err:
             if not stopsig.is_set():
-                raise RuntimeError(f"appeared during measurement: {err}")
+                raise RuntimeError(f"appeared during measurement: {err}") from err
 
         finally:
             # stop measurement threads
@@ -234,7 +234,7 @@ class RtEval(rtevalReport):
 
     def Measure(self):
         """ Run the full measurement suite with reports """
-        global earlystop
+        global EARLYSTOP
         rtevalres = 0
         measure_start = self.__RunMeasurement()
 
@@ -242,7 +242,7 @@ class RtEval(rtevalReport):
         if self.__rtevcfg.sysreport:
             self._sysinfo.run_sysreport(self.__reportdir)
 
-        if earlystop:
+        if EARLYSTOP:
             rtevalres = 1
         self._sysinfo.copy_dmesg(self.__reportdir)
         self._tar_results()
-- 
2.46.2

