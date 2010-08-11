From: John Culvertson <jculvertson@gmail.com>
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
Date: Wed, 11 Aug 2010 12:53:41 -0400
Message-ID: <AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com>
	<AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46342 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab0HKQxm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Aug 2010 12:53:42 -0400
Received: by pzk26 with SMTP id 26so118518pzk.19
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Aug 2010 09:53:41 -0700 (PDT)
In-Reply-To: <AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I updated to 2.6.33.7-rt29, and I am seeing similar symptoms.

[ 2120.781166] BUG: unable to handle kernel paging request at c11cd497
[ 2120.784018] IP: [<c11d5ce2>] tcp_set_skb_tso_segs+0x33/0x85
[ 2120.784018] *pde =3D 1d7f6063 *pte =3D 011cd161
[ 2120.784018] Oops: 0003 [#1] PREEMPT
[ 2120.784018] last sysfs file:
/sys/devices/pci0000:00/0000:00:11.0/firmware/0000:00:11.0/loading
[ 2120.784018] Modules linked in: evdev usbhid ohci_hcd geode_rng ecb
ehci_hcd aes_i586 aes_generic usbcore geode_aes nls_base
[ 2120.784018]
[ 2120.784018] Pid: 6, comm: sirq-net-rx/0 Tainted: G        W
2.6.33.7-rt29 #2 SL8/SL8
[ 2120.784018] EIP: 0060:[<c11d5ce2>] EFLAGS: 00010287 CPU: 0
[ 2120.784018] EIP is at tcp_set_skb_tso_segs+0x33/0x85
[ 2120.784018] EAX: c11cd48f EBX: de78e7e0 ECX: 000005a8 EDX: 00000000
[ 2120.784018] ESI: dd73d1a0 EDI: 0d0005a8 EBP: de78e7e0 ESP: de44bdc4
[ 2120.784018]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 preempt:00=
000000
[ 2120.784018] Process sirq-net-rx/0 (pid: 6, ti=3Dde44a000
task=3Dde420490 task.ti=3Dde44a000)
[ 2120.784018] Stack:
[ 2120.784018]  0006f21b de78e7e0 000005a8 dd73d1a0 de78e7e0 c11d5ee3
000005a8 dd73d1a0
[ 2120.784018] <0> 00000004 c11d79cf 00000000 000005a8 00000002
00000001 00000001 000005a8
[ 2120.784018] <0> 00000000 dd73d1a0 de44be2c 00000000 c11d60ec
dd73d1a0 000005a8 00000020
[ 2120.784018] Call Trace:
[ 2120.784018]  [<c11d5ee3>] ? tcp_init_tso_segs+0x31/0x41
[ 2120.784018]  [<c11d79cf>] ? tcp_write_xmit+0x35a/0x70a
[ 2120.784018]  [<c11d60ec>] ? tcp_established_options+0x1c/0x8d
[ 2120.784018]  [<c11d6198>] ? tcp_current_mss+0x3b/0x56
[ 2120.784018]  [<c11d7d9d>] ? __tcp_push_pending_frames+0x1e/0x50
[ 2120.784018]  [<c11d4451>] ? tcp_data_snd_check+0x1c/0xe6
[ 2120.784018]  [<c11d4c7e>] ? tcp_rcv_established+0xbe/0x476
[ 2120.784018]  [<c11da9d7>] ? tcp_v4_do_rcv+0x129/0x28f
[ 2120.784018]  [<c11dbfeb>] ? tcp_v4_rcv+0x339/0x523
[ 2120.784018]  [<c11c3b22>] ? ip_local_deliver_finish+0xf9/0x160
[ 2120.784018]  [<c11c39bd>] ? ip_rcv_finish+0x28a/0x29d
[ 2120.784018]  [<c11acf24>] ? netif_receive_skb+0x1c2/0x1e9
[ 2120.784018]  [<c118d3d0>] ? e100_poll+0x172/0x37c
[ 2120.784018]  [<c11af9c3>] ? net_rx_action+0x53/0x100
[ 2120.784018]  [<c1027767>] ? run_ksoftirqd+0xfb/0x1da
[ 2120.784018]  [<c102766c>] ? run_ksoftirqd+0x0/0x1da
[ 2120.784018]  [<c1036d51>] ? kthread+0x52/0x57
[ 2120.784018]  [<c1036cff>] ? kthread+0x0/0x57
[ 2120.784018]  [<c1002dbe>] ? kernel_thread_helper+0x6/0x10
[ 2120.784018] Code: 83 ec 04 8b 7a 50 39 cf 76 1b 8b 80 38 01 00 00
c1 e0 10 89 c2 23 96 34 01 00 00 39 c2 75 06 f6 43 64 0c 75 26 8b 83
9c 00 00 00 <66> c7 40 08 01 00 8b 83 9c 00 00 00 66 c7 40 06 00 00 8b
83 9c
[ 2120.784018] EIP: [<c11d5ce2>] tcp_set_skb_tso_segs+0x33/0x85 SS:ESP
0068:de44bdc4
[ 2120.784018] CR2: 00000000c11cd497
[ 2120.784018] ---[ end trace f11850323396760e ]---
[ 2121.268090] BUG: unable to handle kernel NULL pointer dereference at=
 (null)
[ 2121.268112] IP: [<c103bdc3>] exit_creds+0x9/0x51
[ 2121.268150] *pde =3D 00000000
[ 2121.268166] Oops: 0000 [#2] PREEMPT
[ 2121.268182] last sysfs file:
/sys/devices/pci0000:00/0000:00:11.0/firmware/0000:00:11.0/loading
[ 2121.268200] Modules linked in: evdev usbhid ohci_hcd geode_rng ecb
ehci_hcd aes_i586 aes_generic usbcore geode_aes nls_base
[ 2121.268250]
[ 2121.268271] Pid: 12, comm: sirq-rcu/0 Tainted: G      D W
2.6.33.7-rt29 #2 SAM-L8/SAM-L8
[ 2121.268292] EIP: 0060:[<c103bdc3>] EFLAGS: 00010287 CPU: 0
[ 2121.268313] EIP is at exit_creds+0x9/0x51
[ 2121.268330] EAX: 00000000 EBX: de420490 ECX: 00000000 EDX: c122c9c2
[ 2121.268349] ESI: de4208ac EDI: c131e960 EBP: 00000002 ESP: de459f68
[ 2121.268371]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 preempt:00=
000000
[ 2121.268393] Process sirq-rcu/0 (pid: 12, ti=3Dde458000 task=3Dde44e9=
00
task.ti=3Dde458000)
[ 2121.268407] Stack:
[ 2121.268417]  de420490 c1021df9 00000000 c10580c0 c131e760 de4208ac
fffffdff c1313d50
[ 2121.268451] <0> 00000200 00000000 c10581a4 c1027767 00000031
de423f64 de459fb4 c1313d50
[ 2121.268487] <0> c102766c c1036d51 00000000 00000000 de459fb8
de459fb8 de459fc0 de459fc0
[ 2121.268526] Call Trace:
[ 2121.268558]  [<c1021df9>] ? __put_task_struct+0x50/0x65
[ 2121.268584]  [<c10580c0>] ? __rcu_process_callbacks+0x163/0x21a
[ 2121.268611]  [<c10581a4>] ? rcu_process_callbacks+0x2d/0x2e
[ 2121.268641]  [<c1027767>] ? run_ksoftirqd+0xfb/0x1da
[ 2121.268667]  [<c102766c>] ? run_ksoftirqd+0x0/0x1da
[ 2121.268695]  [<c1036d51>] ? kthread+0x52/0x57
[ 2121.268722]  [<c1036cff>] ? kthread+0x0/0x57
[ 2121.268747]  [<c1002dbe>] ? kernel_thread_helper+0x6/0x10
[ 2121.268761] Code: c0 84 c0 74 08 8b 43 60 e8 aa 0b 00 00 8b 43 5c
e8 85 1d ff ff a1 4c 44 3b c1 89 da 5b e9 bb 17 05 00 53 89 c3 8b 80
00 02 00 00 <8b> 00 8b 83 fc 01 00 00 c7 83 fc 01 00 00 00 00 00 00 e8
b5 fd
[ 2121.268950] EIP: [<c103bdc3>] exit_creds+0x9/0x51 SS:ESP 0068:de459f=
68
[ 2121.268978] CR2: 0000000000000000
[ 2121.268994] ---[ end trace f11850323396760f ]---



On Tue, Aug 10, 2010 at 7:19 AM, John Kacur <jkacur@redhat.com> wrote:
> On Mon, Aug 9, 2010 at 10:10 PM, John Culvertson <jculvertson@gmail.c=
om> wrote:
>> Hello,
>>
>> I am trying to use the RT patches on an x86 industrial computer. =A0=
I am
>> getting intermittent network hangs and kernel crashes when I load th=
e
>> network with netperf. =A0The unpatched kernel does not exhibit these
>> problems. =A0The kernel is 2.6.33.6 patched with rt28.
>>
>> The computer has an AMD LX800 processor and two Intel 82559 10/100 P=
CI
>> Ethernet controllers. =A0I have only seen the kernel crashes when
>> running netperf on both ports simultaneously.
>>
>> This is my first time using the RT patches, so I am not sure how to =
go
>> about resolving this. =A0Any tips would be greatly appreciated.
>>
>> [ =A0201.514962] BUG: unable to handle kernel paging request at a028=
2044
>> [ =A0201.516020] IP: [<c108d664>] free_block+0x4f/0xe5
>> [ =A0201.516020] *pde =3D 00000000
>> [ =A0201.516020] Oops: 0002 [#1] PREEMPT
>> [ =A0201.516020] last sysfs file: /sys/module/vt/parameters/default_=
utf8
>> [ =A0201.516020] Modules linked in: evdev usbhid ohci_hcd geode_rng =
ecb
>> aes_i586 ehci_hcd aes_generic usbcore geode_aes nls_base
>> [ =A0201.516020]
>> [ =A0201.516020] Pid: 6, comm: sirq-net-rx/0 Tainted: G =A0 =A0 =A0 =
=A0W
>> 2.6.33.6-rt28 #4 SL8/SL8
>> [ =A0201.516020] EIP: 0060:[<c108d664>] EFLAGS: 00010202 CPU: 0
>> [ =A0201.516020] EIP is at free_block+0x4f/0xe5
>> [ =A0201.516020] EAX: d6d75060 EBX: de682500 ECX: 00000004 EDX: a028=
2040
>> [ =A0201.516020] ESI: de682020 EDI: de431340 EBP: de40e5c0 ESP: de44=
bd74
>> [ =A0201.516020] =A0DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 pre=
empt:00000000
>> [ =A0201.516020] Process sirq-net-rx/0 (pid: 6, ti=3Dde44a000
>> task=3Dde420490 task.ti=3Dde44a000)
>> [ =A0201.516020] Stack:
>> [ =A0201.516020] =A000000003 00000000 0000001b de406688 00000001 de4=
31340
>> 00000000 de406660
>> [ =A0201.516020] <0> 0000001b c108d835 00000000 de44bdc8 de44bdc8
>> ddbd2060 de40e5c0 de431364
>> [ =A0201.516020] <0> 00000000 de40e5c0 ddbd2060 ddbd2060 c108d581
>> 00000000 00000000 d6e78620
>> [ =A0201.516020] Call Trace:
>> [ =A0201.516020] =A0[<c108d835>] ? __cache_free+0x7a/0xae
>> [ =A0201.516020] =A0[<c108d581>] ? kmem_cache_free+0x1c/0x58
>> [ =A0201.516020] =A0[<c11d3493>] ? tcp_ack+0x3eb/0x12f5
>> [ =A0201.516020] =A0[<c11d4bd8>] ? tcp_rcv_established+0xb0/0x476
>> [ =A0201.516020] =A0[<c11da92f>] ? tcp_v4_do_rcv+0x129/0x28f
>> [ =A0201.516020] =A0[<c11dbf43>] ? tcp_v4_rcv+0x339/0x523
>> [ =A0201.516020] =A0[<c11c3a8a>] ? ip_local_deliver_finish+0xf9/0x16=
0
>> [ =A0201.516020] =A0[<c11c3925>] ? ip_rcv_finish+0x28a/0x29d
>> [ =A0201.516020] =A0[<c11aceb4>] ? netif_receive_skb+0x1c2/0x1e9
>> [ =A0201.516020] =A0[<c118d368>] ? e100_poll+0x172/0x37c
>> [ =A0201.516020] =A0[<c11af94c>] ? net_rx_action+0x53/0x100
>> [ =A0201.516020] =A0[<c1027743>] ? run_ksoftirqd+0xfb/0x1da
>> [ =A0201.516020] =A0[<c1027648>] ? run_ksoftirqd+0x0/0x1da
>> [ =A0201.516020] =A0[<c1036d2d>] ? kthread+0x52/0x57
>> [ =A0201.516020] =A0[<c1036cdb>] ? kthread+0x0/0x57
>> [ =A0201.516020] =A0[<c1002dbe>] ? kernel_thread_helper+0x6/0x10
>> [ =A0201.516020] Code: 24 0c 8b 1c 82 89 d8 e8 34 fc ff ff 89 c6 e8 =
18
>> f9 ff ff 85 c0 75 04 0f 0b eb fe 8b 76 1c 8b 44 24 28 8b 16 8b 7c 85
>> 4c 8b 46 04 <89> 42 04 89 10 2b 5e 0c c7 06 00 01 10 00 c7 46 04 00 =
02
>> 20 00
>> [ =A0201.516020] EIP: [<c108d664>] free_block+0x4f/0xe5 SS:ESP 0068:=
de44bd74
>> [ =A0201.516020] CR2: 00000000a0282044
>> [ =A0201.908587] ---[ end trace d28d8d35cd5a7130 ]---
>>
>> [ =A0201.920053] ------------[ cut here ]------------
>> [ =A0201.924018] kernel BUG at kernel/rtmutex.c:831!
>> [ =A0201.924018] invalid opcode: 0000 [#2] PREEMPT
>> [ =A0201.924018] last sysfs file: /sys/module/vt/parameters/default_=
utf8
>> [ =A0201.924018] Modules linked in: evdev usbhid ohci_hcd geode_rng =
ecb
>> aes_i586 ehci_hcd aes_generic usbcore geode_aes nls_base
>> [ =A0201.924018]
>> [ =A0201.924018] Pid: 6, comm: sirq-net-rx/0 Tainted: G =A0 =A0 =A0D=
 W
>> 2.6.33.6-rt28 #4 SL8/SL8
>> [ =A0201.924018] EIP: 0060:[<c122ca6e>] EFLAGS: 00010046 CPU: 0
>> [ =A0201.924018] EIP is at rt_spin_lock_slowlock+0x35/0x155
>> [ =A0201.924018] EAX: de420490 EBX: 00000292 ECX: 00000000 EDX: de42=
0490
>> [ =A0201.924018] ESI: c122ca39 EDI: c1321160 EBP: 00000000 ESP: de44=
bba8
>> [ =A0201.924018] =A0DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 pre=
empt:00000001
>> [ =A0201.924018] Process sirq-net-rx/0 (pid: 6, ti=3Dde44a000
>> task=3Dde420490 task.ti=3Dde44a000)
>> [ =A0201.924018] Stack:
>> [ =A0201.924018] =A000000030 00000046 de44bbd0 c102784a c1003c19 de1=
20c7c
>> de226b3c de40a600
>> [ =A0201.924018] <0> 00000000 c1002db0 de120c7c 00000000 c1322c40
>> de226b3c c1321160 c122ca39
>> [ =A0201.924018] <0> de120c64 00000000 c104582b de44bc08 de40e7a0
>> c108d08a de120c7c c108d576
>> [ =A0201.924018] Call Trace:
>> [ =A0201.924018] =A0[<c102784a>] ? irq_exit+0x28/0x32
>> [ =A0201.924018] =A0[<c1003c19>] ? do_IRQ+0x61/0x71
>> [ =A0201.924018] =A0[<c1002db0>] ? common_interrupt+0x30/0x38
>> [ =A0201.924018] =A0[<c122ca39>] ? rt_spin_lock_slowlock+0x0/0x155
>> [ =A0201.924018] =A0[<c104582b>] ? rt_spin_lock_fastlock+0x52/0x55
>> [ =A0201.924018] =A0[<c108d08a>] ? _slab_irq_disable+0xd/0x15
>> [ =A0201.924018] =A0[<c108d576>] ? kmem_cache_free+0x11/0x58
>> [ =A0201.924018] =A0[<c109f603>] ? destroy_inode+0x1c/0x2b
>> [ =A0201.924018] =A0[<c109eefe>] ? iput+0x47/0x49
>> [ =A0201.924018] =A0[<c109cfd1>] ? d_kill+0x2d/0x47
>> [ =A0201.924018] =A0[<c109d195>] ? __shrink_dcache_sb+0x1aa/0x247
>> [ =A0201.924018] =A0[<c109d4c0>] ? shrink_dcache_parent+0x26/0xd7
>> [ =A0201.924018] =A0[<c10c59f9>] ? proc_flush_task+0x7d/0x165
>> [ =A0201.924018] =A0[<c1024445>] ? release_task+0x18/0x2af
>> [ =A0201.924018] =A0[<c102570c>] ? do_exit+0x4dd/0x547
>> [ =A0201.924018] =A0[<c1004d16>] ? oops_end+0x7f/0x83
>> [ =A0201.924018] =A0[<c1015165>] ? no_context+0x10c/0x115
>> [ =A0201.924018] =A0[<c10153ad>] ? do_page_fault+0x0/0x28f
>> [ =A0201.924018] =A0[<c1015361>] ? bad_area_nosemaphore+0xa/0xc
>> [ =A0201.924018] =A0[<c122d2fb>] ? error_code+0x6b/0x70
>> [ =A0201.924018] =A0[<c108d664>] ? free_block+0x4f/0xe5
>> [ =A0201.924018] =A0[<c108d835>] ? __cache_free+0x7a/0xae
>> [ =A0201.924018] =A0[<c108d581>] ? kmem_cache_free+0x1c/0x58
>> [ =A0201.924018] =A0[<c11d3493>] ? tcp_ack+0x3eb/0x12f5
>> [ =A0201.924018] =A0[<c11d4bd8>] ? tcp_rcv_established+0xb0/0x476
>> [ =A0201.924018] =A0[<c11da92f>] ? tcp_v4_do_rcv+0x129/0x28f
>> [ =A0201.924018] =A0[<c11dbf43>] ? tcp_v4_rcv+0x339/0x523
>> [ =A0201.924018] =A0[<c11c3a8a>] ? ip_local_deliver_finish+0xf9/0x16=
0
>> [ =A0201.924018] =A0[<c11c3925>] ? ip_rcv_finish+0x28a/0x29d
>> [ =A0201.924018] =A0[<c11aceb4>] ? netif_receive_skb+0x1c2/0x1e9
>> [ =A0201.924018] =A0[<c118d368>] ? e100_poll+0x172/0x37c
>> [ =A0201.924018] =A0[<c11af94c>] ? net_rx_action+0x53/0x100
>> [ =A0201.924018] =A0[<c1027743>] ? run_ksoftirqd+0xfb/0x1da
>> [ =A0201.924018] =A0[<c1027648>] ? run_ksoftirqd+0x0/0x1da
>> [ =A0201.924018] =A0[<c1036d2d>] ? kthread+0x52/0x57
>> [ =A0201.924018] =A0[<c1036cdb>] ? kthread+0x0/0x57
>> [ =A0201.924018] =A0[<c1002dbe>] ? kernel_thread_helper+0x6/0x10
>> [ =A0201.924018] Code: 44 24 2c 00 00 00 00 9c 5b fa b8 01 00 00 00 =
e8
>> 8d f5 de ff 89 f8 e8 fd 83 e1 ff 8b 47 10 8b 15 d8 02 31 c1 83 e0 fc
>> 39 d0 75 04 <0f> 0b eb fe 8b 02 e8 e0 82 e1 ff 89 c5 8b 35 d8 02 31 =
c1
>> 8b 46
>> [ =A0201.924018] EIP: [<c122ca6e>] rt_spin_lock_slowlock+0x35/0x155
>> SS:ESP 0068:de44bba8
>> [ =A0201.924018] ---[ end trace d28d8d35cd5a7131 ]---
>> [ =A0201.924018] Fixing recursive fault but reboot is needed!
>> [ =A0202.672902] sched: RT throttling activated
>
>
> Please upgrade to 2.6.33.7-rt29
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
