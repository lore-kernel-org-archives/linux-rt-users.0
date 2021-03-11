Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B497AC433E6
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A7664FF3
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 16:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhCKQCT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 11:02:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbhCKQBw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 11:01:52 -0500
Date:   Thu, 11 Mar 2021 17:01:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615478511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DROmqqXCGCoINCVBqXsN9acf1/D5MJqD7267i0wOrxA=;
        b=QJIx/Jf2NGwh+SOv1J6IBMhplHEBjkiAtedev50FUzknotFfR77W8ZZDieJVEQ+73SzxIO
        wxF3LpnJxhfAmTIGTt9CyYtEDXy02gydPtJkjnMkdRUFQhO7PZiz5svIN15tN4avXJJLsv
        dii/ssjYVuX/fAp58KMSN7Tg/ltkFonsa0PNzNb1t3+ewLMtx6QRkesgNHZ1GUI/+71elC
        I7cZRUt+u8HUB66hzJN6vBQaCmXnqUHT/DOwA+pE7w9n3NOZoeUJOnLfTILug35Brsw410
        jwL2+FGEI9YGeaP76qTqAwzjo2na8AwZ7Oj1OabXfJ/BDA5EhJSUvsFWqZ1HIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615478511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DROmqqXCGCoINCVBqXsN9acf1/D5MJqD7267i0wOrxA=;
        b=gxwOjIgVCY9jxJ7Qvx0m1WjM0VMJsIUrRImxylsT9+u/ktXh+lyLM8/onkhzInwm4amIG5
        ik28YugrF/KTIRAg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: PREEMPT_RT benchmark
Message-ID: <YEo+65NledhEFGqw@lx-t490>
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
 <YEoT7Wvk8V1cbHng@lx-t490>
 <CAKkbJ-yO46NsvYoC7fwtZNeT9BO5EvkiyKf8S+bGuqPXjEZTGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKkbJ-yO46NsvYoC7fwtZNeT9BO5EvkiyKf8S+bGuqPXjEZTGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


[ No top-posting please. See https://daringfireball.net/2007/07/on_top ]

Macena Oliveira wrote:
>
> Do you know if it would be valid for GTK interface applications?
>

Yes, we notice latency increases even when a modern dekstop graphics
environment like GNOME is running but idle. Remember that both Windows
and modern Linux GTK environments uses the GPU — even for 2D rendering.

If you're interested, I presented a small talk about the topic here:

  https://linutronix.de/PDF/Realtime_and_graphics-acontradiction2021.pdf

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
