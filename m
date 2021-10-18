Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F305C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 05:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F99460F25
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 05:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhJRGAI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRGAH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 02:00:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D28C06161C
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 22:57:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v20so10444912plo.7
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 22:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H84R6NGasLTNb95Sy+O3zA/IAsFbwTerVO6HDFRzEzc=;
        b=bpqcl3kvOofFLwEhwT96SE602+UUGJVMp0cEnJMirXWcc2Ky+jLLYy11NhoWVVpL5V
         W96MWDq7gWz4LVMx5HPWIF9hdSjK9psiIzdDrKv1qhJH8yvmDjJUSn+4v/tFHk9UjZWX
         Oa91t8Z5MrjS/guh3iqCSaDdyLl4k3g12YWg9NytCgRGCO4xbKfgSTCwfqAcX0vjuUvz
         ceVmsEgUSPSYZJRVXgSYSVq1wDYSNhBODxD8fewqKeFZBCX1nRpiaCy3sgkeCfIpkbq8
         /YWNAgEydVIOqR5EXExDDPDZJkDxgD1ZxITOyWwWCXjElb2mzVoRjR4/ZSUz+dTVB6i9
         Hqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H84R6NGasLTNb95Sy+O3zA/IAsFbwTerVO6HDFRzEzc=;
        b=prSWlW/O04MwAqLHwkITaYgz+8eBmTXEU+F7WwA8bNdo6LkK+lwYaVCLw5pjKZt2xP
         FQQJSMwHDcvn3c0GYWW4pMmu86TXRO8HtBloAs1R5yg9iulziQxjwucpMZRicyquTScs
         oePjxy62fwcoVd4UWewXdo07jzhfBIjKoozYpGcVRVH8z+EVPPlDkVjGUuRppDZRRxgb
         uDsWO2r1ptEwBWwiw6+yrbJEG37YYAhnBKgxU+enrKFXelszxQNzm18yCuUakZO4iMaS
         NtwbF0DKUk4WiwaJnEgEwNVZDC20XkFvMwQEBVxHRvtPqsylNmh5vP1VIk/KmdK9V5uI
         NZyA==
X-Gm-Message-State: AOAM5330y8ve/duvYIUCMRYtVpl5XLn0zb/LQdQC7LEO7KzXyot/CiI6
        APj5dOj6uFU0/SkzqLTfDQhcwXMQwno=
X-Google-Smtp-Source: ABdhPJyL2Yb1jLvcIxig1vCALeXF6c0jQR7Pzx1kvJYMeelzcWWvwFHnqLjdNJYHPin5cZ2MY/ctcw==
X-Received: by 2002:a17:902:9a4b:b0:13f:c764:6e85 with SMTP id x11-20020a1709029a4b00b0013fc7646e85mr164279plv.29.1634536676679;
        Sun, 17 Oct 2021 22:57:56 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id x7sm11639744pfj.164.2021.10.17.22.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 22:57:56 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH v3 1/4] rteval: cyclictest.py Enable logging cyclictest output
Date:   Mon, 18 Oct 2021 14:57:33 +0900
Message-Id: <20211018055736.412576-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018055736.412576-1-punitagrawal@gmail.com>
References: <20211018055736.412576-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

The cyclictest.py module uses a temporary file to store the output
from "cyclictest" which is deleted at the end of the run. As the
collected log contains information that can be useful for development
or debugging, having the ability to persist the logs is useful.

With this goal, introduce a configuration option for the cyclictest.py
module, "savelogs", that can be used to enable persisting the
cyclictest output to a logfile. As the logs an be quite large, the
default is to not save them.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/modules/measurement/cyclictest.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index b1755d4f4421..ee1de883d844 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -197,6 +197,8 @@ class Cyclictest(rtevalModulePrototype):
         self.__numanodes = int(self.__cfg.setdefault('numanodes', 0))
         self.__priority = int(self.__cfg.setdefault('priority', 95))
         self.__buckets = int(self.__cfg.setdefault('buckets', 2000))
+        self.__reportdir = self.__cfg.setdefault('reportdir', os.getcwd())
+        self.__save_logs = self.__cfg.setdefault('savelogs', False)
         self.__numcores = 0
         self.__cpus = []
         self.__cyclicdata = {}
@@ -255,6 +257,8 @@ class Cyclictest(rtevalModulePrototype):
         mounts.close()
         return ret
 
+    def _open_logfile(self, name):
+        return open(os.path.join(self.__reportdir, "logs", name), 'w+b')
 
     def _WorkloadSetup(self):
         self.__cyclicprocess = None
@@ -288,7 +292,10 @@ class Cyclictest(rtevalModulePrototype):
             self.__cmd.append("--tracemark")
 
         # Buffer for cyclictest data written to stdout
-        self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
+        if self.__save_logs:
+            self.__cyclicoutput = self._open_logfile('cyclictest.stdout')
+        else:
+            self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
 
 
     def _WorkloadTask(self):
-- 
2.33.0

