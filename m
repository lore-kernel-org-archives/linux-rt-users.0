Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A3C77B75
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 May 2023 08:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjEQIyT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 May 2023 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjEQIyS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 May 2023 04:54:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1F630ED
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 01:54:16 -0700 (PDT)
Date:   Wed, 17 May 2023 10:54:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684313654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0H7lsaht6LbJtO6oBZ3bbg0KIxGeLtdaYpt9qbagb8=;
        b=MsJnrepu/HIgNAhxM3T5RNaPsEjTb8F71pZZO1ADlQbL+U635tUN4AH4/50ZRA3UivSAsR
        tQbwazSuIUHAuhSikxWp9DUvEHUHmEIwGozsmgU9FMgzLELpltugLGa+ERDh/jdgNuOgCy
        j7DfchCZIWl9r1hmA5JkMx9K2L8YLEZv/g7FA6prgNI1B2TdzI0UlQiZX4lyG1VIaWF7zC
        8NveGU9U49iYjkMPZesQlT9QJzKiEeqVR8mz0lT11//qbidlH5JyTjXW9q2bwT/cApwR/L
        2i4X3KgbionEbSpqZNTNcxVKIh71SUsuhfQVvPdRjFs6wql5QmSmmbj+mHMPbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684313654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0H7lsaht6LbJtO6oBZ3bbg0KIxGeLtdaYpt9qbagb8=;
        b=1yfEoLNo6s+MGVpzcwxS3ddLSzZOO+t89luiUTsI/Q/PO2W+yrOckN2d549A1m9qP5XaHv
        WVGx/hI+xbB+PdDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
Message-ID: <20230517085411.eTVSySWx@linutronix.de>
References: <202305142217.46875.pisa@cmp.felk.cvut.cz>
 <20230516163352.jaNEyMPF@linutronix.de>
 <CAMj1kXHs0-sxieh_9235Y+QEUzftvPCJLp37Qp3vKXKmO1i=zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMj1kXHs0-sxieh_9235Y+QEUzftvPCJLp37Qp3vKXKmO1i=zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-05-16 19:13:26 [+0200], Ard Biesheuvel wrote:
> On Tue, 16 May 2023 at 18:33, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > + ard, peterz
>=20
> Hello Sebastian,
Hi Ard,

> Please check whether 6.4-rc2 is equally affected - we fixed some
> issues related to BH en/disabling from asm code.

oh oh Ard, you are the best. Thank you.

=E2=80=A6
> Please take a look, and confirm whether or not we still need to drop
> the get_cpu() call from vfp_sync_hwstate()

Yes, it needs to be dealt with. At the time vfp_sync_hwstate() the
context is fully preemptible. So that get_cpu() needs to be removed
before local_bh_disable(). But=E2=80=A6

If I understand the logic right, then the VFP state is saved on context
switch and the FPU access is disabled but the content remains and is in
sync with vfp_current_hw_state. Upon first usage (after the context
switch) in userland there is an exception at which point the access to
the FPU is enabled (FPEXC_EX) and the FPU content is loaded unless it is
in sync as per vfp_current_hw_state.

That means it relies on disabled preemption while operating on
vfp_current_hw_state. On PREEMPT_RT softirqs are only handled in process
context (for instance at the end of the threaded interrupt). Therefore
it is sufficient to disable preemption instead of BH. It would need
something like x86's fpregs_lock().
Otherwise vfp_entry() can get preempted after decisions based on
vfp_current_hw_state have been made. Also kernel_neon_begin() could get
preempted after enabling FPU. I think based on current logic, after
kernel_neon_begin() a task can get preempted on PREEMPT_RT and since
vfp_current_hw_state is NULL the registers won't be saved and a zero set
of registers will be loaded once the neon task gets back on the CPU (it
seems that VFP exceptions in kernel mode are treated the same way as
those in user mode).

What do you think?

> Thanks,
> Ard.

Sebastian
