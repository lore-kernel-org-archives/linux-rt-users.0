Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC7C35646
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C50206E2
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 17:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgBURoW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:44:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46405 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgBURoW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 12:44:22 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j5CLb-0007LT-6x; Fri, 21 Feb 2020 18:44:19 +0100
Date:   Fri, 21 Feb 2020 18:44:19 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH RT] tracing: make preempt_lazy and migrate_disable counter
 smaller
Message-ID: <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
References: <20200221153541.681468-1-jolsa@kernel.org>
 <20200221104922.5ea8bb5f@gandalf.local.home>
 <20200221161030.GC657629@krava>
 <20200221112152.031b4230@gandalf.local.home>
 <20200221163735.53wt2fqoajcuj2js@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221163735.53wt2fqoajcuj2js@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The migrate_disable counter should not exceed 255 so it is enough to
store it in an 8bit field.
With this change we can move the `preempt_lazy_count' member into the
gap so the whole struct shrinks by 4 bytes to 12 bytes in total.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/trace_events.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f3b1ef07e4a5f..c8b3f06cb5ed7 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -62,9 +62,9 @@ struct trace_entry {
 	unsigned char		flags;
 	unsigned char		preempt_count;
 	int			pid;
-	unsigned short		migrate_disable;
-	unsigned short		padding;
+	unsigned char		migrate_disable;
 	unsigned char		preempt_lazy_count;
+	unsigned short		padding;
 };
 
 #define TRACE_EVENT_TYPE_MAX						\
-- 
2.25.0

