From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH]append prompt in /debug/tracing/README file.
Date: Thu, 14 May 2009 17:23:38 +0900
Message-ID: <1242289418.31161.45.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xkFD98a1ZiSFQomIxpPW"
Cc: Ingo Molnar <mingo@elte.hu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>, tglx <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:42544 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760554AbZENIXp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2009 04:23:45 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-xkFD98a1ZiSFQomIxpPW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Dear Steven Rostedt,

    Please, Append prompt in /debug/tracing/README file.
    
    This is trivial issue. Fix typo Mini Howto file(README) for ftrace.

    Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1ce5dc6..a4726f5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2380,7 +2380,7 @@ static const char readme_msg[] =
 	"# echo print-parent > /debug/tracing/trace_options\n"
 	"# echo 1 > /debug/tracing/tracing_enabled\n"
 	"# cat /debug/tracing/trace > /tmp/trace.txt\n"
-	"echo 0 > /debug/tracing/tracing_enabled\n"
+	"# echo 0 > /debug/tracing/tracing_enabled\n"
 ;
 
 static ssize_t



-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim (ELS - OS Group - S/W Lab - SAIT - SAMSUNG)
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://intomail.dnip.net/invain/me/
-----------------------------------------------

--=-xkFD98a1ZiSFQomIxpPW
Content-Disposition: attachment; filename=append-prompt-in-readme-ftrace.patch
Content-Type: text/x-patch; name=append-prompt-in-readme-ftrace.patch; charset=euckr
Content-Transfer-Encoding: 7bit

commit 52d07e507de331cff1623d60cda05a5c2435fac8
Author: GeunSik,Lim <leemgs1@gmail.com>
Date:   Thu May 14 17:18:09 2009 +0900

    append prompt in /debug/tracing/README file.
    
    This is trivial issue. Fix typo Mini Howto file(README) for ftrace.

    Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1ce5dc6..a4726f5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2380,7 +2380,7 @@ static const char readme_msg[] =
 	"# echo print-parent > /debug/tracing/trace_options\n"
 	"# echo 1 > /debug/tracing/tracing_enabled\n"
 	"# cat /debug/tracing/trace > /tmp/trace.txt\n"
-	"echo 0 > /debug/tracing/tracing_enabled\n"
+	"# echo 0 > /debug/tracing/tracing_enabled\n"
 ;
 
 static ssize_t

--=-xkFD98a1ZiSFQomIxpPW--

