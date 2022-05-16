Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488FCC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 May 2022 14:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244627AbiEPOXo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 May 2022 10:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244531AbiEPOXg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 May 2022 10:23:36 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC723B3C3
        for <linux-rt-users@vger.kernel.org>; Mon, 16 May 2022 07:23:24 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id n24so25801uap.13
        for <linux-rt-users@vger.kernel.org>; Mon, 16 May 2022 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDW2+Jg3JfWkAbvIEok9LptY7efQPzBNt+FHHmadtGE=;
        b=iaPhBoyCgu+Z0mzPret+hxTCSAbDCIB/pNxkmRWXKuSKMJv0DphS5MCx4qeWMzzC7M
         gs3N4mZ++ifuZwU2MbtcUNBdhH9hk7aEHO+ToVvUmJwcf53JBGZIcogqoqRX9EnAVNIV
         oOihiafqZq8AJn79bzLjAo8bPPUJ6X65nMnuPGs1PjirTN5dVK3uBiOXIpGmIqMEGQjU
         nF/bNS+ZJxa67ZncNedzfcRNusH2CnDdjujG9gEd6ELNYVbHRcLT3J0lzRM27eVqhL4e
         MzryZcCuyljU/CqD9sH9EHA/wTzvKTU6Oh9kKyMgmyULVTalB6PL7MO2FUL5/GY4EVg7
         83yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDW2+Jg3JfWkAbvIEok9LptY7efQPzBNt+FHHmadtGE=;
        b=accFTtqOMztBtXrqSMde7CEMc9rgopJ0mUlOiqBICCoM8FtzHuYuZNHAtVV8zgdJG7
         a0iJ7euGPpT9j2jKA0rNmkcBcmiKnLy//3WBravzeIQFlxM/5YAKuR2eqx9jzTwGd7EW
         aJYhBeHV1pEnUOit6S7JfXKCR6y9H0hxAMzsSowQzXMxVBQf0dzYcv1nHIAk4v1JS4yK
         XOwlTzqyM0wtTnbUDQGaH3Zx1UgWJKt3I0AhytgoklptZGxlPjjjbXC0d1ebQe3hJXvU
         QBpR0ZpU9DBZaHDIU4Ys4mI+u6YKV/N3aaZ399DQPBZ3TC6ARgXxR+j8xH0YUXwYmf07
         i4bg==
X-Gm-Message-State: AOAM532D7tJv7LMOc4O1A7vZnWzQY9IcK/PYpo5koFM23CTfCOJROf3X
        kgTNdu+EUrLzshYqtTbo0TdKrkFLuvOZg8iJdc46o9yuCGA=
X-Google-Smtp-Source: ABdhPJyTarHHjulEQRwQRdrWaGp7A2pOQgQ5CcGrLFnhtR2ZSmSsDnYOvhrRWqIKBMbDcAB2GZZib9yG+qzkxZXKbeE=
X-Received: by 2002:a05:6130:32a:b0:365:88b6:fd2 with SMTP id
 ay42-20020a056130032a00b0036588b60fd2mr6902068uab.97.1652711003325; Mon, 16
 May 2022 07:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <1631541178.407490.1643808841804.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <1631541178.407490.1643808841804.JavaMail.zimbra@savoirfairelinux.com>
From:   Florent Carli <fcarli@gmail.com>
Date:   Mon, 16 May 2022 16:23:11 +0200
Message-ID: <CAJuRqcA-PCJratDCxK==eu3oZEFerj+trtfcZz1-hVzttP3+Nw@mail.gmail.com>
Subject: Re: [Question] KVM-RT high max latency after upgrade host from 4.19
 to 5.15
To:     =?UTF-8?Q?Mathieu_Dupr=C3=A9?= <mathieu.dupre@savoirfairelinux.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> I would like to know what is introducing this latency. Is it related to the fact
> that the CPU running KVM periodically enters IDLE mode? Why do we
> have this behavior in 5.15 and not in 4.19?

This is easily reproducible when using vcpu-pinning on a guest, I
think I got to the bottom of this. Buckle up, this is a bit tricky :)
I believe these latencies come from hitting RT-Throttling in your
host. This can be verified in your kernel logs where you should find
"RT throttling activated" (printed only once). By default
RT-throttling prevents an RT process to consume more than 95% of a cpu
runtime (actually 950000us/1000000us as you can check in
/proc/sys/kernel/sched_rt_period_us and
/proc/sys/kernel/sched_rt_runtime_us).
Why is throttling activated? Because your guest vCPU processes are
above 95% utilisation, which may seem weird since the cyclictest
process is not consuming so much... what's happening? Indeed the cpu
usage from inside your guest is small, why is it so high from the host
perspective?
The root cause is actually the default value of kvm halt_pool_ns
(200000ns, matching your cyclictest interval value 200us), and because
you are probably using vcpu-pinning (or any other mecanism/constraint
that makes the vcpus running on the exact same number of cpu --> the
vcpu is constrained to a cpu).

