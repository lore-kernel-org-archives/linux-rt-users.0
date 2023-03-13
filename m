Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B43C61DA4
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Mar 2023 09:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCMJly (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCMJlv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Mar 2023 05:41:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEC915540
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Mar 2023 02:41:46 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:41:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678700504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bjz3CMXmxgdt79iVUIHhuGaGQpAej9BpCTSeRwOvq0M=;
        b=2N5pUfG/W6uh3f04RHOwq8q39KWnKb3le96fMK482e9/6+VCV9b8wB4FRlPpJBmi0fwj9x
        z170Fnjuj0YE5zU3z3YYSMli+u5DeQoi2j2AnDeOldG1g0df7iP1oxA5Y8u/nmWD+TMShJ
        yCtcfDwmOubjg9OvJflwjdoGom6IkzbhcbY7lBbOwhmS4X0R9il0bMBMu3tRuU8NRD/cLx
        yLXHF0fer6LHLUzlh7yhmLS0z4aZf6PMtwZkAx5v8APbD2T0opox3FBB1NNo6Qi3vi/7Om
        LlKzVTtUkOwd60Dsy2T4YIyqOY9mLuNHr2dk/4oQyO7ytpIYtG6VCLWC76ofJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678700504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bjz3CMXmxgdt79iVUIHhuGaGQpAej9BpCTSeRwOvq0M=;
        b=0a6Sv6JJrV1XEAkn7CZojOspkQIXCdR2zOBemK5TZhzjMxUq0HsVm1gX/wbfRLK04ZqEwC
        qORFcRzWYH6EDSBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     =?utf-8?B?RnLDqWTDqXJpYw==?= Martinsons 
        <frederic.martinsons@gmail.com>
Cc:     "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: Kernel lock during cryptsetup luksClose
Message-ID: <20230313094143.5t28jqkB@linutronix.de>
References: <Y/yrHe4OIYcWFbNO@linutronix.de>
 <20230228230009.89787-1-brennanlamoreaux@gmail.com>
 <CA+cAkerw6kqhibwacCxwtu4u_U3pBYF0xcRrOVZh1T=++vURbw@mail.gmail.com>
 <CA+cAkerXmfVYAKoO7FU8aPwvZQ5hDPH_-RZgF1==H1LwtteovA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+cAkerXmfVYAKoO7FU8aPwvZQ5hDPH_-RZgF1==H1LwtteovA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-03-02 09:06:41 [+0100], Fr=C3=A9d=C3=A9ric Martinsons wrote:
>=20
> For my curiosity, do you know why I fell in this case ? The bug
> requires specific timing or it only
> appears during usage of device mapper in kernel ?

It always happens if a specific worker pool is removed and this happens
on luksClose. The problem was introduced by a backport, which touched
this corner.

Sebastian
