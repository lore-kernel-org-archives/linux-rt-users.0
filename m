From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: CONFIG_PREEMPT_RT_FULL an usb gadget
Date: Fri, 11 Oct 2013 11:39:26 +0200
Message-ID: <20131011093926.GA6983@linutronix.de>
References: <9BA84827B30CBE4996725F98F7DC91232F954E81@SMExchange01.siebmeyer.org>
 <20130829113521.GB15360@linutronix.de>
 <9BA84827B30CBE4996725F98F7DC91232F955F47@SMExchange01.siebmeyer.org>
 <521F99C6.1010200@linutronix.de>
 <9BA84827B30CBE4996725F98F7DC91232F9730FC@SMExchange01.siebmeyer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander
	<alexander.haenel-baas@sieb-meyer.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59963 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab3JKJj1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 05:39:27 -0400
Content-Disposition: inline
In-Reply-To: <9BA84827B30CBE4996725F98F7DC91232F9730FC@SMExchange01.siebmeyer.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* H=C3=A4nel-Baas, Alexander | 2013-09-12 11:41:56 [+0000]:

>Hello Sebastion,

Hello Alexander

>so the rndis configuration works...
>
>No I see on the target with the rt-preempt patch this kernel message:
>
>[   97.206853] g_ether gadget: high-speed config #2: RNDIS  <- the deb=
ian host is already connected and we have a putty connection to the tar=
get
>[  247.216366] g_ether gadget: rndis response on err -22        <- the=
 debian host say:  communication error

There is quite some time in between.

>[  248.974081] NOHZ: local_softirq_pending 02
>[  248.974135] NOHZ: local_softirq_pending 80
>[  248.984213] NOHZ: local_softirq_pending 182
>[  249.010278] [sched_delayed] sched: RT throttling activated
>[  249.996113] NOHZ: local_softirq_pending 02
>[  249.996647] NOHZ: local_softirq_pending 82
>[  249.996798] NOHZ: local_softirq_pending 102
>[  250.986077] NOHZ: local_softirq_pending 100
>[  250.987073] NOHZ: local_softirq_pending 102
>[  251.976188] NOHZ: local_softirq_pending 02

And this looks like something is busy looping.

>[  253.286567] pch_udc 0000:05:02.4: pch_udc_ep_clear_nak: RxFIFO not =
Empty
>[  254.972880] NOHZ: local_softirq_pending 02

>On this situation the target is very slow.=20
>top shows:
>
>Mem: 29972K used, 464160K free, 0K shrd, 0K buff, 8040K cached
>CPU:  0.1% usr 71.8% sys  0.0% nic 11.0% idle  0.0% io  0.0% irq 16.9%=
 sirq
>Load average: 4.52 2.48 1.06 2/86 203
>  PID  PPID USER     STAT   VSZ %VSZ CPU %CPU COMMAND
>   61     2 root     SW       0  0.0   0 20.1 [irq/18-pch-dma]
>   78     2 root     SW       0  0.0   0 16.6 [irq/18-ehci_hcd]
>  188     2 root     SW       0  0.0   0 14.5 [irq/18-pch_udc]
>   82     2 root     SW       0  0.0   0  9.1 [irq/18-ohci_hcd]
>   81     2 root     SW       0  0.0   0  8.3 [irq/18-ohci_hcd]
>   80     2 root     SW       0  0.0   0  7.8 [irq/18-ohci_hcd]
>    3     2 root     RW       0  0.0   0  6.6 [ksoftirqd/0]
>
>I hope that is right information to find the problem.

pch_udc and maybe pch-dma are probably the two brining the system down.
ehci & ohci are probably only invoked because they share the same line.

Can you check what pch udc/dma are doing on normal situations and what
is different on -RT? My guess is that the UDC is not working well.
I just booted v3.10.14-rt9 on am335x-evm with musb as the UDC and rndis
gadget against x86 with the same kernel.
The host says:
| usbcore: registered new interface driver cdc_ether
| rndis_host 2-1.4:2.0: usb_probe_interface
| rndis_host 2-1.4:2.0: usb_probe_interface - got id
| rndis_host 2-1.4:2.0 usb0: register 'rndis_host' at usb-0000:00:05.0-=
1.4, RNDIS device, 42:10:84:84:ab:88
| usbcore: registered new interface driver rndis_host
| usb 2-1.4: link qh32-0001/f19d9de0 start 2 [1/0 us]
|root@squsb:~# ping 10.10.10.10 -c1
|PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
|64 bytes from 10.10.10.10: icmp_seq=3D1 ttl=3D64 time=3D1.18 ms
|
|--- 10.10.10.10 ping statistics ---
|1 packets transmitted, 1 received, 0% packet loss, time 0ms
|rtt min/avg/max/mdev =3D 1.185/1.185/1.185/0.000 ms

and the device:
| usb0: eth_open
| usb0: eth_start
| g_ether gadget: rndis_open
| rndis_set_param_medium: 0 4259840
| g_ether gadget: suspend
| g_ether gadget: reset config
| g_ether gadget: rndis deactivated
| usb0: gether_disconnect
| g_ether gadget: high-speed config #2: RNDIS
| g_ether gadget: init rndis
| g_ether gadget: RNDIS RX/TX early activation ...=20
| usb0: qlen 10
| g_ether gadget: rndis_open
| rndis_set_param_medium: 0 4259840
| usb0: eth_start
| rndis_set_param_dev:
| g_ether gadget: rndis req21.00 v0000 i0000 l24
| rndis_msg_parser: RNDIS_MSG_INIT
| g_ether gadget: rndis reqa1.01 v0000 i0000 l1025
| g_ether gadget: rndis req21.00 v0000 i0000 l28
| gen_ndis_query_resp: RNDIS_OID_GEN_PHYSICAL_MEDIUM
| g_ether gadget: rndis reqa1.01 v0000 i0000 l1025
| g_ether gadget: rndis req21.00 v0000 i0000 l76
| gen_ndis_query_resp: RNDIS_OID_802_3_PERMANENT_ADDRESS
| g_ether gadget: rndis reqa1.01 v0000 i0000 l1025
| g_ether gadget: rndis req21.00 v0000 i0000 l32
| gen_ndis_set_resp: RNDIS_OID_GEN_CURRENT_PACKET_FILTER 0000002d
| g_ether gadget: rndis reqa1.01 v0000 i0000 l1025
|/ # ping -c1 10.10.10.11
|PING 10.10.10.11 (10.10.10.11): 56 data bytes
|64 bytes from 10.10.10.11: seq=3D0 ttl=3D64 time=3D1.433 ms

I used a difference UDC (musb instead if pch_udc). Since the rndis is
working I think is okay and the problem is somewhere around your UDC.
Try to disable ehci & ohci and try to figure out why pch is taking so
long.

>Greetings
>Alexander

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
