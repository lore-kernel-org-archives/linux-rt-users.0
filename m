Return-Path: <SRS0=B5od=6O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E84C83000
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 01:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E49020787
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 01:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQfjbyvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgD3Bgp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:36:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgD3Bgo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Apr 2020 21:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588210603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1gZzSto7hNc0Fves2SwneJoXyyNd5NhhVuof1lvKH8=;
        b=MQfjbyvF+ToD11IW0NjmQbhLXaRCZhT+3ILdJDGU3gmHmj4+R7FH7vIE7gQsAZgndeIFhu
        DOU5QEEpeQImL2E+lS/l667oov8lCylhRw+qhIYwKQStEDLmbQHh+gM7KFAalLf13+mKMl
        633IMG2Bz3Tov+vB6FGwbku+sL6DNMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-f8b3uKY-OWu0GYdxOfHhfw-1; Wed, 29 Apr 2020 21:36:41 -0400
X-MC-Unique: f8b3uKY-OWu0GYdxOfHhfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 501471005510;
        Thu, 30 Apr 2020 01:36:40 +0000 (UTC)
Received: from ovpn-112-24.phx2.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC481002388;
        Thu, 30 Apr 2020 01:36:39 +0000 (UTC)
Message-ID: <76ad9ab3684bacb2c8458678ef07b6a574384445.camel@redhat.com>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
From:   Scott Wood <swood@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Wed, 29 Apr 2020 20:36:38 -0500
In-Reply-To: <CAKfTPtBsfneVVdT5UhtysUGACqPp7YUGKzSTKu4D8UYKwDbykg@mail.gmail.com>
References: <20200428050242.17717-1-swood@redhat.com>
         <20200428050242.17717-2-swood@redhat.com>
         <CAKfTPtBsfneVVdT5UhtysUGACqPp7YUGKzSTKu4D8UYKwDbykg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-04-29 at 10:27 +0200, Vincent Guittot wrote:
> On Tue, 28 Apr 2020 at 07:02, Scott Wood <swood@redhat.com> wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..74c3c5280d6b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6758,8 +6758,6 @@ balance_fair(struct rq *rq, struct task_struct
> > *prev, struct rq_flags *rf)
> >  {
> >         if (rq->nr_running)
> >                 return 1;
> > -
> > -       return newidle_balance(rq, rf) != 0;
> 
> Missing return ?

Yes, editing error during last minute cleanup. :-P

-Scott


