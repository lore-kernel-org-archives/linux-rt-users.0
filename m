From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: RT patches against v2.6.27-rc7 available
Date: Tue, 30 Sep 2008 18:50:46 -0400
Message-ID: <48E2AD46.7060403@windriver.com>
References: <20080930033248.GA24480@windriver.com> <1222765114.30330.7.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:56348 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036AbYI3Wvj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Sep 2008 18:51:39 -0400
In-Reply-To: <1222765114.30330.7.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sven-Thorsten Dietrich wrote:
> On Mon, 2008-09-29 at 23:32 -0400, Paul Gortmaker wrote:
>
> Paul,
>
> =EF=BB=BFFirst of all thanks for taking a shot at the forward-port.
>
>
>  =20
>> I've completed a carry forward of the 26rt9 broken out patchset onto
>> the 2.6.27-rc7 kernel.  There were a lot of changes in 2.6.27, so th=
is
>> wasn't just a simple case of having all the patches magically work a=
s-is.
>>    =20
>
> Never is :)
>
>  =20
>
> A lot of the patches have a lot of fuzz, in my experience, mis-patche=
s
> occur more frequently with fuzz.=20
>
> You might want to refresh those patches.
>  =20

I was originally thinking that there might be some value in seeing whic=
h
ones really didn't need a change, but given that Steven does a refresh
cycle over the patches for each release it probably makes sense for me
to refresh the fuzz/offset ones as well.

I'll have a patchset updated to 27rc8 available within a couple hours, =
and
for those working from the patches vs. the git tree, the patches will b=
e
all fuzz/offset free.

Thanks,
Paul.

> Thanks,
>
> Sven
>
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
