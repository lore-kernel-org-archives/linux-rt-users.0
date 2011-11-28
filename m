From: Andy Ng <andreas2025@gmail.com>
Subject: Re: Linux RT and Jffs2
Date: Mon, 28 Nov 2011 09:57:47 +0000
Message-ID: <CAAVaN8wUuf1vrvVh32++TPrQA_0ze2HVZYZjNxjNHqysPr6N0w@mail.gmail.com>
References: <CAAVaN8wdd3HjfwzqBeBm0LiMsz93FfJ=ubp6iz2p4gui7sw=EA@mail.gmail.com>
	<20111128071324.GF17668@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58379 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab1K1J5t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Nov 2011 04:57:49 -0500
Received: by bke11 with SMTP id 11so8300238bke.19
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Nov 2011 01:57:47 -0800 (PST)
In-Reply-To: <20111128071324.GF17668@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you for your reply.

I am wondering if there is going to be any improvements if I change
the priority of the garbage collector thread.

I will try and let you know.

Best regards
Andreas

2011/11/28 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Hello Andreas,
>
> On Mon, Nov 28, 2011 at 02:45:26AM +0000, Andreas O wrote:
>> I am using a real-time 2.6.33.7 version on ARM and I have noticed so=
me
>> problems with the NAND. After a power cycle I see messages like
>> "mtd->read( ) returned ECC Error." It is quite strange.
>> Example:
>>
>> mtd->read(0x1fba0 bytes from 0x4e0460) returned ECC error
>> mtd->read(0x1d520 bytes from 0x4e2ae0) returned ECC error
>>
>> Initially, I make write to the NAND the jff2 filesystem and when I
>> boot for first time
>> there are no ECC errors at all. After the first power cycler, some E=
CC
>> errors will appear.
>> If I do a second power cycle, more may be would appear.
>> If I repeat again the same procedure, writing again the rootfile
>> system to the NAND, after a power cycle the ECC errors will come fro=
m
>> the same region (0x4exxxx). I have used different types of NAND, and
>> the problem is the same.
>>
>> I think it might have to do with a combination of the RT and jffs2,
>> Jffs2 garbage collector thread. The GC thread might need priority
>> change as it takes the lock for performing the scan and may sleep fo=
r
>> longer within the RT world. Therefore writes do not happen that ofte=
n,
>> therefore those ECC errors from un-flushed wbuf buffers.
>>
>> Have you seen similar behaviour before with RT and Jffs2?
> How do you restart. Just pressing reset or unplugging is expected to
> yield warnings by jffs2. See
>
> http://www.linux-mtd.infradead.org/faq/jffs2.html#L_messages.
>
> Maybe rt makes it more likely for these to appear, but the problem is
> not specific to rt.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Uwe Kleine-K=F6nig =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
