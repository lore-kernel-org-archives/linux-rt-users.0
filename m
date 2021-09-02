Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A13DC432BE
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 09:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718F861058
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 09:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245183AbhIBJ0N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245064AbhIBJ0M (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Sep 2021 05:26:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F28C061575
        for <linux-rt-users@vger.kernel.org>; Thu,  2 Sep 2021 02:25:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so1293119pgc.6
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Sep 2021 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmCaDM1U0WaT8LSXZ5sOTiK3+wpdfRr4q9T02K3qbKA=;
        b=Yn73HelmglhJTNvBmgtBmM1cECGTXJVFHgaziVl5Tp8KieEJzekTwJcmOuKviIvXhb
         8PYiOXjB0bF55QzrKHsj2yLAtWnBGVJfRv5ODwF9wcJyiG9/igJjmfC98GEWrSEUnPOI
         jGkS2c3iZ9e23oCMGruBgCsyLU9JpvxlIGEYG8mbNwUC/M+cO+KgpMzlP/qc5s0AkMG9
         QBnMUzmdxJWSA8yP2qJEIo61faFAHdG+gFLebR/xS1ndBwxtz4hMJ1tcqtzodDZVxwCV
         AxLUlVe3KE8GLPzDa29aiEXcqX/YnEf2rq4W7O2LcjS1xtt4ZzF8iXhinPco4wMP5Y2N
         2M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmCaDM1U0WaT8LSXZ5sOTiK3+wpdfRr4q9T02K3qbKA=;
        b=EK16ULbvwHVDifnV9Xb7XVYj8HN8dGJR4kIQ8d21HnyoRkvGZsRPpMlWvPSwGS5QSQ
         2Z2iPAnlWL6cATkpTRKmm7T9lA0OR9tUeYIDm980U+6m/+JGSE3yy6vsRs97RqIhDc1V
         RnvOrbw3LHpp24FOPAhgg26PordWw6iNnJFW4Sftz6XlJeD/o5ibBZz8yYJidv7Kkp8F
         VQTkujZJMv1NI44jLhx4w2PQFWgvV2CE/WdRpMt48QATohTpKrX5l1etr+YLj/sIHndL
         9fuffJ4OvbL2IwPYpaNjf6yEtpo7YLcN0OsaRrifqGspjUvS/vbQ8/xL7rfYBRhZqCf3
         O5nw==
X-Gm-Message-State: AOAM530YjfnboyKCW9nClsc1B3ox03JSqp0zu/TYAePc8/XJVS1AfbxG
        4QtjA79MwV7qWodzZvMJNyQ=
X-Google-Smtp-Source: ABdhPJx/L6MUNCN8wm8rpNjrML1kRvxImWltiepnBEDrmYBDpw7wYaCB6bQLlBAb195MrF14ASC6ig==
X-Received: by 2002:a05:6a00:1150:b0:40a:78df:8179 with SMTP id b16-20020a056a00115000b0040a78df8179mr2437256pfm.67.1630574714557;
        Thu, 02 Sep 2021 02:25:14 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id b20sm1478936pfl.9.2021.09.02.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 02:25:14 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        Venkata.Pyla@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com
Subject: [PATCH 1/3] rteval: cyclictest.py Enable logging cyclictest output
Date:   Thu,  2 Sep 2021 18:24:50 +0900
Message-Id: <20210902092452.726905-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210902092452.726905-1-punitagrawal@gmail.com>
References: <20210902092452.726905-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

The cyclictest.py module uses a temporary file to store the output
from "cyclictest" which is deleted at the end of the run. As the
collected log contains more information than what is being reported by
rteval it would make sense to persist the logs. It can also be useful
to sanity check the results reported by rteval.

With this goal, create a persistent file named
"cyclictest.stdout" (instead of a tempfile) to capture the cyclictest
logs. The file is stored in the same location as the logs from the
other modules.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/modules/measurement/cyclictest.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index b1755d4f4421..0037c3ad07bd 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -197,6 +197,7 @@ class Cyclictest(rtevalModulePrototype):
         self.__numanodes = int(self.__cfg.setdefault('numanodes', 0))
         self.__priority = int(self.__cfg.setdefault('priority', 95))
         self.__buckets = int(self.__cfg.setdefault('buckets', 2000))
+        self.__reportdir = self.__cfg.setdefault('reportdir', os.getcwd())
         self.__numcores = 0
         self.__cpus = []
         self.__cyclicdata = {}
@@ -255,6 +256,8 @@ class Cyclictest(rtevalModulePrototype):
         mounts.close()
         return ret
 
+    def _open_logfile(self, name):
+        return open(os.path.join(self.__reportdir, "logs", name), 'w+b')
 
     def _WorkloadSetup(self):
         self.__cyclicprocess = None
@@ -288,7 +291,7 @@ class Cyclictest(rtevalModulePrototype):
             self.__cmd.append("--tracemark")
 
         # Buffer for cyclictest data written to stdout
-        self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
+        self.__cyclicoutput = self._open_logfile('cyclictest.stdout')
 
 
     def _WorkloadTask(self):
-- 
2.32.0

