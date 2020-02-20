Return-Path: <SRS0=oqvG=4I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF94C11D0C
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A054920722
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 16:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cfa.harvard.edu header.i=@cfa.harvard.edu header.b="eaAQejrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgBTQ4g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:56:36 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42485 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgBTQ4g (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Feb 2020 11:56:36 -0500
Received: by mail-ot1-f54.google.com with SMTP id 66so4297341otd.9
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Feb 2020 08:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZAeJ3CnbnnxQVIi2p5EIYShoRY/eK5wbxa3LYOR1jps=;
        b=eaAQejrgpV0LK+sCybkI2p8qQ+2vbI9oONrA11dY2Klp/9Gx+tP4itDueMmS7wL3fA
         2tJ7n5ENFlBx7cgTUv0A2y/1H3ss5C9WAfigKbr0UO4ln0YKVfyu41yNAN87N2WFBRON
         f/4O35cF9ZhG7YEeamilwQhsqLAeXQjGNCjLU7ZuNZQkqA+QX5WIFCSMhXBi8cItADXe
         YJnMTJTy+lFbnu/JjMtxdDVIJGpYEg4jr19DTWZnHG5NJLweygGZeCsH0EjWpZ85oKPw
         mAMOpT/qxnkE3ifJIPj7APXgWodKCIF/EAnQKzopAnOZgzhUOfh3dN4ae0sJ4DGJ4Fst
         SBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZAeJ3CnbnnxQVIi2p5EIYShoRY/eK5wbxa3LYOR1jps=;
        b=MUk+cgMePbfJIZInn6PH+NXWpSoey1jore2tazTXKV1Xtc2Qwpg+pKRY4IXlHu7HGo
         wpfM5Cz+oSDXJeIQ9u2M179KYp0GxSUtRjShCwr7+N/M1Mc31jiZfArRcmBt29eoWpXG
         g4cJmEWcetMO/mFthfuj+4s5RZe0+qMrUlY/Z4BfHxLZyz/RW0UQHtXeGV/lyjo0+ndJ
         ndoAR8K9HIKk9+acsDCfV65oGgKQkRbCXCxC28QF2LZfuT0WaWDTUtTeq8U4SsdbEGHR
         m0FlSvHSJorFakZhJgSW/YDkICO9lPRlhllMm9wD2T+JnEIyl1UBsm54jnfQ+mvi5rW3
         zS2Q==
X-Gm-Message-State: APjAAAVxFsXaJH/C3NxbdgFkmrlWyAiRcwqH84ZiAsXJy1D71Oz2kQfI
        DbshSadUMjOmQZaO2t2dN4M8/4NbYGRUMAjdtuNSTdfJaqw=
X-Google-Smtp-Source: APXvYqyGzCdY+EOXFEKFH6BvmufRDcXV+Z5fbDDzAgmW3hjjXXjTM4vvr+CZFt2BhV75GDDfGLE5ut81/JRU1YPTHDU=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr23311505otm.247.1582217793978;
 Thu, 20 Feb 2020 08:56:33 -0800 (PST)
MIME-Version: 1.0
From:   "Kansky, Jan E." <jan.kansky@cfa.harvard.edu>
Date:   Thu, 20 Feb 2020 11:56:23 -0500
Message-ID: <CAGF5Q78rz5ULUgcH5Kv_GCLj+-aLfBaV9J0XGHKo6k+hvrjDiQ@mail.gmail.com>
Subject: Debugging unexpected latency on a new Xeon W C422 system
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Here is my new system:
Intel(R) Xeon(R) W-2123 CPU @ 3.60GHz
C422 chipset
Centos 8

I've compiled and built two versions of the realtime kernel to take
the place of the stock Centos kernel:
4.19.103-rt42
and
5.4.17-rt9

For both kernels, I run cyclictest:
./cyclictest -p 98 --smp -b 600  -f -m

The worst case latencies approach 2 milliseconds at times.

I have disabled SpeedStep in the BIOS.

I have also experimented with the following additional kernel boot
parameters for both kernels:
noibrs noibpb nospectre_v2 nospectre_v1 l1tf=off
nospec_store_bypass_disable no_stf_barrier mds=off mitigations=off
nosoftlockup intel_idle.max_cstate=0 mce=ignore_ce
processor.max_cstate=0

These parameters didn't solve the problem.

The trace results show that the unexpected large latency seems to
occur in the following ways:

llvmpipe-9436    3d...... 4901974us!: switch_fpu_return
<-prepare_exit_to_usermode
llvmpipe-9436    3d...... 4902845us : smp_apic_timer_interrupt
<-apic_timer_interrupt

or

    Xorg-8825    3....... 4905576us!: kfree <-__audit_syscall_exit
  <idle>-0       2d...1.. 4905876us : smp_apic_timer_interrupt
<-apic_timer_interrupt

or
  <idle>-0       2d...1.. 4905910us!: mwait_idle <-default_idle_call
  <idle>-0       0d...1.. 4906049us : smp_apic_timer_interrupt
<-apic_timer_interrupt

or

llvmpipe-9435    1d...... 4917323us!: rcu_irq_exit <-irq_exit
llvmpipe-9438    3d...... 4917845us : smp_apic_timer_interrupt
<-apic_timer_interrupt

I do see NMIs occurring on the system, although not all latency events
seem to correlate with an increment in the NMI counter in
/proc/interrupts.

I would greatly appreciate any advice on what I should do to trace the
problem with this new system.  I can send my .config files if needed.
CONFIG_PREEMPT_RT_FULL=y is set.

Thanks!
Jan
