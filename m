Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B361A8405
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Dec 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734700728; cv=none; b=NVraJBX2wqJYnYPhAY0l66uDKQ6QY7T0WrO2TkkS2Fhsn8PzMvl68gBYZxoozwp/xelJG5Y0JJ9qDfj3NsOTlR2OQB6Amgb/GL9PZoAr/g98kw+09ZK8OCj8Q/PHFYbjbKn7B7qaHN8DiGbQ9FkoIGVVpC56lPGHEuJaELBrkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734700728; c=relaxed/simple;
	bh=WrVPaEfjMAxFxZPhpXRY1qR9NZv2nKJyvb1CF+LjeOY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=UGjBPBjkV33zpzjgvJnp/cHxEfwzl7oUYlFxVS3YYWyLpF6qPebO0K1dXP9UR1dZleCO/cU792WwO+LYa2iBde2vTz6Axv4uJkxjOCSzlKWUkvnWtUjdcu7ZRMdlGzR9AwbNE+gpWBn0XCvVZ/b9wL4ymRb8QF0EuQqAA67w4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=rfMWZnG8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="rfMWZnG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1734700723; x=1735305523; i=mista.tapas@gmx.net;
	bh=XBeGXjGfnKLulIA6UlfHaOwul5CvhSmNzRo1r6Prh7M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rfMWZnG8yo/3kpCqXdx04W9VL3AjUduATPyB7zz7Yv1abVRtOF999/axaPD82JaM
	 +c7hnjPN/qyNx8u9hPIOqksKsmf4Uvsy8nSVeJK21kD/k+MfCwqFKgZY6Xh3h2aU0
	 j03tnNKPttZVZYByjAiVbtNAjJadQW7GoS8pAImkwAphU8dv4vX7RErdB0nrp1OK8
	 qEgJxiR5WfdGkzUvMhNNPaMSai3VD2A9Q2I5sDw6cJuLK3K2lPJZi1DVn4fDCWl0F
	 QGjV5sf5HYvIkrCzVhsJVz0X9Q0ykWy8pDchm1XfRCeX0LctLvr+FKiWwy4KaIrdP
	 lql9fwhIq3MgEfg1jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.136] ([92.39.22.117]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1t2XfH2Obg-00WG0P for
 <linux-rt-users@vger.kernel.org>; Fri, 20 Dec 2024 14:18:43 +0100
Message-ID: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
Date: Fri, 20 Dec 2024 14:18:43 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Paul Schmidt <mista.tapas@gmx.net>
Subject: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GukUAO0U+xSD21CK6EpmawcvC6+Z1GNh93tDxA/Ylv/TETT4CDn
 F8uV4CJhn8cQPVfJMH8aXG6f/BgtVXrjHIZ9Wf6IY914kd+/agdp3K/5ZMzVzaN0cvqEPbv
 TWE6zNGaBkvJ2cYW2jLdccUvsHRGMnu9HCRZh+Ulx6fCP1hGLZUgfl4aPSrAWxYLxcB+2Qh
 6OtTnqrQ4860rH6IX/dGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IOacqw99Skg=;AjFHoarOp2mwBsdAB6s600qRhCz
 +FdwRXIVF40fRZ9TBPr48XURZUyYWA0u7PnRV/jt0N+5EClJw+kSpAc3j0iR2baohGsM3X0lz
 AxrCHX2Iz4lQn9cii0ee8eIPGfQ+wk+ne5T6+AnoGYe/xPacbwqvPTWjPwiO7yEZSctne4dwJ
 lB0LkVU9hlimPc6y1sOEwBYarR/QAdyhDTUyu+9bnilGtI83g2swzfKwkbYeLEWb0z2o7vIyE
 ANmYAKvmpTPw9fRARIE7wjc4SYqfW7VQkiB5Uc5t9a7CuvSr3vKhgIX9tm8SUyyOKLhxfb6hw
 ux5tHDur+ThQbqaM+oNhuEC1QrryeH2CQqA6ldv+rg7tQ+23tZKzPq/ZczBbAMhPt01cNaWrB
 wI/3VFHiD4gcr19lxlonA5hSxIdhEULU17Zx0n1KKH+Pm/y8rk87QhcpgSCoOaID5wpnyWhLy
 9ViFw2MYXWUnAysrInIw/R7VMTc9PEBGfEARG25oOWOjcCgjeIKfUAQl6FekzFmhnLXt0y2AP
 hOTUWVf5JiPUV4csk+j/x2xMfFnonX1h0czL5uOYWzcQ1parT9NmGSykGUDBB0pGfmtRczynB
 B8U6FStC9eJJ1V+vnp/BzmfIzS5MRozO04gZAqZKCR01CKhcGJmq7bs5yqZnPVIoNP+EkAN/h
 KjID8HKmaxOi1aJsM54+T63tnWo/nA5WNQ+u4xwfp9Ots3Wz+c7WXJmdnMSCsthUfdBeuSgB8
 TdW6BCWbHrg/yNEhotxH8ZP4Z2yonYcTeTkQQaAnf4KpEQFvm6tZzL70PL9HwnSwP0QLKez3C
 wbG+bvF2Ymi+fC2gg2mhkuLFA7uuAk/uAoUzyqy0C/Mn8xcC9hSg7QqurGhsx3u5YVnT4vY6z
 5flnoaM/RS9fWB12tc7s0Zvp/27Lb1s1eNBNntLPPYCwUwiXu6tUCcAt49LuqcO+x4wb5c+Nz
 47mxuY3C9jvdN8hcm1Wpidqnkbeo0y0pupoxsETVEYdPaD09nIbNmVsI4gvGX2Do5pjzBwPrx
 iranRklNEP/sHUhc3v2OqPrqQdhA6kuYq74Yyj9yHCBnYTFcgzmiJC67ei0Khj8Czdd7JgjM9
 nJDcG1s0ajvl+VplmgHraufikIb3R0

Hi!

I'm playing around with a Raspberry Pi 5 and a PREEMPT_RT kernel (raspberry
pi 6.13.y branch) and wonder about the latencies I see. First I tried
cyclictest and saw latencies in the upper 50s up to 80s or so under a
kernel compile load.

