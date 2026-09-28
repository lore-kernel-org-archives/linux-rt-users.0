Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C404E4C34
	for <linux-rt-users@vger.kernel.org>; Mon, 28 Sep 2026 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628956; cv=none; b=VjIWFgb1poIks9x7Q1+L7lv0w/6ZxNajuGFERuX7qtqyTLUY9ONFULg8dXXe2/53MTjfgDZ+opq/cWUc7vtZsIGsWphrvUz/XWD1jxuNoagm0bkXiZrZPF+ekszpQojFIFin/zTqjS7FKAjlb2jfZ5ok1y9PnhdHyrVh4qMZNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628956; c=relaxed/simple;
	bh=oWAlrjw8xsEO2PPKMC7KIBcALoZiHzYKGSl+BvlDZi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr+SMb+vF6+p59Cg0mMJcxIlFUgQppPMN8zYj70v5w1dWCXaB0kp0iIHaNOFlcZL2YB4oUfLI/fRDpCiDI9z2gutXHDcbsf7Kpn1/k+h93gkIBKgImNJtJ6fOVwPBBa8mGGqJMPQNtRidTBDhQOk8D7hUcqs7HS2RYccDg5Rops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kp7lRDOP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp7lRDOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790628954;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtMssDAE6O67jOZ84hNycJgos3eVQWT1du+z3hqPtks=;
	b=Kp7lRDOPfvs4ujpYLHxU6sDH3Y6jqkm8V6womInW6QoGIIqtOOUpNkZBdLe3lxoA4k3GC/
	bpHVE+pSU5vBVkCyHRw01ngl66qnumPCw4AnwFLRYUZpzgEXyeptw+NsomOp9jQa5Cd+eb
	3xW4DrCDMCG1Usl/DHc9D+vW4I1GLWk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-vN8F1sR1PemUDLz_p3Aicg-1; Mon,
 28 Sep 2026 16:55:50 -0400
X-MC-Unique: vN8F1sR1PemUDLz_p3Aicg-1
X-Mimecast-MFC-AGG-ID: vN8F1sR1PemUDLz_p3Aicg_1790628950
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 091B71800A47;
	Mon, 28 Sep 2026 20:55:50 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 678F71800352;
	Mon, 28 Sep 2026 20:54:45 +0000 (UTC)
Date: Mon, 28 Sep 2026 16:54:31 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: williams@redhat.com, vkuznets@redhat.com, 
	linux-rt-users@vger.kernel.org
Subject: Re: Console Hang on SMP Secondary CPU Bringup
Message-ID: <arrMKtKKVpiJBLeF@debarbos-thinkpadt14gen5.rmtusma.csb>
Reply-To: debarbos@redhat.com
References: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
 <20260928140837.058IIp53@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928140837.058IIp53@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Sebastian,

On Mon, Sep 28, 2026 at 04:08:37PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-23 12:02:31 [-0400], Derek Barbosa wrote:
> > In the v6.6-rt-rebase branch in the linux-stable-rt kernel trees, building (with
> > defconfig and additional HV drivers enabled), installing, then booting a kernel
> > in a paravirtualized Virtual Machine environment (HyperV in this case) via UEFI
> > boot may result in a unrecoverable "hang"
> 
> Does this also occur in v6.6-rt15? If so, can you check v7.3-rc5 and if
> it does not occur, try other RT kernels where this started happening?

You mean the non-rebase branch, correct? I can throw that on the TODO as well.

Just recently I tested a 7.2 kernel with PREEMPT_RT (and some other Fedora
configs) and was able to reproduce the issue. I need to confirm this though,
running some more trials and collecting data. I've been a little
scatter-brained.

> This HyperV is something I can't try here, can I?

Hmm. IIRC you either need a Windows host with the functionality enabled, or
access to some sort of Azure cloud platform [0]. It is similar to other compute
providers in terms of signup, etc.

> 
> …
> > In any case, the system is completely unresponsive over the any serial consoles,
> > responding to neither SysRQs nor NMIs, even with the appropriate cmdline
> > arguments to invoke such behavior.
> 
> Does this run in qemu where you could attach gdb and check what the CPUs
> are doing?
> 

I John's email with something similar. TLDR: I don't know what other functionalities
of Hyper-V the "Azure Cloud VMs" expose, I will play around with the knobs and
fiddle with some buttons here and there...

