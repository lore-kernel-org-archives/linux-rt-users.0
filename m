Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6411AC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0160664E6F
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhBRP5f (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 10:57:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhBRPNP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 10:13:15 -0500
Date:   Thu, 18 Feb 2021 16:12:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613661152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1TAxGC5Ky5fHRH7tEpzxYdTdneXJGOZsBSnJ7JenJo=;
        b=Ocbqzcnro6OyPwV+4PNvaMzPIYIkB0ah0cGQssYwICHBueU/8ekmAO4o48NV1h9Sh9NQac
        J565ujmRydo9Io90aG1YdzmyVHgWpfArcdqVe+4XNcawCSm/YIypb/VimFysuFnsg7HvMA
        wykz910vfF/bFlRbsBACfEJrpbboRYcOPx/jaseuEl2Nk+mSqL1PzSNa7QORT1UtXikEOi
        2dFyULfSPNUpZ8+BtaTOKk5E+QhTUUnlo1CkHMOe92YWwD31xiXCYx7djgEVZbpM08lVEO
        6obJ0duo5rRLYw8cj90WsFHpAyA8BNllVG9FrgF74Nq2MhUjgtoh7k9dKAjPXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613661152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1TAxGC5Ky5fHRH7tEpzxYdTdneXJGOZsBSnJ7JenJo=;
        b=y2rHCnQgy+mHToD38VBrK/2JM5LyxnkAoOivEWzE1NejIOMHMe2gzN1/hbg+M4uVXVFwWZ
        YrrdFUfFpMRN2jCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Issue with cyclictest, RT_GROUP_SCHED, isolcpus and NOHZ_FULL
Message-ID: <20210218151231.przmuzsygtutjpck@linutronix.de>
References: <b07b6fc7-1a5f-0dcc-ca65-821de96cd8b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b07b6fc7-1a5f-0dcc-ca65-821de96cd8b4@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-30 14:09:19 [+0100], Jonathan Schwender wrote:
> Hi everyone,
>=20
> I've been trying to test the real-time `performance` possible with
> containers, by running cyclictest in a container on an RT-Kernel.
> The issue I've been having does not require containers or an
> RT kernel though.
>=20
> Issue: cyclictest freezes after running for a few seconds
> to minutes. After that only the loadavg section is updated,
> while the count line does not change anymore.
> cyclictest can't be killed after that point
> other than by restarting the machine, and
> this also takes a few minutes until the kernel kills
> cyclictest.
>=20
> This behaviour only occurs when the following conditions are
> met:
>=20
> - RT_GROUP_SCHED is used
> - cyclictest is bound to an isolated cpu core with
> =C2=A0 nohz_full=3D<core>, and isolcpus=3Dnohz,domain,<core>

So if you remove RT_GROUP_SCHED and use cyclictest on the nohz_full
cores then everything is fine?

> I've tested this on a machine with Fedora 33 and vanilla
> stable 5.10.3 kernel with RT_GROUP_SCHED.
> The same behaviour also exists on 5.10.1-rt20 with
> PREEMPT_RT and RT_GROUP_SCHED configured.
>=20
> After booting I configure the rt_runtime_us like this:
> `echo "700000" > /sys/fs/cgroup/cpu,cpuacct/user.slice/cpu.rt_runtime_us`
> `echo "100000" > /sys/fs/cgroup/cpu,cpuacct/system.slice/cpu.rt_runtime_u=
s`
>=20
> Then I start cyclictest via:
> `taskset -c 14 cgexec -g cpu,cpuacct:user.slice cyclictest --mlockall \
> =C2=A0 --priority=3D96 --interval=3D200 --affinity=3D14 --duration=3D15m`
>=20
> These are the cmdline options I tried out to narrow the problem down:
> working: `isolcpus=3D14 irqaffinity=3D0-3 maxcpus=3D15
> systemd.unified_cgroup_hierarchy=3D0`
> working: `isolcpus=3Dnohz,14 nohz_full=3D14 irqaffinity=3D0-3 maxcpus=3D15
> systemd.unified_cgroup_hierarchy=3D0`
> working: `isolcpus=3Dnohz,domain,14 irqaffinity=3D0-3 maxcpus=3D15
> systemd.unified_cgroup_hierarchy=3D0`
> broken:=C2=A0 `isolcpus=3Dnohz,domain,14 nohz_full=3D14 irqaffinity=3D0-3=
 maxcpus=3D15
> systemd.unified_cgroup_hierarchy=3D0`
>=20
> unified_cgroup_hierarchy is needed to get cgroups v1, which
> seems to be needed for RT_GROUP_SCHED (at least I couldn't
> find any options similar to cpu.rt_runtime_us with the default
> cgroup v2).
> Basically it boils down to that the combination of the
> domain parameter to isolcpus and nohz_full together with
> RT_GROUP_SCHED cause the problem I'm observing.
>=20
> Does anyone have any idea what could be causing this?
> Am I doing something wrong, or is there an issue with cyclictest or
> even the kernel that's causing this?
>=20
> My motivation is running (testing) a real-time container on isolated
> cores, so I think I do need all the kernel parameters I used above to
> get good latencies.

You might want to try without nohz_full. My understanding is that this
used if your application remains mostly in userland (and uses no
syscalls, etc.).

Let me this on my list of things to try out.

> Regards,
>=20
> Jonathan Schwender

Sebastian
