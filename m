Return-Path: <SRS0=F8C2=CR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B9DC2BC11
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 19:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6820E2098B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 19:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Hb83dQ9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgIHTZo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:25:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:57997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731022AbgIHQAn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599580772;
        bh=oKw/yzYD6eOW39I8U2TosMiSpWSrS9JUrnApsFbd3ks=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Hb83dQ9YTcTOvkLigukuawO5OCt08jdArJZ08Sq7E+LBXEmeiaBr05ZcKv/ndZQOB
         Pb7bbyA3xu/1NpUvJZnMh8bLOgqQeyXeRSyvRtPzuPTIPlDL31IXuBQPgKa90gfLRu
         KPWFiD1P+eiQq6rRQwNSUR4nkKo6A2n1+RoXnFyg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1jtDCY0Kri-00MbOz; Tue, 08
 Sep 2020 17:59:32 +0200
Message-ID: <a79815352e2f238b7f108e6e7202f6655f26159d.camel@gmx.de>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 08 Sep 2020 17:59:31 +0200
In-Reply-To: <20200908151229.g24j4n4fderlm2pe@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
         <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
         <b989e196a8b9cceda35152de9202d7a67ca32196.camel@gmx.de>
         <20200908151229.g24j4n4fderlm2pe@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dpbJGdyniN1L8GgtVO9C42d9xu0vTjB2nNyE9vu9ukXbtho5I7V
 3g3nNwehyDv1LlKRhz2iBO+CoPaS2JC+NQEjExZ8lAR/BgwIs2qGR0ouuiijgb4r3GBmPl/
 HVNLR8CGpRGT0HihPMrs9G/J+bxbrUbAk62tZEUY0oUlOuCiCHCoHHDDTmoTE43eR7xcx/+
 m6rLsKSq6JKLRw6GGAegg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bBQiVy6+LQg=:yQDEL/dplQfSmsutFc7m8V
 OXvgj0VTwHR0PVbycsGQQtwxJZaYYeNup5Xa4TFu+Lb4Kr3/ZK4bwKYd8wDBg6yAqlREHg/5f
 J/V+aNnxANtj8yYGgCTPjXz4CxvXKU2gIlTlqE4HHbAIOk/kL5C9TxW7VDqtSooFPdAiVG5jc
 fTwOVU28LVzFlc55iG+85DAiGd6UWSUP0lpCQzVBQAu7n83Fv5QgQNQmcnvLmSa7VhOyvmvNb
 5UDkpj9VjEM0ydQOVxf52U25ApynjvjPVVcJ56/atAbgr8sV3p4yWk8TfOBylBnrWaNY2+uPA
 InhMEomAG43bQjyGlPf2hcopVN3SqrqsGqcqytWp+nxoLr8PR2A7YOoySzal1VQ7YRIDQA4Xj
 DVuK5rn19tiy9ccFuCRT4jNad3RwYPFc2UBBPV/fa8/ga8MKcPX3AjWxDRuxv+4LrR435dmmZ
 6IaQjG8q0btTXq5aV7SU9ZeK/CEJuFZvlMxX99M2sD7neLLbVfdJDyz5f2HNJR98IA2K6vU83
 nAll1UgzuH3vASsMNeAvKU2D+OxKx4nXGMjMgTMwHRss4+r6W/CEFbJvlB8N80v8EsWTywgHu
 AZ4pY4dX9yD8702AmcfKanHOyX1MTx4LLyTpTJAEQC3jB7XbneqdZ2oINzCfzjuCCiYNNVc3/
 bnJHhplbIYWyJ3ityd/cOvLuUT8MTn6KqJXMh+EQPyowey0NzvuUk+rvovPrZRw481YC2ViPU
 VlcHnP7cOaAQFT3C1XOZRRRC3+7SFaSA9i6t5T6pEKtUlJBg13jKSvsQMJh+kYQR3YJ9bDrei
 92F2qGB6lh0IxixrEknzaCb1qa7SoLWPk8ty+VaEnZ0ylOQJOxr5fGcpypNYZMB6x3QCsaA7L
 t79lXMdlXiDxewO2aVor2fN4JcKnbqbAYuZuQBK32t/sL0Qtr9L/eljc/mWsI+NWvZJuqQrDq
 11+Qe/173cI+WgS4oaFJzik0bbVMTUKPlBjnD9L3TnwFBp8eYZsVi+PEHrRjI10h6g6p3EtzH
 JMemM5B1n5K4VgDaMomabAiLLK4Fl4/BTVHqvP6FIGd3DPqhntmIbesrG6bK909axlWO14L/i
 XqyryG9+EVza5H9VhPYXl/AGnIX438JVNxEp7YKp6zGNiwunj+Rvi7ws23DrvKScm280vCfo1
 3euTjN6pyCsSQrMPO49WRagdRf+xZmgTWmHsomNxzLMlYiogod+sGaW5/lTrEufSAb8Coi3qt
 /hFlu/JxuXRM8Fpbm
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-09-08 at 17:12 +0200, Sebastian Andrzej Siewior wrote:
> On 2020-09-05 07:19:10 [+0200], Mike Galbraith wrote:
> > Lappy, which does not use bridge, boots clean... but lock leakage
> > pretty darn quickly inspires lockdep to craps its drawers.
> >
> > [  209.001111] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > [  209.001113] turning off the locking correctness validator.
> > [  209.001114] CPU: 2 PID: 3773 Comm: Socket Thread Tainted: G S      =
  I E     5.9.0.gc70672d-rt3-rt #8
> > [  209.001117] Hardware name: HP HP Spectre x360 Convertible/804F, BIO=
S F.47 11/22/2017
> > [  209.001118] Call Trace:
> > [  209.001123]  dump_stack+0x77/0x9b
> > [  209.001129]  validate_chain+0xf60/0x1230
>
> I have no idea how to debug this based on this report. Can you narrow
> it down to something?

I instrumented what I presume is still this problem once upon a time,
structures containing locks are allocated/initialized/freed again and
again with no cleanup until we increment into the wall.

> Is Lappy new, got a new something or has a new config switch? I'm just
> curious if this something or something that was always there but
> remained undetected.

Nah, this is nothing new.  Turn lockdep on in RT, it's just a matter of
time before it turns itself off.  It's usually just not _that_ quick.

	-Mike

