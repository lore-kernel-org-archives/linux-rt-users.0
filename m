Return-Path: <SRS0=srch=2A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D592FC2BD09
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Dec 2019 00:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6762077B
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Dec 2019 00:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frf8yQ67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLJAkn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:40:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41658 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727213AbfLJAkn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Dec 2019 19:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575938441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/YzsUey/QUfeMhkR+4E7rM31vqJRlot5SdRo7HQJhY=;
        b=frf8yQ67QNJWIlop1dePY+C4foMm5G99rxHV0LOTxLv3AvDk1PAffdmIw2n2SSwM+8nYGY
        WmG+p3kgHy+SWckG9i2XmhRyLiVss60vbhR2u7bNH8qWb9awxmX7kWCOty8NpiSTvUdXxW
        j0e/qNx/+i9ziWXjDlACk5b74QyDntg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-7IqqN94HOg2uNaDYqOTvMg-1; Mon, 09 Dec 2019 19:40:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 022DC10054E3;
        Tue, 10 Dec 2019 00:40:38 +0000 (UTC)
Received: from ovpn-116-192.phx2.redhat.com (ovpn-116-192.phx2.redhat.com [10.3.116.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 971205C219;
        Tue, 10 Dec 2019 00:40:37 +0000 (UTC)
Message-ID: <1db9c7c960570e975ac0d684d6313ca35a3b1450.camel@redhat.com>
Subject: Re: [PATCH] lib: Check for migrate_disable only on SMP systems
From:   Scott Wood <swood@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon, 09 Dec 2019 18:40:37 -0600
In-Reply-To: <20191209100447.codml4nop4ibbjkz@beryllium.lan>
References: <20191206142103.29647-1-dwagner@suse.de>
         <4513f4a584586a4c17ef14f7365f6275042c3071.camel@redhat.com>
         <20191206193954.yi5hac366agt7k3o@beryllium.lan>
         <3ce4699f987e784e84b2030aa3a1c529b274b498.camel@redhat.com>
         <20191209100447.codml4nop4ibbjkz@beryllium.lan>
Organization: Red Hat
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 7IqqN94HOg2uNaDYqOTvMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2019-12-09 at 11:04 +0100, Daniel Wagner wrote:
> Hi Scott,
> 
> On Fri, Dec 06, 2019 at 09:21:36PM -0600, Scott Wood wrote:
> > On Fri, 2019-12-06 at 20:39 +0100, Daniel Wagner wrote:
> > > On Fri, Dec 06, 2019 at 12:49:12PM -0600, Scott Wood wrote:
> > > > On Fri, 2019-12-06 at 15:21 +0100, Daniel Wagner wrote:
> > > > Won't this give false positives on UP with CONFIG_PREEMPT_RT_BASE
> > > > and
> > > > CONFIG_DEBUG_PREEMPT? If we have CONFIG_SCHED_DEBUG then we can
> > > > still
> > > > check migrate_disable.
> > > 
> > > Ohhh, I see what you mean. I didn't realize that migrate_disable is
> > > also available with CONFIG_SCHED_DEBUG. So the ifdef should be
> > > something like:
> > > 
> > > #if defined(CONFIG_PREEMP_RT_BASE) && \
> > >     (defined(CONFIG_SMP) || \
> > >       (!defined(CONFIG_SMP) && defined(CONFIG_SCHED_DEBUG)))
> > 
> > That would still leave the issue with false positives if you have
> > CONFIG_DEBUG_PREEMPT but not CONFIG_SCHED_DEBUG (which should be the
> > only
> > config currently experiencing build problems).

Actually it looks like we're saved from the false positives by the
following check for nr_cpus_allowed == 1, which should always be true on
UP.

If we want this check to be effective on UP we'd need some way to keep
track of whether a thread is forced by the kernel to be bound to one CPU,
rather than whether it just happens to have only one CPU in the mask. 
Barring that, we should just stub out check_preemption_disabled() as a
whole on UP.

> I didn't realize that smp_processor_id.c is only build with
> CONFIG_DEBUG_PREEMPT. It should be enough to add
> 
> 	#if defined(CONFIG_SCHED_DEBUG)
> 
> Did I get it finally correct? :)

No, then we *would* get those false positives on SMP without
CONFIG_SCHED_DEBUG, and it wouldn't build without CONFIG_PREEMPT_RT_BASE.

-Scott

