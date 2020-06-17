Return-Path: <SRS0=83CY=76=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438FCC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 11:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18541208B3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 11:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5IpYY4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgFQLMn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:12:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbgFQLMn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jun 2020 07:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592392362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2z181TXc64M8Yu7vmLA4Y8zzduJjQblot9d2VpO3nY=;
        b=b5IpYY4UQ5AZ58t8qcanOqyO/QtFG7E/3zweXg897CMQPpNy4BKw2aYO3JsKWgZXnbaeh0
        aFyClIY5lzBF0XvKG2T+AToSZNY09NNtX3CQu3HHpb+53LFx4P9uelCyF8ElG6/d+39WqU
        +ifcYvYkV857t4es6jq/buxbioqhKAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-C58wLiWHO6qhnpP0zMKHWQ-1; Wed, 17 Jun 2020 07:12:37 -0400
X-MC-Unique: C58wLiWHO6qhnpP0zMKHWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5252918A0762;
        Wed, 17 Jun 2020 11:12:36 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 630D660BF4;
        Wed, 17 Jun 2020 11:12:33 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 78DED416F5D2; Wed, 17 Jun 2020 07:11:36 -0300 (-03)
Date:   Wed, 17 Jun 2020 07:11:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 2/2] mm: page_alloc: drain pages remotely
Message-ID: <20200617101136.GA392445@fuller.cnet>
References: <20200616161149.392213902@fuller.cnet>
 <20200616161409.299575008@fuller.cnet>
 <20200616163248.z5bdrx7gj2sf7d3m@linutronix.de>
 <20200616165536.GA306273@fuller.cnet>
 <20200617074223.wtd5lsxbpvqvbxs7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617074223.wtd5lsxbpvqvbxs7@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jun 17, 2020 at 09:42:23AM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-16 13:55:36 [-0300], Marcelo Tosatti wrote:
> > > We had this
> > >   https://lore.kernel.org/linux-mm/20190424111208.24459-1-bigeasy@linutronix.de/
> > 
> > Will reply to that thread. Do you want to refresh/resend that patchset or
> > should I?
> 
> I don't plan to refresh/resend it because what we have now with local-locks
> in v5.8-rc1 works for RT.

If your application busy-spins with DPDK (such as FlexRAN does):

https://www.slideshare.net/LuminaNetworks/osn-bay-area-feb-2019-meetup-intel-5g-flexran-solution-131647692

Then v5.8-rc1 does not work, right? (remote pagevec locking + remote
draining would be necessary).

> I dropped that from RT in v5.4.26-rt17 so the previous release should have
> the last version of this. Please be aware that Joe Korty reported that
> this patch somehow breaks a workload for him. The report never made it
> to the list but he confirmed in
>    https://lkml.kernel.org/r/20200330154110.GA2975@zipoli.concurrent-rt.com

OK, will see if i can reproduce it and assist in the pagevec locking
upstreaming effort.

Thanks!

> 
> that is problem is gone with the removal of the patch.
> 
> Sebastian

