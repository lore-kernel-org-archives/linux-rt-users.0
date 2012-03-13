From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH RT] preempt: Define preempt_check_resched_rt() for non
 PREEMPT config
Date: Tue, 13 Mar 2012 14:32:42 +0100
Message-ID: <CAONaPpEFOrYFH9=HX+QUweGKqxXw2GUmj9+BAzwmxFtyJX=p+w@mail.gmail.com>
References: <1331607058.25686.660.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39043 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab2CMNco convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Mar 2012 09:32:44 -0400
In-Reply-To: <1331607058.25686.660.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 13, 2012 at 3:50 AM, Steven Rostedt <rostedt@goodmis.org> w=
rote:
>
> Fix compiler error when CONFIG_PREEMPT is not set.
>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 4125456..11412d7 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -95,6 +95,7 @@ do { \
> =A0#define preempt_enable_no_resched() =A0 =A0do { } while (0)
> =A0#define preempt_enable() =A0 =A0 =A0 =A0 =A0 =A0 =A0 do { } while =
(0)
> =A0#define preempt_check_resched() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do =
{ } while (0)
> +#define preempt_check_resched_rt() =A0 =A0 do { } while (0)
>
> =A0#define preempt_disable_notrace() =A0 =A0 =A0 =A0 =A0 =A0 =A0do { =
} while (0)
> =A0#define preempt_enable_no_resched_notrace() =A0 =A0do { } while (0=
)
>

This is the same patch I sent for v3.2.9-rt17. (where you complained
because I gave clark a SOB instead of a Tested-by:) I see that
#define preempt_check_resched()
without the _rt has been shuffled to a more logical spot which is the
only way I recognized that you mean this for v3.0.23-rt.

Could we please start to specify the rt-kernel version in these patches=
?

Thanks

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
