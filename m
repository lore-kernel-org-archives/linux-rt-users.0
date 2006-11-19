From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: 2.6.19 rc6 rt3 on embedded ARM system
Date: Sun, 19 Nov 2006 20:27:02 +0100
Message-ID: <4560B006.2070305@gmail.com>
References: <45609603.3000106@gmail.com> <20061119181539.GQ18636@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:50850 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933054AbWKSTWE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Nov 2006 14:22:04 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1046415ugc
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Nov 2006 11:22:03 -0800 (PST)
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20061119181539.GQ18636@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Robert Schwebel wrote:
> On Sun, Nov 19, 2006 at 06:36:03PM +0100, Dirk Behme wrote:
> 
>>playing with patch-2.6.19-rc6-rt3 on an embedded TI OMAP 
>>based ARM926 system I encountered two issues.
>>
>>First, I got the system booting and even playing MP3 via NFS 
>>using madplay on ALSA works :)
>>
>>But after madplay stops, I got an Oops:
>>
>>kernel BUG at kernel/rtmutex.c:672!
>>Unable to handle kernel NULL pointer dereference at virtual
>>address 00000000
>>pgd = c0004000
>>[00000000] *pgd=00000000
>>Internal error: Oops: 817 [#1]
>>PC is at __bug+0x44/0x58
>>LR is at rt_up+0x4c/0x6c
>>...
>>Any ideas what's wrong here? 
> 
> You snipped the stack trace here, which could offer some information
> about the call path. Could you post it?

Thought for whoever coded this explicit bug statement info 
above would be sufficient ;)

Ah! Thanks for directing me to the details. Looks like I 
missed one spinlock -> raw_spinlock conversion...

> 	arm-v4t-linux-gnueabi/gcc-4.2-20061031-glibc-2.5
> 	arm-v4t-linux-gnueabi/gcc-4.1.1-glibc-2.5
...
>>I use a gcc 4.1.0 toolchain built with crosstool with glibc-2.3.2:
> 
> I assume glibc-2.3.2 is too old.

Yeah, thanks. A toolchain with glibc 2.3.6 seem to make the 
job. Maybe this is worth a hint in wiki?

Cheers

Dirk
