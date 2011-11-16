From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH][RT] tracing: Show padding as unsigned short
Date: Wed, 16 Nov 2011 13:19:35 -0500
Message-ID: <1321467575.4181.36.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:45480 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab1KPSTi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Nov 2011 13:19:38 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

RT added two bytes to trace migrate disable counting to the trace events
and used two bytes of the padding to make the change. The structures and
all were updated correctly, but the display in the event formats was
not:

cat /debug/tracing/events/sched/sched_switch/format

name: sched_switch
ID: 51
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;
	field:unsigned short common_migrate_disable;	offset:8;	size:2;	signed:0;
	field:int common_padding;	offset:10;	size:2;	signed:0;


The field for common_padding has the correct size and offset, but the
use of "int" might confuse some parsers (and people that are reading
it). This needs to be changed to "unsigned short".

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 37d3ffb..c71844c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -117,7 +117,7 @@ static int trace_define_common_fields(void)
 	__common_field(unsigned char, preempt_count);
 	__common_field(int, pid);
 	__common_field(unsigned short, migrate_disable);
-	__common_field(int, padding);
+	__common_field(unsigned short, padding);
 
 	return ret;
 }


