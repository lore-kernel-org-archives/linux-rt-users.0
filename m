Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BBCC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Feb 2022 21:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiBGVQo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiBGVQk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Feb 2022 16:16:40 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A51C0612A4
        for <linux-rt-users@vger.kernel.org>; Mon,  7 Feb 2022 13:16:40 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id o25so12102038qkj.7
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Feb 2022 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zw0QZba3gOXLf0/yxu6fi22k/UgvBcc0fLQPAGm0ktU=;
        b=QEfH3fALl17Upp9aZ6g9dXxL0TAG8Ir186lCQG3fk5ScXxbRm/PUIwSqUXWXbE26e1
         JZuGjrsRuESkkJwKDxjkotSMCs86vR5+xun2vfTFw8wK2jrdo9F2U4lFvaL5nKs7/VX+
         Cn64BUed1H4i1nKl/FG4YYW91QFDdX6i9i++8jdzf7/KhqLw05G8LSsTmGHXjBpUgdSa
         PKTGAglX+zOn2KfG1d6Zu5a19OwGUCLMMQ0yRVEtU6CYmEXqHP5mzQ4o+UYO7uT5s5C8
         TzmRRFOJiXxZ42bHndr6mPQuC+ecjnaYX5umbP4S1YPF2dgSs1VYHKtMu45h6SkKB4A+
         uMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=zw0QZba3gOXLf0/yxu6fi22k/UgvBcc0fLQPAGm0ktU=;
        b=XhAy1UDMFEZYiwhAOfVZN1kgnYzga9htPFjvMdTt7BUD2avIiafVTYVq1IuUqF8xii
         qdIBJf+ZbgddAJbefzMqpOYTW4axVDtIpU1RTJ8hX2/tf71yvmCcMm+q1Bhw8BxMCjW6
         LN91zw+Mhj7bp3ck8o8kbJS1sNbjLEEwpoBHmYbZCCx5tKIqysF1b7DA6km7usXHtfj2
         2SAptdidRv7aL4uywlWuk50NTxFRlGiiRzZS4JIGRRWxJqUH8VNHSe9hP0HetNL0izJJ
         WbgpA2Zl/fOG+4vZK4LOTEQr5SuYVryW1Ckdd+wnJRjCxvDnx+FLqfJ0nlUUJoPiBePm
         CrOw==
X-Gm-Message-State: AOAM5305EAYQcwEVx3UfxaoFJUAN8rmQG4s3zf/RNdpZx/9ZfaupmW5n
        pGxEP8f08Xlam/+iEgB6hdX8vI09HfY=
X-Google-Smtp-Source: ABdhPJyuIhjgERZlyto1WAWHJS7SN+Hv8E58rspClLp9Fh5RcOP9RiV940jurZ9Jwu8raCjReI3VeQ==
X-Received: by 2002:a05:620a:1991:: with SMTP id bm17mr1023721qkb.475.1644268599018;
        Mon, 07 Feb 2022 13:16:39 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id i12sm6323166qkn.83.2022.02.07.13.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:16:38 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Don't restrict measurement threads to inherited cpumask
Date:   Mon,  7 Feb 2022 16:16:13 -0500
Message-Id: <20220207211613.111005-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This patch reverses be811d28a471cfcaf7960289e00960e7f5b18f03

This patch syncs rteval to 795433f50f20ef7598db5cfe991b5386e4080d41 in
rt-tests

If the user does not specify a cpumask, rteval will still run on the
cpus according to the cpumask inherited from the runtime environment.
However, if the user specifies a cpumask, then it will overwrite the
runtime environment where allowed.

This will allow the user to run measurement threads on isolated cpus.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 5330d1466302..4ca310bf7490 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -217,19 +217,9 @@ class Cyclictest(rtevalModulePrototype):
         else:
             self.__cpus = online_cpus()
 
-        # Sort the list of cpus to align with the order reported by
-        # cyclictest
+        # Sort the list of cpus to align with the order reported by cyclictest
         self.__cpus.sort(key=int)
 
-        # Get the cpuset from the environment
-        cpuset = os.sched_getaffinity(0)
-
-        # Convert the elements to strings
-        cpuset = [str(c) for c in cpuset]
-
-        # Only include cpus that are in the cpuset
-        self.__cpus = [c for c in self.__cpus if c in cpuset]
-
         self.__numcores = len(self.__cpus)
 
         info = cpuinfo()
-- 
2.34.1

