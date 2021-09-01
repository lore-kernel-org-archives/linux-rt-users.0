Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F2AC432BE
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1706103A
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242893AbhIAIJe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbhIAIJc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Sep 2021 04:09:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37033C061575
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Sep 2021 01:08:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fz10so1379421pjb.0
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Sep 2021 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/CF16kZJZkQPH0G8TrjahVb86M3Ad+WbMog4tm7yyo=;
        b=LK6ZqKycoFmBGqPMO4KY80jUv72ubq1HZZmVUkYZ40fg5vWmJzki1BqGHa1YfAAGH3
         5MyO9Qs133Uli2fStpspHQp7vK4xJw+IqOnvhbbKvI2jqIo14V3oSbm/oiGHrD9BORlP
         ghAdIpAyKFpArlaQUBf69OGR3pIwDIsy2+T4uvU90su5AqX1GlgjoQVFE51A/6FKEaxo
         jUh0p877xndto4Af7Jo9M+YaQOo1rZGoykuWQumy25kN7qyWDP4cZUDxomVUdGKF+hY6
         kcTbvUj8rhnI+uarqLKsSZgSugfZyVTes/WwNoVsVwYlvmC3UH79lRsr/BJkbaF2xYDl
         5UOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/CF16kZJZkQPH0G8TrjahVb86M3Ad+WbMog4tm7yyo=;
        b=nHqrhGQI0oVbd+Jb9JUEk3LNuxPIb4iiMS9ykA/bkjNPvgntDS44AlCsaLYt5+weZw
         QwtUkwOs8FN/mo5Bf0aw0SuWSf87Hg6fKm9tibal8G+Te3ihGFiczZm6UcZFVHNMzw1T
         Aj/oWaFA5LibHmCPC4CE2Q33sEyXsW1AFW5LHx13rGbMdVSewvuXBnrww82iNsbpbUhY
         KCK2g1bdi4G+0VbXrK8pqNxvVjkuQl2mG+j1nL/6nQ4YnIdgzsXs3C8macVAgSnXwJU0
         WrMADga/bGCBbg9o0baCrOZ3eKUZM0rJ0KT7RSM+tdI5P5R6QIlEnI1+3G71/AMxhP5i
         905A==
X-Gm-Message-State: AOAM533f5p7Th3cb/GCBe0YB/gySBjiCDlV4XXYI79zqyySdivjE5gHp
        i/enifKAxOHMtwc6gvLObQaSB8bG7pY=
X-Google-Smtp-Source: ABdhPJxhZAGvw9bHJHzqHxS3nT3SKt9PqM5KUtwKir1H3LkjmeucESAbihjPf/xkJP6O1y8PJgH9XQ==
X-Received: by 2002:a17:90a:bc8d:: with SMTP id x13mr10402958pjr.66.1630483715729;
        Wed, 01 Sep 2021 01:08:35 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id y12sm22650055pgl.65.2021.09.01.01.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 01:08:35 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     punit1.agrawal@toshiba.co.jp,
        Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 2/5] rteval: cyclictest.py: Update logic to get core description
Date:   Wed,  1 Sep 2021 17:08:13 +0900
Message-Id: <20210901080816.721731-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210901080816.721731-1-punitagrawal@gmail.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Certain architectures such as arm and arm64 don't have a "model name"
in /proc/cpuinfo but provide other identifying information such as
implementer, architecture, variant, part, revision, etc..

Add a function 'get_cpumodel()' that takes the per-core dictionary
constructed from /proc/cpuinfo and uses the available data to
construct the CPU description. Update the users of "model name" to use
the newly added function.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/misc.py                           | 23 ++++++++++++++++++++++-
 rteval/modules/measurement/cyclictest.py |  8 +++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/rteval/misc.py b/rteval/misc.py
index 0dd361ff19fd..537041b53d61 100644
--- a/rteval/misc.py
+++ b/rteval/misc.py
@@ -79,6 +79,27 @@ def cpuinfo():
         info[core][key] = val
     return info
 
+# Pass the per-core dictionary that is part of the dictionary returned
+# by cpuinfo()
+def get_cpumodel(core_info):
+    desc = core_info.get('model name', '')
+    if not desc:
+        # On Arm (both 32 and 64 bit), 'CPU Implementer' is always
+        # present. Return 'unknown' otherwise
+        if 'CPU implementer' not in core_info:
+            desc = 'unknown'
+        else:
+            implementor = core_info.get('CPU implementer', '')
+            architecture = core_info.get('CPU architecture', '')
+            variant = core_info.get('CPU variant', '')
+            part = core_info.get('CPU part', '')
+            revision = core_info.get('CPU revision', '')
+
+            desc = 'Implementor: %s Architecture: %s Variant: %s Part: %s Revision: %s' \
+                % (implementor, architecture, variant, part, revision)
+
+    return desc
+
 if __name__ == "__main__":
 
     info = cpuinfo()
@@ -86,4 +107,4 @@ if __name__ == "__main__":
     for i in idx:
         print("%s: %s" % (i, info[i]))
 
-    print("0: %s" % (info['0']['model name']))
+    print("0: %s" % (get_cpumodel(info['0'])))
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index b1755d4f4421..11cb45e711dd 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -34,7 +34,7 @@ import math
 import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
-from rteval.misc import expand_cpulist, online_cpus, cpuinfo
+from rteval.misc import expand_cpulist, online_cpus, cpuinfo, get_cpumodel
 
 class RunData:
     '''class to keep instance data from a cyclictest run'''
@@ -226,13 +226,15 @@ class Cyclictest(rtevalModulePrototype):
         for core in self.__cpus:
             self.__cyclicdata[core] = RunData(core, 'core', self.__priority,
                                               logfnc=self._log)
-            self.__cyclicdata[core].description = info[core]['model name']
+            self.__cyclicdata[core].description = get_cpumodel(info[core])
+            if self.__cyclicdata[core].description == 'unknown':
+                self._log(Log.INFO, "Unknown model for core %d" % core)
 
         # Create a RunData object for the overall system
         self.__cyclicdata['system'] = RunData('system',
                                               'system', self.__priority,
                                               logfnc=self._log)
-        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0']['model name']
+        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + get_cpumodel(info['0'])
 
         if self.__sparse:
             self._log(Log.DEBUG, "system using %d cpu cores" % self.__numcores)
-- 
2.32.0

