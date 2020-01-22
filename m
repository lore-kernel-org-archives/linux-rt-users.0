Return-Path: <SRS0=RBrU=3L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF75C33CAF
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jan 2020 04:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54B72071E
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jan 2020 04:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8PpmlzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAVEiz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Jan 2020 23:38:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30140 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727141AbgAVEiz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Jan 2020 23:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579667931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aG38Vx1puBG+RPiJmI9NRh9p5smiSfqCNqvndnPKL64=;
        b=Y8PpmlzSdJmDSzY6Wkz0pPmGADr0luJ2gAugQ2EEBrXVdpFvIczzMAmJRGK6lecGkQiVrp
        uENQbBCZzc4CHZ0sKl797AR2a+bY5f8N7hoqBTZ33F9QKleEi6DcAV+GF6w6iMqpjr9jXl
        1SbFn4uBRzlCdsZYvXJy4MncBFasdXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-oQdvpv7CORedz9qJuBr6WA-1; Tue, 21 Jan 2020 23:38:45 -0500
X-MC-Unique: oQdvpv7CORedz9qJuBr6WA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E29F066F;
        Wed, 22 Jan 2020 04:38:43 +0000 (UTC)
Received: from ovpn-120-231.rdu2.redhat.com (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26DCA5C1BB;
        Wed, 22 Jan 2020 04:38:43 +0000 (UTC)
Message-ID: <c979dd686853ea85da887cb1796cb8220dd51d0f.camel@redhat.com>
Subject: Re: [PATCH RT] Revert "cpumask: Disable CONFIG_CPUMASK_OFFSTACK for
 RT"
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 21 Jan 2020 22:38:42 -0600
In-Reply-To: <20200119103400.3vj4dr4sr4hxyxus@linutronix.de>
References: <20191218174159.ndcvzgqxavpcb37c@linutronix.de>
         <f19f0181e819989b13dc3605c25b110aa2677189.camel@redhat.com>
         <20200119103400.3vj4dr4sr4hxyxus@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2020-01-19 at 11:34 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-01-19 02:03:23 [-0600], Scott Wood wrote:
> > I get splats with this due to zalloc_cpumask_var() with preemption
> > disabled
> > (from the get_cpu() in x86 flush_tlb_mm_range()):
> 
> Is 
> 	
> http://lkml.kernel.org/r/20200117090137.1205765-1-bigeasy@linutronix.de
> 
> solving the issue?
> 
> Sebastian
> 

Yes, looks good with those patches.

-Scott


