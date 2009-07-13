From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Kernel Panic with preempt RT patch 2.6.29.5-rt21
Date: Mon, 13 Jul 2009 12:54:28 -0700
Message-ID: <4A5B90F4.6070200@us.ibm.com>
References: <af81d2bf0907130807w7af6aef0ha0210c263f93b01b@mail.gmail.com> <af81d2bf0907130939vcad717ct64778d8f1be98ada@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Meha Mehta <mehtameha@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:60125 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755714AbZGMTyb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2009 15:54:31 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6DJmqoV011264
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jul 2009 15:48:52 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n6DJsUj2065696
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jul 2009 15:54:30 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n6DJsUVI011201
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jul 2009 15:54:30 -0400
In-Reply-To: <af81d2bf0907130939vcad717ct64778d8f1be98ada@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Meha Mehta wrote:
> Hi all,
> 
> I am trying to boot Linux 2.6.29.5 with PREEMPT RT patch on x86
> system. I have enabled all the configuration option required for
> PREEMPT_RT.
> I get kernel panic with message "Attempted to kill init!". Here is
> panic output.
> 
> ? panic 0x48/0xd1
> ? do_exit + 0x5e/0x637
> ? do_group_exit+0x5b/0x83
> ? sys_exit_group+0xd/0x10
> ? syscall_call+0x7/0xb
> 
> I get same panic with 2.6.29.5-rt22 and 2.6.29.6-rt23.
> 
> Has anybody tried 2.6.29.5-rt21 patch? What am I missing here? Any suggestions?

Most likely a configuration issue or a bad initrd.  Tell us a bit about 
which OS you're building on and what the messages were before the panic. 
  First guess is you may have failed to include the module for your root 
filesystem either in the initrd or as =y in the kernel.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
