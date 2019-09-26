Return-Path: <SRS0=fYRI=XV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F04C4360C
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Sep 2019 16:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D1A222C7
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Sep 2019 16:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfIZQws (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14149 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZQws (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Sep 2019 12:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FFA6316E531;
        Thu, 26 Sep 2019 16:52:48 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E47F65C21F;
        Thu, 26 Sep 2019 16:52:42 +0000 (UTC)
Message-ID: <f3b31297df859eb7d1dc86637c29b271fbf87970.camel@redhat.com>
Subject: Re: [PATCH RT 4/8] sched: migrate disable: Protect cpus_ptr with
 lock
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Thu, 26 Sep 2019 11:52:42 -0500
In-Reply-To: <20190926163940.khzhsp3a4h7vj7lw@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
         <20190727055638.20443-5-swood@redhat.com>
         <20190926163940.khzhsp3a4h7vj7lw@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 26 Sep 2019 16:52:48 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2019-09-26 at 18:39 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-07-27 00:56:34 [-0500], Scott Wood wrote:
> > Various places assume that cpus_ptr is protected by rq/pi locks,
> > so don't change it before grabbing those locks.
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> 
> I applied now everything until here and you can take a look at
>   
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/log/?h=linux-5.2.y-rt-RC
> 
> If there are no objections then I would make this a -rt9 and then go
> further.
> 
> Sebastian

Looks good, thanks!

-Scott