So I compiled the kernel with timerlat and osnoise tracers and ran a bit of

rtla timerlat top -a 60 --dma-latency 0

and I get traces like the following:


                                      Timer Latency
   0 00:00:22   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
   0 #21138     |        4         0         0        14 |       17         3         4        48
   1 #21138     |        6         0         0        21 |       41         3         4        50
   2 #21138     |       11         0         0        11 |       61         3         4        61
   3 #21138     |        5         0         0        10 |       40         3         4        57
rtla timerlat hit stop tracing
## CPU 2 hit stop tracing, analyzing it ##
   IRQ handler delay:                                         1.36 us (2.22 %)
   IRQ latency:                                              11.60 us
   Timerlat IRQ duration:                                    21.26 us (34.63 %)
   Blocking thread:                                          19.46 us (31.70 %)
                              cc1:265581                     19.46 us
     Blocking thread stack trace
                 -> timerlat_irq
                 -> __hrtimer_run_queues
                 -> hrtimer_interrupt
                 -> arch_timer_handler_phys
                 -> handle_percpu_devid_irq
                 -> generic_handle_domain_irq
                 -> gic_handle_irq
                 -> call_on_irq_stack
                 -> do_interrupt_handler
                 -> el0_interrupt
                 -> __el0_irq_handler_common
                 -> el0t_64_irq_handler
                 -> el0t_64_irq
------------------------------------------------------------------------
   Thread latency:                                           61.40 us (100%)

Max timerlat IRQ latency from idle: 4.74 us in cpu 2
   Saving trace to timerlat_trace.txt

And the surprising thing was that there was nothing out of the ordinary (at
least to my non-expert eyes): No spin locks or similar. Just a syscall (these
are implemented via IRQ EL0, right?) which then goes straight to the timer
handling. I might be completely off here though, as I am not an expert at
all in these things.

When I contrast this to an unloaded system and a threshold like 10 us it seems
that there is actually "something" in the trace.

                                      Timer Latency
   0 00:00:04   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
   0 #4004      |        0         0         0         1 |        3         3         3         6
   1 #4004      |        1         0         0         1 |       10         3         3        10
   2 #4003      |        0         0         0         0 |        3         3         3         7
   3 #4003      |        0         0         0         1 |        3         3         3         7
