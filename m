Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F99C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 17:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D2E60FD9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhHQRKL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:10:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhHQRKF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Aug 2021 13:10:05 -0400
Date:   Tue, 17 Aug 2021 19:09:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629220166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pua/3tjO7aIRXX12+cyflypDu8x21Lu5L5biSj5T99Q=;
        b=YD3Vht+o8To9S+hGwb+xNIUKaaST5m0SQIawHWrrnR4/fsCUYmTQBQZ/0ToWgzcOcoCuCN
        oZWqQi2hODx16ZVD9str+sWpO7fC5hLDCMf5RgSdPI72cFIq1wOMiraZL5AABD4T1HRU/N
        pP0IAYWgQw9otSDnEaBI5FZOeSgh02Ji241N2gEz3IFQO5fdgNAoojs6wWw3HvtCKD4YTr
        x3cOfLTYuoNL/uRL4l36/jCvb489Ia9rvzKqeNJzdG1gYdnGAPSFSI4SDbehZtmjl5bRRi
        RTzBp8PhHhOCuXWaTrAwfkRxP0N+gj+8yOm2rWzjInEq5/7CzgQxkQeto56ApQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629220166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pua/3tjO7aIRXX12+cyflypDu8x21Lu5L5biSj5T99Q=;
        b=HpqKGx3k0um5s2EPmjYfPHpbuLBCi0eO6tySgz/NBu6CU/39l03bVrV6GVZbss3RYLU6Or
        GPzX1T4JuaejwfBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3 2/4] sched: Introduce migratable()
Message-ID: <20210817170925.2jwqvgvmqab2glwu@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210811201354.1976839-3-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-11 21:13:52 [+0100], Valentin Schneider wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index debc960f41e3..8ba7b4a7ee69 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1715,6 +1715,16 @@ static inline bool is_percpu_thread(void)
>  #endif
>  }
> =20
> +/* Is the current task guaranteed to stay on its current CPU? */
> +static inline bool migratable(void)

I'm going to rename this in my tree to `is_migratable' because of
|security/keys/trusted-keys/trusted_core.c:45:22: error: =E2=80=98migratabl=
e=E2=80=99 redeclared as different kind of symbol
|   45 | static unsigned char migratable;
|      |                      ^~~~~~~~~~
|In file included from arch/arm64/include/asm/compat.h:16,
|                 from arch/arm64/include/asm/stat.h:13,
|                 from include/linux/stat.h:6,
|                 from include/linux/sysfs.h:22,
|                 from include/linux/kobject.h:20,
|                 from include/linux/of.h:17,
|                 from include/linux/irqdomain.h:35,
|                 from include/linux/acpi.h:13,
|                 from include/linux/tpm.h:21,
|                 from include/keys/trusted-type.h:12,
|                 from security/keys/trusted-keys/trusted_core.c:10:
|include/linux/sched.h:1719:20: note: previous definition of =E2=80=98migra=
table=E2=80=99 was here
| 1719 | static inline bool migratable(void)
|      |                    ^~~~~~~~~~

Sebastian
