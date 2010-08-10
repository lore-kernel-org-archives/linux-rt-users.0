From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
Date: Tue, 10 Aug 2010 14:23:35 +0200
Message-ID: <4C6144C7.4040609@enseirb-matmeca.fr>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plan.enseirb.fr ([147.210.18.60]:37495 "EHLO plan.enseirb.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757142Ab0HJMuX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Aug 2010 08:50:23 -0400
Received: from localhost (mx [147.210.18.15])
	by plan.enseirb.fr (8.13.8/8.13.8) with ESMTP id o7ACN9cE022809
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2010 14:23:09 +0200 (MEST)
Received: from plan.enseirb.fr ([147.210.18.60])
	by localhost (tan.enseirb.fr [147.210.18.15]) (amavisd-new, port 10041)
	with LMTP id Q+-R6W+4RyYT for <linux-rt-users@vger.kernel.org>;
	Tue, 10 Aug 2010 14:23:18 +0200 (MEST)
Received: from [192.168.0.1] (dispo-82-65-217-243.adsl.proxad.net [82.65.217.243])
	(authenticated bits=0)
	from identified as kadionik
	by plan.enseirb.fr (8.13.8/8.13.8) with ESMTP id o7ACN5NL022806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2010 14:23:06 +0200 (MEST)
In-Reply-To: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le 09/08/2010 22:10, John Culvertson a =E9crit :
> Hello,
>   =20
Hello,

> I am trying to use the RT patches on an x86 industrial computer.  I a=
m
> getting intermittent network hangs and kernel crashes when I load the
> network with netperf.  The unpatched kernel does not exhibit these
> problems.  The kernel is 2.6.33.6 patched with rt28.
>
> The computer has an AMD LX800 processor and two Intel 82559 10/100 PC=
I
> Ethernet controllers.  I have only seen the kernel crashes when
> running netperf on both ports simultaneously.
>   =20
I have ported PREEMPT-RT to the NIOS II architecture. NIOS II is a=20
softcore processor from Altera.
I have added to the NIOS II Linux port(http://sopc.et.ntust.edu.tw/) th=
e=20
hrtimer support and can now use cyclistest.
I have done some measurements for having latency (my NIOS II target=20
boards runs at 100 MHz!).
I have used ping flooding from another powerful PC (CPU frequency > 2=20
GHz) and have noticed that after few seconds, the bounded latency I had=
=20
arises up to 50 ms! My target board doesn't crash like you.
  I have spent time for understanding. The ping flooding is OK with a=20
normal Linux kernel (few ms as latency in this case). I used wireshark=20
to analyze the traffic and saw that my board with PREEMPT-RT support=20
doesn't respond after few seconds to all ping requests.

I've tried to put the IRQ thread of the Ethernet driver in a classical=20
mode like with the standard Linux kernel through adding the IRQ_NODELAY=
=20
flag with with request_irq() in the driver. My boards boots but crashs=20
on the first ping because treatment is always done by the soft IRQ=20
sirq-net-rx (this is this soft IRQ thread that causes your crash).
The NIOS II has no ftrace support yet so no tool for studying latencies=
=20
is available...

I've done some researchs on the net on this problem and found the=20
presentation "INTERRUPTS CONSIDERED HARMFUL" from Peter Chubb and Yang=20
Song=20
(http://citeseerx.ist.psu.edu/viewdoc/download?doi=3D10.1.1.156.9914&re=
p=3Drep1&type=3Dpdf).=20


The paper presents the same testing environment like you and me: a=20
target board under PREEMPT-RT and a Ethernet traffic generator that can=
=20
generates a huge traffic load. They use cyclictest too.With heavy=20
traffic, latency from cyclictest goes up to 50 ms (like me)! By=20
analyzing traces (with ftrace), they saw that the soft IRQ sirq-net-rx=20
takes too time for responding in case of heavy traffic load. The=20
solution they have found was to modify the Ethernet driver (e1000)  wit=
h=20
no soft IRQ.
I know now the source of my problem and can't have a realistic response=
=20
time to ping flooding with a traffic generator that saturates the targe=
t=20
board under PREEMPT-RT. In this case, the Ethernet driver must be revis=
ited.
You may have the same problem with another consequence: crash. Have you=
=20
tried to ping flood just one Ethernet interface with heavy traffic?
=46or latency measurement, I just use hackbench=20
(http://devresources.linuxfoundation.org/craiger/hackbench/), stress=20
(http://weather.ou.edu/~apw/projects/stress/) tools and dd commands. My=
=20
latency time with cyclictest is bounded with heavy CPU load (min=3D 300=
=B5s =20
max<1400 =B5s CPU@100 MHz) and know that I can have realistic response=20
time in case of heavy Ethernet traffic (my NIOS II board has not enough=
=20
CPU power in this case).

Pat.


> This is my first time using the RT patches, so I am not sure how to g=
o
> about resolving this.  Any tips would be greatly appreciated.
>
> [  201.514962] BUG: unable to handle kernel paging request at a028204=
4
> [  201.516020] IP: [<c108d664>] free_block+0x4f/0xe5
> [  201.516020] *pde =3D 00000000
> [  201.516020] Oops: 0002 [#1] PREEMPT
> [  201.516020] last sysfs file: /sys/module/vt/parameters/default_utf=
8
> [  201.516020] Modules linked in: evdev usbhid ohci_hcd geode_rng ecb
> aes_i586 ehci_hcd aes_generic usbcore geode_aes nls_base
> [  201.516020]
> [  201.516020] Pid: 6, comm: sirq-net-rx/0 Tainted: G        W
> 2.6.33.6-rt28 #4 SL8/SL8
> [  201.516020] EIP: 0060:[<c108d664>] EFLAGS: 00010202 CPU: 0
> [  201.516020] EIP is at free_block+0x4f/0xe5
> [  201.516020] EAX: d6d75060 EBX: de682500 ECX: 00000004 EDX: a028204=
0
> [  201.516020] ESI: de682020 EDI: de431340 EBP: de40e5c0 ESP: de44bd7=
4
> [  201.516020]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 preempt:=
00000000
> [  201.516020] Process sirq-net-rx/0 (pid: 6, ti=3Dde44a000
> task=3Dde420490 task.ti=3Dde44a000)
> [  201.516020] Stack:
> [  201.516020]  00000003 00000000 0000001b de406688 00000001 de431340
> 00000000 de406660
> [  201.516020]<0>  0000001b c108d835 00000000 de44bdc8 de44bdc8
> ddbd2060 de40e5c0 de431364
> [  201.516020]<0>  00000000 de40e5c0 ddbd2060 ddbd2060 c108d581
> 00000000 00000000 d6e78620
> [  201.516020] Call Trace:
> [  201.516020]  [<c108d835>] ? __cache_free+0x7a/0xae
> [  201.516020]  [<c108d581>] ? kmem_cache_free+0x1c/0x58
> [  201.516020]  [<c11d3493>] ? tcp_ack+0x3eb/0x12f5
> [  201.516020]  [<c11d4bd8>] ? tcp_rcv_established+0xb0/0x476
> [  201.516020]  [<c11da92f>] ? tcp_v4_do_rcv+0x129/0x28f
> [  201.516020]  [<c11dbf43>] ? tcp_v4_rcv+0x339/0x523
> [  201.516020]  [<c11c3a8a>] ? ip_local_deliver_finish+0xf9/0x160
> [  201.516020]  [<c11c3925>] ? ip_rcv_finish+0x28a/0x29d
> [  201.516020]  [<c11aceb4>] ? netif_receive_skb+0x1c2/0x1e9
> [  201.516020]  [<c118d368>] ? e100_poll+0x172/0x37c
> [  201.516020]  [<c11af94c>] ? net_rx_action+0x53/0x100
> [  201.516020]  [<c1027743>] ? run_ksoftirqd+0xfb/0x1da
> [  201.516020]  [<c1027648>] ? run_ksoftirqd+0x0/0x1da
> [  201.516020]  [<c1036d2d>] ? kthread+0x52/0x57
> [  201.516020]  [<c1036cdb>] ? kthread+0x0/0x57
> [  201.516020]  [<c1002dbe>] ? kernel_thread_helper+0x6/0x10
> [  201.516020] Code: 24 0c 8b 1c 82 89 d8 e8 34 fc ff ff 89 c6 e8 18
> f9 ff ff 85 c0 75 04 0f 0b eb fe 8b 76 1c 8b 44 24 28 8b 16 8b 7c 85
> 4c 8b 46 04<89>  42 04 89 10 2b 5e 0c c7 06 00 01 10 00 c7 46 04 00 0=
2
> 20 00
> [  201.516020] EIP: [<c108d664>] free_block+0x4f/0xe5 SS:ESP 0068:de4=
4bd74
> [  201.516020] CR2: 00000000a0282044
> [  201.908587] ---[ end trace d28d8d35cd5a7130 ]---
>
> [  201.920053] ------------[ cut here ]------------
> [  201.924018] kernel BUG at kernel/rtmutex.c:831!
> [  201.924018] invalid opcode: 0000 [#2] PREEMPT
> [  201.924018] last sysfs file: /sys/module/vt/parameters/default_utf=
8
> [  201.924018] Modules linked in: evdev usbhid ohci_hcd geode_rng ecb
> aes_i586 ehci_hcd aes_generic usbcore geode_aes nls_base
> [  201.924018]
> [  201.924018] Pid: 6, comm: sirq-net-rx/0 Tainted: G      D W
> 2.6.33.6-rt28 #4 SL8/SL8
> [  201.924018] EIP: 0060:[<c122ca6e>] EFLAGS: 00010046 CPU: 0
> [  201.924018] EIP is at rt_spin_lock_slowlock+0x35/0x155
> [  201.924018] EAX: de420490 EBX: 00000292 ECX: 00000000 EDX: de42049=
0
> [  201.924018] ESI: c122ca39 EDI: c1321160 EBP: 00000000 ESP: de44bba=
8
> [  201.924018]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 preempt:=
00000001
> [  201.924018] Process sirq-net-rx/0 (pid: 6, ti=3Dde44a000
> task=3Dde420490 task.ti=3Dde44a000)
> [  201.924018] Stack:
> [  201.924018]  00000030 00000046 de44bbd0 c102784a c1003c19 de120c7c
> de226b3c de40a600
> [  201.924018]<0>  00000000 c1002db0 de120c7c 00000000 c1322c40
> de226b3c c1321160 c122ca39
> [  201.924018]<0>  de120c64 00000000 c104582b de44bc08 de40e7a0
> c108d08a de120c7c c108d576
> [  201.924018] Call Trace:
> [  201.924018]  [<c102784a>] ? irq_exit+0x28/0x32
> [  201.924018]  [<c1003c19>] ? do_IRQ+0x61/0x71
> [  201.924018]  [<c1002db0>] ? common_interrupt+0x30/0x38
> [  201.924018]  [<c122ca39>] ? rt_spin_lock_slowlock+0x0/0x155
> [  201.924018]  [<c104582b>] ? rt_spin_lock_fastlock+0x52/0x55
> [  201.924018]  [<c108d08a>] ? _slab_irq_disable+0xd/0x15
> [  201.924018]  [<c108d576>] ? kmem_cache_free+0x11/0x58
> [  201.924018]  [<c109f603>] ? destroy_inode+0x1c/0x2b
> [  201.924018]  [<c109eefe>] ? iput+0x47/0x49
> [  201.924018]  [<c109cfd1>] ? d_kill+0x2d/0x47
> [  201.924018]  [<c109d195>] ? __shrink_dcache_sb+0x1aa/0x247
> [  201.924018]  [<c109d4c0>] ? shrink_dcache_parent+0x26/0xd7
> [  201.924018]  [<c10c59f9>] ? proc_flush_task+0x7d/0x165
> [  201.924018]  [<c1024445>] ? release_task+0x18/0x2af
> [  201.924018]  [<c102570c>] ? do_exit+0x4dd/0x547
> [  201.924018]  [<c1004d16>] ? oops_end+0x7f/0x83
> [  201.924018]  [<c1015165>] ? no_context+0x10c/0x115
> [  201.924018]  [<c10153ad>] ? do_page_fault+0x0/0x28f
> [  201.924018]  [<c1015361>] ? bad_area_nosemaphore+0xa/0xc
> [  201.924018]  [<c122d2fb>] ? error_code+0x6b/0x70
> [  201.924018]  [<c108d664>] ? free_block+0x4f/0xe5
> [  201.924018]  [<c108d835>] ? __cache_free+0x7a/0xae
> [  201.924018]  [<c108d581>] ? kmem_cache_free+0x1c/0x58
> [  201.924018]  [<c11d3493>] ? tcp_ack+0x3eb/0x12f5
> [  201.924018]  [<c11d4bd8>] ? tcp_rcv_established+0xb0/0x476
> [  201.924018]  [<c11da92f>] ? tcp_v4_do_rcv+0x129/0x28f
> [  201.924018]  [<c11dbf43>] ? tcp_v4_rcv+0x339/0x523
> [  201.924018]  [<c11c3a8a>] ? ip_local_deliver_finish+0xf9/0x160
> [  201.924018]  [<c11c3925>] ? ip_rcv_finish+0x28a/0x29d
> [  201.924018]  [<c11aceb4>] ? netif_receive_skb+0x1c2/0x1e9
> [  201.924018]  [<c118d368>] ? e100_poll+0x172/0x37c
> [  201.924018]  [<c11af94c>] ? net_rx_action+0x53/0x100
> [  201.924018]  [<c1027743>] ? run_ksoftirqd+0xfb/0x1da
> [  201.924018]  [<c1027648>] ? run_ksoftirqd+0x0/0x1da
> [  201.924018]  [<c1036d2d>] ? kthread+0x52/0x57
> [  201.924018]  [<c1036cdb>] ? kthread+0x0/0x57
> [  201.924018]  [<c1002dbe>] ? kernel_thread_helper+0x6/0x10
> [  201.924018] Code: 44 24 2c 00 00 00 00 9c 5b fa b8 01 00 00 00 e8
> 8d f5 de ff 89 f8 e8 fd 83 e1 ff 8b 47 10 8b 15 d8 02 31 c1 83 e0 fc
> 39 d0 75 04<0f>  0b eb fe 8b 02 e8 e0 82 e1 ff 89 c5 8b 35 d8 02 31 c=
1
> 8b 46
> [  201.924018] EIP: [<c122ca6e>] rt_spin_lock_slowlock+0x35/0x155
> SS:ESP 0068:de44bba8
> [  201.924018] ---[ end trace d28d8d35cd5a7131 ]---
> [  201.924018] Fixing recursive fault but reboot is needed!
> [  202.672902] sched: RT throttling activated
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   =20


--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------=
+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" =
+
+----------------------------------------------------------------------=
+
+ Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik =
+
+ IMS Laboratory               http://www.ims-bordeaux.fr/             =
+
+ ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           =
+
+ PO BOX 99                    fax   : +33 5.56.37.20.23               =
+
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               =
+
+ FRANCE                       mailto:patrice.kadionik@ims-bordeaux.fr =
+
+----------------------------------------------------------------------=
+

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
