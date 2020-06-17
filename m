Return-Path: <SRS0=83CY=76=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D3EC433DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 11:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5FB20CC7
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 11:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeMSlcVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFQLMm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:12:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57100 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgFQLMm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jun 2020 07:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592392361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1dVj8I9a65xBLj259xh4rs3uh9pBlFndgvotOH6f5zo=;
        b=DeMSlcVIcrCcUM1hi6buwHunwHvSHr8CpT848eZUiUNbQNmPituw5Jt8lRdbyK3jWXcxDt
        oKV2I5DcfHalpv1XZnaZttI/0tTAKpFsUcawRcWzvsZxe1cij9hEicRTz0CeexrohTNmZw
        bQBxTPqMRckPcMpqvV+/RN1oZr1QZ28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-3Tkh9aVBOOORA40r7OSNxA-1; Wed, 17 Jun 2020 07:12:37 -0400
X-MC-Unique: 3Tkh9aVBOOORA40r7OSNxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DF15100961C;
        Wed, 17 Jun 2020 11:12:36 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62E0678EE1;
        Wed, 17 Jun 2020 11:12:33 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C96C341887FC; Wed, 17 Jun 2020 07:12:12 -0300 (-03)
Date:   Wed, 17 Jun 2020 07:12:12 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 2/2] mm: page_alloc: drain pages remotely
Message-ID: <20200617101212.GB392445@fuller.cnet>
References: <20200616161149.392213902@fuller.cnet>
 <20200616161409.299575008@fuller.cnet>
 <20200616163248.z5bdrx7gj2sf7d3m@linutronix.de>
 <20200616170425.GA324900@fuller.cnet>
 <20200617074617.p4m5l5uu5urmagsc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617074617.p4m5l5uu5urmagsc@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jun 17, 2020 at 09:46:17AM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-16 14:04:25 [-0300], Marcelo Tosatti wrote:
> > It is affected. The workqueue thread for a given CPU is SCHED_OTHER, which can't
> > interrupt a SCHED_FIFO task which does not sleep.
> 
> Okay. So it is a problem which exists independently of -RT.
> As I pointed out to Juri, vmstat_update() should have the very same
> problem, correct?

Yes.

