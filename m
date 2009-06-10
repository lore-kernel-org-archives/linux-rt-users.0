From: Vivek Satpute <vivek@linsyssoft.com>
Subject: Re: RT-linux on MIPS..
Date: Wed, 10 Jun 2009 20:10:19 +0530
Message-ID: <fae6a9700906100740q4c32a01fjb08b04b9ecd4496f@mail.gmail.com>
References: <74848fb40906090018m267594f7u6225cf77388f8b4c@mail.gmail.com>
	 <9f1ddb481cf54eb91d48d76457d8f134@walsimou.com>
	 <fae6a9700906090505m4386dc0clde443ec8f1f857ec@mail.gmail.com>
	 <alpine.LFD.2.00.0906092313230.3351@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: walsimou@walsimou.com, Tom Desouza <desouza.tom@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f180.google.com ([209.85.221.180]:62162 "EHLO
	mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986AbZFJOkT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Jun 2009 10:40:19 -0400
Received: by qyk10 with SMTP id 10so642668qyk.33
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Jun 2009 07:40:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0906092313230.3351@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

On Wed, Jun 10, 2009 at 2:45 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
>
> Vivek,
>
> please do _NOT_ toppost. Thanks.
>
> On Tue, 9 Jun 2009, Vivek Satpute wrote:
> > Could I know the current state of rt-support on MIPS arch ? When wi=
ll
> > it be released with full MIPS support ?
>
> There have been patches posted on this Mailinglist. I did not come
> around yet to go through them and there are pending review issues fro=
m
> the MIPS maintainter IIRC. If you need MIPS -RT support please grab
> the patches and help to get them in shape.
>

I searched MIPS specific rt-patches in mailing list upto 27 Jun 2008.
I found only 2 patches
specific to MIPS arch. Posting after 27th Jun 2008 seems to be for
linux-2.6.25.8. I have few
doubts, could you please help me out ?

1) Currently, I am using rt-patches
patch-2.6.29.1-rt9-broken-out.tar.bz2, picked up from
    http://www.kernel.org/pub/linux/kernel/projects/rt/ . It has
patches for MIPS arch also.
    Are all those patches specific to MIPS are tested and working ? I
mean does those
    have any unsolved issues ? Or do I have to test them ?
2) Could I know how many patches posted on mailing list, have been
released so far ?


> Thanks,
>
> =A0 =A0 =A0 =A0tglx

Thanks,
Vivek
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
