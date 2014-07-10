From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: SysRQ via ICMP does not work in 3.14
Date: Thu, 10 Jul 2014 14:16:55 +0200
Message-ID: <CAFLxGvwrckrNs6xEm7ntt3aeawaFJm9HkNiV1S7QPf6tcxy1OQ@mail.gmail.com>
References: <53BDD9D6.5080508@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:50712 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbaGJMQ4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jul 2014 08:16:56 -0400
Received: by mail-vc0-f180.google.com with SMTP id im17so10138284vcb.25
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2014 05:16:55 -0700 (PDT)
In-Reply-To: <53BDD9D6.5080508@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jul 10, 2014 at 2:09 AM, Pavel Vasilyev <pavel@pavlinux.ru> wrote:
> - Remote side:
>
> # sysctl -w net.ipv4.icmp_echo_sysrq=305419896
>
> - Local side:
>
> $ ping -c1 -s57 -p1122338862 172.16.0.26
> PATTERN: 0x1122338862

This pattern does not match net.ipv4.icmp_echo_sysrq.

> PING 172.16.0.26 (172.16.0.26) 57(85) bytes of data.
> 65 bytes from 172.16.0.26: icmp_req=1 ttl=64 time=0.508 ms
>
> --- 172.16.0.26 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.508/0.508/0.508/0.000 ms
>
>
> - Remote side: Hello, i'm live!
> --
>
>                                                          Pavel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,
//richard