> > It appears as though the behavior in question has been bisected to af3a8162581e
> > ("serial: 8250: Switch to nbcon console")
> > 
> > <snip>
> > $ git describe --contains af3a8162581e
> > 
> > v6.6.156-rt79-rebase~63
> > 
> > $ git show v6.6.156-rt79
> > </snip>
> > 
> > and is not reproducible prior to this point (it has not been bisectable to any
> > HV/HyperV/Xen/etc commits _yet_).
> > 
> > IIRC, this commit was reverted in mainline for the time being, as a significant
> > amount of work was/is being done in tty/serial, etc...
> 
> As far as I remember, it was dropped because other driver fall apart.
> 
> > It is not entirely clear what effect the commit introduces with regard to the
> > smp secondary CPU masking/bringup, and why it would cause a
> > seemingly-unrecoverable state prior to the cpuhp callbacks.
> 
> It could be unrelated to the driver, just some printk corner case.
> 
> > IIUC (and from what I have seen in the traces) at this point in the init
> > process, we've disabled earlycon/earlyserial, and have brought up nbcon.
> …
> > I have seen in some cases where nbcon 8250 can be slightly slower at boot time,
> > which could introduce the possibility of some contention between the increased
> > console verbosity and replacement of send_IPI_all/self() with
> > hv_send_ipi_all/self() (this is just conjecturing).
> 
> Not sure how this is related. Maybe it is a wakeup for the nbcon thread
> on the remote CPU.
> 
> …
> > Specifically, I was curious if serial8250_console_write_thread() could
> > potentially be the culprit, especially given the fact that we are running in
> > CONFIG_PREEMPT_VOLUNTARY as opposed to CONFIG_PREEMPT_RT.
> 
> So we are not doing PREEMPT_RT?

The issue was reproducible in both :)

But seeing as how the code still exists in this tree, I figured this may be the
best place to report it.

> 
> > My understanding is shaky at best here, but specifically:
> > 
> > <snip>
> > 	while (!nbcon_enter_unsafe(wctxt))
> > 		nbcon_reacquire(wctxt);
> > 
> > 	/* Finally, wait for transmitter to become empty and restore IER. */
> > 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
> > 	if (em485) {
> > 		mdelay(port->rs485.delay_rts_after_send);
> > 		if (em485->tx_stopped)
> > 			up->rs485_stop_tx(up);
> > 	}
> > 	serial_port_out(port, UART_IER, ier);
> > </snip>
> > 
> > Is it possible that we just spin here? That we somehow lost ownership at some
> > point during the secondary CPU startup sequence and cannot restore UART_IER?
> > Would this explain the silent console + hang at PID1?
> 
> The regular printk path acquires the uart lock. If my memory serves me
> right, the take over takes place in atomic context (say from panic()).
> 

Thanks for the note.

> > If that is not the case (very plausible) -- what I am still very unsure of, is
> > how the atomic 8250 implementation here could affect the rdmsr()s in
> > save/get_fixed_ranges(), to the point of intermittently stalling in the Hyper-V
> > VM (MTRR virtualization / SMT sibling) environment?
> 
> Me, too. It is just all callback to CPU0 with waiting until it is done.
> If CPU1 stalls then CPU0 did not finish… CPU0 should be more or less
> idle here.

Yes, that checks out. In fact, further testing reveals that this was a red
herring anyway.

Shortly after I sent that mail, a kernel that I had just finished building with
the mtrr_save_.*() functionalities disabled -- as this appears to be disabled on
HV guests anyway [1] -- had quickly hit the issue again (unrelated, but after
RTFM, it appears that the use of PATs are more common in "modern" kernels than
MTRRs to begin with).

It hangs right at the "cpuhp up cpu1 state cpu:kick_ap" message I had inserted.

I will play around with some of John's suggestions, and a few more ideas I had
in mind.

>  
> …
> > Many thanks in advance,
> 
> The printk version is a bit old but still functional :) If the problem
> does not occur in a later kernel then could think about backporting that
> printk version back to v6.6 (unless there is a single obvious cause).

It very much is! I am pretty positive that we're only seeing the bug in
this weird corner case of HyperV (Linux guest), nbcon + high loglevel.

Thank you for the heads up. I will report back with more results + findings
soon. The bug is just pretty tedious to reproduce.

> 
> Sebastian
> 

[0] https://azure.microsoft.com/en-us/pricing/purchase-options/azure-account?icid=virtual-machines
[1] https://lore.kernel.org/all/20230306163425.8324-1-jgross@suse.com/

-- 
Derek <debarbos@redhat.com>

