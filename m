From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: [ANNOUNCE] 4.4.19-rt27
Date: Thu, 1 Sep 2016 09:46:49 +0200
Message-ID: <89ebab62-4bda-4a8e-a256-5ee46a88e99d@manjaro.org>
References: <20160831140916.651de217@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.manjaro.org ([176.9.38.148]:35081 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753878AbcIAHq5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Sep 2016 03:46:57 -0400
In-Reply-To: <20160831140916.651de217@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This version of the patch produces a compile error for me about 
|add_interrupt_randomness
|

|CC [M] drivers/hv/vmbus_drv.o drivers/hv/vmbus_drv.c: In function 
‘vmbus_isr’: drivers/hv/vmbus_drv.c:831:2: error: too few arguments to 
function ‘add_interrupt_randomness’ 
add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0); 
^~~~~~~~~~~~~~~~~~~~~~~~ In file included from 
drivers/hv/vmbus_drv.c:44:0: include/linux/random.h:23:13: note: 
declared here extern void add_interrupt_randomness(int irq, int 
irq_flags, __u64 ip); ^~~~~~~~~~~~~~~~~~~~~~~~ make[2]: *** 
[scripts/Makefile.build:258: drivers/hv/vmbus_drv.o] Error 1 make[1]: 
*** [scripts/Makefile.build:403: drivers/hv] Error 2 make: *** 
[Makefile:947: drivers] Error 2 Any ideas? regards Bernhard |


On 31/08/16 20:09, Steven Rostedt wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 4.4.19-rt27 stable release.
>
>
> This release is just an update to the new stable 4.4.19 version
> and no RT specific changes have been made.
>
>
> You can get this release via the git tree at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>    branch: v4.4-rt
>    Head SHA1: 9eb16eaa11f388a29dcf3fe360ebd7849ee562f0
>
>
> Or to build 4.4.19-rt27 directly, the following patches should be applied:
>
>    http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz
>
>    http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.19.xz
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.19-rt27.patch.xz
>
>
>
>
> Enjoy,
>
> -- Steve
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

