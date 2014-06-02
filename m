From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: Mainline patch-3.14.4-5.xz
Date: Tue, 03 Jun 2014 02:02:34 +0400
Message-ID: <538CF47A.3070207@pavlinux.ru>
References: <538A6552.3050501@pavlinux.ru> <20140602114658.3c81b2f8@sluggy>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:38470 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbaFBWDh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Jun 2014 18:03:37 -0400
In-Reply-To: <20140602114658.3c81b2f8@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

02.06.2014 20:46, Clark Williams =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> What to do? :)
>>
> I thought I was the only one to do crazy rebasing like this :)
>
> I kept the #ifdef CONFIG_PREEMPT_LAZY block (the RT code) in
> include/linux/thread_info.h and removed the definition of
> tif_need_resched() in include/linux/preempt.h.

Code migrate from <linux/thread_info.h>  to <linux/preempt.h>

https://www.kernel.org/diff/diffview.cgi?file=3D%2Fpub%2Flinux%2Fkernel=
%2Fv3.x%2Fincr%2Fpatch-3.14.4-5.xz;z=3D78

https://www.kernel.org/diff/diffview.cgi?file=3D%2Fpub%2Flinux%2Fkernel=
%2Fv3.x%2Fincr%2Fpatch-3.14.4-5.xz;z=3D82

Link: http://marc.info/?l=3Dlinux-kernel&m=3D139705352130896

--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
