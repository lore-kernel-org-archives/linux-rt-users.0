From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: Workqueue "scheduling while atomic" issues in v3.12.19-rt30
Date: Tue, 23 Sep 2014 15:27:04 +0400
Message-ID: <54215908.4020605@pavlinux.ru>
References: <OF7A166039.4A11D04A-ON80257D5C.00394E82-80257D5C.003C09F4@belden.com>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Chris.Pringle@grassvalley.com, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp01.mtu.ru ([62.5.255.10]:56844 "EHLO imp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689AbaIWL1P (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Sep 2014 07:27:15 -0400
In-Reply-To: <OF7A166039.4A11D04A-ON80257D5C.00394E82-80257D5C.003C09F4@belden.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

23.09.2014 14:55, Chris.Pringle@grassvalley.com =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> Dear All,
>
> We've come across a number of "scheduling while atomic" BUGs after
> upgrading from v3.0 (Freescale SDK v1.2.1) to v3.12.19-rt30 (Freescal=
e SDK
> v1.6) on a P2041 (e500mc core).

Use 3.2.x or 3.14, other - buggy patches.


--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
