From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Highmem support on ppc32 plattform with PREEMPT_RT_FULL option
Date: Fri, 31 May 2013 21:56:49 +0200
Message-ID: <20130531195649.GB24632@linutronix.de>
References: <CAKQvxgWOcnK79bn1f0LWqvagAEXVrS39eGv0ESUvp4LwdnGEFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Heiko Schumann <heiko.sirona@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39926 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab3EaT4u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 May 2013 15:56:50 -0400
Content-Disposition: inline
In-Reply-To: <CAKQvxgWOcnK79bn1f0LWqvagAEXVrS39eGv0ESUvp4LwdnGEFw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Heiko Schumann | 2013-05-14 13:04:34 [+0200]:

>Hello,
Hi,

>i=C2=B4ve a ppc32 processor with 2 GB Ram. I use a 3.8.4 Kernel with v=
endor
>and 3.8.4rt2 patch. To support  2 GB of RAM i=C2=B4ve to set the kerne=
l
>option HIGHMEM. But this option is not available when PREEMPT_RT_FULL
>is selected.
>Is there a workaround or additional patch to use more than 1GB RAM on
>a ppc32 with the option PREEMPT_RT_FULL?

No, we have only arm and x86 so far. Either try to do the same thing on
Power that has been on ARM & x86.
A workaround would be to adjust lowmem, virtual base and user stack.
That means your userland wouldn't have 3GiB virtual address space but
the kernel could access 2GiB.
Something like=20
  CONFIG_PAGE_OFFSET=3D0x40000000
  CONFIG_KERNEL_START=3D0x40000000
  CONFIG_TASK_SIZE=3D0x40000000

should work.

>
>Thanks

Sebatian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
