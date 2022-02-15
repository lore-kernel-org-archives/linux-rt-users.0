Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76554C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Feb 2022 04:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiBOENv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Feb 2022 23:13:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiBOENu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Feb 2022 23:13:50 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE15B5636
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2022 20:13:41 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id b22so16268789qkk.12
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2022 20:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qH0p3z0M42LDoO63AiZuV7WfcncQ0aHTXNwHMjxM8gM=;
        b=PJW3ozVIbMLG6drtGNVOC8687PBlXnGHBMjl44tCRd76JpMRkCquLbRQbjZLMaUUA2
         nt4rutxrbKTMmhYchXTLQYKfJtR6qcASyL3igqE8pUkTX4hTwSknX96HwwnBume4MU1C
         jAozHoiRwuTxQas6RbD1606GxlkQhyH+ZMzvLwbP3QaxFNDS2jyI0NiP2QeFQkUIp2nO
         UInuuuHH4j1v1w5tNbucgJ/eJz30NC94xqUru0/PsuKJU5yfX1CKXsMQOSMOqv50i6vj
         eypEmHgvEHUJcZJmlzKXaHYitDWuq+mwpI69G+oYKxciSfgFQab5tnS6lmNm3bEEzNXR
         eJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qH0p3z0M42LDoO63AiZuV7WfcncQ0aHTXNwHMjxM8gM=;
        b=V64bmX+egt2cyKMK8buCLDcgDtajMV7fQnLC56z/3RacZcwGAD1mrC89vjwmhoCSA2
         /TBs+j6PYEyDv2J3ZCmC9NaDN0e6Px0UV4nNIF/ZuDz95Lj+O8+GTEVcnD8Zo7aTbHXu
         cWCHAS9OkT4pIwO1f6f4cu0RMZY7IrGsKNeFzOOoWzVDH4Nq5hKePZom9mcla2yATJ+1
         K5G1t0oae2WHaXVPS4eYJdEpC1J6cTcr3XBJ84KzOumWhlG4QVQChu1hV0FtSo1s2Vcu
         U1nOxBIEFsYBOECSIL6tVY+c3NHe9fl0Dbv/fCAYiTTsu+p/4zxDLcpnrZd1k0/+4i87
         eOqw==
X-Gm-Message-State: AOAM530bedu8E+8h8kPyf2y55s3FdixiJZBOuS/gqnxlgcRbgH8IILr5
        9sr2+7/51gvOtMKsRT+B8VNjc31c7Sg=
X-Google-Smtp-Source: ABdhPJyRe7tVlv1NXJHjfS4ACEw229EC+xRdTIGbr7IL4l5To0pQcGU25/AHk5tS/O0OABopw3C/Jw==
X-Received: by 2002:a37:3c4:: with SMTP id 187mr1115365qkd.718.1644898420506;
        Mon, 14 Feb 2022 20:13:40 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id r129sm16313719qkf.99.2022.02.14.20.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 20:13:39 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: If the user doesn't specify a cpumask, use the inherited one
Date:   Mon, 14 Feb 2022 23:13:28 -0500
Message-Id: <20220215041328.416853-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If the user doesn't specify a cpumask, then we need to use the inherited
one to match what cyclictest currently does

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 4ca310bf7490..8fdd5341794a 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -216,6 +216,12 @@ class Cyclictest(rtevalModulePrototype):
             self.__sparse = True
         else:
             self.__cpus = online_cpus()
+            # Get the cpuset from the environment
+            cpuset = os.sched_getaffinity(0)
+            # Convert the elements to strings
+            cpuset = [str(c) for c in cpuset]
+            # Only include cpus that are in the cpuset
+            self.__cpus = [c for c in self.__cpus if c in cpuset]
 
         # Sort the list of cpus to align with the order reported by cyclictest
         self.__cpus.sort(key=int)
-- 
2.34.1

