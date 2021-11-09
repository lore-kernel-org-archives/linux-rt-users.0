Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FFFC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 07:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40C36115B
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 07:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbhKIHE0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 02:04:26 -0500
Received: from mail1470c50.megamailservers.eu ([91.136.14.70]:34048 "EHLO
        mail102c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243389AbhKIHEZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Nov 2021 02:04:25 -0500
X-Greylist: delayed 1195 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 02:04:25 EST
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1636438240;
        bh=N+WmKZhgNfHjgopDL8wvUNJTg5r27D0psV1J6PM8+XY=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=U8CgcPeiVziKywqe8OTZtfETP8hU38X7fR9XVSlLT6F8sscdsB4y6VVFdcDqeKP7/
         qVEtkZ52rDIonO5i2+7x7jzKNbi4THHBSAkgqXn8ZVjRbChDSsspWQqn/MYqSDu4t7
         RdO58ij0s2Mc9sBY/ACKDitWHr9JGzKCBFFk0rFk=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (dynamic-093-131-127-239.93.131.pool.telefonica.de [93.131.127.239])
        (authenticated bits=0)
        by mail102c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 1A96Ac4D023630
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Tue, 9 Nov 2021 06:10:39 +0000
Date:   Tue, 9 Nov 2021 07:10:42 +0100
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users@vger.kernel.org
Subject: Re: A question about the PREEMPT_RT patch set
Message-ID: <20211109071042.35f5da06@archlinux>
In-Reply-To: <80B78A8B8FEE6145A87579E8435D78C3023AB9B631@FZEX6.ruijie.com.cn>
References: <80B78A8B8FEE6145A87579E8435D78C3023AB9B631@FZEX6.ruijie.com.cn>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A742F21.618A10E0.000A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.4 cv=MfIPB7zf c=1 sm=1 tr=0 ts=618a10e0
        a=TwUdobaDdyQgvzb6nQg2UQ==:117 a=TwUdobaDdyQgvzb6nQg2UQ==:17
        a=kj9zAlcOel0A:10 a=BIfhnXS2Valde01xEUcA:9 a=CjuIK1q_8ugA:10
X-Origin-Country: DE
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 9 Nov 2021 02:27:37 +0000:
>I have a question. If I apply the PREEMPT_RT patch set to the Linux
>kernel, is the real-time supported by the kernel hard real-time or
>soft real-time?

Hi,

when I programmed my C64 in Assembly I got no audible MIDI jitter,
using software written by other, the same was true for my Atari ST, on
my Linux PCs there very often is audible MIDI jitter and the amount of
jitter varies depending on the used MIDI interface. USB MIDI devices
are less accurate than PCI/PCIe devices.

What I try to point out is, that a lot of layers are involved, when
using a PC and apart from those layers some things are even not
real-time processed at all.

If you are using the PC to process audio signals (instead of MIDI)
there at least will be a minimal amount of a delay (latency) already
produced by the audio device's hardware.

In short, I don't know what it is called done by a rt patched Linux
kernel, but the result, including the communication with interfaces,
when using a PC, in my opinion doesn't fit the definition of "hard
real-time. OTOH some users have got success to use patched kernels for
CNC, but I don't know what patch is used.

To my understanding "hard real-time" is a squishy term when using a
multi-tasking, multi-user PC. Such machines are probably more suitable
as remote control for independent hard-realtime machines equipped with
microcontrollers.

Regards,
Ralf
