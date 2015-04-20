From: Alexandre COFFIGNAL <acoffignal@geral.com>
Subject: 3.14.36-rt34 kernel crash on imx6
Date: Mon, 20 Apr 2015 11:35:04 +0200
Message-ID: <5534C848.4010809@geral.com>
References: <552F7406.1030806@geral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailhost.geral.com ([37.58.166.5]:58179 "EHLO
	mailhost.geral.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbbDTJfH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2015 05:35:07 -0400
In-Reply-To: <552F7406.1030806@geral.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

we are running PREEMPT_RT 3.14.36-rt34 on a imx6 board which works really fine.
But we see the following trace when we run this very simple app over ssh :


#include <stdio.h>

int main(int argc, char *argv[]){
     int i=0;
     while(1){
         printf("loop : %d\n",  i++);
     }
     return(0);
}

after a few minutes kernel crash with this message :

Does anybody have any idea on how to solve this?

Thank you very much for all help on this questions.

Regards,

Alexandre

Unable to handle kernel paging request at virtual address 3e1c7270
pgd = 80004000
[3e1c7270] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 45 Comm: kworker/1:1 Not tainted 3.14.36-rt34 #1
Workqueue: events flush_to_ldisc
task: beeb2b00 ti: bef24000 task.ti: bef24000
PC is at memcpy+0x114/0x330
LR is at n_tty_receive_buf_common+0x294/0x924
pc : [<8032c074>]    lr : [<803865a0>]    psr: 60000013
sp : bef25ddc  ip : 00000002  fp : bef25e44
r10: be155c00  r9 : 00000fff  r8 : be156c00
r7 : be156c24  r6 : be155c00  r5 : 00000192  r4 : c0b64000
r3 : 00000e6e  r2 : 0000018e  r1 : 3e1c7270  r0 : c0b64eac
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 4e23404a  DAC: 00000015
Process kworker/1:1 (pid: 45, stack limit = 0xbef24240)
Stack: (0xbef25ddc to 0xbef26000)
5dc0: c0b64eac
5de0: c0b64000 803865a0 00498e6e be156c24 be156c00 c0b64000 be155d24
bef25e44
5e00: beeb2b00 bef25e1c 00000000 3e1c7272 00000000 7ff8de1e be156c24
be155000
5e20: be156c04 be155c00 be156c24 be156c00 be6c4e80 bef24010 bef25e5c
bef25e48
5e40: 80386c4c 80386318 00000001 be156c04 bef25e8c bef25e60 8038a0b0
80386c3c
5e60: 80389fd8 be156c04 beecfa00 bf7cdd40 bef25eb0 00000000 bf7d1400
bef24010
5e80: bef25eec bef25e90 80042b60 80389fe4 00000002 00000000 80042ad0
80012e4c
5ea0: 00000000 00000002 00000000 00000000 80ebca58 80a15eb0 00000000
807c41d8
5ec0: bef25eec beecfa00 bf7cdd40 bf7cdd94 beecfa18 bef24030 bef24000
80947e0e
5ee0: bef25f24 bef25ef0 80043a34 800429b0 800438f8 00000000 00000000
beef8400
5f00: 00000000 beecfa00 800438f8 00000000 00000000 00000000 bef25fac
bef25f28
5f20: 80049a04 80043904 beeb2b00 00000000 8090bae8 beecfa00 00000000
00000000
5f40: dead4ead ffffffff ffffffff 80957708 00000000 00000000 807b2b64
bef25f5c
5f60: bef25f5c 00000000 00000000 dead4ead ffffffff ffffffff 80957708
00000000
5f80: 00000000 807b2b64 bef25f88 bef25f88 beef8400 80049938 00000000
00000000
5fa0: 00000000 bef25fb0 8000f348 80049944 00000000 00000000 00000000
00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00200000
00802000
Backtrace:
[<8038630c>] (n_tty_receive_buf_common) from [<80386c4c>]
(n_tty_receive_buf2+0x1c/0x24)
  r10:bef24010 r9:be6c4e80 r8:be156c00 r7:be156c24 r6:be155c00 r5:be156c04
  r4:be155000
[<80386c30>] (n_tty_receive_buf2) from [<8038a0b0>]
(flush_to_ldisc+0xd8/0x124)
[<80389fd8>] (flush_to_ldisc) from [<80042b60>]
(process_one_work+0x1bc/0x568)
  r10:bef24010 r9:bf7d1400 r8:00000000 r7:bef25eb0 r6:bf7cdd40 r5:beecfa00
  r4:be156c04 r3:80389fd8
[<800429a4>] (process_one_work) from [<80043a34>]
(worker_thread+0x13c/0x418)
  r10:80947e0e r9:bef24000 r8:bef24030 r7:beecfa18 r6:bf7cdd94 r5:bf7cdd40
  r4:beecfa00
[<800438f8>] (worker_thread) from [<80049a04>] (kthread+0xcc/0xe4)
  r10:00000000 r9:00000000 r8:00000000 r7:800438f8 r6:beecfa00 r5:00000000
  r4:beef8400
[<80049938>] (kthread) from [<8000f348>] (ret_from_fork+0x14/0x2c)
  r7:00000000 r6:00000000 r5:80049938 r4:beef8400
Code: e211c003 0affffc4 e3c11003 e35c0002 (e491e004)
---[ end trace 0000000000000002 ]---
Unable to handle kernel paging request at virtual address ffffffd0
pgd = 80004000
[ffffffd0] *pgd=4fffd821, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#2] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 45 Comm: kworker/1:1 Tainted: G      D      3.14.36-rt34 #1
task: beeb2b00 ti: bef24000 task.ti: bef24000
PC is at kthread_data+0x10/0x18
LR is at wq_worker_sleeping+0x10/0xb0
pc : [<8004a0c0>]    lr : [<80043d78>]    psr: 20000113
sp : bef25b10  ip : bef25b20  fp : bef25b1c
r10: beeb2b00  r9 : becb8000  r8 : beeb2cf8
r7 : beeb2af8  r6 : beeb2cf8  r5 : beeb2af8  r4 : beeb2b00
r3 : 00000000  r2 : bef25b38  r1 : beeb2c68  r0 : beeb2b00
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 4e11004a  DAC: 00000015
Process kworker/1:1 (pid: 45, stack limit = 0xbef24240)
Stack: (0xbef25b10 to 0xbef26000)
5b00:                                     bef25b34 bef25b20 80043d78
8004a0bc
5b20: 0420806c beeb2b00 bef25b4c bef25b38 8060c674 80043d74 00000040
00000001
5b40: bef25b84 bef25b50 8002881c 8060c61c 0000000b 00000001 bef24010
bef25b68
5b60: 00000001 beeb2d40 bef25b68 bef25b68 80026dec bef24000 bef25c04
bef25b88
5b80: 800135d4 80028190 bef24240 0000000b 00000008 00000000 60000113
00000000
5ba0: 65000005 63313132 20333030 66666130 34636666 63336520 30303131
33652033
5bc0: 30306335 28203230 31393465 34303065 80002029 806080e4 807d70e8
3e1c7270
5be0: 00000005 00000000 bef25d90 3e1c7270 00000005 be155c00 bef25c1c
bef25c08
5c00: 80606e24 800133dc bef25d90 beeb2b00 bef25cbc bef25c20 8001bf70
80606dd4
5c20: 5842e00e 11710088 0000000f 00000018 80d63ca8 beeb3060 00000003
00000006
5c40: beeb2b00 00000004 00000006 80e449f4 bef25c94 bef25c60 8006c630
8006bf20
5c60: bef25cbc 00000000 bf7ce350 bef24018 8060ecd8 beeb2b00 00000001
00000001
5c80: bef24018 00000000 bef25cb4 bef25c98 8006c800 3e1c7270 bef25d90
00000005
5ca0: 3e1c7270 bef25d90 00000fff be155c00 bef25cdc bef25cc0 8001c214
8001bc70
5cc0: 80901940 00000005 8001c148 80901990 bef25d8c bef25ce0 80008414
8001c154
5ce0: 8091b5e8 00000000 80054bf0 00000000 5842e212 11710088 00000213
00000008
5d00: beeb3078 bef24008 bef25db4 bef25d18 8060c388 8005737c 809f3da0
beeb2b00
5d20: 80d63ca8 beeb3060 00000003 00000006 beeb2b00 beeb2b00 bef24000
80013ed4
5d40: bef25dc4 be156c00 00000fff be155c00 bef25d7c bef25d60 80069f1c
800b5ea8
5d60: 803865a0 8032c074 60000013 8032c074 60000013 ffffffff bef25dc4
be156c00
5d80: bef25e44 bef25d90 80013ee4 800083e4 c0b64eac 3e1c7270 0000018e
00000e6e
5da0: c0b64000 00000192 be155c00 be156c24 be156c00 00000fff be155c00
bef25e44
5dc0: 00000002 bef25ddc 803865a0 8032c074 60000013 ffffffff bef25e44
c0b64eac
5de0: c0b64000 803865a0 00498e6e be156c24 be156c00 c0b64000 be155d24
bef25e44
5e00: beeb2b00 bef25e1c 00000000 3e1c7272 00000000 7ff8de1e be156c24
be155000
5e20: be156c04 be155c00 be156c24 be156c00 be6c4e80 bef24010 bef25e5c
bef25e48
5e40: 80386c4c 80386318 00000001 be156c04 bef25e8c bef25e60 8038a0b0
80386c3c
5e60: 80389fd8 be156c04 beecfa00 bf7cdd40 bef25eb0 00000000 bf7d1400
bef24010
5e80: bef25eec bef25e90 80042b60 80389fe4 00000002 00000000 80042ad0
80012e4c
5ea0: 00000000 00000002 00000000 00000000 80ebca58 80a15eb0 00000000
807c41d8
5ec0: bef25eec beecfa00 bf7cdd40 bf7cdd94 beecfa18 bef24030 bef24000
80947e0e
5ee0: bef25f24 bef25ef0 80043a34 800429b0 800438f8 00000000 00000000
beef8400
5f00: 00000000 beecfa00 800438f8 00000000 00000000 00000000 bef25fac
bef25f28
5f20: 80049a04 80043904 beeb2b00 00000000 8090bae8 beecfa00 00000000
00000000
5f40: dead4ead ffffffff ffffffff 80957708 00000000 00000000 807b2b64
bef25f5c
5f60: bef25f5c 00000001 00010001 dead4ead ffffffff ffffffff 80957708
00000000
5f80: 00000000 807b2b64 bef25f88 bef25f88 beef8400 80049938 00000000
00000000
5fa0: 00000000 bef25fb0 8000f348 80049944 00000000 00000000 00000000
00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00200000
00802000
Backtrace:
[<8004a0b0>] (kthread_data) from [<80043d78>]
(wq_worker_sleeping+0x10/0xb0)
[<80043d68>] (wq_worker_sleeping) from [<8060c674>] (schedule+0x64/0xbc)
  r4:beeb2b00 r3:0420806c
[<8060c610>] (schedule) from [<8002881c>] (do_exit+0x698/0x980)
  r4:00000001 r3:00000040
[<80028184>] (do_exit) from [<800135d4>] (die+0x204/0x3cc)
  r7:bef24000
[<800133d0>] (die) from [<80606e24>] (__do_kernel_fault.part.11+0x5c/0x7c)
  r10:be155c00 r9:00000005 r8:3e1c7270 r7:bef25d90 r6:00000000 r5:00000005
  r4:3e1c7270
[<80606dc8>] (__do_kernel_fault.part.11) from [<8001bf70>]
(do_page_fault+0x30c/0x408)
  r7:beeb2b00 r3:bef25d90
[<8001bc64>] (do_page_fault) from [<8001c214>]
(do_translation_fault+0xcc/0xd8)
  r10:be155c00 r9:00000fff r8:bef25d90 r7:3e1c7270 r6:00000005 r5:bef25d90
  r4:3e1c7270
[<8001c148>] (do_translation_fault) from [<80008414>]
(do_DataAbort+0x3c/0xa0)
  r6:80901990 r5:8001c148 r4:00000005 r3:80901940
[<800083d8>] (do_DataAbort) from [<80013ee4>] (__dabt_svc+0x44/0x80)
Exception stack(0xbef25d90 to 0xbef25dd8)
5d80:                                     c0b64eac 3e1c7270 0000018e
00000e6e
5da0: c0b64000 00000192 be155c00 be156c24 be156c00 00000fff be155c00
bef25e44
5dc0: 00000002 bef25ddc 803865a0 8032c074 60000013 ffffffff
  r8:be156c00 r7:bef25dc4 r6:ffffffff r5:60000013 r4:8032c074
[<8038630c>] (n_tty_receive_buf_common) from [<80386c4c>]
(n_tty_receive_buf2+0x1c/0x24)
  r10:bef24010 r9:be6c4e80 r8:be156c00 r7:be156c24 r6:be155c00 r5:be156c04
  r4:be155000
[<80386c30>] (n_tty_receive_buf2) from [<8038a0b0>]
(flush_to_ldisc+0xd8/0x124)
[<80389fd8>] (flush_to_ldisc) from [<80042b60>]
(process_one_work+0x1bc/0x568)
  r10:bef24010 r9:bf7d1400 r8:00000000 r7:bef25eb0 r6:bf7cdd40 r5:beecfa00
  r4:be156c04 r3:80389fd8
[<800429a4>] (process_one_work) from [<80043a34>]
(worker_thread+0x13c/0x418)
  r10:80947e0e r9:bef24000 r8:bef24030 r7:beecfa18 r6:bf7cdd94 r5:bf7cdd40
  r4:beecfa00
[<800438f8>] (worker_thread) from [<80049a04>] (kthread+0xcc/0xe4)
  r10:00000000 r9:00000000 r8:00000000 r7:800438f8 r6:beecfa00 r5:00000000
  r4:beef8400
[<80049938>] (kthread) from [<8000f348>] (ret_from_fork+0x14/0x2c)
  r7:00000000 r6:00000000 r5:80049938 r4:beef8400
Code: e1a0c00d e92dd800 e24cb004 e5903250 (e5130030)
---[ end trace 0000000000000003 ]---

  Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request at virtual address ffffffd0
pgd = 80004000
[ffffffd0] *pgd=4fffd821, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#3] PREEMPT SMP ARM
[...]






