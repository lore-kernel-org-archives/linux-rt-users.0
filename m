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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54263C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 08:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C73961056
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 08:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbhIQIzb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 04:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhIQIza (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Sep 2021 04:55:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D9C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2021 01:54:08 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so8995000pgf.5
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2021 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaIH7Nm/eonGJSkkOd0bJYXfLYhwUXgxhxJTOKMhsTQ=;
        b=bBj1Jf15VCEaW9ONyrIiZXfA21IkZepbSHx2CharcMLHgE52sCCS0M95p5Tpojg1S8
         S1QMNhk75w5mghT9vFfE54BbohB8WYz0ND1C4cYtlfg6WHRwfxu/YWXUGfNK1TpC3wDU
         ylRTedcNhRjDz+amcDWFRcVXrzqexd8KCSiknTIlQlquFE4oVvufU3p5pE0bA00n49nv
         31xARn50Ip/uSX67j528HHdE2VmeH6Txx6kz6SjIQCoMpCdM8//Gba1MyKo7LYO612jm
         H0boPF+T+v3N7TJ7GQ/FSHk9HEZp7vqOJKOSk4TzwO2XiMnc1hE7PIojq89Bc+CSbipH
         tUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaIH7Nm/eonGJSkkOd0bJYXfLYhwUXgxhxJTOKMhsTQ=;
        b=urL9K6wZeJEcWillyfhD9I1HV8PJtMHJoB5zjKMhJ1tO5wz5bfAyimdvBU1rIXVub9
         ZGDAQGVN3bHw/M3LMSfMlXiNybwQPwHyeloTmrECaM0cjpe+fknmr6hP//3uRjwjLNO/
         Z7kcOOLm+0Ml+D/mLwHXIXXsBv+0Xu0zQlKnUF0MlKy8LcWdUlvvcDEj0+7Th1P8IANr
         ikOGXHOmuoAiGUgvhuFaqB7VuUHiSuaB1iGqyzxkDTiI6XZlYzz0i0TmWAA2YdrrKO2j
         kMzCTz5AwiDm/tVBpt1k184WYrFKD1uqI7oOP9MSBYXCYwjBp7QL9Wp3kSYNTIdbwKEd
         353g==
X-Gm-Message-State: AOAM533uUHjpRbPSKZzPXfOAD8vWIRxRmZ5cnPBsapwHd+wLZdglKQOE
        PW0MaSCAZJRO//ENDQEV7Us=
X-Google-Smtp-Source: ABdhPJz5YTWkO2vElCX/mJjrQ2U+VVFTOLgoodMbW5eSKG2gpVd1HwwywYz4Inc7yjDG0zHoUV3IVQ==
X-Received: by 2002:a62:2f47:0:b0:434:5705:3a83 with SMTP id v68-20020a622f47000000b0043457053a83mr9455103pfv.11.1631868848269;
        Fri, 17 Sep 2021 01:54:08 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id t13sm4956190pjg.25.2021.09.17.01.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 01:54:07 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: [PATCH v2 1/3] rteval: cyclictest.py Enable logging cyclictest output
Date:   Fri, 17 Sep 2021 17:53:41 +0900
Message-Id: <20210917085343.2775300-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917085343.2775300-1-punitagrawal@gmail.com>
References: <20210917085343.2775300-1-punitagrawal@gmail.com>
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
2.32.0

