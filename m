Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A733AD88
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Oct 2026 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974424; cv=none; b=OtCGDToYffq57ywblJMXc5n99hjmWlVsvo0tqYLBv51x9wrRjVhS9TcXko9V7epCfwjUdai+cMlLqPGrJQpt6XTNoRotWIuCgmjAuzTRqU90B1PbSVY4eGWYWB3KTlE3nEGDhmjtcrh6eNfqhdu/83bIbfpy+y1lVHlX7P4EBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974424; c=relaxed/simple;
	bh=1lC0zunUYd9QsA+zWpzAfbP7riFOrPJ9HalRFEGI+0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROj+N6R99vOieF0G3JjOYfFRvkxOvkfmciRlNotzF9ag3pgG0phF4dOdiDi0kg1EJzla6sOqLCTCuJKdr8WI/fw3kB8tVkwo1TGgnfjRvqQio87ovob6kieF70mqch4snRKusrNMIeZXQg57+APvDUhtHz6IDFe3e29Kir9Dud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/0i/NxK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/0i/NxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790974412;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=ciPFe/lfXiwnNhpVXVEPTnzHcxO28cbv1wIlJCF8mqE=;
	b=D/0i/NxK0BOSmx55IUuD6hm1mN+iacMzguksI+zuhU7tCI2mmD95lG4YCxCKuLXhyuJF1k
	LG7T+UYQwmJFzrwE/6X7OwFNmVaPUcD2SxKRy1VTWacEYTIqpaA9VLn+grkiuRQNAgL6Of
	fx/FZSs8171PABBZytNT3NGWheDL7eU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-tICG-ty0NYW6Hs5gBRZ7mA-1; Fri,
 02 Oct 2026 16:53:31 -0400
X-MC-Unique: tICG-ty0NYW6Hs5gBRZ7mA-1
X-Mimecast-MFC-AGG-ID: tICG-ty0NYW6Hs5gBRZ7mA_1790974410
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 884BD1955E7A;
	Fri,  2 Oct 2026 20:53:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E70B1956086;
	Fri,  2 Oct 2026 20:53:30 +0000 (UTC)
Date: Fri, 2 Oct 2026 16:53:29 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: williams@redhat.com, vkuznets@redhat.com, 
	linux-rt-users@vger.kernel.org
Subject: Re: Console Hang on SMP Secondary CPU Bringup
Message-ID: <asAN93Bvi29KXd1h@debarbos-thinkpadt14gen5.rmtusma.csb>
Reply-To: debarbos@redhat.com
References: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
 <20260928140837.058IIp53@linutronix.de>
 <arrMKtKKVpiJBLeF@debarbos-thinkpadt14gen5.rmtusma.csb>
 <20260929091415.0yfm4bPw@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929091415.0yfm4bPw@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hey Sebastian,

On Tue, Sep 29, 2026 at 11:14:15AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-28 16:54:31 [-0400], Derek Barbosa wrote:
> > Hi Sebastian,
> Hi Derek,
> 
> > On Mon, Sep 28, 2026 at 04:08:37PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2026-09-23 12:02:31 [-0400], Derek Barbosa wrote:
> > > > In the v6.6-rt-rebase branch in the linux-stable-rt kernel trees, building (with
> > > > defconfig and additional HV drivers enabled), installing, then booting a kernel
> > > > in a paravirtualized Virtual Machine environment (HyperV in this case) via UEFI
> > > > boot may result in a unrecoverable "hang"
> > > 
> > > Does this also occur in v6.6-rt15? If so, can you check v7.3-rc5 and if
> > > it does not occur, try other RT kernels where this started happening?
> > 
> > You mean the non-rebase branch, correct? I can throw that on the TODO as well.
> 
> I don't care so much about rebase vs non-rebase but the old v6.6-rt15 vs
> current. Just to ensure that nothing slipped in while moving forward. I
> would assume that the rebase and non-rebase branch are equal for a fiven
> version.

I haven't been able to run as many trials as I would like, but it is
reproducible at v6.6-rt15.

> 
> > Just recently I tested a 7.2 kernel with PREEMPT_RT (and some other Fedora
> > configs) and was able to reproduce the issue. I need to confirm this though,
> > running some more trials and collecting data. I've been a little
> > scatter-brained.
> 
> Oh. That is good because it is not something that exists just in this
> old version of printk but also in the recent one.
> 
> > > This HyperV is something I can't try here, can I?
> > 
> > Hmm. IIRC you either need a Windows host with the functionality enabled, or
> > access to some sort of Azure cloud platform [0]. It is similar to other compute
> > providers in terms of signup, etc.
> 
> I have neither.
> 
> > > Does this run in qemu where you could attach gdb and check what the CPUs
> > > are doing?
> > > 
> > 
> > I John's email with something similar. TLDR: I don't know what other functionalities
> > of Hyper-V the "Azure Cloud VMs" expose, I will play around with the knobs and
> > fiddle with some buttons here and there...
> 
> Ah, I forget that gdb and so on does not work in the other world.
> 
> > > So we are not doing PREEMPT_RT?
> > 
> > The issue was reproducible in both :)
> > 
> > But seeing as how the code still exists in this tree, I figured this may be the
> > best place to report it.
> 
> The logic should be widely the same but changed in a few details to what
> we have now in v7.3-rc1. Also the print logic is different in RT vs
> non-RT (due to threaded printing and not).
> 

