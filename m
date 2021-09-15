Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9112C433FE
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 12:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A19461216
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 12:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhIOMQO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbhIOMQO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Sep 2021 08:16:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C697C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2021 05:14:55 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u4so2096781qta.2
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2021 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHnKb9RgaoS+QS6tyf0vIOKQR3cDGKeF52I9Rw7OVdI=;
        b=HlUtvC/PkaDUFQ0jm2cYM+8aY36lyH/JrXnxsJClv8WBNzgGuwRQQiAAZ+44SVeVp8
         crJJxcTB0fmT5T3bSQojxHeJXcGuwV4FyJg68iRC+6pcWqhVdWpDO8SsfumSCZL9OEFD
         ZGfHH8Imo8aQM5QS1nEEqd4maTKxf0WwmD80lYURw7zy0jY6nQUfdDAk7DZABPMF7NZo
         W5/5+hFzdxoLX+Mnt10biNFw+VNsHqIXHxKM37+wGuJUgsvYQBos9frGWIOn1cbm90Lx
         njPr5qpKWsS9ew3vWtCJ73YHipQvWT3rS3MwaZZUafQ1dPSKCCPLeAsFpO9/f1CXIzUu
         bJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NHnKb9RgaoS+QS6tyf0vIOKQR3cDGKeF52I9Rw7OVdI=;
        b=M0ajT12U+26dLbGY9tZofLnD5E0pPQ1Q8MJONXWLLvWCmbpxvxeOixbLQkbWAk410Z
         UwUYE/xlzpogAa6HiLbWC/lXQVopm3vl+XN6RyhrWdLC4Gzq8yA19N/YJ6n32t5vLIY1
         7AJcW7y4oCJasXF8kP3TIE8PitLTtml12e0v3SAJ99wei3+UHQd5QlDSnzXMjcVrMMo7
         rgYcLwPzN/oCCKN+NKF/Zn4BaeazS4rRekvRB6piaCetfldpc5TuOlj2NpbGcfgGUyni
         RY+5fkMQMlK8DyHg4D4panxQ8i+fAEU2WjRu/FKeHckbsZBiFuMRkTynljhTRwW84/h2
         pW7A==
X-Gm-Message-State: AOAM533/rre4XKeBLJXFsH+MxxAu7j3c8Uw/BIfcx8V+k3VarxZh8fwy
        x8maZyQAyia2vICVRC6kpX6Z/khnb0M=
X-Google-Smtp-Source: ABdhPJzE9UeFn5rZWo6p9paAVEvawkG1UrbaxC3tVpkpjWksMKWMBW7tF63xe9PXsvJftBTGpHuC4A==
X-Received: by 2002:ac8:4684:: with SMTP id g4mr9770413qto.290.1631708094208;
        Wed, 15 Sep 2021 05:14:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id 9sm7768466qtz.83.2021.09.15.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:14:53 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Remove mult from hackbench.py
Date:   Wed, 15 Sep 2021 08:14:31 -0400
Message-Id: <20210915121432.5472-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915121432.5472-1-jkacur@redhat.com>
References: <20210915121432.5472-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The method for calculating the number of jobs to run for hackbench was
changed with the following commit.
commit 67629a1b69ffe72af6bfb3a0d4362ac1920005a7

However, the mult variable which was used to calculate the number of
jobs using the older method was not removed.

Remove it now and simplify the logic.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/hackbench.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index ab028c495d8b..8119d50f626a 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -41,7 +41,6 @@ class Hackbench(CommandLineLoad):
     def __init__(self, config, logger):
         CommandLineLoad.__init__(self, "hackbench", config, logger)
 
-
     def _WorkloadSetup(self):
         'calculate arguments based on input parameters'
         (mem, units) = self.memsize
@@ -51,12 +50,10 @@ class Hackbench(CommandLineLoad):
             mem = mem / 1024.0
         elif units == 'TB':
             mem = mem * 1024
+
         ratio = float(mem) / float(self.num_cpus)
-        if ratio >= 0.75:
-            mult = float(self._cfg.setdefault('jobspercore', 2))
-        else:
+        if ratio < 0.75:
             self._log(Log.WARN, "Low memory system (%f GB/core)!" % ratio)
-            mult = 0
 
         sysTop = SysTopology()
         # get the number of nodes
-- 
2.31.1

