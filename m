From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kenrel panic with 3.18.7-rt2 - rootfs at MMC
Date: Sun, 1 Mar 2015 20:31:25 -0500
Message-ID: <CAP=VYLqqDRfpz+LH21ZPQ3sVJ-Re4bUjWW9aRvzCB6=OCnQuWQ@mail.gmail.com>
References: <54EC487F.8020109@gmail.com> <CAP=VYLr=vMTRYCqoXcQBjrMT1-7dGp8fsThTYWzf=4L2tEYyyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?UTF-8?Q?Michal_=C5=A0mucr?= <msmucr@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:41554 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbCBBb4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Mar 2015 20:31:56 -0500
Received: by wevm14 with SMTP id m14so30435237wev.8
        for <linux-rt-users@vger.kernel.org>; Sun, 01 Mar 2015 17:31:55 -0800 (PST)
In-Reply-To: <CAP=VYLr=vMTRYCqoXcQBjrMT1-7dGp8fsThTYWzf=4L2tEYyyA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Mar 1, 2015 at 8:25 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On Tue, Feb 24, 2015 at 4:46 AM, Michal =C5=A0mucr <msmucr@gmail.com>=
 wrote:
>> Hello to all,
>>
>> I'm getting kernel panics, when I'm using kernel 3.18.7 with recentl=
y
>> released rt1 and rt2 patches. Platform is x86_64.
>> It happens only when root filesystem is at SDHC card.
>> At 3.14.31-rt28 or recent plain vanilla kernels I haven't spotted th=
is
>> issue.
>>
>> Boot panic is possible to workaround by adding kernel parameter:
>> "scsi_mod.scan=3Dsync", but it still happens during initrd rebuild u=
sing
>> update-initramfs at Debian Jessie.
>>
>> Log from panic is attached.
>
> Seems sdhci_irq is operating on a (non-raw) host->lock and you
> are running that code in hard IRQ context, which will trigger the
> alarm for operating on a sleeping lock while in atomic context.
> (i.e code is not currently -rt friendly as-is).

Aha, I see Sebastian already sent out a patch to move it out
of hard IRQ context  ; didn't immediately see it since it wasn't
threaded to this discussion and so it looked unreplied to.

P.
--

>
>>
>> Thanks for any comment regarding issue or better way for bug-report,
>
> In the future, putting the log lines in line (vs attachment) makes
> it easier to reply and comment - meaning more people will look
> at the report.
>
> P.
> --
>
>>
>> Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
