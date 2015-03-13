From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [OSADL QA 3.18.9-rt4 #1] Radeon driver hangs
Date: Fri, 13 Mar 2015 12:12:23 +0100
Message-ID: <5502C617.3090305@linutronix.de>
References: <55021FFE.904@osadl.org> <55024A2A.8000206@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
	Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55712 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbbCMLMZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Mar 2015 07:12:25 -0400
In-Reply-To: <55024A2A.8000206@daenzer.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/13/2015 03:23 AM, Michel D=C3=A4nzer wrote:
> The commits from
> http://cgit.freedesktop.org/~airlied/linux/commit/?h=3Ddrm-fixes&id=3D=
f957063fee6392bb9365370db6db74dc0b2dce0a
> to
> http://cgit.freedesktop.org/~airlied/linux/commit/?h=3Ddrm-fixes&id=3D=
cffefd9bb31cd35ab745d3b49005d10616d25bdc
> and
> http://cgit.freedesktop.org/~airlied/linux/commit/?h=3Ddrm-fixes&id=3D=
b6610101718d4ab90d793c482625e98eb1262cad
> might help for this.
Thanks.

I can't reproduce this myself but I pulled in the commits you mentioned
and "drm/radeon: only enable kv/kb dpm interrupts once v3" to avoid a
reject. The box runs, glxgears and so on seem to do something, can't
look at the screen :) All of those commits (and a ton more) are marked
stable so I will probably get them anyway=E2=80=A6

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
