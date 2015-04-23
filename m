From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.14.36-rt34 kernel crash on imx6
Date: Thu, 23 Apr 2015 16:32:19 -0400
Message-ID: <20150423163219.3c354d19@gandalf.local.home>
References: <552F7406.1030806@geral.com>
	<5534C848.4010809@geral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Alexandre COFFIGNAL <acoffignal@geral.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:48802 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754209AbbDWUcW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2015 16:32:22 -0400
In-Reply-To: <5534C848.4010809@geral.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 20 Apr 2015 11:35:04 +0200
Alexandre COFFIGNAL <acoffignal@geral.com> wrote:

> Hi All,
> 
> we are running PREEMPT_RT 3.14.36-rt34 on a imx6 board which works really fine.
> But we see the following trace when we run this very simple app over ssh :

I tried to see if I could reproduce this on my ARM board, but my
snowball board is dead, and my beaglebone white, for some reason wont
boot 3.14 (vanilla or -rt).

> 
> 
> #include <stdio.h>
> 
> int main(int argc, char *argv[]){
>      int i=0;
>      while(1){
>          printf("loop : %d\n",  i++);
>      }
>      return(0);
> }
> 
> after a few minutes kernel crash with this message :
> 
> Does anybody have any idea on how to solve this?
> 
> Thank you very much for all help on this questions.
> 
> Regards,
> 
> Alexandre
> 
> Unable to handle kernel paging request at virtual address 3e1c7270
> pgd = 80004000
> [3e1c7270] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 45 Comm: kworker/1:1 Not tainted 3.14.36-rt34 #1
> Workqueue: events flush_to_ldisc
> task: beeb2b00 ti: bef24000 task.ti: bef24000
> PC is at memcpy+0x114/0x330
> LR is at n_tty_receive_buf_common+0x294/0x924
> pc : [<8032c074>]    lr : [<803865a0>]    psr: 60000013
> sp : bef25ddc  ip : 00000002  fp : bef25e44
> r10: be155c00  r9 : 00000fff  r8 : be156c00
> r7 : be156c24  r6 : be155c00  r5 : 00000192  r4 : c0b64000
> r3 : 00000e6e  r2 : 0000018e  r1 : 3e1c7270  r0 : c0b64eac
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel

Can you try 3.14.39-rt37. There has been some fixes in the vanilla
stable tree in this code. I don't know if it will help you, but it may
be worth a try.

-- Steve


> Control: 10c5387d  Table: 4e23404a  DAC: 00000015
> Process kworker/1:1 (pid: 45, stack limit = 0xbef24240)
> Stack: (0xbef25ddc to 0xbef26000)
> 5dc0: c0b64eac
> 5de0: c0b64000 803865a0 00498e6e be156c24 be156c00 c0b64000 be155d24
> bef25e44
> 5e00: beeb2b00 bef25e1c 00000000 3e1c7272 00000000 7ff8de1e be156c24
> be155000
> 5e20: be156c04 be155c00 be156c24 be156c00 be6c4e80 bef24010 bef25e5c
> bef25e48
> 5e40: 80386c4c 80386318 00000001 be156c04 bef25e8c bef25e60 8038a0b0
> 80386c3c
> 5e60: 80389fd8 be156c04 beecfa00 bf7cdd40 bef25eb0 00000000 bf7d1400
> bef24010
> 5e80: bef25eec bef25e90 80042b60 80389fe4 00000002 00000000 80042ad0
> 80012e4c
> 5ea0: 00000000 00000002 00000000 00000000 80ebca58 80a15eb0 00000000
> 807c41d8
> 5ec0: bef25eec beecfa00 bf7cdd40 bf7cdd94 beecfa18 bef24030 bef24000
> 80947e0e
> 5ee0: bef25f24 bef25ef0 80043a34 800429b0 800438f8 00000000 00000000
> beef8400
> 5f00: 00000000 beecfa00 800438f8 00000000 00000000 00000000 bef25fac
> bef25f28
> 5f20: 80049a04 80043904 beeb2b00 00000000 8090bae8 beecfa00 00000000
> 00000000
> 5f40: dead4ead ffffffff ffffffff 80957708 00000000 00000000 807b2b64
> bef25f5c
> 5f60: bef25f5c 00000000 00000000 dead4ead ffffffff ffffffff 80957708
> 00000000
> 5f80: 00000000 807b2b64 bef25f88 bef25f88 beef8400 80049938 00000000
> 00000000
> 5fa0: 00000000 bef25fb0 8000f348 80049944 00000000 00000000 00000000
> 00000000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00200000
> 00802000
> Backtrace:
> [<8038630c>] (n_tty_receive_buf_common) from [<80386c4c>]
> (n_tty_receive_buf2+0x1c/0x24)
>   r10:bef24010 r9:be6c4e80 r8:be156c00 r7:be156c24 r6:be155c00 r5:be156c04
>   r4:be155000
> [<80386c30>] (n_tty_receive_buf2) from [<8038a0b0>]
> (flush_to_ldisc+0xd8/0x124)
> [<80389fd8>] (flush_to_ldisc) from [<80042b60>]
> (process_one_work+0x1bc/0x568)
>   r10:bef24010 r9:bf7d1400 r8:00000000 r7:bef25eb0 r6:bf7cdd40 r5:beecfa00
>   r4:be156c04 r3:80389fd8
> [<800429a4>] (process_one_work) from [<80043a34>]
> (worker_thread+0x13c/0x418)
>   r10:80947e0e r9:bef24000 r8:bef24030 r7:beecfa18 r6:bf7cdd94 r5:bf7cdd40
>   r4:beecfa00
> [<800438f8>] (worker_thread) from [<80049a04>] (kthread+0xcc/0xe4)
>   r10:00000000 r9:00000000 r8:00000000 r7:800438f8 r6:beecfa00 r5:00000000
>   r4:beef8400
> [<80049938>] (kthread) from [<8000f348>] (ret_from_fork+0x14/0x2c)
>   r7:00000000 r6:00000000 r5:80049938 r4:beef8400
> Code: e211c003 0affffc4 e3c11003 e35c0002 (e491e004)
> ---[ end trace 0000000000000002 ]---

