From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch 1/6] preempt_lazy: remove redundant test_thread_flag() call
Date: Fri, 02 May 2014 13:12:46 +0200
Message-ID: <1399029166.5233.125.camel@marge.simpson.net>
References: <1399020080.5233.96.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:51879 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaEBLMt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 07:12:49 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so3099976eek.9
        for <linux-rt-users@vger.kernel.org>; Fri, 02 May 2014 04:12:48 -0700 (PDT)
In-Reply-To: <1399020080.5233.96.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

__preempt_count_dec_and_test() already does it.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 include/linux/preempt.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -126,8 +126,7 @@ do { \
 #define preempt_enable_notrace() \
 do { \
 	barrier(); \
-	if (unlikely(__preempt_count_dec_and_test() || \
-				test_thread_flag(TIF_NEED_RESCHED_LAZY))) \
+	if (unlikely(__preempt_count_dec_and_test())) \
 		__preempt_schedule_context(); \
 } while (0)
 #else



