Return-Path: <SRS0=keAW=3N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F01C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EAD206F0
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZK/LjvDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbgAXLL4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:11:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387861AbgAXLLz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jan 2020 06:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579864314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Ch982V+umlLpw6I38JUNUVDMopuxgmpFcPRNY4jO2GY=;
        b=ZK/LjvDdkq2xRjh7Gzn3VCEbFqb4rUvflTsGCcLAqTsIRcgmtOveNGpD+KjSGDXGLFq40O
        h2uKueiLlMzWWaLqDJakJvahQQoeAxC57UE+RBXMjSTBVq/gOmYSoKbV8zQUP3mmBbosMu
        GwwWPwxknCDKOlz9gmjJzK2Ohri6HsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-nbWU-IMmMe6XTE5Fhmb2YA-1; Fri, 24 Jan 2020 06:11:50 -0500
X-MC-Unique: nbWU-IMmMe6XTE5Fhmb2YA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 805B3DB60;
        Fri, 24 Jan 2020 11:11:49 +0000 (UTC)
Received: from intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com (intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com [10.19.176.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C93221001925;
        Fri, 24 Jan 2020 11:11:48 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT 2/2] sched: migrate_enable: Remove __schedule() call
Date:   Fri, 24 Jan 2020 06:11:47 -0500
Message-Id: <1579864307-13093-2-git-send-email-swood@redhat.com>
In-Reply-To: <1579864307-13093-1-git-send-email-swood@redhat.com>
References: <1579864307-13093-1-git-send-email-swood@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We can rely on preempt_enable() to schedule.  Besides simplifying the
code, this potentially allows sequences such as the following to be
permitted:

migrate_disable();
preempt_disable();
migrate_enable();
preempt_enable();

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7713e9c34ad1..ea0536461981 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8248,7 +8248,6 @@ void migrate_enable(void)
 
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    arg, work);
-		__schedule(true);
 	}
 
 out:
-- 
1.8.3.1

