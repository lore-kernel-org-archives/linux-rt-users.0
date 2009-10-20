From: John Kacur <jkacur@gmail.com>
Subject: Re: MIPS SUPPORT with rt-24
Date: Tue, 20 Oct 2009 11:28:04 +0200
Message-ID: <520f0cf10910200228qc47b84ar78931c6a9ff2f70d@mail.gmail.com>
References: <2cc9eb1b0910200155p5761c44djed6ab3a1de7d2984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: fabio <fabio7774@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:49280 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbZJTJ2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Oct 2009 05:28:00 -0400
Received: by ewy17 with SMTP id 17so5132358ewy.39
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Oct 2009 02:28:04 -0700 (PDT)
In-Reply-To: <2cc9eb1b0910200155p5761c44djed6ab3a1de7d2984@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Oct 20, 2009 at 10:55 AM, fabio <fabio7774@gmail.com> wrote:
> (re-sent with title).
>
> I just installed the rt-patches (rt-24) on top of 2.6.29-rc6 for a MI=
PS board.
>
> After I noticed that it doesn't compile out of the box, I found out
> that it has not been tested on MIPS except for Lemote in 2.6.26 I
> think.
>
> Questions:
>
> Is there a schedule date for MIPS =A0support ? otherwise from which
> stable version may I start on or even better from which patches shoul=
d I
> start in order to make rt-24 support for MIPS.
>
> Also how about rt14 ? Is there any MIPS support ?
>

Hi Fabio

The -rtX numbering starts with X=3D1 when we start developing against
a new kernel. (or usually a release candidate).

So for example, the latest -rt kernel is 2.6.31.4-rt14
The first one in that series was, 2.6.31-rc4-rt1

So, you need to refer to the whole kernel version number or
we can't tell which version you are talking about.

If you would like to contribute MIPS patches that would be great. I rec=
ommend
you do so against the latest version though or else you'll most likely
be on your own!

Also, there are no schedules. If the support isn't there, you can eithe=
r try
to provide it yourself, or pay a company to do so for you.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
