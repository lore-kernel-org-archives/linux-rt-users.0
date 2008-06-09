From: Tarkan Erimer <tarkan@netone.net.tr>
Subject: Re: 2.6.25.4-rt6
Date: Mon, 09 Jun 2008 10:38:20 +0300
Message-ID: <484CDDEC.7050405@netone.net.tr>
References: <1212793171.7695.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.netone.net.tr ([193.192.98.182]:42063 "EHLO
	mail.netone.net.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299AbYFIHie (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jun 2008 03:38:34 -0400
In-Reply-To: <1212793171.7695.2.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I got this error message at compile stage. Also it is the same error 
that was on -rt4. -rt3 compiles and runs fine.


VDSOSYM arch/x86/vdso/vdso32-syms.lds
LD arch/x86/vdso/built-in.o
CC kernel/sched.o
kernel/sched.c: In function 'sched_init':
kernel/sched.c:7702: error: implicit declaration of function 
'global_rt_runtime'
make[2]: *** [kernel/sched.o] Error 1
make[1]: *** [kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.25.4'
make: *** [debian/stamp-build-kernel] Error 2
root@tarkane:/usr/src/linux-2.6.25.4#

Steven Rostedt wrote:
> We are pleased to announce the 2.6.25.4-rt6 tree, which can be
> downloaded from the location:
>
>   http://rt.et.redhat.com/download/
>
> Information on the RT patch can be found at:
>
>   http://rt.wiki.kernel.org/index.php/Main_Page
>
> Changes since 2.6.25.4-rt5
>
>   - sched_cpupri hotplug support (Gregory Haskins)
>
>   - sched_cpupri prio count (Gregory Haskins)
>
>   - ftrace hotplug fix (Steven Rostedt)
>
> to build a 2.6.25.4-rt6 tree, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.25.4.bz2
>   http://rt.et.redhat.com/download/patch-2.6.25.4-rt6.bz2
>
>
>
> And like always, my RT version of Matt Mackall's ketchup will get this
> for you nicely:
>
>   http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3
>
>
> The broken out patches are also available.
>
>
> -- Steve
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   

