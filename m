From: "Nelson Castillo" <nelsoneci@gmail.com>
Subject: Re: v2.6.21.4-rt11
Date: Sun, 17 Jun 2007 11:15:35 -0500
Message-ID: <2accc2ff0706170915h7cc0ce97ofc16bc33f1714567@mail.gmail.com>
References: <20070609210507.GA29194@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:47023 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbXFQQPh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 17 Jun 2007 12:15:37 -0400
Received: by py-out-1112.google.com with SMTP id a29so2617296pyi
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Jun 2007 09:15:36 -0700 (PDT)
In-Reply-To: <20070609210507.GA29194@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 6/9/07, Ingo Molnar <mingo@elte.hu> wrote:
>
> i'm pleased to announce the v2.6.21.4-rt11 kernel, which can be
> downloaded from the usual place:
>
>      http://people.redhat.com/mingo/realtime-preempt/
>
> more info about the -rt patchset can be found in the RT wiki:
>
>      http://rt.wiki.kernel.org

Not for ARM yet :(

What should I try for the ARM architecture? There are many choices and
I don't know what is the more friendly. By friendly I mean the one that
is likely to be merged and that cooperate with you.

> to build a 2.6.21.4-rt11 tree, the following patches should be applied:
>
>     http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.4.tar.bz2
>     http://people.redhat.com/mingo/realtime-preempt/patch-2.6.21.4-rt11
>


Using this patch:

  http://people.redhat.com/mingo/realtime-preempt/patch-2.6.21.4-rt14

  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0xd3f0): In function `do_sys_settimeofday':
: undefined reference to `warp_check_clock_was_changed'
kernel/built-in.o(.text+0x12588): In function `timekeeping_resume':
: undefined reference to `warp_check_clock_was_changed'
kernel/built-in.o(.text+0x132f8): In function `do_sysinfo':
: undefined reference to `__get_nsec_offset'
kernel/built-in.o(.text+0x20a04): In function `ktime_get_ts':
: undefined reference to `__get_nsec_offset'
kernel/built-in.o(.text+0x221c0): In function `$a':
: undefined reference to `warp_check_clock_was_changed'
kernel/built-in.o(.text+0x22208): In function `$a':
: undefined reference to `warp_check_clock_was_changed'
kernel/built-in.o(.text+0x2b9dc): In function `$a':
: undefined reference to `usecs_to_cycles'
make: *** [.tmp_vmlinux1] Error 1

Regards.

-- 
http://arhuaco.org
http://emQbit.com
