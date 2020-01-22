Return-Path: <SRS0=RBrU=3L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B56C32771
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jan 2020 21:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725C62465B
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jan 2020 21:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9lGQdwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAVVNe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:13:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725827AbgAVVNe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Jan 2020 16:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579727613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAFkHZvXgFbOOmInMzD/oyrNf29uWQKgC8OYdhvTl4w=;
        b=g9lGQdwgm/x1mfFpIsDrwwLXJQprbTKpcoQCKks6is30jZAesOw0gkrMHBhrT45oYzdztQ
        /jFsoadguRQWvTpzYC+ksaILLMrjh+WZ27mv+AjnasxIGyK6GggDM4VDh7LBHbYPgwtEGt
        m9rGj0vepF3ZQfHpeV/WPrTL8dLAwrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-zFjepyucMk2m4lwMXX13wA-1; Wed, 22 Jan 2020 16:13:29 -0500
X-MC-Unique: zFjepyucMk2m4lwMXX13wA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B17DDBAB;
        Wed, 22 Jan 2020 21:13:28 +0000 (UTC)
Received: from ovpn-120-231.rdu2.redhat.com (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E0691001B03;
        Wed, 22 Jan 2020 21:13:27 +0000 (UTC)
Message-ID: <801c5fbbd93e126b8eef7ab0e53550479059a34c.camel@redhat.com>
Subject: Re: [PATCH RT] sched: migrate_enable: Busy loop until the migration
 request is completed
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 22 Jan 2020 15:13:26 -0600
In-Reply-To: <20191213081428.mw6bqjg6m7djwhby@linutronix.de>
References: <20191212112717.2tzoqbe3xeknoyvs@linutronix.de>
         <30ab713901ef0e1f23c1ca387373788a4a73639f.camel@redhat.com>
         <20191213081428.mw6bqjg6m7djwhby@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2019-12-13 at 09:14 +0100, Sebastian Andrzej Siewior wrote:
> On 2019-12-13 00:44:22 [-0600], Scott Wood wrote:
> > > @@ -8239,7 +8239,10 @@ void migrate_enable(void)
> > >  		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
> > >  				    &arg, &work);
> > >  		__schedule(true);
> > > -		WARN_ON_ONCE(!arg.done && !work.disabled);
> > > +		if (!work.disabled) {
> > > +			while (!arg.done)
> > > +				cpu_relax();
> > > +		}
> >=20
> > We should enable preemption while spinning -- besides the general
> > badness
> > of spinning with it disabled, there could be deadlock scenarios if
> > multiple CPUs are spinning in such a loop.  Long term maybe have a wa=
y
> > to
> > dequeue the no-longer-needed work instead of waiting.
>=20
> Hmm. My plan was to use per-CPU memory and spin before the request is
> enqueued if the previous isn't done yet (which should not happen=E2=84=A2=
).

Either it can't happen (and thus no need to spin) or it can, and we need =
to
worry about deadlocks if we're spinning with preemption disabled.  In fac=
t a
deadlock is guaranteed if we're spinning with preemption disabled on the =
cpu
that's supposed to be running the stopper we're waiting on.

I think you're right that it can't happen though (as long as we queue it
before enabling preemption, the stopper will be runnable and nothing else
can run on the cpu before the queue gets drained), so we can just make it=
 a=20
warning.  I'm testing a patch now.

> Then we could remove __schedule() here and rely on preempt_enable()
> doing that.

We could do that regardless.

-Scott


