Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85681C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68729610C8
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 18:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbhIWSzE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbhIWSzD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Sep 2021 14:55:03 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38E1C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2021 11:53:31 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f130so25073900qke.6
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2021 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWYrnMWfZomC9VGD+kJpPyvzahQYVHY7C4u0owt/5lg=;
        b=JpcCy5azRFKAN0mbK+oQnYbuvrSUcJLiixF4mzmHiGo4KOXidnnva0di2QVNqQFDK0
         6+al7Z+vVl1qBaN1JCLch5xw7TDCOuIW9ji5hnKcV6c5cXfoBsmukorq0yr8A7eunU7G
         nkR98s0FrbbSwS4kExutS9m8VUBZMFF6C1yjxBiBpLdqUChULSZg6nzIi8tlAWAONhj3
         lidQIq9yw1WrBvJyQYYl3/qRW+ONhUvHbSugLL209ThBd5/qiODbJfXjDKtvtp/5vH0L
         mcYn75hZAcdmtWEVQvphmyTybwRjmV645YLpU1NzZV+mM1e/JYQIgRVaVxUEOqSy3BdR
         5GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kWYrnMWfZomC9VGD+kJpPyvzahQYVHY7C4u0owt/5lg=;
        b=1ULru6Ersz5IBWz//VzbRSu+M18C6KVHA08fRSAKIYZUm0xEH4xjt+xaNj/LA9bjao
         LnKFhxmjrcnDpCZ19A2R8AA5OBEMHrTSj7RrT1c2vrXNE01jS+TIDUcxuWRBTrJaXp7r
         kRkol7si6e/UPndJn8WU5iNfZ1fnX1bEmqyK86lRvPO9uTLTvD1G/Yt33MzyEtCstf+J
         V3HB/TkMtqgHkTSVGETPMSWmKuFVl8Ud0rsltE+QSbu8Xvv12MXjiFjX0zft21ExfG+o
         AfIQznwUai3goGT6zdIfzy2qdo03dehqcmG7qEN362eBUUYhVqQ+mRCkuE92JYW2RyHe
         0OeA==
X-Gm-Message-State: AOAM5315V6SrwJ8KyabyybPcrXrORdmALGJf9uVOkYoYxNTTrRhes4/L
        fMW7mTbDXIUXydQwm7DgjKBZZv7TkiQ=
X-Google-Smtp-Source: ABdhPJx8ZxHgjuNoTy2QeyYZwDTUqdiUMM+RKJabPV9VQNSq+XvwBqSA6R+Xn0EJewRMeeSmLIbHZA==
X-Received: by 2002:a37:6249:: with SMTP id w70mr6417852qkb.326.1632423211098;
        Thu, 23 Sep 2021 11:53:31 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-75.dsl.bell.ca. [184.147.140.75])
        by smtp.gmail.com with ESMTPSA id az6sm4672089qkb.70.2021.09.23.11.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 11:53:30 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rteval: Add idea of exclusive load module and make stress-ng one
Date:   Thu, 23 Sep 2021 14:53:19 -0400
Message-Id: <20210923185319.1216575-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923185319.1216575-1-jkacur@redhat.com>
References: <20210923185319.1216575-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When running stress-ng as a load module in rteval, we don't want to run
kcompile or hackbench, so create the notion of an exclusive load module
and make stress-ng one.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/__init__.py       | 21 +++++++++++++++++++++
 rteval/modules/loads/stressng.py |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 6ff82d10bf8c..d52dd597186a 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -58,6 +58,7 @@ class rtevalModulePrototype(threading.Thread):
                          "stop": threading.Event(),
                          "finished": threading.Event()}
         self._donotrun = False
+        self._exclusive = False
         self.__timestamps = {}
         self.__sleeptime = 2.0
 
@@ -75,6 +76,16 @@ class rtevalModulePrototype(threading.Thread):
         return self.__ready
 
 
+    def is_exclusive(self):
+        """ Returns true if this workload should run alone """
+        return self._exclusive
+
+
+    def set_donotrun(self):
+        """ set a module's donotrun field to True """
+        self._donotrun = True
+
+
     def _setReady(self, state=True):
         """ Sets the ready flag for the module """
         self.__ready = state
@@ -459,7 +470,17 @@ class RtEvalModules:
             raise rtevalRuntimeError("No %s modules configured" % self._module_type)
 
         self._logger.log(Log.INFO, "Preparing %s modules" % self._module_type)
+        exclusive = 0
+        for (modname, mod) in self.__modules:
+            if mod.is_exclusive() and mod.WorkloadWillRun():
+                exclusive += 1
         for (modname, mod) in self.__modules:
+            if exclusive >= 1:
+                if exclusive != 1:
+                    msg = f"More than one exclusive load: {exclusive}"
+                    raise RuntimeError(msg)
+                if not mod.is_exclusive() and mod.WorkloadWillRun():
+                    mod.set_donotrun()
             mod.start()
             if mod.WorkloadWillRun():
                 self._logger.log(Log.DEBUG, "\t - Started %s preparations" % modname)
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 926de38e3116..d084814142fb 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -27,6 +27,8 @@ class Stressng(CommandLineLoad):
             self._donotrun = False
         else:
             self._donotrun = True
+        """ When this module runs, other load modules should not """
+        self._exclusive = True
 
     def _WorkloadSetup(self):
         " Since there is nothing to build, we don't need to do anything here "
-- 
2.31.1

