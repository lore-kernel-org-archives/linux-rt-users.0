Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF2C6FD19
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Mar 2023 21:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCJVJe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJVJc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Mar 2023 16:09:32 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1B011E6CE
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Mar 2023 13:09:31 -0800 (PST)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E110C3F26C;
        Fri, 10 Mar 2023 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678482568;
        bh=NnaTnBYhO5EDvhe/1ofPHW2UOn7SNNhmCSdLnEHYYeU=;
        h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
         In-Reply-To:Content-Type;
        b=MzzoAJ8P9c7yuAKXJ+1twnzTMyMe1GHAMK2QeX1qKFf10bX/HLvOx8hRi9VxzbmvC
         h/KzONuYpzuFd1NxY4Aw4MI9aKj0Wel68Nr9wLZImcpEIy1y5r+ON7GkguskJOEbWK
         w0dBDA8fpZ8rTqoHuYbH/0ILVZeOqdUuNOII0JramxiEJTL5oup/Md/++ScbE9mWgT
         4lNgj8n4oMz3e3rD9JvqLXjkxaHrrfNF7qx82Lm/sYLYi3G6d0rY00I0TaK+4j5iFU
         5mivf3TG5//LmxBczX5JBLt/iNyygmR9ddqe1i4yPlgn5sUQ7iBD9mt2ui2uK9edVL
         1f9vLmtg5D2RA==
Message-ID: <daaa77a0-5091-1c21-2d53-160220f27594@canonical.com>
Date:   Fri, 10 Mar 2023 16:09:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        bigeasy@linutronix.de, rostedt@goodmis.org, tglx@linutronix.de
References: <fe5974c9-3ed0-938a-f43c-4d301f603e92@canonical.com>
 <be47fd9c-028a-0b6b-9c7f-877f01e73960@canonical.com>
 <dea6d0e9-7814-4b8c-44dd-4804cbe48227@canonical.com>
 <c4fe632e-568b-7c60-c6d2-99e0148680ad@canonical.com>
 <Y+5kz/DfgypT8Hsr@linutronix.de>
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Re: System Hang With 5.15.79-rt54 Patch Set
In-Reply-To: <Y+5kz/DfgypT8Hsr@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 2/16/23 12:15, Sebastian Andrzej Siewior wrote:
> On 2023-01-18 13:52:21 [-0500], Joseph Salisbury wrote:
>> I'll add more details to this thread as I continue.
> Any update on this?
> Does the system really hang? The dmesg says:
> |[ 8235.110075] INFO: task stress-ng:9466 blocked for more than 122 seconds.
>
> which means stress-ng is blocked for quite some time due to I/O
> according to the backtrace. This appears once for each stress-ng
> process, 10 times in total. It does not repeat and the system runs at
> least until
>
> | [50733.471625] hid-generic 0003:03F0:7029.0004: input,hidraw1: USB HID v1.10 Mouse [iLO Virtual Keyboard] on usb-0000:01:00.4-1/input1
>
> ~11h after that report.
> Based on that it looks like the system complained about slow I/O but did
> not hang as it completed its task.
>
> Sebastian
Hi Sebastian,

Sorry I missed this mail due to a mail filtering issue.

A bisect has not provided additional detail. This issue does not appear 
to be a regression and appears to have always existed.

I was able to get additional debug info, by enabling 
CONFIG_DEBUG_PREEMPT, CONFIG_PROVE_LOCKING and CONFIG_JBD2_DEBUG. 
Enabling these configs shows a circular locking issue[0] and a call 
trace[1].

I don't think the circular locking report is related.  I think your 
correct that the system is not actually hanging.  The interactive 
response make it seem like it's hung.  For example, once the issue 
starts to happen, no other interactive commands can be issues without 
taking at least days (I never waiting more that 3 days :-) )  I'm also 
not able to log in or log out while the system "Appears" hung.  I was 
able to get a sysrq-W while the system was in this state[2].

I think I may have starting investigating too deep at first (By 
bisecting and enabling trace, etc).  I stepped back and looked at the 
high level stats.  The stress-ng test is started with one process for 
each core, and there are 96 of them.  I looked at top[3] during a hang, 
and many of the stress-ng processes are running 'R'. However, a sysrq-q 
also shows many stress-ng processes are 'D' in uninterruptible sleep.  
What also sticks out to me is all the stress-ng processes are running as 
root with a priority of 20. Looking back at one of the call traces[1], I 
see jbd2 stuck in an uninterruptible state:
...
[ 4461.908213] task:journal-offline state:D stack:    0 pid:17541 
ppid:     1 flags:0x00000226
...


The jdb2 kernel thread also runs with a priority of 20[4].  When the 
hang happens, jbd2 is also stuck in an uninterruptible state(As well as 
systemd-journal):
1521 root      20   0       0      0      0 D   0.0   0.0   4:10.48 
jbd2/sda2-8
1593 root      19  -1   64692  15832  14512 D   0.0   0.1   0:01.54 
systemd-journal



I don't yet know why running the test the same way for a generic kernel 
does not cause this behavior when it does for a preempt-rt kernel.  
Maybe it's a case of priority 'Sameness' and not priority inversion :-) ?

I tried to pin all of the stress-ng threads to cores 1-95 and the kernel 
threads to a housekeeping cpu, 0. I recall though that there are certain 
kernel threads that need to run on every core and kworker is one of 
them.  Output from cmdline:
"BOOT_IMAGE=/boot/vmlinuz-5.15.0-1033-realtime 
root=UUID=3583d8c4-d539-439f-9d50-4341675268cc ro console=tty0 
console=ttyS0,115200 skew_tick=1 isolcpus=managed_irq,domain,1-95 
intel_pstate=disable nosoftlockup tsc=nowatchdog 
crashkernel=0M-2G:128M,2G-6G:256M,6G-8G:512M,8G-:768M"

However, even with this pinning, stress-ng ends up running on cpu 0, per 
the ps output[4].  This may be why it is interfering with jbd2.

I'll see if I can modify the test to run as a non-root user or with a 
lower priority.  I could also try bumping the priority of jdb2. Maybe 
one of these would allow the journal to complete it's work and the test 
to finish?

Could it be that that the system is not hung, it is just waiting to 
complete I/O, which will never happen since the jdb2 threads are stuck. 
In this case, this is not a bug, but a test that is not configured 
correctly for a real-time system.  Does that sound plausible?  If you 
think that is the case, I'll talk with the bug reporter and assist them 
with running the test properly for a real-time system.



Thanks for your assistance!

Joe


[0] https://launchpadlibrarian.net/653810449/locking_issue.txt
[1] https://launchpadlibrarian.net/653810490/call_trace.txt
[2] https://launchpadlibrarian.net/655372944/sysrq-w.txt
[3] https://launchpadlibrarian.net/655374168/top-during-hang.txt
[4] https://launchpadlibrarian.net/655380123/ps-test-running.txt
