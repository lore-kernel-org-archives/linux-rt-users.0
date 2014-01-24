From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Crash in TCP/IP stack
Date: Fri, 24 Jan 2014 13:56:39 +0100
Message-ID: <20140124125639.GC10264@linutronix.de>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA76D06990@edb1.wapice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
To: Sami =?utf-8?Q?Pietik=C3=A4inen?= <Sami.Pietikainen@wapice.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54396 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbaAXM4k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jan 2014 07:56:40 -0500
Content-Disposition: inline
In-Reply-To: <EBD2DE4ADA47B94E831AED12A4B0CADA76D06990@edb1.wapice.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sami Pietik=C3=A4inen | 2013-12-17 10:21:33 [+0000]:

>Hello,
Hi Sami,

>We have run into a crash in the TCP/IP stack when doing torture tests =
on our devices.=20
>We have been able to reproduce this issue with Atmel SAMA5D35-EK using=
 3.6.9-rt21,=20
>3.10.20-rt17 and 3.12.5-rt6 kernels and using Xilinx Zynq Zedboard wit=
h 3.8.13-rt15 kernel.=20
>Unable to handle kernel NULL pointer dereference at virtual address 00=
000010
>CPU: 0 PID: 7292 Comm: wget Not tainted 3.12.5-rt6-custom #1
>[<c01989fc>] (__ip_make_skb+0x200/0x280) from [<c0198acf>] (ip_push_pe=
nding_frames+0xf/0x24)
>[<c0198acf>] (ip_push_pending_frames+0xf/0x24) from [<c0198cf5>] (ip_s=
end_unicast_reply+0x179/0x198)
>[<c0198cf5>] (ip_send_unicast_reply+0x179/0x198) from [<c01a992d>] (tc=
p_v4_send_reset+0x10d/0x138)
>[<c01a992d>] (tcp_v4_send_reset+0x10d/0x138) from [<c01aa491>] (tcp_v4=
_do_rcv+0x6d/0x168)
>[<c01aa491>] (tcp_v4_do_rcv+0x6d/0x168) from [<c0175683>] (release_soc=
k+0x63/0xe0)
>[<c0175683>] (release_sock+0x63/0xe0) from [<c019f81b>] (tcp_close+0x1=
2b/0x33c)
>[<c019f81b>] (tcp_close+0x12b/0x33c) from [<c01b6b61>] (inet_release+0=
x25/0x44)
>[<c01b6b61>] (inet_release+0x25/0x44) from [<c01731db>] (sock_release+=
0xf/0x5c)
>[<c01731db>] (sock_release+0xf/0x5c) from [<c01733ed>] (sock_close+0x9=
/0xc)
>[<c01733ed>] (sock_close+0x9/0xc) from [<c0065259>] (__fput+0x5d/0x17c=
)
>[<c0065259>] (__fput+0x5d/0x17c) from [<c002469b>] (task_work_run+0x53=
/0x78)
>[<c002469b>] (task_work_run+0x53/0x78) from [<c000e3ab>] (do_work_pend=
ing+0x5f/0x74)
>[<c000e3ab>] (do_work_pending+0x5f/0x74) from [<c000cb53>] (work_pendi=
ng+0x9/0x1a)

Just that I have it tagged here properly. This bug seems to exist
since v3.6-rt and Nicholas Mc Guire posted a fix for it.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
