Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F8C43334
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Jul 2022 08:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiGYIPQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYIPO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jul 2022 04:15:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608D5109C
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jul 2022 01:15:13 -0700 (PDT)
Date:   Mon, 25 Jul 2022 10:15:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658736910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=57AkfEd7xAlGTly2G6cmJEDVRLWxM2maX+MseoqDR3U=;
        b=FgkUlT6n9taEdVroRPnPDhJBR6wKJM2n8FJlpY/jmI3i0qhH2gfwK7o7PcQn0BdSIYbus5
        cI/CpBrYdeV4XsHrJ7H27Kv4LpDMhzilTCv3jze5q4xIKMH7b7I+eiQppudfGhNaUbROZO
        NYTubYlU0isG8X3P/4tjv2aUROiLStsZN8wINqrIwmQugludRB34sni/7oisndOwiYDLt3
        IJdQILAyDmdN+Xy2ChCDvT3HJ4lQUYXmfWqZ4Y1q3NFBmKaBZXv4oQ/AfaH8A1xFZcRRgs
        uthXiyR9Pd2q7wXzBtfw/5Mpc3h6/znIPairBAEyLT8GE+aksNpNJvXIQ7oLyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658736910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=57AkfEd7xAlGTly2G6cmJEDVRLWxM2maX+MseoqDR3U=;
        b=zJ5+aRX22syp2HgkIPW9/oAXcDu4wW2IijGrcCPXDgngXUVleve50PoZnj7pWAs6N5J058
        X43d6L5N8k+rDHAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
Message-ID: <Yt5RDajSVTPqahV4@linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
 <YrV4795StT13AUC+@linutronix.de>
 <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
 <YrWPiwtk0kAWxXI9@linutronix.de>
 <87wnd616ds.fsf@jogness.linutronix.de>
 <87tu8a16bm.fsf@jogness.linutronix.de>
 <daf9b4678af9a121ba85f30b04f1335b44639433.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <daf9b4678af9a121ba85f30b04f1335b44639433.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-07-21 15:06:45 [+0200], Mike Galbraith wrote:
> That's in tip, but pulling my bandaid off...
> 
> [    3.903338] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [    3.903340] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 389, name: systemd-udevd
> [    3.903340] preempt_count: 0, expected: 0
> [    3.903341] RCU nest depth: 1, expected: 1
> [    3.903342] CPU: 0 PID: 389 Comm: systemd-udevd Tainted: G            E     5.19.0.g96ff3a1-tip-rt #8 3a0ec7519629dbce1c881d809a8600cfad8358ca
> [    3.903344] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [    3.903345] Call Trace:
> [    3.903346]  <TASK>
> [    3.903347]  dump_stack_lvl+0x44/0x5c
> [    3.903352]  ? migrate_disable+0x37/0xa0
> [    3.903354]  __might_resched+0x171/0x1c0
> [    3.903357]  rt_spin_lock+0x2d/0x70
> [    3.903361]  crng_make_state+0x80/0x1d0
> [    3.903364]  _get_random_bytes.part.15+0x4e/0x120
> [    3.903366]  ? nvkm_vmm_iter.constprop.11+0x311/0x860 [nouveau 9c7d46b64ad6b15f254390d4ef3bd03268a3030d]
> [    3.903449]  ? nvkm_vmm_sparse_unref_ptes+0x80/0x80 [nouveau 9c7d46b64ad6b15f254390d4ef3bd03268a3030d]
> [    3.903518]  ? gf100_vmm_pgt_sgl+0x230/0x230 [nouveau 9c7d46b64ad6b15f254390d4ef3bd03268a3030d]
> [    3.903588]  default_pointer+0x2a0/0x2d0
> [    3.903591]  vsnprintf+0x35e/0x4c0
> [    3.903593]  ? gf100_gr_object_new+0x2b/0x70 [nouveau 9c7d46b64ad6b15f254390d4ef3bd03268a3030d]
> [    3.903669]  va_format.isra.16+0x6e/0xa0
> [    3.903670]  vsnprintf+0x35e/0x4c0
> [    3.903673]  vprintk_store+0x140/0x540

I remember asking why it is needed to disable interrupts across
vsnprintf(). John, can I take this as-it or are you sending a new batch?

> Bandaid:
> 
> printk: fix RT vprintk_store() might sleep splat
> 
> RT can't call vsnprintf() with IRQs disabled, so disable migration
> and move the printk_enter_irqsave() call down to where it's needed.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  kernel/printk/printk.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2277,8 +2277,7 @@ int vprintk_store(int facility, int leve
>  	int ret = 0;
>  	u64 ts_nsec;
> 
> -	if (!printk_enter_irqsave(recursion_ptr, irqflags))
> -		return 0;
> +	migrate_disable();
> 
>  	/*
>  	 * Since the duration of printk() can vary depending on the message
> @@ -2313,6 +2312,11 @@ int vprintk_store(int facility, int leve
>  	if (dev_info)
>  		flags |= LOG_NEWLINE;
> 
> +	if (!printk_enter_irqsave(recursion_ptr, irqflags)) {
> +		migrate_enable();
> +		return 0;
> +	}
> +
>  	if (flags & LOG_CONT) {
>  		prb_rec_init_wr(&r, reserve_size);
>  		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
> @@ -2369,6 +2373,7 @@ int vprintk_store(int facility, int leve
>  	ret = text_len + trunc_msg_len;
>  out:
>  	printk_exit_irqrestore(recursion_ptr, irqflags);
> +	migrate_enable();
>  	return ret;
>  }
> 
Sebastian
