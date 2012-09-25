From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: Memory leak in 3.4.x-rt ?
Date: Tue, 25 Sep 2012 17:39:23 +0200
Message-ID: <CAL8zT=j5qF=b3bsehLZtV3X7F71LR+aX6L0zGKJqHZd=avkSug@mail.gmail.com>
References: <503775B3.4080504@cantastic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?UTF-8?Q?Ralf_R=C3=B6sch?= <rtlinux@cantastic.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47134 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959Ab2IYPjo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Sep 2012 11:39:44 -0400
Received: by ieak13 with SMTP id k13so14229541iea.19
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Sep 2012 08:39:43 -0700 (PDT)
In-Reply-To: <503775B3.4080504@cantastic.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2012/8/24 Ralf R=C3=B6sch <rtlinux@cantastic.org>:
> Hi,
>
> we work on our TX4938 (Toshiba Mips, little endian mode) based embedd=
ed
> system (motion control)
> running successfully a 3.2 RT patched kernel for month now.
>
> I just give a try to a 3.4 RT patched kernel and detected a memory pr=
oblem
> as you can see from the logs below:
>
> 3.2 with RT FULL PREEMPT is o.k
> 3.4 without RT FULL PREEMPT is .ok.
> 3.4 with RT FULL PREEMPT is not o.k.
>
> Can anyone give me hint in which direction I could go to detect the p=
roblem
> or has anyone else the same problem?
>
> Thanks and regards
> Ralf
>
>
> Linux MCU 3.2.27-rt40-00027-g8fd8396 #36 PREEMPT RT Mon Aug 20 16:21:=
04 CEST
> 2012 mips GNU/Linux
> [root@MCU:/opt]# watch -n 1 cat /proc/meminfo  | grep MemFree
> MemFree:          216992 kB
> MemFree:          216992 kB
> MemFree:          216944 kB
> MemFree:          216992 kB
> MemFree:          216992 kB
> MemFree:          216992 kB
> MemFree:          216992 kB
>
> uname -a
> Linux MCU 3.4.9-rt17-11244-gb12622a #23 PREEMPT RT Fri Aug 24 12:15:4=
9 CEST
> 2012 mips GNU/Linux
> [root@MCU:/opt]# watch -n 1 cat /proc/meminfo  | grep MemFree
> MemFree:          204304 kB
> MemFree:          204208 kB
> MemFree:          204112 kB
> MemFree:          204064 kB
> MemFree:          203968 kB
> MemFree:          203920 kB
> MemFree:          203824 kB
> MemFree:          203776 kB
>
> uname -a
> Linux MCU 3.4.9-rt17-11244-gb12622a #24 PREEMPT Fri Aug 24 14:15:04 C=
EST
> 2012 mips GNU/Linux
> [root@MCU:/opt]# watch -n 1 cat /proc/meminfo  | grep MemFree
> MemFree:          222240 kB
> MemFree:          222192 kB
> MemFree:          222192 kB
> MemFree:          222192 kB
> MemFree:          222144 kB
> MemFree:          222144 kB
> MemFree:          222192 kB
> MemFree:          222144 kB
> MemFree:          222192 kB
> MemFree:          222144 kB

You have a big leak (around 100kB/sec), yes, but can you give us more d=
etails ?
What kind of application ? Network ? video encoder ?
Which drivers are you using ?
Did you try using some advanced tools in order to check that your
application cannot have a memory leak in a specific use case (race
condition ?) ?
You will need to be more precise on the memory leak detection, because
with what you gave, I (maybe others can) cannot help you more...

Regards,
JM
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
