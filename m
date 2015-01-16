From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: RT Patch to use for Kernel 3.2.0
Date: Sat, 17 Jan 2015 01:23:54 +0300
Message-ID: <54B98F7A.5040208@pavlinux.ru>
References: <2181AC96E5EC8347999039A22D7597B7C6D8AA@MAL901.liteon.com>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jing Shao <Jing.Shao@liteon.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp03.mtu.ru ([62.5.255.20]:56794 "EHLO imp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbbAPWaz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Jan 2015 17:30:55 -0500
In-Reply-To: <2181AC96E5EC8347999039A22D7597B7C6D8AA@MAL901.liteon.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

17.01.2015 01:14, Jing Shao =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Dear sir,
>
> I am trying to patch a Linux 3.2.0 kernel with PREEMPT_RT patch, I tr=
ied the patch-3.2.64-rt94.patch.gz, but the Linux kernel fails to compi=
le afterwards, is this the right patch to use?
> For your info, the ouput of "uname -r" is 3.2.0. The kernel comes in =
as part of the SDK for a TI Sitara processor.

wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.64.tar.xz
wget=20
https://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.64-rt=
94.patch.xz

tar -xf linux-3.2.64.tar.xz && cd linux-3.2.64
xz -cd ../patch-3.2.64-rt94.patch.xz | patch -p1
make menuconfig
=2E..
=2E..
=2E..
make;



--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
