Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E29C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Oct 2022 07:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJFH0e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJFH0e (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2022 03:26:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8A389937
        for <linux-rt-users@vger.kernel.org>; Thu,  6 Oct 2022 00:26:33 -0700 (PDT)
Date:   Thu, 6 Oct 2022 09:26:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665041191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCGVf/LJKYs7oUnS2AHYa3P29mIOfkPi/iUc+YaLdVs=;
        b=r9G4RhSHSz6sMrvOZEm6n/T96Zwrl2woBZIiH/3Aybos9QJlYRTz3+ChvR/shRYAclrkGD
        gQJH1SCkcmHmWZapn28OsrBg1jiSqjJdP4v98O+iCWmrD/nTE/orGNkXCsxURogJ7p+KUC
        W8yD4BfPv4rGqn+WtcNGohDY/YrYWEg4QPCOjWWTFjXqsp0cYcCna3uD5PMSLYWfK+Ugy/
        5ufDPxCld40dIYy3v6RPmpSP8zNYs+ySbFJQP7CKWNzXrpaQuvM/7x1AYSJHFb1hSo1KsA
        z8WQSaNtbi3nhWObRJXB15NVhh9lvd/jRba5dVuaxWyABhy5WHEOxEjBnQPfSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665041191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCGVf/LJKYs7oUnS2AHYa3P29mIOfkPi/iUc+YaLdVs=;
        b=A7SD/n/bhMlX4A8QpFWOM0ystC5z7Uqnu8mUzV+4rPBDjIMkyESAn+tGRNqOzp/noT98dr
        aXYGNMxhzwOkMJBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Florian Paul Schmidt <mista.tapas@gmx.net>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
Message-ID: <Yz6DJo4rHUuQQpVb@linutronix.de>
References: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
 <Yz2HQlzZ491HtOm+@linutronix.de>
 <5675da76-80ba-5708-e022-2385e3b56fad@redhat.com>
 <9a950f2b-94c2-7dad-51f2-545aa37850c2@gmx.net>
 <6b79b2f3-7ec9-88e9-48e4-71c6ec85b7db@redhat.com>
 <5d127d10-d606-52ad-b270-9bcbd66eec6c@gmx.net>
 <Yz51W0+ZVvYSa9kq@linutronix.de>
 <447228e9-2509-20e7-c259-c226e2ee4742@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <447228e9-2509-20e7-c259-c226e2ee4742@gmx.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-10-06 09:16:25 [+0200], Florian Paul Schmidt wrote:
> On 10/6/2022 8:27 AM, Sebastian Andrzej Siewior wrote:
> > that looks fine to me.
> > The runtime_resume path points to intel_dmc_load_program(). The
> > preempt-disable section there was introduced by commit
> >     dff457d74e7ea ("drm/i915: Speed up DMC firmware loading")
> >=20
> > and the other thing seems to be intel_irq_reset() not sure where but it
> > is the runtime_suspend path.
> >=20
> > So disabling runtime-suspend should help.
>=20
> OK, so it was a user error :) Thanks for teaching me about rtla in the
> process! This will turn out to be helpful in the future!

So that got introduced in the v5.17 cycle then independent of RT itself?
If so I'm not sure what to do about it. Probably adding it to the i915
pile=E2=80=A6

> I passed acpi=3Doff as kernel parameter and that seems to have helped! The
> closest to runtime-suspend I could find was:
>=20
> /sys/devices/system/cpu/power/runtime_enabled

You should have one for the i915 somewhere under
   /sys/devices/pci*/*/drm/*/power

there is powertop which should also have a disable button (it is usually
used to enable it).
Disabling acpi could be a big hammer in case there are also useful
things coming out it.

> which is "disabled" now.
>=20
> > Sebastian
>=20
> Thanks again and kind regards,
> FPS

Sebastian
