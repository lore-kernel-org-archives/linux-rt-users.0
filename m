Return-Path: <SRS0=e0E4=S2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B59EC10F11
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D3121903
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfDXOgK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:36:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54131 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbfDXOgJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Apr 2019 10:36:09 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hJJ0H-0002lq-IA; Wed, 24 Apr 2019 16:36:05 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org
Subject: [PATCH] printk: kmsg_dump: remove mutex usage
References: <91d59e3f2074265c834b9a7ea48a7b41292fc9f8.camel@redhat.com>
Date:   Wed, 24 Apr 2019 16:36:04 +0200
In-Reply-To: <91d59e3f2074265c834b9a7ea48a7b41292fc9f8.camel@redhat.com>
        (Scott Wood's message of "Tue, 23 Apr 2019 16:56:25 -0500")
Message-ID: <87pnpb79nv.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The kmsg dumper can be called from any context, but the dumping
helpers were using a mutex to synchronize the iterator against
concurrent dumps.

Rather than trying to synchronize the iterator, use a local copy
of the iterator during the dump. Then no synchronization is
required.

Reported-by: Scott Wood <swood@redhat.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 I tested this patch by creating a custom dumper and triggering
 it from NMI context.

 kernel/printk/printk.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 997d07b6bf97..7d3522e0bcec 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -359,8 +359,6 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
-static DEFINE_MUTEX(kmsg_dump_lock);
-
 /* the last printk record at the last 'clear' command */
 static u64 clear_seq;
 
@@ -2820,6 +2818,7 @@ module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);
  */
 void kmsg_dump(enum kmsg_dump_reason reason)
 {
+	struct kmsg_dumper dumper_local;
 	struct kmsg_dumper *dumper;
 
 	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
@@ -2830,16 +2829,18 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		if (dumper->max_reason && reason > dumper->max_reason)
 			continue;
 
-		/* initialize iterator with data about the stored records */
-		dumper->active = true;
+		/*
+		 * use a local copy to avoid modifying the
+		 * iterator used by any other cpus/contexts
+		 */
+		memcpy(&dumper_local, dumper, sizeof(dumper_local));
 
-		kmsg_dump_rewind(dumper);
+		/* initialize iterator with data about the stored records */
+		dumper_local.active = true;
+		kmsg_dump_rewind(&dumper_local);
 
 		/* invoke dumper which will iterate over records */
-		dumper->dump(dumper, reason);
-
-		/* reset iterator */
-		dumper->active = false;
+		dumper_local.dump(&dumper_local, reason);
 	}
 	rcu_read_unlock();
 }
@@ -2951,9 +2952,7 @@ bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
 {
 	bool ret;
 
-	mutex_lock(&kmsg_dump_lock);
 	ret = kmsg_dump_get_line_nolock(dumper, syslog, line, size, len);
-	mutex_unlock(&kmsg_dump_lock);
 
 	return ret;
 }
@@ -3105,9 +3104,7 @@ void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
  */
 void kmsg_dump_rewind(struct kmsg_dumper *dumper)
 {
-	mutex_lock(&kmsg_dump_lock);
 	kmsg_dump_rewind_nolock(dumper);
-	mutex_unlock(&kmsg_dump_lock);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
-- 
2.11.0
