Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF96C00140
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Aug 2022 16:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbiHRQdh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344815AbiHRQdc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Aug 2022 12:33:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759371704B;
        Thu, 18 Aug 2022 09:33:31 -0700 (PDT)
Date:   Thu, 18 Aug 2022 18:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660840410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8G/qFmUGW/BNQytAyJX+Ki4HfNnrYJzfFV7g5CzBno=;
        b=yxPOe4Bm2C2U6jGLDCHYvCFzUQuEuqZhVqSoejm4cG+fy0ac0NY5XS11qa0xYgI8iqJqE7
        rYMDhnf0lEvCtBU/808yY3JKmAEI/gDNC2OtdAtDHJ0Cp5jhIytTOfjbLZjpP6WQI+itQy
        8vXYZm4wyqBPuu+mnyvplxz8WxW5JW6/iwHkGg2Y8QQ/O5pGsFq/cIX4Sm0tQn/MdfUnFC
        RqY9wymEgc5Zfuc25YIvLRCzbfk3W056WDrG+WDme83rZvXXuRgbXHXVg5ikHAM0gP0Ejt
        6eIJBA5uwFQhjZy4VYotP3GnPuZRKilYoK2pLWrSY9uk6lKahK8P4pHJYMV7Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660840410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8G/qFmUGW/BNQytAyJX+Ki4HfNnrYJzfFV7g5CzBno=;
        b=oxOkjT3VB0bl0Ks27qtnGE/9M+MXKPmQKuVRW0g6WRq+V4uXL2Zy7j7VFEMO3l5rP1zU4z
        2ztGb1JJ0IgwnaDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux RT users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT BUG] Mismatched get_uid/free_uid usage in signals in some
 rts (2nd try)
Message-ID: <Yv5p2E9e5B897V4I@linutronix.de>
References: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
 <YrXtH1z2JSmwLS7W@T470>
 <20220624184431.GA4386@zipoli.concurrent-rt.com>
 <20220626123019.GA51149@zipoli.concurrent-rt.com>
 <Yv5j8NQ72KXu60nL@linutronix.de>
 <20220818163126.GA47319@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220818163126.GA47319@zipoli.concurrent-rt.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-08-18 12:31:26 [-0400], Joe Korty wrote:
> Hi Sebastian,
Hi Joe,

> I just verified that 4.9.319-rt195 has this fix.

Good to hear. And the v4.9 series was the only broken, right?

> Regards,
> Joe

Sebastian
