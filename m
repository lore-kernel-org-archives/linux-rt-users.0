From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH-RT] preempt.h: Fix implicit declaration of
 'preempt_check_resched_rt'
Date: Thu, 08 Mar 2012 15:34:25 -0500
Message-ID: <1331238865.25686.474.camel@gandalf.stny.rr.com>
References: <1331237591-4406-1-git-send-email-jkacur@redhat.com>
	 <1331237840.25686.470.camel@gandalf.stny.rr.com>
	 <20120308142257.145e0968@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:31292 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab2CHUe0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Mar 2012 15:34:26 -0500
In-Reply-To: <20120308142257.145e0968@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-03-08 at 14:22 -0600, Clark Williams wrote:
> On Thu, 08 Mar 2012 15:17:20 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> > On Thu, 2012-03-08 at 21:13 +0100, John Kacur wrote:
> > > When building a non-preempt kernel where CONFIG_PREEMPT_COUNT is =
not
> > > defined the following build break occurs.
> > >=20
> > > /home/jkacur/linux-rt/block/blk-softirq.c: In function =E2=80=98t=
rigger_softirq=E2=80=99:
> > > /home/jkacur/linux-rt/block/blk-softirq.c:54: error: implicit dec=
laration of function =E2=80=98preempt_check_resched_rt=E2=80=99
> > > make[2]: *** [block/blk-softirq.o] Error 1
> > > make[1]: *** [block/blk-softirq.o] Error 2
> > > make: *** [sub-make] Error 2
> > >=20
> > > This patch fixes the build error by adding a define to the
> > > !CONFIG_PREEMPT_COUNT section.
> > >=20
> > > Signed-off-by: Clark Williams <williams@redhat.com>
> >=20
> > Why Clark's SOB? Did he write it and send it to you?
>=20
> I suppose to be technically correct it should have been a Tested-by:
>=20
> John found it while I was working on it and I tested it for him.

Either a "Reported-by" if you mentioned it to John and he fixed it, or =
a
"Tested-by" if he fixed it and you tested it. You can have both if that
is true too.

But "Signed-off-by" has supposed legal significance. It means that you
are responsible for this patch. Either you authored it, or it went
through you to get to the git repo (ie. you are the maintainer that too=
k
the patch).

All other tags are FYI only. Only the SOB is required and has real
meaning. Also, you should *never* add a SOB to a patch without the
person explicitly giving it to you.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
