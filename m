Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBDD1D543
	for <linux-rt-users@vger.kernel.org>; Fri,  3 May 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768675; cv=none; b=ndU/eUQ41L9CwhpyuIvIwWAVQzqOo/nbr/t0jgTR3BtxCMIGuqPIQqLUW9gNutnev8/hA1WxC/D//kluJxGPeQNDlQif9h5Dsjke2vBxp1451Uq4x7P9CmrbGjnyifKO9ATfRanOmJztDtNu5BI39fBHCwN3C/x8LOV7DwhvJig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768675; c=relaxed/simple;
	bh=Qyy9hDeLH8S38e55HDEMpVxPj3DiD7Je9hfb52BB3hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTGGTxQcoaS72pSPYj1EpGj/Eu1ZuJxSHeg493NPytniSRJPJh3CujSvI/gd7dXyUNw3nn7d/fbtByNE5M6lay+YgKRsF/d1W3ECzpHa2l2+qkVwSIhEYUSHOwCJIM7CDu8MHJSq5WDYhn+jSOYA4Lq00gb9lb1bsvlvsmy0kdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuASoRqW; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuASoRqW"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78f05341128so2513085a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 03 May 2024 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714768672; x=1715373472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lq5CAwC6hlV/squlospfV2+GYZrsjgv3/I1V7jYuHko=;
        b=IuASoRqWlNsSmy2a3IIf0z9TKILPN/5ceK2R6USN2kuii2+WED+vRdAgVeRW3rLvf4
         cqfGhAz6eYC5riOWlZsuGG7oRsj0qbev7nqLcbguOzpkOAbcOksEB/BGs8FW8cQy14XZ
         nzgCCkOOX0baOMfQvglnSUhPVZiVwzpW+GEMe+ZbnsZ0TouCsRjZAOk4z/kLt98IUOg4
         wM/OYnMgI6Ghs2g55mcH9UrVtSe6Mxl0M8tvVhPwnsghu4khxnk4T/uxbWlI0NJ15l0N
         ++tgERzEmCpdL5W8I/CIZoubhdUsxc0LY2+qfA5+nJpa2XZr4KT56tIx48N/CN9zMsEp
         4NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714768672; x=1715373472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq5CAwC6hlV/squlospfV2+GYZrsjgv3/I1V7jYuHko=;
        b=t5fvQkNTwhGoYwxxw0QMckiHqhxlB/DJJj1xZxvYE1/CfypuuCaoqz9MS4HtoICI4w
         at0IF/vs28hUY4b2sDxttailqbRg4p0Nz4G8ZpAXd1n7EzxUTJbpXXi/M8jHDvh1yrWy
         ET261nAlzFIbxl8Ls5GrtQBY2LHT2X8YMQS6B0+ncvbfaaqJ6I31p43zlYlJAmQKMD+y
         nGQ/csHlPE++nAfSZFiL9omj0iwBAqcGL7asr9f0jScMEUaOwQOP0N0+FgzoXAOEQ2c7
         2Hf4Elug+/h865/eeoew+DafDXfmZQdZXE1vN2a007e0ZMwkmJN8U0WFg68z6mnhBoOv
         KwGQ==
X-Gm-Message-State: AOJu0YzmOYT+suz7QC3hIMAfc0TJCt80qADus6OjKRkPaOa8GPltDziv
	jr5q62jorYmfG4lHyO1aV8WyNZ0AjjFTVbuKpsUtrJ8gkbQGssqVr6G4OA==
X-Google-Smtp-Source: AGHT+IEA9Nhli3DAvbmIwdyxhxkccEqGYR4wZHnWvNXPl6QBpkK89Fpubmtz17amW0sxbEDyaklUVQ==
X-Received: by 2002:a05:6214:29ea:b0:6a0:c924:10a with SMTP id jv10-20020a05621429ea00b006a0c924010amr4090329qvb.38.1714768672077;
        Fri, 03 May 2024 13:37:52 -0700 (PDT)
Received: from localhost.localdomain ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id j14-20020a056214032e00b006a0fbb7e6acsm1474938qvu.107.2024.05.03.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:37:51 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: stress-ng: Use inherited method to set exclusive module
Date: Fri,  3 May 2024 16:37:12 -0400
Message-ID: <20240503203712.67724-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the method set_exclusive() in the rtevalModuleProtype and use it in
stress-ng instead of setting the variable directly

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/__init__.py       | 5 +++++
 rteval/modules/loads/stressng.py | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index cdb0e56f0c63..4330a839db6f 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -62,6 +62,11 @@ class rtevalModulePrototype(threading.Thread):
         return self._exclusive
 
 
+    def set_exclusive(self):
+        """ Sets This module to run alone """
+        self._exclusive = True
+
+
     def set_donotrun(self):
         """ set a module's donotrun field to True """
         self._donotrun = True
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index cbcf6b74c1c2..4f6abfb5eabd 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -31,7 +31,7 @@ class Stressng(CommandLineLoad):
         else:
             self._donotrun = True
         # When this module runs, other load modules should not
-        self._exclusive = True
+        self.set_exclusive()
 
     def _WorkloadSetup(self):
         " Since there is nothing to build, we don't need to do anything here "
-- 
2.44.0

