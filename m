Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F1DC4320A
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Aug 2021 01:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A457061186
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Aug 2021 01:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhHGBoA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 21:44:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:53367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhHGBn7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 21:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628300551;
        bh=F4bbSXyjHIN1BGUeLpaEx8mOppLBhHGK/+Ms07Fv+wg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=OTXNBwmrCrz385A/QKCFxzvv8LJBv0Rsmu8brx8RuAzT07gCJLouSwxrgmkAxAI/x
         Q+vF1I55sfrWvQLTMWp1Q94M0zEAbAzBl38hA2KcgT4cdCWf+eg1qZlW1e1r0aNVUe
         KzvLqqEWMO0USS+MzbWzjRomQlD8it27LTbe4XA4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1md1uf0mhu-00QxYw; Sat, 07
 Aug 2021 03:42:31 +0200
Message-ID: <800ff941e3ec86ea1397cddf8ecea3d4a17c55dc.camel@gmx.de>
Subject: Re: [PATCH v2 2/4] sched: Introduce is_pcpu_safe()
From:   Mike Galbraith <efault@gmx.de>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 07 Aug 2021 03:42:28 +0200
In-Reply-To: <20210807005807.1083943-3-valentin.schneider@arm.com>
References: <20210807005807.1083943-1-valentin.schneider@arm.com>
         <20210807005807.1083943-3-valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7IREJpazqVFoymZlSqnbvmojHa+lnVsdP2PzWl3dtLW58icJX8s
 JgJUFsj4wgy7wr8QtZUI/vFW4mR9w2E31PuFtRvj7hkcsKmpHUZgA+scftFcijFvvr6DXxh
 95RWdUc0BOTY+kBVXigE1yn8ESnjNnRC+WcXS2iXAk0Qp/k2o4R14M2S2Uel3nIcrCyYPcH
 XAyDuRzL1gjrdlPt16Dow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ziS+D4sSvLI=:WbksQVBOYKr+mWLdbgRvMi
 HkBtpSEWdVSq3U2tMNWKwGchuz1LatjO4v6Tnj1sNFa7sww6eYzp3vy+qwsa5b57HOdHWVjJ6
 kSlG37cppGDOqg3pVHVY6mYAYbODhmfXgQJfgrLOFdXoD1yi4DpmOtjalpsYDzFmlpgRMSm4S
 r+gKe+2FpsTlojglASxGW2Jrh4luHMM9E0GUAIsqZJVROb4+0Vq9auqLL3q2D9MGua6JnfTeV
 nX3xl00+Jt+rqaOvyoR6Dt1n+814Qzjqm/NB00QtxuytXgMduAOq4pM+F9w4wmdJSPcpJOICf
 rlcMaJbIrPZbRkk6GPApFsdCZFqaQX6NPFWhAV3U+MF6hN11FODtCZmH0DvxSDzKu4cojh4Mh
 Aar+fH3oK5+kWYD+SukFFq1fgNN77zf09JcC2awznynBa3kZtV2tD7x20fSshH+j15dyZJJfk
 UOIy99JVZQ0SLf0EpSM25/TZKtWEDqqw537dGpBak8f+NmwJQR3PxDEjFv9SA3HF6PawDwZbV
 lXbS4OYQktEqi8d12tgUi/GJU67C6lTGKWStFv6VfeIDZiogsFUVAc3CTuVWXo16ZDmbsldCD
 8E7xF4znYZQSPGHDgNT6GQ6lQTchYkbI1DQdKHCNv2keYBumzdzfk8WK8zX1a1IdFw1bwnviM
 l2iL22FIHbyFBB/ilL0p2fytmILNKiTM8pWTTjuWCkAi27AR047x3t1ptbBUobete9E02ViAx
 BLzEr/fVRfgesFMldr3eTtp8OqRdUb9IKpmCkRSEw2lvv4UIhwEEPMrDCavi1z1UmM2w9miHW
 MuO5geGOhFQXcafngB++KYKvQOpTEa8cXIOtnV3RgPvWf5GWiiVsQR3RwxUOSt3LcCAHD0aoQ
 MNWah5vgxZwRp9ulbj8Kh/BU9ZNx4/015EHIsTm9h2yF3KzBdNrSxD/IfJi/Qg1ucr2JL6Fsu
 d0y4c4JI56h7rbA+W4/FVa6PGpT+VlvoDBvuVZQX51KifTTJ4Sxc3wQUc2Gcxqd6+dQL/XYrq
 g7W/d4MAHgTQRwGPqcuUySdsnanpv2bAOvthZEcoiGEGtnFsdFlNdyiNvPQqmmh2/qTtnnj8y
 4gON1KfzFnu//WSZfsXdTwaXaRCjtJSvloq
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-08-07 at 01:58 +0100, Valentin Schneider wrote:
>
> +static inline bool is_pcpu_safe(void)

Nit: seems odd to avoid spelling it out to save two characters, percpu
is word like, rolls off the ole tongue better than p-c-p-u.

	-Mike

