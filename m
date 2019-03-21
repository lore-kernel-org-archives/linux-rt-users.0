Return-Path: <SRS0=LpNT=RY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AC4C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Mar 2019 21:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05B721916
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Mar 2019 21:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dg9wRkAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCUVqT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:46:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCUVqT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Mar 2019 17:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=35ds/feV4RRRq7lM+jr3+41UG3D+jiIiVEdpwKqgndw=; b=dg9wRkAjynL6K2TUTfGm+YYEG
        +tpryCag15dVV2bfwRnUpqosxOWLRNf80zXrqwzV/VDeW8bFmTRld2S1pMEbcNAfb9/8phgPvYxPL
        +uhTlDBYQDaOSzgEJTFlDYc1JGVRzDoIQ4F70eTgGfFB0ketClDdNsfhKg3ceIpxgZVrwnvem6Iiw
        D/kqZLdowYPgVFDXAV53r3i0ytmk7ziW5AoZm25689zK0OySfYs71Wa9ZkGZXjirb7PQnXRQYl/HS
        2Sq7XibLSFibG57zBH3kETP6nfPOAfu7okr+eemyAYO/H10gxL89tfS/w0mPlV5Nu1mdrxrYP+FiA
        TfZu+BYeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h75Vs-0004Vc-89; Thu, 21 Mar 2019 21:46:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED1E2984EEA; Thu, 21 Mar 2019 22:46:08 +0100 (CET)
Date:   Thu, 21 Mar 2019 22:46:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        =?iso-8859-1?Q?R=F4mulo?= Silva de Oliveira 
        <romulo.deoliveira@ufsc.br>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG-RT: scheduling while in atomic in the watchdog's hrtimer
Message-ID: <20190321214608.GE7905@worktop.programming.kicks-ass.net>
References: <d2eb047a-6c07-e176-aa2a-68a425efd0ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2eb047a-6c07-e176-aa2a-68a425efd0ae@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Mar 21, 2019 at 10:27:30PM +0100, Daniel Bristot de Oliveira wrote:
> Hi,
> 
> In the 4.19/5.0-rt configured !SMP, the following chain of events can
> take place:
> 
> ------------------------------ %< -------------------------------------
> smp_apic_timer_interrupt(){
> 	hrtimer_interrupt() {
> 		__hrtimer_run_queues() {
> 			watchdog_timer_fn() {
> 				stop_one_cpu_nowait() {
> 					#ifdef !CONFIG_SMP

ARGGHH..
