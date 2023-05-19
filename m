Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D8AC7EE2F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 14:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjESO5p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 10:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjESO5n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 10:57:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AEE101
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 07:57:41 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684508259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypWxguJqEcmnXsydByTCdczcMQDyk0WZ1+aKDo350nw=;
        b=yRtBJxTrYAomtuBJTWAhTmJ/JQ9BRIhF5SvyxWDVAp4JqHsPwLkQl0BewM8Pg9jdg6/wk+
        DhpEuBVhj4tJLemuG4hm5i/jzGf521KCJR3w6CBJyisWvCGXMOOwsCi4Ot/XMR0DVgGcoU
        XYoufxIyjqU52BhgOZif/n00L9eBfegV2qwh2fehtCZ1B+kZ6WfwjhnVk2OK8GYDFdKsut
        5BtlErt3OxpIq4292cHWE3VqOJUIegAbhf9Tj7uOb8wRoJh5WAV5APbin+3JQpZr1UPh2X
        a56YcRMgGCuQ0s5ltVZSJQvI2vUkZtxka/XafIQAQjM7je8daCiQQi2G6QPWAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684508259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypWxguJqEcmnXsydByTCdczcMQDyk0WZ1+aKDo350nw=;
        b=fvKMZqqietvWQg462u60lrV34VmWRtD6nAtxE2vHBZ+W21Aj51Qn3n4hEu4TLfEkLC2LsQ
        yytGaUJaubFsi9DQ==
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] ARM: vfp: Fixes for PREEMP_RT
Date:   Fri, 19 May 2023 16:57:28 +0200
Message-Id: <20230519145731.574867-1-bigeasy@linutronix.de>
In-Reply-To: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
References: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Ard,

On 2023-05-18 00:05:33 [+0200], Ard Biesheuvel wrote:
> Don't let me stop you :-)

made a small series. It seems to address everything and with your
assembly rework it is not a big mess.

What do you think?

Sebastian


