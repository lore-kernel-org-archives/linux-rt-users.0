Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15750C11D2F
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 17:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7E920838
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 17:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBXRBE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:01:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50573 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgBXRBE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 12:01:04 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j6H6L-000855-FJ; Mon, 24 Feb 2020 18:01:01 +0100
Date:   Mon, 24 Feb 2020 18:01:01 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH RT v2] tracing: make preempt_lazy and migrate_disable counter
 smaller
Message-ID: <20200224170101.qvxapdecp5vsbwrw@linutronix.de>
References: <20200221153541.681468-1-jolsa@kernel.org>
 <20200221104922.5ea8bb5f@gandalf.local.home>
 <20200221161030.GC657629@krava>
 <20200221112152.031b4230@gandalf.local.home>
 <20200221163735.53wt2fqoajcuj2js@linutronix.de>
 <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
 <20200221204957.GE657629@krava>
 <20200224100104.sbupmfe2oehmsrrb@linutronix.de>
 <20200224115403.GD16664@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200224115403.GD16664@krava>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The migrate_disable counter should not exceed 255 so it is enough to
store it in an 8bit field.
With this change we can move the `preempt_lazy_count' member into the
gap so the whole struct shrinks by 4 bytes to 12 bytes in total.
Remove the `padding' field, it is not needed.
Update the tracing fields in trace_define_common_fields() (it was
missing the preempt_lazy_count field).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2:
  - drop the `padding' member
  - update the members in trace_define_common_fields() to match struct
    trace_entry.

 include/linux/trace_events.h | 3 +--
 kernel/trace/trace_events.c  | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f3b1ef07e4a5f..10bbf986bc1d5 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -62,8 +62,7 @@ struct trace_entry {
 	unsigned char		flags;
 	unsigned char		preempt_count;
 	int			pid;
-	unsigned short		migrate_disable;
-	unsigned short		padding;
+	unsigned char		migrate_disable;
 	unsigned char		preempt_lazy_count;
 };
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index accaae59a7626..8bfb187cce65a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -181,8 +181,8 @@ static int trace_define_common_fields(void)
 	__common_field(unsigned char, flags);
 	__common_field(unsigned char, preempt_count);
 	__common_field(int, pid);
-	__common_field(unsigned short, migrate_disable);
-	__common_field(unsigned short, padding);
+	__common_field(unsigned char, migrate_disable);
+	__common_field(unsigned char, preempt_lazy_count);
 
 	return ret;
 }
-- 
2.25.1

