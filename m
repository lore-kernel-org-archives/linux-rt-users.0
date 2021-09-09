Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300A6C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C32361167
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbhIITeA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhIITeA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 15:34:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48390C061574
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Sep 2021 12:32:50 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id u4so2487753qta.2
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0BkU4u51Zmcs1jVs9Bub6l6cAh9ThkxHQrK9MEevH4=;
        b=ReuoGcvV7OAP2p8d4w5N3j7P8/7uRv5MXjQQwqwTjr4aJpSXsStQ48I2O9upgF2CFn
         nij8LsZKnSwOjaKQx6lJ78AMAIwuV0HEnZNYienOx8enpUa6khA5fT93+4D4aSydAws4
         nJTxpdLRPDHLVuGY2ZHKtGCLVWsgIchrIDW+3WNpKCZDPiXMzsSQaUA8aqXyCUaD95p/
         Eo03tLRNsyQFZoyOrKB04lLKWHc3okeAKyB5BTt5Lih5FJxuSIEzDNFqQwQDw6rGQOOv
         wLrqsYj1hTidgIPxEw+GwjJ0Ai1ajpw4mgrISCOagYbIJ5uu8WBqGcIaNy5higpiBADL
         6v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=J0BkU4u51Zmcs1jVs9Bub6l6cAh9ThkxHQrK9MEevH4=;
        b=7m4L8UbtF9C5v4gnPko9+gdddZ7iXygNa6VsoNnGCL0XsgSzOrvR6hnWWoUvplcYnk
         RRsBA4CuGLwzwaaAbojMEmOLxjW7O8ksQ2O+RQgn57aD0o4nuQsmufchqKMKuMW4/Twf
         7vh423A+NmRB40kpCiJ/IZWphmstuvgYLWHM99+mN86t/vrst1Dm8YQxE+BjE3v6KW5W
         H9ZUI6+DHWLq1+DghDAALdRxK5NMqz4MayZhxkRi95nQooDtu9COWg3cjI3oU/cS1VfM
         BYAGos+nr8CTJQ7SPa4tfoo1Wh0yJAo8df/rghBg3N8j3f6O+CMyeraQM7ItiBhUttZl
         IG+A==
X-Gm-Message-State: AOAM533n7VlUqhPVpXcFxP8+AjRqtZT2usv4UPg3fY/VynOLP7cmbiVc
        HctJKsYq+MddKfMyWmvoDKrEE5DxQr0=
X-Google-Smtp-Source: ABdhPJyPSI9MLRx4c0wba4vMWoMKYd5dEwJGgLTS2ZFkumqBGKIzX+qdn+aqG951GR27NW2J9EL3ZA==
X-Received: by 2002:ac8:14d:: with SMTP id f13mr4625707qtg.400.1631215969443;
        Thu, 09 Sep 2021 12:32:49 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id v7sm2054469qkd.41.2021.09.09.12.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 12:32:49 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     Clark Williams <williams@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH] rteval: kcompile: Fix for no numactl and no cpulist
Date:   Thu,  9 Sep 2021 15:32:40 -0400
Message-Id: <20210909193240.438891-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Constructing a command to compile the kernel as a load can fail
in certain cases such as when numactl is not available and the user
doesn't pass a cpulist.

Fix this for both the runcmd and the cleancmd by not assuming that
numactl is available or that taskset will be used.

Reported-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/kcompile.py | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index d1955c7aee3d..8d08a3d44302 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -45,23 +45,33 @@ class KBuildJob:
         self.jobid = None
         self.node = node
         self.logger = logger
+        self.binder = None
         self.builddir = os.path.dirname(kdir)
         self.objdir = "%s/node%d" % (self.builddir, int(node))
+
         if not os.path.isdir(self.objdir):
             os.mkdir(self.objdir)
+
         if os.path.exists('/usr/bin/numactl') and not cpulist:
+            """ Use numactl """
             self.binder = 'numactl --cpunodebind %d' % int(self.node)
-        else:
-            self.binder = 'taskset -c %s' % compress_cpulist(cpulist)
-        if cpulist:
+            self.jobs = self.calc_jobs_per_cpu() * len(self.node)
+        elif cpulist:
+            """ Use taskset """
             self.jobs = self.calc_jobs_per_cpu() * len(cpulist)
+            self.binder = 'taskset -c %s' % compress_cpulist(cpulist)
         else:
+            """ Without numactl calculate number of jobs from the node """
             self.jobs = self.calc_jobs_per_cpu() * len(self.node)
+
+        self.runcmd = f"make O={self.objdir} -C {self.kdir} -j{self.jobs}"
+        self.cleancmd = f"make O={self.objdir} -C {self.kdir} clean allmodconfig"
+        if self.binder:
+            self.runcmd = self.binder + " " + self.runcmd
+            self.cleancmd = self.binder + " " + self.cleancmd
+
         self.log(Log.DEBUG, "node %d: jobs == %d" % (int(node), self.jobs))
-        self.runcmd = "%s make O=%s -C %s -j%d" \
-                % (self.binder, self.objdir, self.kdir, self.jobs)
-        self.cleancmd = "%s make O=%s -C %s clean allmodconfig" \
-                % (self.binder, self.objdir, self.kdir)
+        self.log(Log.DEBUG, f"cleancmd = {self.cleancmd}")
         self.log(Log.DEBUG, "node%d kcompile command: %s" \
                 % (int(node), self.runcmd))
 
-- 
2.31.1

