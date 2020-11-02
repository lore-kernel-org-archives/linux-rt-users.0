Return-Path: <SRS0=ditW=EI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4C1C00A89
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 16:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7826822258
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 16:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8MMb+sv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jaUDPVmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKBQeP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Nov 2020 11:34:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKBQeO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Nov 2020 11:34:14 -0500
Date:   Mon, 2 Nov 2020 17:34:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604334853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gz1LLGR+NSFeYv5NxVGQVIUHcU24Q6fUApbLfMryaG8=;
        b=y8MMb+sv9I6MVC+VnIQD57ke6Hw96iJwBoHdPUAdKuD4uwD3lfocmWi+Rlie595HwBwQE9
        hxSr+WUT2YbKIK2wrhmfD4pYXslbUthoMtGaUjxmSrcNCC5ezgdZ7zbO83u35q8/x8ItT5
        uFe6nuttocsBHlgLY7SPMFmfQmL8Pf0nOHi177Xn+OkA1WBSVjeAw6bhkFr5ZzLTUDsjXg
        gh3UvSflQ30+Whk7/CuCmsdrUOZZtwLGGJcrykNebd+VG9vNt7HE3Ha1yObqZosM1u6+4N
        WOt21hwrcK+emNsoAqPvEKbFjn+MHzI0wQIzB3MN6qPWpYdTuAg5Z1ASRF/QWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604334853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gz1LLGR+NSFeYv5NxVGQVIUHcU24Q6fUApbLfMryaG8=;
        b=jaUDPVmiabb4UCaSZ2ywlFSpqsqMVo6kh9c1UPr3cbFII93MVAbRmQzh8wKVPHKYnU9hle
        1+CtDn/lOIOrq1AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201102163411.izhdlegaifq544l2@linutronix.de>
References: <20201102155001.GA18313@redhat.com>
 <20201102162514.GA18631@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201102162514.GA18631@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-02 17:25:14 [+0100], Oleg Nesterov wrote:
> On 11/02, Oleg Nesterov wrote:
> >
> >  	spin_lock_irq(&task->sighand->siglock);
> > -	if (task->state =3D=3D __TASK_TRACED) {
> > -		if (__fatal_signal_pending(task))
> > -			wake_up_state(task, __TASK_TRACED);
> > -		else
> > -			task->state =3D TASK_TRACED;
> > -	}
> > +
> > +	raw_spin_lock(&task->pi_lock);
>=20
> but perhaps it should be raw_spin_lock_irq() ?
>=20
> I know nothing about kernel-rt, however it seems that spin_lock_irq()
> from include/linux/spinlock_rt.h doesn't disable irqs?

I don't exactly how much breaks when we turn siglock into a
raw_spinlock_t but there is a memory allocation in __send_signal() which
is a no no.

There is task_is_traced() which looks under the PI lock for the task
state to be sure (we a few of those). I haven't looked at the patch yet=E2=
=80=A6

> Oleg.

Sebastian
