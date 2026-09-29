Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B54374E5A
	for <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673270; cv=none; b=EvJUGHIrWktNxE8JzLqcpvSaBuO2zCXqHau9p7ZtGf8fXNYOVhB5QyQeRyxW+KccdROObQodmTuBayV5s7By9D8JfTZkFewlhohFc7NiHj674a2y0+sOdQDg4iMImvU1YxLUZtcxAKCxsKN2SP6/s3rRBo/3kDkBESM1qtHg/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673270; c=relaxed/simple;
	bh=RAdQtygi9utLehAmIo8XcZS/kleX8azM5mwQoNzQyRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJN8QG2mCn/OptFCmZ0PaEaKIa5Z04yvrT28Xqn1b3L95oNhMJd48ARCzi/BpuIJYRhbhm8hfM3TDouf16MKFjtSRN/qoncOhvuoGGEeXsJ0baTQ8PXxCW8CbJRHDpRi5F8dJuziJw1GrxhF4ywZs/mvi5etlpWkxkGtVZZQLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vjaFOGEM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wh+rhv9f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vjaFOGEM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wh+rhv9f"
Date: Tue, 29 Sep 2026 11:14:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790673257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2oZ92swnGjPvCS2Gj6fpfutsghiOBzz7wC81WtE+IE=;
	b=vjaFOGEM2zTefW4fZEyHNSSNrCPSvR0IceymBrJjT97wyImrUoPS4tOF/wOt3Zolo3yBe9
	Q8Wi6J7Wj3Wphs4UWaTjjhwdNARzI9NtLS/r7T/Sz3bUyF4VFrLs2o5vG8TjoRmxOuZK5E
	Bt+l+IgfuB0nHYRhKGrUZcV8IauEEuZ80dsGs8k2KaEMvluMHr+gjXi6Nsj7+3AlxOn90j
	UkGThLPzRs9wSlzoYaHaBIpmK7dbNl49gG6hcbPFrluCwvwmBIz06cCiKc6s3s8YiFKUeA
	0haU18D8dRy3DyGO2jPFILcQpXDTrndD51gwhL8KsWmkPDdRqe8RO+YGpH+Y0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790673257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2oZ92swnGjPvCS2Gj6fpfutsghiOBzz7wC81WtE+IE=;
	b=Wh+rhv9fdzM2cbTATr8h7qlKEkqF2sGk0NYmIvyaXUuU0eGDOgwWHE1emF5XkN1lL/rR7s
	bcWQv7Y9Rw4evKDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: williams@redhat.com, vkuznets@redhat.com,
	linux-rt-users@vger.kernel.org
Subject: Re: Console Hang on SMP Secondary CPU Bringup
Message-ID: <20260929091415.0yfm4bPw@linutronix.de>
References: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
 <20260928140837.058IIp53@linutronix.de>
 <arrMKtKKVpiJBLeF@debarbos-thinkpadt14gen5.rmtusma.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arrMKtKKVpiJBLeF@debarbos-thinkpadt14gen5.rmtusma.csb>

On 2026-09-28 16:54:31 [-0400], Derek Barbosa wrote:
> Hi Sebastian,
Hi Derek,

> On Mon, Sep 28, 2026 at 04:08:37PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-09-23 12:02:31 [-0400], Derek Barbosa wrote:
> > > In the v6.6-rt-rebase branch in the linux-stable-rt kernel trees, building (with
> > > defconfig and additional HV drivers enabled), installing, then booting a kernel
> > > in a paravirtualized Virtual Machine environment (HyperV in this case) via UEFI
> > > boot may result in a unrecoverable "hang"
> > 
> > Does this also occur in v6.6-rt15? If so, can you check v7.3-rc5 and if
> > it does not occur, try other RT kernels where this started happening?
> 
> You mean the non-rebase branch, correct? I can throw that on the TODO as well.

I don't care so much about rebase vs non-rebase but the old v6.6-rt15 vs
current. Just to ensure that nothing slipped in while moving forward. I
would assume that the rebase and non-rebase branch are equal for a fiven
version.

> Just recently I tested a 7.2 kernel with PREEMPT_RT (and some other Fedora
> configs) and was able to reproduce the issue. I need to confirm this though,
> running some more trials and collecting data. I've been a little
> scatter-brained.

Oh. That is good because it is not something that exists just in this
old version of printk but also in the recent one.

> > This HyperV is something I can't try here, can I?
> 
> Hmm. IIRC you either need a Windows host with the functionality enabled, or
> access to some sort of Azure cloud platform [0]. It is similar to other compute
> providers in terms of signup, etc.

I have neither.

> > Does this run in qemu where you could attach gdb and check what the CPUs
> > are doing?
> > 
> 
> I John's email with something similar. TLDR: I don't know what other functionalities
> of Hyper-V the "Azure Cloud VMs" expose, I will play around with the knobs and
> fiddle with some buttons here and there...

Ah, I forget that gdb and so on does not work in the other world.

> > So we are not doing PREEMPT_RT?
> 
> The issue was reproducible in both :)
> 
> But seeing as how the code still exists in this tree, I figured this may be the
> best place to report it.

The logic should be widely the same but changed in a few details to what
we have now in v7.3-rc1. Also the print logic is different in RT vs
non-RT (due to threaded printing and not).

> It hangs right at the "cpuhp up cpu1 state cpu:kick_ap" message I had inserted.
> 
> I will play around with some of John's suggestions, and a few more ideas I had
> in mind.

The question is, does it hang on its own or is related to printk message
it issues.

> > The printk version is a bit old but still functional :) If the problem
> > does not occur in a later kernel then could think about backporting that
> > printk version back to v6.6 (unless there is a single obvious cause).
> 
> It very much is! I am pretty positive that we're only seeing the bug in
> this weird corner case of HyperV (Linux guest), nbcon + high loglevel.
> 
> Thank you for the heads up. I will report back with more results + findings
> soon. The bug is just pretty tedious to reproduce.

okay, thanks.

Sebastian
