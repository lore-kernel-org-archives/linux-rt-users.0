From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: [PATCH] Fix build, missing profile.h include in kernel/sysctl.c (against 2.6.24.3-rt3)
Date: Fri, 29 Feb 2008 23:11:40 +0100
Message-ID: <c384c5ea0802291411s44cfb349r811da1e7daaefa19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:63740 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759706AbYB2WLl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Feb 2008 17:11:41 -0500
Received: by an-out-0708.google.com with SMTP id d31so945264and.103
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Feb 2008 14:11:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Build fix for kernel/sysctl.c:356: error: 'prof_pid' undeclared here
(not in a function).
The fix is to include <linux/profile.h> which defines prof_pid as external.
Patch is against 2.6.24.3-rt3.

Signed-off-by: Leon Woestenberg <leon@sidebranch.com>

Index: linux-2.6.24.3/kernel/sysctl.c
===================================================================
--- linux-2.6.24.3.orig/kernel/sysctl.c 2008-02-29 00:52:45.000000000 +0100
+++ linux-2.6.24.3/kernel/sysctl.c      2008-02-29 00:52:59.000000000 +0100
@@ -47,6 +47,7 @@
 #include <linux/acpi.h>
 #include <linux/reboot.h>
 #include <linux/ftrace.h>
+#include <linux/profile.h>

 #include <asm/uaccess.h>
 #include <asm/processor.h>


-- 
Leon
