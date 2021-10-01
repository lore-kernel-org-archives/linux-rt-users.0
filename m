Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D53C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 17:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1A26187D
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 17:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhJARbj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhJARbi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Oct 2021 13:31:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ABDC061775
        for <linux-rt-users@vger.kernel.org>; Fri,  1 Oct 2021 10:29:54 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id m26so9698454qtn.1
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Oct 2021 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TwwPTW4OXBgxJfCaSjFWRooC75QyLlyJdHUpk9GWS78=;
        b=hDCVPs0bx7irfVfB7xUQkYkmfYb1trbzkLjkzVd8l9yg0LRiSyXb79FF1PJeZj5D9E
         mBVMszLfsoFBnIrYNQe5WrSaspuyKa7PIJvRCpQs24N/AGG8GzH12UxJamHhoR+hgNKo
         QNpS2IlymkHdsvs9FDU61TzVc/vL+FtWCYjlJKqeEe9i0Y4l+/ORULq3TBkAO8+Mo3Qu
         YeU19/Rlh5BMzto4Urzt+NVKDDKQEmZ8PYUVCPCxQbrrL1hhYtACHl6aHpLg/BBRh9i9
         yaq/8myqfVKS2WTLhH6vSQoT1Oj277uSa4Ug9MFRNvI+lkzcaFWB+lZkGlmpWn4oaOmr
         tDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TwwPTW4OXBgxJfCaSjFWRooC75QyLlyJdHUpk9GWS78=;
        b=RoCwQWr7vZjP8WRdxIpCiXrMtHtdwSfC8ZtGvV91te33/DPvRGcHDcvQ3zf9uJA/4o
         1jFH+Uw/b+M597jMKPKU8NRIliqTKQ9s2o3sZ9PeEmxEKe6gvxvVvwrouEjtDBQ+lGLB
         yxUDAG5g1Oc9tkUVlbE8CoeC/HoAfAs8AetlpmSl3iLOIbZqmhdiewQHjBNwk8PzayOn
         oa82q7ddBcR4aqko941m3Bh6jiUD1pRlFuKwtK9etfOt2gWV4R2xuFWxDrdJV3KJ+YEQ
         qAKsY5fmuK3tccWjzBmCJMMRPiH9FBd3FU6nEkUfdMVUh8VB26Jm+mrThD+R7BTtq4n7
         8KEg==
X-Gm-Message-State: AOAM533XrztOH8d173i3d5X/KXzKTeQ/kdII6feU3DrrNtY1loYT4TRZ
        a6Bk7+ODJPiA1a+FSuq3IJpYNovPv2M=
X-Google-Smtp-Source: ABdhPJw5c2yqJombYCSfD+1k1SI/HPYeNmoTx2vr5dgEF7XIZ1PHu6dqE9u+QiaiEcHaWIyWPLHcyw==
X-Received: by 2002:ac8:764a:: with SMTP id i10mr13988544qtr.414.1633109393539;
        Fri, 01 Oct 2021 10:29:53 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id o23sm3741131qtl.74.2021.10.01.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:29:53 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Punit Agrawal <punitagrawal@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] rt-tests: Add *.dat to .gitignore
Date:   Fri,  1 Oct 2021 13:29:35 -0400
Message-Id: <20211001172937.13060-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add *.dat to .gitignore so that files such as trace.dat
are ignored by git

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index a975c4bd28fb..61fb49c874d3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@
 *.bz2
 *.xz
 *.asc
+*.dat
 tmp
 patches
 ChangeLog
-- 
2.31.1

