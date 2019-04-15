Return-Path: <SRS0=uP6E=SR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A383AC10F0E
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621FD20880
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EmFnMyQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfDOOOi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:14:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:47246 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfDOOOh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Apr 2019 10:14:37 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0FFB3181D8B;
        Mon, 15 Apr 2019 10:14:36 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id inG-3kaUi9lI; Mon, 15 Apr 2019 10:14:35 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7879D181D84;
        Mon, 15 Apr 2019 10:14:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7879D181D84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555337675;
        bh=qytA59mzKiVD28tnExt3/nLYj6HcKL1h58xZqd8v70c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EmFnMyQ9Ll64unQxEvMy6hy6wvG0UbTtOOq03QDvHgIlDehz79VP71uJJMgDjSUXY
         ffb1Zphwj6lzT+URBc4nJMZ1M/CvCVquGPk8ddJy/bIoNQ1nWu80PINUcz/+9ORnMU
         TAm6lvL7IGm7ixzXVc8zQjAlbRvqZFMwQI6Cfq6tkR8kLM5llUaDG4S0ODC/9V5AVY
         +/CQbJf2JQnxHxRQTknUEL+mFmn5iCY20pRbm0M2XtJ+a2QxwKP0hLf/yEsxL+X9e0
         8+D+yKYCOlvGoCTPvZ61O1r/ggH1i8dCBmYd2fQiSCYmI4M7/7RRCj6otuFeWm0YfA
         jw9crUy2KwBiA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id CKIJYz6q1Q6l; Mon, 15 Apr 2019 10:14:35 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 58476181D79;
        Mon, 15 Apr 2019 10:14:35 -0400 (EDT)
Date:   Mon, 15 Apr 2019 10:14:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Nicholas Sadjoli <nick.sadjoli@gmail.com>
Cc:     lttng-dev <lttng-dev@lists.lttng.org>,
        rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dev-raspberry-pi <dev-raspberry-pi@lists.mozilla.org>
Message-ID: <149638318.491.1555337675226.JavaMail.zimbra@efficios.com>
In-Reply-To: <725895933.460.1555337504175.JavaMail.zimbra@efficios.com>
References: <CAKUXLvdNYPitwKb8D5VDC7nXA4-z3OiApGX=qbVxV5LWFkDyJw@mail.gmail.com> <725895933.460.1555337504175.JavaMail.zimbra@efficios.com>
Subject: Re: [lttng-dev] Problems setting up lttng on PREEMPT_RT Raspberry
 Pi
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: Problems setting up lttng on PREEMPT_RT Raspberry Pi
Thread-Index: rt4Tt9XN9FqJ3CrS+ycMpCpBdJNfgSVprO9d
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Re-sent as plain text.

----- On Apr 15, 2019, at 10:11 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 15, 2019, at 7:07 AM, Nicholas Sadjoli <nick.sadjoli@gmail.com>
> wrote:

>> Dear Lttng dev Team,
>> I am currently interested in using lttng to measure the interrupt or hardware
>> real-time latencies experienced within my user-space applications.
>> Unfortunately I have been having issues installing lttng on my Raspberry Pi
>> that is using the PREEMPT_RT patched kernel, version 4.14.91-rt49-v7+. The
>> problems so far can be seen documented in the RPi Linux github forum page here:
>> [ https://github.com/raspberrypi/linux/issues/2930 |
>> https://github.com/raspberrypi/linux/issues/2930 ]

>> Initially I was about to just install the Debian package of the lttng onto the
>> RPi, and just proceeded with the commands ' sudo apt-get install
>> lttng-modules-dkms liblttng-ust-dev lttng-tools' However, I was unable to use
>> lttng package at all and found out that for the RPi, a build from source is
>> necessary for lttng, as described here: [
>> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
>> |
>> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
>> ]

>> Following their suggestion, I then tried to build the lttng packages from
>> source, and even re-building the RPi kernel locally to ensure the kernel
>> headers are in the RPi and linked up properly to the source packages.

>> Unfortunately when I tried to do this for the lttng-modules package, it instead
>> gave me the following warning in my latest attempt:

>> I n file included from
>> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:
>> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19:4:
>> error: #error "Your kernel is known to have buggy optimized kprobes
>> implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM:
>> 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in Linux. Disable
>> CONFIG_OPTPROBES or upgrade your kernel."
>> # error "Your kernel is known to have buggy optimized kprobes implementation.
>> Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM: 8834/1: Fix:
>> kprobes: optimized kprobes illegal instruction\" in Linux. Disable
>> CONFIG_OPTPROBES or upgrade your kernel."

>> I then tried to turn off the CONFIG_OPTPROBES kernel config, but it seemed to be
>> automatically overwritten during kernel building and is considered an important
>> part of the real-time RPi kernels. Has such problems been reported with this
>> version of the PREEMPT_RT kernel in the past (again, the current kernel version
>> that I am using is 4.14.91-rt49-v7+)? If there are I would like to know how
>> this issue was resolved so that I can properly build and use the lttng package
>> for my project.

> Hi Nicholas,

> It looks like our lttng-modules kernel version blacklist is acting exactly as it
> should. Looking at this
> git tree:

> git clone https://github.com/raspberrypi/linux.git -b rpi-4.14.y-rt
> I notice that in the git log, we find this bogus commit:

> commit f9e0bc710347fadad55910846ee36f0681d0dca8
> Author: Kees Cook <keescook@chromium.org>
> Date: Tue Oct 30 22:12:56 2018 +0100

> ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE

> commit e46daee53bb50bde38805f1823a182979724c229 upstream.

> But not the fix for it (upstream):

> commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date: Tue Feb 5 16:37:40 2019 +0100

> ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction

> So lttng-modules refuses to build against your kernel configuration with
> CONFIG_OPTPROBES=y
> to save you the trouble of having kprobes trigger illegal instruction OOPS at
> runtime.

> I'm unusure who maintains that raspberrypi rt kernel tree. However, the upstream
> rt tree
> for 4.14-rt maintained by Tom Zanussi seems to contain the fix:

> [
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt
> |
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt
> ]

> (currently at 4.14.109-rt57).

> So you should contact your raspberrypi linux rt tree clone maintainer and ask
> him
> to upgrade, or, as stated in the #error generated by lttng-modules, simply
> ensure
> CONFIG_OPTPROBES is unset when you build your kernel. You should ask the
> raspberrypi community advice on how to ensure this configuration option is not
> overridden by the raspberrypi build system.

> Thanks,

> Mathieu

>> Thank you so much for your attention and looking forward to your reply soon.

>> Best Regards,

>> Nicholas Sadjoli

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
