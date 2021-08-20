Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0102C4320A
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 03:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36B961103
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 03:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhHTDYf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 23:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238098AbhHTDYe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Aug 2021 23:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629429836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWdTs6izqiA/pimZyzqfzwAT5R8dcZcICeLEyrt5S/U=;
        b=Hfou/h8IkPfpPwMnLbzlNn5c+kXlDScCE8NjwkLq9lqm8osLtbm6XbkJ24jqNZVTe2X7EH
        66lkDP/LitOBhqe5jJbH+UVONFb5bRIhsI4V8Y4Mjp//ivA89MNPtvINzQ5geGOobnE6sH
        wlYS5Zgmuq4+Rb8PpuMY/p/gkMzGuZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-hqiP0e4XOxq-BwqdJck-_g-1; Thu, 19 Aug 2021 23:23:53 -0400
X-MC-Unique: hqiP0e4XOxq-BwqdJck-_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD375C73A4;
        Fri, 20 Aug 2021 03:23:44 +0000 (UTC)
Received: from ovpn-113-78.phx2.redhat.com (ovpn-113-78.phx2.redhat.com [10.3.113.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19C13189BB;
        Fri, 20 Aug 2021 03:23:37 +0000 (UTC)
Message-ID: <20b9051fe47b7068ed3496bd7f5d417b1af69e3a.camel@redhat.com>
Subject: Re: [PATCH] rcutorture: Avoid problematic critical section nesting
 on RT
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
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
Date:   Thu, 19 Aug 2021 22:23:37 -0500
In-Reply-To: <20210817144018.nqssoq475vitrqlv@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
         <20210811201354.1976839-2-valentin.schneider@arm.com>
         <20210817121345.5iyj5epemczn3a52@linutronix.de>
         <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
         <20210817144018.nqssoq475vitrqlv@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2021-08-17 at 16:40 +0200, Sebastian Andrzej Siewior wrote:
> [bigeasy: remove 'preempt_disable(); local_bh_disable(); preempt_enable();
>  local_bh_enable();' from the examples because this works on RT now. ]

Does it actually work?  If preemption is disabled during local_bh_disable,
softirq_ctrl.lock won't be taken.  If you then get preempted between the
preempt_enable() and the local_bh_enable(), and another task tries to do
local_bh_disable(), won't it successfully get softirq_ctrl.lock, add to
softirq_ctrl.cnt, and proceed right into the critical section?

Or am I missing something?

-Scott


