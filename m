From: Tobias Knutsson <tobias.knutsson@gmail.com>
Subject: Re: Difference between chrt and nice
Date: Tue, 31 Mar 2009 08:07:47 +0200
Message-ID: <ccb913ac0903302307x3e55035agac5d60992c3b5248@mail.gmail.com>
References: <901f25b80903302243q5ae531fs92113638539ea557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Jaakko Sipari <jaakko.sipari@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:59208 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756750AbZCaGHt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Mar 2009 02:07:49 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2996417wff.4
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2009 23:07:47 -0700 (PDT)
In-Reply-To: <901f25b80903302243q5ae531fs92113638539ea557@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Jaakko,

I'm relatively new in this field so take this information will a grain =
of salt.

=46rom what i understand, the nice command will only change the priorit=
y
within the SCHED_OTHER scheduling policy. It is not possible to assign
the process to another policy such as SCHED_RR or SCHED_FIFO, which
would have precedence over all SCHED_OTHER processes. This can be done
with chrt.

Both of these commands should work both with a vanilla and an rt
kernel. The result will be different however. Since the locking
mechanisms in the rt kernel are much more sophisticated, it will be
able to provide much more deterministic latencies to the processes
assigned to the processes assigned to the realtime scheduling policies
(round robin and fifo).

//Tobbe

On Tue, Mar 31, 2009 at 07:43, Jaakko Sipari <jaakko.sipari@gmail.com> =
wrote:
> Hi!
>
> I've already asked this in a couple of forums but got no answers. I
> would appreciate it if someone in this list could take some time to
> answer to my possibly stupid question(s):
>
> What's the difference of setting process priority with chrt and nice?
> And how do using both of these commands compare with a normal vs.
> realtime-kernel =A0(PREEMPT_RT)?
>
> BR, Jaakko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20

H=E4lsningar/Regards
Tobias Knutsson
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
