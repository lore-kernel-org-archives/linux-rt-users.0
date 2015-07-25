From: pavel <pavel@pavlinux.ru>
Subject: Re: Where IOSCHED ?
Date: Sat, 25 Jul 2015 04:42:11 +0300
Message-ID: <55B2E973.4060908@pavlinux.ru>
References: <55AFF784.7040900@pavlinux.ru> <55B206CF.3050000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Wolfgang M. Reimer" <linuxball@gmail.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward13p.cmail.yandex.net ([87.250.241.140]:34101 "EHLO
	forward13p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753083AbbGYBvs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2015 21:51:48 -0400
In-Reply-To: <55B206CF.3050000@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


24.07.2015 12:35, Wolfgang M. Reimer =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 22.07.2015 22:05, Pavel Vasilyev wrote:
>
>> # dmesg | grep sched
>> [    0.387902] io scheduler noop registered
>> [    0.387989] io scheduler deadline registered
>> [    0.388079] io scheduler cfq registered (default)
>>
> # dmesg | grep sched
> [    0.516085] io scheduler noop registered
> [    0.516089] io scheduler deadline registered (default)
> [    0.516096] io scheduler cfq registered
>
>> # cat /boot/config-3.18.17-rt14 | grep IOSCHED
>> CONFIG_IOSCHED_NOOP=3Dy
>> CONFIG_IOSCHED_DEADLINE=3Dy
>> CONFIG_IOSCHED_CFQ=3Dy
>> CONFIG_CFQ_GROUP_IOSCHED=3Dy
>> CONFIG_DEFAULT_IOSCHED=3D"cfq"
>>
> # cat /boot/config-3.18.17-rt14 | grep IOSCHED
> CONFIG_IOSCHED_NOOP=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_CFQ=3Dy
> CONFIG_CFQ_GROUP_IOSCHED=3Dy
> CONFIG_DEFAULT_IOSCHED=3D"deadline"
>
>
>> # cat /sys/block/sda/queue/scheduler
>> none
>>
> # cat /sys/block/sda/queue/scheduler
> noop [deadline] cfq
>
>> # uname -a
>> Linux localhost 3.18.17-rt14 #1 SMP PREEMPT RT Wed Jul 22 18:49:51 M=
SK 2015 x86_64 GNU/Linux
> # uname -a
> Linux t520-wolf 3.18.17-rt14 #1 SMP PREEMPT RT Tue Jul 7 14:23:12 CES=
T 2015 x86_64 x86_64 x86_64 GNU/Linux
>
>
> Hi Pavel,
>
> so in my case /sys/block/sda/queue/scheduler shows the correct I/O
> schedulers for the *same* kernel (3.18.17-rt14). The only difference =
is
> that my default I/O scheduler is "deadline".
>
> Wolfgang
>

Maybe my mistake, but I use a Soft RAID1

$ cat /sys/block/{sd,md}*/queue/scheduler
none
none
none
none
none
none

--

Other server (Debian 6.0.10): non RT, but with soft RAID1 too.

$ uname -a
Linux mail 2.6.32-5-amd64 #1 SMP Wed Jun 17 16:09:06 UTC 2015 x86_64 GN=
U/Linux


$ cat /sys/block/{sd,md}*/queue/scheduler

noop anticipatory deadline [cfq]
noop anticipatory deadline [cfq]
none
none
none

here: sda,sdb,md0,md1,md2,md3

--

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