rtla timerlat hit stop tracing
## CPU 1 hit stop tracing, analyzing it ##
   IRQ handler delay:                                         0.00 us (0.00 %)
   IRQ latency:                                               1.40 us
   Timerlat IRQ duration:                                     4.67 us (45.67 %)
   Blocking thread:                                           3.17 us (30.98 %)
                             htop:262562                      3.17 us
     Blocking thread stack trace
                 -> timerlat_irq
                 -> __hrtimer_run_queues
                 -> hrtimer_interrupt
                 -> arch_timer_handler_phys
                 -> handle_percpu_devid_irq
                 -> generic_handle_domain_irq
                 -> gic_handle_irq
                 -> call_on_irq_stack
                 -> do_interrupt_handler
                 -> el1_interrupt
                 -> el1h_64_irq_handler
                 -> el1h_64_irq
                 -> tracer_preempt_on
                 -> preempt_count_sub
                 -> migrate_enable
                 -> kmem_cache_free
                 -> __fput
                 -> __fput_sync
                 -> __arm64_sys_close
                 -> invoke_syscall
                 -> el0_svc_common.constprop.0
                 -> do_el0_svc
                 -> el0_svc
                 -> el0t_64_sync_handler
                 -> el0t_64_sync
------------------------------------------------------------------------
   Thread latency:                                           10.22 us (100%)

Max timerlat IRQ latency from idle: 1.43 us in cpu 1
   Saving trace to timerlat_trace.txt

In this case it's htop invoking some syscall. So I really wonder how to
interpret things like the first trace above where "nothing" is happening
and still there are large-ish latencie.

At some point in time I wondered what kind of loads did trigger the
longest latencies and I played with "stress -m 6" a little and I was
surprised to see the latencies even go higher than 100. Here is an
example trace

                                      Timer Latency
   0 00:00:16   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
   0 #15654     |        1         0         2        31 |        6         3        15        75
   1 #15654     |        2         0         3        42 |       13         3        17        91
   2 #15654     |        2         0         2        38 |       17         3        16        87
   3 #15654     |        5         0         3        26 |      111         3        16       111
rtla timerlat hit stop tracing
## CPU 3 hit stop tracing, analyzing it ##
   IRQ handler delay:                                         0.00 us (0.00 %)
   IRQ latency:                                               5.16 us
   Timerlat IRQ duration:                                    47.41 us (42.53 %)
   Blocking thread:                                          50.50 us (45.30 %)
                           stress:278226                     50.50 us
     Blocking thread stack trace
                 -> timerlat_irq
                 -> __hrtimer_run_queues
                 -> hrtimer_interrupt
                 -> arch_timer_handler_phys
                 -> handle_percpu_devid_irq
                 -> generic_handle_domain_irq
                 -> gic_handle_irq
                 -> call_on_irq_stack
                 -> do_interrupt_handler
                 -> el1_interrupt
                 -> el1h_64_irq_handler
                 -> el1h_64_irq
                 -> folios_put_refs
                 -> free_pages_and_swap_cache
                 -> __tlb_batch_free_encoded_pages
                 -> tlb_flush_mmu
                 -> unmap_page_range
                 -> unmap_vmas
                 -> vms_clear_ptes
                 -> vms_complete_munmap_vmas
                 -> do_vmi_align_munmap
                 -> do_vmi_munmap
                 -> __vm_munmap
                 -> __arm64_sys_munmap
                 -> invoke_syscall
                 -> el0_svc_common.constprop.0
                 -> do_el0_svc
                 -> el0_svc
                 -> el0t_64_sync_handler
                 -> el0t_64_sync
------------------------------------------------------------------------
   Thread latency:                                          111.47 us (100%)

Max timerlat IRQ latency from idle: 1.98 us in cpu 3
   Saving trace to timerlat_trace.txt


OK, here at least something related to virtual memory is happening.
I still wonder though: How come the latencies are so large? Is the
raspberry pi platform just not suited to reach lower latencies? Is
everything working as expected? Are maybe the raspberry pi
patches responsible for latency sources which are invisible in the
traces? I there any hope for getting these latencies a little more
under control?

Kind regards,
FPS
