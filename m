Return-Path: <SRS0=JZDS=42=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FB4C10F25
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6350C24679
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583783318;
	bh=DHgaPoXIlY1cM6abocvK6wxA7mw7OuaqdKOLEtP6vNU=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=Ei795tqrx45tdFd5YduXr8c0/uNJpLoLcJKeaSYn9U0arwkvm1lrGaVjcYYc/Mh27
	 bNRw97AJAZchiZ0LG+FuQR9ZFyA2yl7PX0HS+OcVBZCqZJfulo6tYsHtH5qgQhJ6DI
	 a4zxrP2Gur/McYUULk0vbcOokWuOeCGLti6HvksQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCITsb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgCITsW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Mar 2020 15:48:22 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C0662467C;
        Mon,  9 Mar 2020 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583783301;
        bh=DHgaPoXIlY1cM6abocvK6wxA7mw7OuaqdKOLEtP6vNU=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ua/Ua6ibrf8csvzxj3hhjH9wav49bYx3QJ/Hoh7fcSkLLjwGqRslDQPSKLjki2MEm
         9YibqYrnVHoM4wipswHm3skQMyO9QscYo6y+EJFfmrnyu6uXaNTImpm15Cn5vzWYah
         Px9wRvor7/x+zRxriayNPUggAKoS1FddpXoB9TiA=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 7/8] tracing: make preempt_lazy and migrate_disable counter smaller
Date:   Mon,  9 Mar 2020 14:47:52 -0500
Message-Id: <0012457a5fe618e36a20b4d1b27265be51c6e8b1.1583783251.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.172-rt78-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit dd430bf5ecb40f9a89679c85868826475d71de54 ]

The migrate_disable counter should not exceed 255 so it is enough to
store it in an 8bit field.
With this change we can move the `preempt_lazy_count' member into the
gap so the whole struct shrinks by 4 bytes to 12 bytes in total.
Remove the `padding' field, it is not needed.
Update the tracing fields in trace_define_common_fields() (it was
missing the preempt_lazy_count field).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h | 3 +--
 kernel/trace/trace_events.c  | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index edd1e42e8a2f7..01e9ab3107531 100644
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
index 60e371451ec31..edd43841c94ad 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -187,8 +187,8 @@ static int trace_define_common_fields(void)
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
2.14.1

