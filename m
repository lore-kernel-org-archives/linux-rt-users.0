From: "Wolfgang M. Reimer" <linuxball@gmail.com>
Subject: Re: Where IOSCHED ?
Date: Fri, 24 Jul 2015 11:35:11 +0200
Message-ID: <55B206CF.3050000@gmail.com>
References: <55AFF784.7040900@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: pavel@pavlinux.ru, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33136 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbGXJfP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2015 05:35:15 -0400
Received: by wicmv11 with SMTP id mv11so57215353wic.0
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jul 2015 02:35:14 -0700 (PDT)
In-Reply-To: <55AFF784.7040900@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 22.07.2015 22:05, Pavel Vasilyev wrote:

> # dmesg | grep sched
> [    0.387902] io scheduler noop registered
> [    0.387989] io scheduler deadline registered
> [    0.388079] io scheduler cfq registered (default)
> 

# dmesg | grep sched
[    0.516085] io scheduler noop registered
[    0.516089] io scheduler deadline registered (default)
[    0.516096] io scheduler cfq registered

> # cat /boot/config-3.18.17-rt14 | grep IOSCHED
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_CFQ_GROUP_IOSCHED=y
> CONFIG_DEFAULT_IOSCHED="cfq"
> 

# cat /boot/config-3.18.17-rt14 | grep IOSCHED
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_IOSCHED="deadline"


> # cat /sys/block/sda/queue/scheduler
> none
> 

# cat /sys/block/sda/queue/scheduler
noop [deadline] cfq 

> # uname -a
> Linux localhost 3.18.17-rt14 #1 SMP PREEMPT RT Wed Jul 22 18:49:51 MSK 2015 x86_64 GNU/Linux

# uname -a
Linux t520-wolf 3.18.17-rt14 #1 SMP PREEMPT RT Tue Jul 7 14:23:12 CEST 2015 x86_64 x86_64 x86_64 GNU/Linux


Hi Pavel,

so in my case /sys/block/sda/queue/scheduler shows the correct I/O
schedulers for the *same* kernel (3.18.17-rt14). The only difference is
that my default I/O scheduler is "deadline".

Wolfgang

