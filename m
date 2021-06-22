Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEEDC2B9F4
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Jun 2021 13:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9129610C7
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Jun 2021 13:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFVNqv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 09:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhFVNqn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Jun 2021 09:46:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF67C061574;
        Tue, 22 Jun 2021 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3H00gnKd4aNoDsEENeDEJQeV+mVhwSX4UIb1VZLCQi0=; b=JRs4YOFpHY1YWpIp+4Vnp7BfH1
        Vo7WpAZpqicWzSGYzXna31nBZdnou0FHQo3cS7qrqrmc16nQlvg+K9UW879O7RlIAe6iuBaO6VpRw
        Slo+yVM974Af063gpQ12zxmBp82nzRk0NK49AJ4AUY8RnUCoxCfa5DU9AyaX2PKNsHoV+RF9vyJus
        DoSf9bA8LFAOeMMvrbOf5elenpwZPwsSFgcRaaVW5uRJY03aNI+/A5Mc8v8pv3Fe3JR3teaQ1c7UI
        2wIcU1BjxUqgBXPaMI1kll96nFXQwxrwBzEMi57THg+k84jBDgHMqr9KcjXtu6hwUTdk5+Mw/wnGg
        BCJvmzlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvghN-00Abzm-1V; Tue, 22 Jun 2021 13:44:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 377B8300223;
        Tue, 22 Jun 2021 15:44:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A15220C169E1; Tue, 22 Jun 2021 15:44:23 +0200 (CEST)
Date:   Tue, 22 Jun 2021 15:44:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC 2/2] timers: Make sure irq_work is handled when no pending
 timers
Message-ID: <YNHpN1h5hEZdt+Au@hirez.programming.kicks-ass.net>
References: <20210610125945.558872-1-nsaenzju@redhat.com>
 <20210610125945.558872-2-nsaenzju@redhat.com>
 <87mtrmeqon.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtrmeqon.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Jun 19, 2021 at 12:47:04AM +0200, Thomas Gleixner wrote:
> There are two solutions:
> 
>   1) Create a IRQ_WORK softirq and raise that
> 
>   2) Simply delegate it to a workqueue

IIRC someone was looking to stick the whole thing in a kthread_worker.
Jiri, was that you?