I am currently spinning the reproducer on some v7.3-rc4 kernels (both RT and
!RT) and have been able to reproduce at both.


7.3-rc4+rt
<snip>
[    0.097652] Console: colour dummy device 80x25
[    0.097656] printk: legacy console [tty1] enabled
[    0.977756] printk: console [ttyS0] enabled
[    0.977760] printk: legacy bootconsole [earlyser0] disabled
[    0.977839] ACPI: Core revision 20260408
[    0.986610] Failed to register legacy timer interrupt
[    0.990016] APIC: Switch to symmetric I/O mode setup
[    1.002458] x2apic enabled
[    1.012987] APIC: Switched APIC routing to: physical x2apic
[    1.016900] Hyper-V: Hypervisor Build 10.0.26102.1438-1-0
[    1.020785] Hyper-V: enabling crash_kexec_post_notifiers
[    1.024336] Hyper-V: Using IPI hypercalls
[    1.026985] APIC: send_IPI() replaced with hv_send_ipi()
[    1.030622] APIC: send_IPI_mask() replaced with hv_send_ipi_mask()
[    1.035561] APIC: send_IPI_mask_allbutself() replaced with hv_send_ipi_mask_allbutself()
[    1.040568] APIC: send_IPI_allbutself() replaced with hv_send_ipi_allbutself()
[    1.045725] APIC: send_IPI_all() replaced with hv_send_ipi_all()
[    1.049794] APIC: send_IPI_self() replaced with hv_send_ipi_self()
[    1.053820] Calibrating delay loop (skipped), value calculated using timer frequency.. 4589.37 BogoMIPS (lpj=2294685)
[    1.054817] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    1.054817] Last level dTLB entries: 4KB 64, 2MB 32, 4MB 32, 1GB 4
[    1.054817] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[    1.054817] Speculative Store Bypass: Vulnerable
[    1.054817] Spectre V2 : Mitigation: Retpolines
[    1.054817] ITS: Mitigation: Aligned branch/return thunks
[    1.054817] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.054817] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.054817] MMIO Stale Data: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.054817] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.054817] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
[    1.054817] active return thunk: its_return_thunk
[    1.054817] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    1.054817] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    1.054817] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    1.054817] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    1.054817] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    1.054817] pid_max: default: 32768 minimum: 301
[    1.054817] landlock: Up and running.
[    1.054817] Yama: becoming mindful.
[    1.054817] SELinux:  Initializing.
[    1.054817] LSM support for eBPF active
[    1.054817] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    1.054817] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    1.054817] VFS: Finished mounting rootfs on nullfs
[    1.054817] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz (family: 0x6, model: 0x4f, stepping: 0x1)
[    1.055239] Performance Events: unsupported CPU family 6 model 79 no PMU driver, software events only.
[    1.055872] signal: max sigframe size: 1776
[    1.057165] rcu: Hierarchical SRCU implementation.
[    1.057167] rcu:     Max phase no-delay instances is 400.
[    1.063689] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    1.076550] NMI watchdog: Perf NMI watchdog permanently disabled
[    1.076631] smp: Bringing up secondary CPUs .. ## HANG HERE
</snip>

I would like to run some more trials to truly confirm that this behavior is
consistently reproducible. I've noted that at 7.3-rc4+rt, it takes significantly
more time to reproduce, as opposed to 6.6-rc4+rt (nearly 4x as long).

I was unable to recover a full trace for 7.3-rc4, but it was orders of magnitude
longer, closer to 4 hours to reproduce.

At that point, I am worried that we are just hitting some flakiness caused by
repeated/consecutive boots -- not actually reproducing the console hang -- so I
cannot confidently declare that this is an issue that also affects mainline,
_yet_.

I will be running more trials to confirm.

> > It hangs right at the "cpuhp up cpu1 state cpu:kick_ap" message I had inserted.
> > 
> > I will play around with some of John's suggestions, and a few more ideas I had
> > in mind.
> 
> The question is, does it hang on its own or is related to printk message
> it issues.
> 
> > > The printk version is a bit old but still functional :) If the problem
> > > does not occur in a later kernel then could think about backporting that
> > > printk version back to v6.6 (unless there is a single obvious cause).
> > 
> > It very much is! I am pretty positive that we're only seeing the bug in
> > this weird corner case of HyperV (Linux guest), nbcon + high loglevel.
> > 
> > Thank you for the heads up. I will report back with more results + findings
> > soon. The bug is just pretty tedious to reproduce.
> 
> okay, thanks.
> 
> Sebastian
> 

Cheers,

-- 
Derek <debarbos@redhat.com>

