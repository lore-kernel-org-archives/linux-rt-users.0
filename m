Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE84C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Jan 2022 02:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbiAGCPM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Jan 2022 21:15:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345309AbiAGCPK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Jan 2022 21:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641521710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zc6WWTb3MwHUgKOW+vivwiwYoFn62Ru2//1tgIJ3lco=;
        b=Wz0GzdIIXHCJr2upFEt367Pr1r9/LtdyUHbMUJUWbFgAvqVu6LVuzlkmIWkLucoHJrc3/F
        ga9Iy65/DbvRcYbmbfB7syifvJpQewHL5+GM3A7uSZ4M1m/yWf4gEp4ts+ov9bzcjFswcK
        kBqq9paT+/wzcP0LtjZXr7Jc9yYNDrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-d9uMsowBOYWYjAW2ZD50EQ-1; Thu, 06 Jan 2022 21:15:07 -0500
X-MC-Unique: d9uMsowBOYWYjAW2ZD50EQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E87B100C609;
        Fri,  7 Jan 2022 02:15:05 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.8.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4864F5BE10;
        Fri,  7 Jan 2022 02:15:04 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id A49A43C003C; Thu,  6 Jan 2022 23:15:02 -0300 (-03)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        "stable-rt@vger.kernel.org"@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 2/3] stop_machine: Remove this_cpu_ptr() from print_stop_info().
Date:   Thu,  6 Jan 2022 23:15:01 -0300
Message-Id: <20220107021502.1121597-3-lgoncalv@redhat.com>
In-Reply-To: <20220107021502.1121597-1-lgoncalv@redhat.com>
References: <20220107021502.1121597-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.10.90-rt61-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


This aligns the patch ("stop_machine: Add function and caller debug
info) with commit
  a8b62fd085050 ("stop_machine: Add function and caller debug info")

that was merged upstream and is slightly different.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/stop_machine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index dbf585cf4b9f8..971d8acceaecb 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -51,7 +51,11 @@ static bool stop_machine_initialized = false;
 
 void print_stop_info(const char *log_lvl, struct task_struct *task)
 {
-	struct cpu_stopper *stopper = this_cpu_ptr(&cpu_stopper);
+	/*
+	 * If @task is a stopper task, it cannot migrate and task_cpu() is
+	 * stable.
+	 */
+	struct cpu_stopper *stopper = per_cpu_ptr(&cpu_stopper, task_cpu(task));
 
 	if (task != stopper->thread)
 		return;
-- 
2.33.1

