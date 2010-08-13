From: jordan johnston <triplesquarednine@gmail.com>
Subject: Re: 2.6.35 RT support roadmap
Date: Fri, 13 Aug 2010 05:32:53 -0400
Message-ID: <AANLkTiksuyBCcUER3dHPegW7zO7sNzserSOPkUwFDNHE@mail.gmail.com>
References: <CD8FEF6F82F55744AA1ED2BE5E7D8FD2015184EE0B@dnce01.ent.ti.com>
	<AANLkTimmCqNz+ZhSCqMGhaiCmW38hnjfkLV0ZU+e2gkX@mail.gmail.com>
	<1281638311.7093.4.camel@marge.simson.net>
	<4C645567.2080308@gmail.com>
	<AANLkTikoUbL4Q8PNia38AByEfTY56Bqr5uVnyyNxvS1W@mail.gmail.com>
	<1281679536.7356.8.camel@baracus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Galbraith <efault@gmx.de>,
	Xianghua Xiao <xiaoxianghua@gmail.com>,
	"Walzer, Frank" <f-walzer@ti.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41201 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934042Ab0HMJcz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 05:32:55 -0400
Received: by eyg5 with SMTP id 5so41205eyg.19
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Aug 2010 02:32:54 -0700 (PDT)
In-Reply-To: <1281679536.7356.8.camel@baracus>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Aug 13, 2010 at 2:05 AM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
> On Thu, 2010-08-12 at 23:17 -0400, jordan johnston wrote:
>> > Google did Android and even Palm woke up (just long enough to watc=
h its own
>> > demise).
>> >
>> > The rest is history.
>> >
>> > Except of course putting the RT Kernel in Android.
>>
>> As i understand it, many Android users are using the BFS patchset, a=
nd
>> have been for a while. BFS pretty much does what "the end result of
>> using the rt-patches" accomplish, minus rtirq, spin-locks, etc. You
>> will get the desired
>> responsiveness that using RT would give you.
>>
>
> I assume that it might well depend to some extent on whether I am
> pumping market data feeds into a processing model using 512 CPUs or
> playing a game on my Nexus-1, but I won't disagree agree with you on =
the
> importance of task-appropriate efficient scheduling, appropriate
> workload partitioning, and all that jazz.

agreed, 100%. the "case in point" here is i was commenting on android.
When talking on the scale of 512 CPUs,
RT is the choice hands down. i should have said "You will get the
desired responsiveness that using RT would give you ON ANDROID".

>> Im pretty sure that is why Zen-kernel has a git repository "very
>> specifically" for android (BFS is the default kernel setting). I'm
>> sure there are other goodies for android in there too.
>>
>> www.zen-kernel.org
>>
>> I don't know much about the Android repo's state (as it's fairly new=
).
>> but worth a
>> look for your "rt-usage" (ie. performance/responsiveness) for androi=
d.
>> =A0As i do not own an Android, i have not tested it, but i have talk=
ed
>> with people who do..
>>
>> I'm waiting to see what 2.6.35 holds for RT.... but personally i am
>> using BFS and 2.6.34 with a lot of performance tuning (a good deal o=
f
>> time spent analyzing/tuning) and i am yielding better results not
>> using the upstream rt-patches.
>> we will see what happens in 2.6.35/36....
>>
>
> Sounds good. I know there has been some extensive discussion about th=
e
> interpretation and applicability of the various scheduler performance
> metrics, including special examination of BFS vs. CFS - and I definit=
ely
> think that has been hashed out in gore and detail already.
>
> But if you have some pretty plots that characterize performance for y=
our
> platform, vs. Preempt-RT, I am always interested in looking at pictur=
es
> and numbers about what's happening on the other side of the fence.

Of course, i wasn't interested in getting into the CFS/BFS war. they
are both valid and useful.
I also think the existence of both, is a good thing. if anything it's
healthy for development.
I do plan to document some of my testing/usage but not until i get my
new 3u rack up and running.

jordan
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
