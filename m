From: John Kacur <jkacur@gmail.com>
Subject: Fwd: MIPS SUPPORT with rt-24
Date: Tue, 20 Oct 2009 13:32:23 +0200
Message-ID: <520f0cf10910200432l53ff8c32h94537f3b64019fb8@mail.gmail.com>
References: <2cc9eb1b0910200155p5761c44djed6ab3a1de7d2984@mail.gmail.com>
	 <520f0cf10910200228qc47b84ar78931c6a9ff2f70d@mail.gmail.com>
	 <2cc9eb1b0910200326r5e4becc1v5b4f683ba9eda8b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:47460 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbZJTLcU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Oct 2009 07:32:20 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1157264eyd.19
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Oct 2009 04:32:24 -0700 (PDT)
In-Reply-To: <2cc9eb1b0910200326r5e4becc1v5b4f683ba9eda8b8@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

---------- Forwarded message ----------
=46rom: fabio <fabio7774@gmail.com>
Date: Tue, Oct 20, 2009 at 12:26 PM
Subject: Re: MIPS SUPPORT with rt-24
To: John Kacur <jkacur@gmail.com>


Hi John,

Thanks for the reply.
=46irst I would be happy to contribute but does that mean that the
2.6.31.4-rt14 doesn't support MIPS or at least in not tested ?

My current Linux version is 2.6.29.6 and I would like first to re-use
the loongson port for my board so I can get something quite very
quickly then in parralel move to 2.6.31.4-rt14 .
I can't get hold of linux-2.6.29-stable-loongson-RT_PREEMPT. Could you
please guide me on where to get it.

Thanks

=46abio



On Tue, Oct 20, 2009 at 11:28 AM, John Kacur <jkacur@gmail.com> wrote:
> On Tue, Oct 20, 2009 at 10:55 AM, fabio <fabio7774@gmail.com> wrote:
>> (re-sent with title).
>>
>> I just installed the rt-patches (rt-24) on top of 2.6.29-rc6 for a M=
IPS board.
>>
>> After I noticed that it doesn't compile out of the box, I found out
>> that it has not been tested on MIPS except for Lemote in 2.6.26 I
>> think.
>>
>> Questions:
>>
>> Is there a schedule date for MIPS =A0support ? otherwise from which
>> stable version may I start on or even better from which patches shou=
ld I
>> start in order to make rt-24 support for MIPS.
>>
>> Also how about rt14 ? Is there any MIPS support ?
>>
>
> Hi Fabio
>
> The -rtX numbering starts with X=3D1 when we start developing against
> a new kernel. (or usually a release candidate).
>
> So for example, the latest -rt kernel is 2.6.31.4-rt14
> The first one in that series was, 2.6.31-rc4-rt1
>
> So, you need to refer to the whole kernel version number or
> we can't tell which version you are talking about.
>
> If you would like to contribute MIPS patches that would be great. I r=
ecommend
> you do so against the latest version though or else you'll most likel=
y
> be on your own!
>
> Also, there are no schedules. If the support isn't there, you can eit=
her try
> to provide it yourself, or pay a company to do so for you.
>
> John
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