From https://www.kernel.org/doc/Documentation/virtual/kvm/halt-polling.txt:
"The KVM halt polling system provides a feature within KVM whereby the
latency of a guest can, under some circumstances, be reduced by
polling in the host for some time period after the guest has elected
to no longer run by cedeing."

When the cyclictest interval is larger than halt_poll_ns, then the
polling does not help (it's never interrupted) and the
growing/shrinking algorithm makes the interval go to 0 ("In the event
that the total block time was greater than the global max polling
interval then the host will never poll for long enough (limited by the
global max) to wakeup during the polling interval so it may as well be
shrunk in order to avoid pointless polling.").

But when the cyclictest interval starts becoming smaller than
halt_poll_ns, then a wakeup source is received within polling...
"During polling if a wakeup source is received within the halt polling
interval, the interval is left unchanged.", and so polling continues
with the same value, again and again, which puts us is this situation:

"Care should be taken when setting the halt_poll_ns module parameter
as a large value has the potential to drive the cpu usage to 100% on a
machine which would be almost entirely idle otherwise. This is because
even if a guest has wakeups during which very little work is done and
which are quite far apart, if the period is shorter than the global
max polling interval (halt_poll_ns) then the host will always poll for
the entire block time and thus cpu utilisation will go to 100%."

To sum up, when you use cyclictest with an interval <= halt_poll_ns,
and when the vCPU is constrained, the vCPU and the associated CPU will
naturally hit 100%, which will make your host throttle the RT process
(by default 50ms every second, which is precisely the kind of
latencies you observe).
If the vCPU is not constrained to a CPU, I guess the high load from
the RT process is more easily migrated to different cpus by the
scheduler, so even though the process will show 100% usage total, no
cpu will hit RT-throttling. I don't know what makes the process
migrate in that case, if someone knows please feel free to respond.

What's weird is that you say you still encounter this situation with
halt_poll_ns lowered to 50000ns and that's not supposed to happen. My
guess is that you may not have restarted your guest so that it catches
on the new value. My experience (I didn't check the kvm code) is that
this setting is determined per guest, at guest startup.

Now for the last part of the problem, why you didn't hit this problem
with kernel v4.19.

With kernel v4.19 you didn't hit RT-throttling, even thought the vcpu
was using 100% cpu runtime (you can check in your kernel logs). The
reason is that on kernel < 5.10, the scheduler comes with RT runtime
sharing enabled (RT_RUNTIME_SHARE is true by default). With kernel
v5.10, RT_RUNTIME_SHARE is disabled by default.
https://lore.kernel.org/lkml/c596a06773658d976fb839e02843a459ed4c2edf.1479204252.git.bristot@redhat.com/

"RT_RUNTIME_SHARE sched feature enables the sharing of rt_runtime
between CPUs, allowing a CPU to run a real-time task up to 100% of the
time while leaving more space for non-real-time tasks to run on the
CPU that lend rt_runtime"

My understanding it that with RT_RUNTIME_SHARE enabled (on your 4.19
kernel), the vcpu needing 100% runtime would "borrow" the extra 5% to
another cpu runtime, and thus would not get throttled by
RT-throttling.

To conclude, you have 5 ways not to have this problem (the first 3 are
just to not be in this very specific situation):
1) increase your cyclictest interval, so that you don't hit the halt
polling problem at default value 200us, then your vpcu won't use 100%
of the cpu
2) lower your halt polling max interval, so that your cyclictest with
a 200us does not hit the lowered halt polling interval (you can also
disable halt polling altogother, by setting 0 to halt_poll_ns), your
vcpu won't use 100% of the cpu. This is what you have tested and
should have solved the issue. Be sure you stop the VM and start it
again when you change halt_poll_ns.
3) do not use vcpu-pinning so that the high cpu load is dispatched on
different cpus (if you have more cpus than vcpus of course...)
4) disable RT-Throttling (echo -1 >
/proc/sys/kernel/sched_rt_period_us): even though the vcpu uses 100%
of its cpu, it won't be throttled so you won't get the latencies
5) enable RT_RUNTIME_SHARE (echo RT_RUNTIME_SHARE >
/sys/kernel/debug/sched/features) so that your are exactly in the
kernel <5.10 situation (no throttling because of sharing). Since you
are compiling a custom kernel, note that you need CONFIG_SCHED_DEBUG
to play with scheduler features.

I personally would keep using vcpu-pinning, but avoid testing with a
cyclictest interval <= halt_poll_ns since it's kind of a particular
situation which will make you cpu go crazy, which is something you
probably do not want anyway. And since you are using isolated cpus for
your RT workloads, I would also go with disabling RT-Throttling, which
is kind of a standard best practice when trying to achieve best
latencies (see redhat tuned profile for realtime for example)
https://github.com/redhat-performance/tuned/blob/9fa66f19de78f31009fdaf3968a6d75686c190bc/profiles/realtime/tuned.conf#L44
