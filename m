From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH-RT] preempt.h: Fix implicit declaration of
 'preempt_check_resched_rt'
Date: Tue, 13 Mar 2012 15:24:11 -0400
Message-ID: <1331666651.25686.665.camel@gandalf.stny.rr.com>
References: <1331237591-4406-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:10177 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758884Ab2CMTYO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Mar 2012 15:24:14 -0400
In-Reply-To: <1331237591-4406-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

Can you apply this patch (with the fixed "tested-by") and push out a ne=
w
3.2-rt?

This bug is causing one of my "stable tests" to fail, and I wont push
out a new stable test until it passes. But I also wont add a fix that i=
s
not in your tree. This means that 3.0-rt is being held back until this
gets applied.

Thanks,

-- Steve


On Thu, 2012-03-08 at 21:13 +0100, John Kacur wrote:
> When building a non-preempt kernel where CONFIG_PREEMPT_COUNT is not
> defined the following build break occurs.
>=20
> /home/jkacur/linux-rt/block/blk-softirq.c: In function =E2=80=98trigg=
er_softirq=E2=80=99:
> /home/jkacur/linux-rt/block/blk-softirq.c:54: error: implicit declara=
tion of function =E2=80=98preempt_check_resched_rt=E2=80=99
> make[2]: *** [block/blk-softirq.o] Error 1
> make[1]: *** [block/blk-softirq.o] Error 2
> make: *** [sub-make] Error 2
>=20
> This patch fixes the build error by adding a define to the
> !CONFIG_PREEMPT_COUNT section.
>=20
> Signed-off-by: Clark Williams <williams@redhat.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  include/linux/preempt.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index fa40695..58d8982 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -107,6 +107,7 @@ do { \
>  #define preempt_disable_notrace()		do { } while (0)
>  #define preempt_enable_no_resched_notrace()	do { } while (0)
>  #define preempt_enable_notrace()		do { } while (0)
> +#define preempt_check_resched_rt()	do { } while (0)
> =20
>  #endif /* CONFIG_PREEMPT_COUNT */
> =20


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
