Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE2CC47082
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 22:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500E260C40
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 22:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhEaWtw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 May 2021 18:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232035AbhEaWtu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 May 2021 18:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622501290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FuaFB3Nx0JVIcNgs2OHuArgQ5BWJUDEy0OO77XQzguE=;
        b=WqmRpFYJpFwqnB1ISo5Ot1B1EhTylqx5eyZI4GJspdfnEJJcqBFyqcOtqStRGuWy4I+7TC
        R/g7jgkZ+VUGtmDmHay0YNfAM4G0NneSbVYXDq/TO25iqSeVO6dM6KIEdzt0hXelmPUIoh
        G1uI7Tj39vVDHQdxtXXbnU5ZNc/TxQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ZafZWPhdMsy0gfBWLQ7O0Q-1; Mon, 31 May 2021 18:48:08 -0400
X-MC-Unique: ZafZWPhdMsy0gfBWLQ7O0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A3EE802B4F;
        Mon, 31 May 2021 22:48:07 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05E1D60E3A;
        Mon, 31 May 2021 22:48:06 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 42E203C016F; Mon, 31 May 2021 19:48:05 -0300 (-03)
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
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 1/3] printk: revamp "Make rt aware"
Date:   Mon, 31 May 2021 19:48:03 -0300
Message-Id: <20210531224805.45914-2-lgoncalv@redhat.com>
In-Reply-To: <20210531224805.45914-1-lgoncalv@redhat.com>
References: <20210531224805.45914-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v4.14.232-rt112-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Commit 7fcfb8fdfc41e ("printk: Make rt aware") from v4.19-rt is more
comprehensive than its equivalent in v4.14-rt (commit 70ce7ac4c16f1).

As one example, this commit resolves the following build warnings from
v4.14-rt:

  kernel/printk/printk.c: At top level:
  kernel/printk/printk.c:1608:13: warning: ‘console_lock_spinning_enable’ defined but not used [-Wunused-function]
   static void console_lock_spinning_enable(void)
               ^
  kernel/printk/printk.c:1633:12: warning: ‘console_lock_spinning_disable_and_check’ defined but not used [-Wunused-function]
   static int console_lock_spinning_disable_and_check(void)
              ^

Fixes: 70ce7ac4c16f1 ("printk: Make rt aware")
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/printk/printk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 624ba7bb74374..fdae4fbd8a127 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1581,6 +1581,7 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Special console_lock variants that help to reduce the risk of soft-lockups.
  * They allow to pass console_lock to another printk() call using a busy wait.
@@ -1721,6 +1722,15 @@ static int console_trylock_spinning(void)
 	return 1;
 }
 
+#else
+
+static int console_trylock_spinning(void)
+{
+	return console_trylock();
+}
+
+#endif
+
 /*
  * Call the console drivers, asking them to write out
  * log_buf[start] to log_buf[end - 1].
@@ -2855,6 +2865,7 @@ static int __init printk_late_init(void)
 	struct console *con;
 	int ret;
 
+	migrate_disable();
 	for_each_console(con) {
 		if (!(con->flags & CON_BOOT))
 			continue;
-- 
2.31.1

