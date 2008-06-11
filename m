From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: MPC5200B: -rt11/-rt12 network problems
Date: Thu, 12 Jun 2008 00:03:07 +0200
Message-ID: <c384c5ea0806111503v1af6d294sab5c6ddcb98b20e9@mail.gmail.com>
References: <DD39B5C3F4963040ADC9768BE7E430CB0305ADFC@is-hdq-exchange.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, grant.likely@secretlabs.com
To: "Daniel Schnell" <daniel.schnell@marel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:3595 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbYFKWDH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jun 2008 18:03:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1687455rvb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Jun 2008 15:03:07 -0700 (PDT)
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0305ADFC@is-hdq-exchange.marel.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Daniel,

I fired up -rt for the EFIKA, in a try to see if your problem reproduces here.

On Wed, Jun 4, 2008 at 5:32 PM, Daniel Schnell <daniel.schnell@marel.com> wrote:
>
> I am running 2.6.24.7 with either -rt11 or -rt12 on a MPC5200B custom
> board.
>
EFIKA MPC5200B board here, rootfs mounted via NFS.

I could not reproduce your problem with my setup, which is a bit different:

root@efika:~# uname -a
Linux efika 2.6.25.4-rt6-efika #9 PREEMPT RT Wed Jun 11 23:53:03 CEST
2008 ppc unknown

root@efika:~# mount
rootfs on / type rootfs (rw)
/dev/root on / type nfs
(rw,vers=2,rsize=4096,wsize=4096,hard,nolock,proto=udp,timeo=11,retrans=2,sec=sys,addr=192.168.1.24)
<...>

root@efika:~# dd if=/dev/zero of=/test bs=1024 count=200000

After a 30 seconds or so, I could CTRL-C, and checked on my host:

-rw-r--r--  1 root root 198497280 2008-06-11 23:58 test

>
> P.S. BTW, latency wise -rt11 and above are big steps forward.
>
What did you see between pre-rt11 and -rt11+?

Regards,
-- 
Leon
