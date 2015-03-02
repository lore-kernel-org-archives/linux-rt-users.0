From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kenrel panic with 3.18.7-rt2 - rootfs at MMC
Date: Sun, 1 Mar 2015 20:25:24 -0500
Message-ID: <CAP=VYLr=vMTRYCqoXcQBjrMT1-7dGp8fsThTYWzf=4L2tEYyyA@mail.gmail.com>
References: <54EC487F.8020109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?UTF-8?Q?Michal_=C5=A0mucr?= <msmucr@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:42902 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbCBBZz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Mar 2015 20:25:55 -0500
Received: by wiwh11 with SMTP id h11so11369735wiw.1
        for <linux-rt-users@vger.kernel.org>; Sun, 01 Mar 2015 17:25:54 -0800 (PST)
In-Reply-To: <54EC487F.8020109@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 24, 2015 at 4:46 AM, Michal =C5=A0mucr <msmucr@gmail.com> w=
rote:
> Hello to all,
>
> I'm getting kernel panics, when I'm using kernel 3.18.7 with recently
> released rt1 and rt2 patches. Platform is x86_64.
> It happens only when root filesystem is at SDHC card.
> At 3.14.31-rt28 or recent plain vanilla kernels I haven't spotted thi=
s
> issue.
>
> Boot panic is possible to workaround by adding kernel parameter:
> "scsi_mod.scan=3Dsync", but it still happens during initrd rebuild us=
ing
> update-initramfs at Debian Jessie.
>
> Log from panic is attached.

Seems sdhci_irq is operating on a (non-raw) host->lock and you
are running that code in hard IRQ context, which will trigger the
alarm for operating on a sleeping lock while in atomic context.
(i.e code is not currently -rt friendly as-is).

>
> Thanks for any comment regarding issue or better way for bug-report,

In the future, putting the log lines in line (vs attachment) makes
it easier to reply and comment - meaning more people will look
at the report.

P.
--

>
> Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
