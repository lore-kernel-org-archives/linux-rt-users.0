From: Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [PATCH] Update old Mini-HOWTO for ftrace
Date: Tue, 7 Apr 2009 10:25:26 +0900
Message-ID: <28c262360904061825n6728509ey7933fefdaae35f9f@mail.gmail.com>
References: <49b7c2350904060702j3f725a45ub5e7d3ee3af883c1@mail.gmail.com>
	 <49b7c2350904060717l1a87cca7p880b6843ea92c702@mail.gmail.com>
	 <49b7c2350904061609q7984d5f0u478a092ffcabe12c@mail.gmail.com>
	 <alpine.LFD.2.00.0904070120090.21577@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GeunSik Lim <leemgs1@gmail.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	rt-users <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:39114 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbZDGBZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Apr 2009 21:25:28 -0400
In-Reply-To: <alpine.LFD.2.00.0904070120090.21577@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

One more thing.

Please, Not attach your patch but inline one.
Many people want to add their comments to line-by-line.

Tip -
If you use gmail with web, your patch is mangled by web server.
That will hurt maintainers.

Documentation/email-clients.txt can help you. :)

On Tue, Apr 7, 2009 at 8:32 AM, Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> GeunSik,
>
> On Tue, 7 Apr 2009, GeunSik Lim wrote:
>
>> Sorry,
>> I mistake because I don't understand how to submit patch exactly.
>
> To submit a patch you need to have:
>
> 1) useful subject line
>
> =C2=A0 [PATCH] subsystem: what does the patch do
>
> =C2=A0 subsystem in your care is: ftrace
>
> 2) useful patch description
>
> =C2=A0 explains what the patch does. Which bug/problem it fixes or wh=
ich
> =C2=A0 enhancement it provides
>
> =C2=A0 Look at the git log. Each commit has an (more or lesss) useful=
l
> =C2=A0 description, but you get the idea. If you see a confusing or
> =C2=A0 cryptic description you need way more time to figure out what =
the
> =C2=A0 patch does or what it is supposed to do.
>
> 3) Your Signed-off-by
>
> =C2=A0 Signed-off-by is the certificate of origin as described in
>
> =C2=A0 Documentation/SubmittingPatches
>
> =C2=A0 You can only add your own Signed-off-by. You never can add the
> =C2=A0 Signed-off-by of some one else.
>
>> I just appended below "singned-off" contents for convenience.
>> Sorry again.
>>
>> =C2=A0 =C2=A0Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
>> =C2=A0 =C2=A0Signed-off-by: Steven Rostedt <srostedt@redhat.com>
>> =C2=A0 =C2=A0Signed-off-by: Ingo Molnar <mingo@elte.hu>
>
> That's how it might look later on. It would say:
>
> =C2=A0 =C2=A0 =C2=A0 GeunSik Lim =C2=A0 =C2=A0 =C2=A0 wrote the patch
> =C2=A0 =C2=A0 =C2=A0 Steven Rostedt =C2=A0 =C2=A0picked it up from yo=
ur mail and sent it to Ingo
> =C2=A0 =C2=A0 =C2=A0 Ingo Molnar =C2=A0 =C2=A0 =C2=A0 received it fro=
m Steven's mail and applied it
>
> There is no way for you to forsee how your patch will be picked up an=
d
> propagated. It might go via Andrew Morton or directly to Linus. Ok ?
>
> So you only add your own Signed-off-by.
>
> Hope that helps. Thanks,
>
> =C2=A0 =C2=A0 tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Kinds regards,
Minchan Kim
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
