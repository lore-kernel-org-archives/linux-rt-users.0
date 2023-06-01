Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA196C7EE29
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjFAU2v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjFAU2s (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCD8E
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPgrce9Pn1FWVVZjRJocjaUdAB4mwM3JhGCt5cpjPWA=;
        b=GbcpKcfJxit8MBIfW7hgBzeMTJF2l+CFedFf63KA+ftlm7kDw/At51DAItWA4ZJUIUVLZT
        gaMwuNXghkXUrn9rUqsiUS1o+0/GLshe78a9HuRiSjFhV+pZc8p+jISfXnjpsKY+fRvABZ
        lzs+HwXWxe5nl3fbvdVlNWpK5JUCnB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-7V4TcBpGP_-8OahrTalqQA-1; Thu, 01 Jun 2023 16:28:00 -0400
X-MC-Unique: 7V4TcBpGP_-8OahrTalqQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADC11185A78F
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:27:59 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED3EC154D9;
        Thu,  1 Jun 2023 20:27:59 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 04/10] rteval: Use f-strings in kernel.py
Date:   Thu,  1 Jun 2023 16:27:30 -0400
Message-Id: <20230601202734.813515-5-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use f-strings in kernel.py

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/sysinfo/kernel.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/sysinfo/kernel.py b/rteval/sysinfo/kernel.py
index f2e9d72ac2ef..ba5cadda40c5 100644
--- a/rteval/sysinfo/kernel.py
+++ b/rteval/sysinfo/kernel.py
@@ -47,8 +47,8 @@ class KernelInfo:
         policies = {'DLN': 'deadline', 'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
         ret_kthreads = {}
         self.__log(Log.DEBUG, "getting kthread status")
-        cmd = '%s -eocommand,pid,policy,rtprio,comm' % getcmdpath('ps')
-        self.__log(Log.DEBUG, "cmd: %s" % cmd)
+        cmd = f"{getcmdpath('ps')} -eocommand,pid,policy,rtprio,comm"
+        self.__log(Log.DEBUG, f"cmd: {cmd}")
         c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
         for p in c.stdout:
             v = p.strip().split()
-- 
2.31.1

