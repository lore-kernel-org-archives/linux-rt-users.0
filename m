Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606B0C38BF9
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 22:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316E6218AC
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 22:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6SIpBLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgBXWQD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:16:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21661 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgBXWQD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 17:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582582562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNSD66ImMoPsjxgik/kryHw2+qoaM+eMsRblP5sq1ko=;
        b=Q6SIpBLMhyaRHyfEj/r2uUb7ZLrmPCsvQA9MgfjwhFai7t22B+v8UR7rnCBmjJFivgJaI9
        /mszhL+yNZi14GV0hFM5UtJ6wCXQT8Q4q3hn9X5s9IBCmD4zAmqHFLTFDL35rdEmCqRr/o
        jRWQHRPDLwgY5PhRPcZMb/tk0ttz1V0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-laDNQN88PKGHPbLLdvhBnQ-1; Mon, 24 Feb 2020 17:15:54 -0500
X-MC-Unique: laDNQN88PKGHPbLLdvhBnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B14E100DFC7;
        Mon, 24 Feb 2020 22:15:52 +0000 (UTC)
Received: from ovpn-118-56.phx2.redhat.com (ovpn-118-56.phx2.redhat.com [10.3.118.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4687393;
        Mon, 24 Feb 2020 22:15:50 +0000 (UTC)
Message-ID: <4f7ecfa4034463892e2d211d3cba2b9c8f6449c7.camel@redhat.com>
Subject: Re: [PATCH RT 15/25] sched: migrate_enable: Use select_fallback_rq()
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Date:   Mon, 24 Feb 2020 16:15:49 -0600
In-Reply-To: <20200224160529.f5lg44gyk2mgayd4@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
         <eb183ce95bb3d92b426bdadf36f0648cda474379.1582320278.git.zanussi@kernel.org>
         <20200224094349.5x6dca4tggtmmbnq@linutronix.de>
         <1582558266.12738.32.camel@kernel.org>
         <20200224160529.f5lg44gyk2mgayd4@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-02-24 at 17:05 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-02-24 09:31:06 [-0600], Tom Zanussi wrote:
> > On Mon, 2020-02-24 at 10:43 +0100, Sebastian Andrzej Siewior wrote:
> > > On 2020-02-21 15:24:43 [-0600], zanussi@kernel.org wrote:
> > > > From: Scott Wood <swood@redhat.com>
> > > > 
> > > > v4.14.170-rt75-rc1 stable review patch.
> > > > If anyone has any objections, please let me know.
> > > 
> > > This creates bug which is stuffed later via
> > > 	sched: migrate_enable: Busy loop until the migration request is
> > > completed
> > > 
> > > So if apply this, please take the bug fix, too. This is Stevens queue
> > > for reference:
> > > > [PATCH RT 22/30] sched: migrate_enable: Use select_fallback_rq()
> > > 
> > > ^^ bug introduced
> > > 
> > 
> > Hmm, it seemed from the comment on the 4.19 series that it was '24/32
> > sched: migrate_enable: Use stop_one_cpu_nowait()' that required 'sched:
> > migrate_enable: Busy loop until the migration request is
> > completed' as a bug fix.
> > 
> >   
> > https://lore.kernel.org/linux-rt-users/20200122083130.kuu3yppckhyjrr4u@linutronix.de/#t
> > 
> > I didn't take the stop_one_cpu_nowait() one, so didn't take the busy
> > loop one either.
> 
> Ach, it was the different WARN_ON() then. So this might not introduce
> any bug then. *Might*. 
> Steven backported the whole pile and you took just this one patch. The
> whole set was tested in devel and uncovered a problem which was fixed
> later. Taking only a part *may* expose other problems it *may* be fine.

Taking up to this patch should be OK (well, you still have the 
current->state clobbering, but it shouldn't introduce any new known bugs). 
The busy loop patch itself has a followup fix though (in theory the busy
loop could deadlock): 2dcd94b443c5dcbc ("sched: migrate_enable: Use per-cpu
cpu_stop_work") which should be considered for v4.19 rt stable which has the
busy loop patch.

-Scott


