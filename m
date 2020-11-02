Return-Path: <SRS0=ditW=EI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAF2C00A89
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2D021D40
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWQZZb6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgKBRli (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:41:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725841AbgKBRli (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Nov 2020 12:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604338897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mhrzmc9yS0z2mEBD/zFuKx1y0EvDz/pF0atFM9UnL30=;
        b=CWQZZb6eJMGBeHP+edpjM1EJyU0NovlnGh/+6VXD+CRfncqvJ36PoD1NqUk6S3uWZ135Re
        oRepFhPUz+NeiNeJ3DVPF8rzoFVDPciYbcl5bOJ62yV3I1ovfE2L8yTtxp0DJX5NtwsA0N
        ZXMTo1ZLyZF4Ly+Wpkg63yUnzSGgdRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-y86MxTfeP4iAGIsU2SQKGQ-1; Mon, 02 Nov 2020 12:41:35 -0500
X-MC-Unique: y86MxTfeP4iAGIsU2SQKGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18A711015C9B;
        Mon,  2 Nov 2020 17:41:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1FFC65B4A9;
        Mon,  2 Nov 2020 17:41:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  2 Nov 2020 18:41:33 +0100 (CET)
Date:   Mon, 2 Nov 2020 18:41:31 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201102174130.GA18984@redhat.com>
References: <20201102155001.GA18313@redhat.com>
 <20201102162514.GA18631@redhat.com>
 <20201102163411.izhdlegaifq544l2@linutronix.de>
 <20201102170132.GA32111@redhat.com>
 <20201102173059.ib4au7ia5vyynn6l@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102173059.ib4au7ia5vyynn6l@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sorry, I don't understand. If it was not clear, let me repeat that I know
nothing about kernel-rt.

On 11/02, Sebastian Andrzej Siewior wrote:
> On 2020-11-02 18:01:33 [+0100], Oleg Nesterov wrote:
>
> > So it seems I should send V2 which uses raw_spin_(un)lock_irq().
> >
> > Or even _irqsave() like ptrace_freeze_traced() does? Although this looks
> > confusing, exactly because ptrace_freeze_traced() calls task_is_traced()
> > which does raw_spin_lock_irq().
>
> Urgh. Judging from
>  release_task()
>  -> write_lock_irq(&tasklist_lock);
>  -> ptrace_release_task();
>     -> ptrace_unlink();
>        -> __ptrace_unlink();
>          -> task_is_traced().
>
> it will break on !RT so irqsave is indeed needed.

Why?

task_is_traced() does raw_spin_lock_irq() under ifdef(CONFIG_PREEMPT_RT).

Oleg.

