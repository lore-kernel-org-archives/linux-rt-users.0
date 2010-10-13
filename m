From: John Kacur <jkacur@redhat.com>
Subject: Re: real time interrupts
Date: Wed, 13 Oct 2010 10:37:22 +0200
Message-ID: <AANLkTink4kxePdLP96qYXPp7yHK-TxT7fr-XxLYZjDob@mail.gmail.com>
References: <AANLkTi=PK8LSBTAQexeFbehTtPi8QUqsmP-1hkcX5Bve@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: ratheesh k <ratheesh.ksz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40285 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab0JMIhX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Oct 2010 04:37:23 -0400
Received: by qyk2 with SMTP id 2so463834qyk.19
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Oct 2010 01:37:23 -0700 (PDT)
In-Reply-To: <AANLkTi=PK8LSBTAQexeFbehTtPi8QUqsmP-1hkcX5Bve@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 13, 2010 at 10:10 AM, ratheesh k <ratheesh.ksz@gmail.com> w=
rote:
> I =A0am using 2.6.18 kernel with rt-linux patch. In my userspace prog=
ram
> , I registered for signals =A065,64,63,62 ( timer =A0) . In my signal
> handler , i have a call to localtime(). local_time() seems to be
> invoking an io call.
>
> program seems to be frozen , when all interrupts comes together. i
> could see from the core ( grenerated forcifully using ABRT signal )
> that all signal handler acquire some lock and suddently some other
> inteerupt comes....this leads to deadlock
>
>
> #15 <signal handler called>
> #16 0x0070a886 in _IO_vfscanf_internal () from /lib/libc.so.6
> #17 0x007170c1 in vsscanf () from /lib/libc.so.6
> #18 0x00711dae in sscanf () from /lib/libc.so.6
> #19 0x0073ff9f in __tzset_parse_tz () from /lib/libc.so.6
> #20 0x00740f8f in __tzfile_compute () from /lib/libc.so.6
> #21 0x00740845 in __tz_convert () from /lib/libc.so.6
> #22 0x0073ecff in localtime () from /lib/libc.so.6
>
> How to get away from this ?
> --

I'm afraid that with such an old kernel, you are unlikely to find any
support here. If it is at all possible for you, please update to
something newer.

Thanks.
John Kacur
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
