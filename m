From: Meha Mehta <mehtameha@gmail.com>
Subject: Kernel Panic with preempt RT patch 2.6.29.5-rt21
Date: Mon, 13 Jul 2009 12:39:53 -0400
Message-ID: <af81d2bf0907130939vcad717ct64778d8f1be98ada@mail.gmail.com>
References: <af81d2bf0907130807w7af6aef0ha0210c263f93b01b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:15986 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbZGMQjy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2009 12:39:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so4733552and.1
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Jul 2009 09:39:53 -0700 (PDT)
In-Reply-To: <af81d2bf0907130807w7af6aef0ha0210c263f93b01b@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I am trying to boot Linux 2.6.29.5 with PREEMPT RT patch on x86
system. I have enabled all the configuration option required for
PREEMPT_RT.
I get kernel panic with message "Attempted to kill init!". Here is
panic output.

? panic 0x48/0xd1
? do_exit + 0x5e/0x637
? do_group_exit+0x5b/0x83
? sys_exit_group+0xd/0x10
? syscall_call+0x7/0xb

I get same panic with 2.6.29.5-rt22 and 2.6.29.6-rt23.

Has anybody tried 2.6.29.5-rt21 patch? What am I missing here? Any suggestions?

Thanks,
Meha
