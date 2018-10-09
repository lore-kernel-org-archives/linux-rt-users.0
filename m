Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.efficios.com ([167.114.142.138]:40076 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIWoz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Oct 2018 18:44:55 -0400
Date: Tue, 9 Oct 2018 11:27:23 -0400
From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: __migrate_disabled symbol not exported for rt kernel > 4.9
Message-ID: <20181009152723.GA7665@joraj-alpa>
References: <20180918205514.GB31793@joraj-alpa>
 <20181005142325.bltjehfbffvnhkam@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181005142325.bltjehfbffvnhkam@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, skrishnakar@gmail.com

Hi,

On Fri, Oct 05, 2018 at 04:23:25PM +0200, Sebastian Andrzej Siewior wrote=
:
> > It looks like __migrate_disabled was moved from linux/include/sched.h=
 to
> > linux/include/preempt.h. No problem there but for a configuration the
> > inline function was transformed into a function declaration. The symb=
ol for
> > that function is not currently exported (EXPORT_SYMBOL*).
> >=20
> > Should __migrate_disabled be exported when defined in kernel/sched/co=
re.c?
>=20
> If you need it, I guess so. In order to inline it again, it should be
> moved back to sched.h=E2=80=A6

The inline nature of it, for us, is less pertinent, the symbol presence i=
s more
important.

>=20
> > And for personal knowledge:
> >=20
> > What is the reason for not using an inline function for the (CONFIG_S=
MP)
> > && (CONFIG_PREEMPT_RT_BASE) configuration?
>=20
> we should not include sched.h (for struct task_struct) into preempt.h
>=20
> > The commit message introducing __migrate_disabled does not give much =
information
> > regarding why it is done differently compared to 4.9-rt kernels.
> >=20
> > We will probably end up accessing the migrate_disabled field directly=
 since we
> > need to support those kernel versions somehow.
>=20
> Do you want a EXPORT_SYMBOL_GPL for that or are you good?

Yes EXPORT_SYMBOL_GPL would do the trick.

Thanks

--=20
Jonathan Rajotte-Julien
EfficiOS
