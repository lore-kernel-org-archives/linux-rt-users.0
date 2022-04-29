Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12320C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Apr 2022 20:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351534AbiD2U0T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiD2U0R (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Apr 2022 16:26:17 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCE9CD643
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Apr 2022 13:22:58 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j9so6764734qkg.1
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Apr 2022 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yNAY4L/jjUpkMTGttcKgVq9TuiWZ/abLOfcPRM/xhU=;
        b=a6vpOeT7elJuLCnNu5Mg+ZAxr2/Wfi/9XY3R+f3PItbdvuBWCR1Fk8IcxygQi41D/7
         O+heUfSfstz5mUOw08x574HzMCU/9u55i+taJrQBKAhrvqiH1p32Nj6Zu7Y+i1sDbFMq
         7cLu8TRT+yKG08i4zqFopZU94txGk+ZNO6V9JuxEplxT787K//DvmwZk1h+coUytsF2y
         lyM1A0q4zfpXXZkoWw0xKH2wBLV+rjd9/sBg3V+Ol4e4Z1GSeC0784XQ9hDttu3hLyJj
         qz3OViq5hkpRH32sOWdeL+njQquCsRDpiJLbD8Gh9pDsC865qy153i9+YF/+20Tq/pTM
         1O+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2yNAY4L/jjUpkMTGttcKgVq9TuiWZ/abLOfcPRM/xhU=;
        b=xG8gP8bAzKdzV/Ja6YZyIVDE8FApjxdwTqnSZybgPW/dfdgIAC3Sa2Uzbtnf6ePsjy
         xN8GPwi8T9kVc8tCJLH8gBGcP+BQeSnpYBwwgScHoMs9xewVfdGcOfY7vtsS98YRk9yO
         P/D3EufEqJA3RbWFGMMrjdZDv5HfXxp5DSQAnhPHsl/zPtcVaAZ1vxvim/7XlSw/mtoN
         Ix7PjaT9KDmE80P66cOtTLTSxFx8zUoKaBdxyY0MAHNRMrgfE3qdphqRiEa2dKQjRgUN
         EVbFfw4dxA/gErJOCMNd2pC/weJD7J+9qqsUKNn/gvfoRQAkGeNzQ1R70YwfF1bheFZq
         p1Rw==
X-Gm-Message-State: AOAM532GEfxYNWewTt7JdLl8X/NIXsTACwg4OEu/yk4LICIP6MBkZdaA
        5mm3zNT9d0KVayhSH9oDd8dHKpZ4jJI=
X-Google-Smtp-Source: ABdhPJzzE82N5B95H0XKROegmTrKbnlMXybM11/EGE1Hdrth2tLYj9Ovhd++P8sV4aiwh5s9RwrLgw==
X-Received: by 2002:a05:620a:454e:b0:69f:b9fd:f05d with SMTP id u14-20020a05620a454e00b0069fb9fdf05dmr636930qkp.633.1651263777293;
        Fri, 29 Apr 2022 13:22:57 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id l20-20020ac84a94000000b002f39b99f676sm113484qtq.16.2022.04.29.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:22:56 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] rteval: kcompile: Use systopology to get a list of cpus on a node
Date:   Fri, 29 Apr 2022 16:22:02 -0400
Message-Id: <20220429202202.23499-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

kcompile gets a lists of cpus on a node but doesn't take into account
whether the cpus are online or not.

Instead of using the method in kcompile, use the method in systopology,
since that will consider whether the cpus are online or not.

Reported-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/kcompile.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 367f8dc1ca86..add0cd86cde4 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -202,7 +202,7 @@ class Kcompile(CommandLineLoad):
         self.cpus = {}
         self.nodes = self.topology.getnodes()
         for n in self.nodes:
-            self.cpus[n] = [int(c.split('/')[-1][3:]) for c in glob.glob('/sys/devices/system/node/node%s/cpu[0-9]*' % n)]
+            self.cpus[n] = self.topology.getcpus(n)
             self.cpus[n].sort()
 
             # if a cpulist was specified, only allow cpus in that list on the node
-- 
2.35.1

