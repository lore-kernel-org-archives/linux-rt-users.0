From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: print user stack
Date: Sat, 23 Oct 2010 17:46:35 +0530
Message-ID: <AANLkTim5r_GoCDp0oKmEjWbf+64UL1r35_3GmCow1ETD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50877 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab0JWMQg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Oct 2010 08:16:36 -0400
Received: by iwn34 with SMTP id 34so2082867iwn.19
        for <linux-rt-users@vger.kernel.org>; Sat, 23 Oct 2010 05:16:36 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I had a strange problem of core file getting truncated. I could not
find any stack trace.


So, i wrote a kernel module. Which will find a  task_struct using pid.
 find_task_jby_pid.
then i used show_stack for the same task struct to list out the stack
trace. But it is printing the kernel stack not user stack. Any idea
how to print user stack .
