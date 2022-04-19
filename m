Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4CAC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Apr 2022 16:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354483AbiDSQRo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbiDSQRn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Apr 2022 12:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B23D6BC21
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650384899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcRv8Pq2Wi5OQorGor9al/2Mb6MqsLk1kf7iSmdEiF4=;
        b=HyIZBj2oDNwH0C/hrJ0Z590qh7j7bV9XCaG+sMXaZ5SQJPq96ajaWMg79LuBcEfxmMSlrG
        bwCt4+9ltjvWD3WHdNdKWFz8vSNPx20pwjVrM+8ClmVrJC/ZZHMxtcMIzoCxXeG8UmUdDo
        gtByahZPtdNmAoh2zRp4zYiLG1yJ+9Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-VyMxjECzNpq6KqmALagFTA-1; Tue, 19 Apr 2022 12:14:58 -0400
X-MC-Unique: VyMxjECzNpq6KqmALagFTA-1
Received: by mail-wm1-f72.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1449932wmj.0
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcRv8Pq2Wi5OQorGor9al/2Mb6MqsLk1kf7iSmdEiF4=;
        b=GkX07usu0qTWzibJMpUFNCg4ZXfq+3z6k+r0wRJpfzZTGxzRZyOVxt1pBJHvcBloXy
         Uni6xZ5zvBAkbiIbYRr/tOkVFeYHauRsbbXlw8JLlP2bvIKwfQd6fHmzBJs5zaga2CrC
         CN+ZP+2/KgPxdCmAQUzOggmYKY9Os2Vn+ONNANziFeDgYN3jWmFTwAwYfVHM9uONVKdO
         aK94iI/VKaJpvmiDU4vKonIzl74IoeSikEjaLAVsq8tjIXXKPK8rWOyHiP6qH5HO7XWl
         5F7bzFIK0AKFhTD86Fh3nAYOH/K0vqrgqvloaKn4kQ5Mv+T+FAi9ixEmRvfXNdUD5cJF
         kOzA==
X-Gm-Message-State: AOAM533fm7KOkW12/S3G7gf75I6vh+BY7UpFyDxXwG/YP3pHy/4bzDoz
        brODjHR8laOE+BB7plNJyr8E7mVGNKSO7WRTLyNMOqP1LYor+Nr/AK37/xjPeeKtuqHcAui5JPc
        37fsvYfwTMk/KLLySn6jlPCcO30+tN1dz//7MKP0P39gQZ4F8DBoXYnLHXyJzAP9s0tnoedbu9n
        MkkNo=
X-Received: by 2002:a05:600c:35c3:b0:392:33c1:65b1 with SMTP id r3-20020a05600c35c300b0039233c165b1mr17964563wmq.86.1650384897232;
        Tue, 19 Apr 2022 09:14:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu1ihzbVjYpMhtJZBoFbkNerKzGLfigt5QlNopRyxyM4kbvAt3+6KRQWNE+Jnv4uShQUSt1Q==
X-Received: by 2002:a05:600c:35c3:b0:392:33c1:65b1 with SMTP id r3-20020a05600c35c300b0039233c165b1mr17964549wmq.86.1650384897053;
        Tue, 19 Apr 2022 09:14:57 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600018ad00b0020a87feadfcsm8682381wri.84.2022.04.19.09.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:14:56 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH 2/3] rteval: kcompile: Fix offline node handling
Date:   Tue, 19 Apr 2022 17:14:42 +0100
Message-Id: <20220419161443.89674-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220419161443.89674-1-vschneid@redhat.com>
References: <20220419161443.89674-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Having an empty NumaNode but with CPUs attached to it (IOW they are all
offline) causes kcompile.py to raise the following exception:

  calc_jobs_per_cpu():
      ratio = float(mem) / float(len(self.node))
  ZeroDivisionError: float division by zero

Remove nodes that do have CPUs but none of which are online.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 rteval/modules/loads/kcompile.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 367f8dc..ac99964 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -211,7 +211,10 @@ class Kcompile(CommandLineLoad):
 
         # remove nodes with no cpus available for running
         for node, cpus in self.cpus.items():
-            if not cpus:
+            # If the intersection between the node CPUs and the cpulist is empty
+            # then either the cpulist exludes that node, or the CPUs allowed by
+            # the cpulist are actually offline
+            if not set(self.topology.nodes[node].cpus.cpulist) & set(cpus):
                 self.nodes.remove(node)
                 self._log(Log.DEBUG, "node %s has no available cpus, removing" % node)
 
-- 
2.27.0

