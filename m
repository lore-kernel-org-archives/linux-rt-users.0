Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58627C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 19:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4263861008
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 19:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhHQTbB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230110AbhHQTbA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Aug 2021 15:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629228626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9FE22rxp6AYKElT4XtdoX7zLTcx3lonKYmaIy1Dz4c=;
        b=G37IKFDCscNp6Y05fllAdtQYuKNqcDbuBmSBrbXP0xql5swk0Lr4jpgFJR5QLwo0W+fs4a
        v7kIs5UwIalXNNN8Azs3LLbtRzuw/m985eikTROPHxsopkix90OnjY6nMXyMK4FvPML6aB
        WeEdkTQ/WaS7rGmF2+wHjH0EJ8BKT38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-4vvYO79JPfeSXV7wb0FHTg-1; Tue, 17 Aug 2021 15:30:23 -0400
X-MC-Unique: 4vvYO79JPfeSXV7wb0FHTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C148F1008060;
        Tue, 17 Aug 2021 19:30:19 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.10.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CC301036D28;
        Tue, 17 Aug 2021 19:30:12 +0000 (UTC)
Date:   Tue, 17 Aug 2021 15:30:10 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <YRwOQtvOW02QFVow@lorien.usersys.redhat.com>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-3-valentin.schneider@arm.com>
 <20210817170925.2jwqvgvmqab2glwu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210817170925.2jwqvgvmqab2glwu@linutronix.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 17, 2021 at 07:09:25PM +0200 Sebastian Andrzej Siewior wrote:
> On 2021-08-11 21:13:52 [+0100], Valentin Schneider wrote:
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index debc960f41e3..8ba7b4a7ee69 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1715,6 +1715,16 @@ static inline bool is_percpu_thread(void)
> >  #endif
> >  }
> >  
> > +/* Is the current task guaranteed to stay on its current CPU? */
> > +static inline bool migratable(void)
> 
> I'm going to rename this in my tree to `is_migratable' because of

It's better anyway. See is_percpu_thread() 5 lines above :)


> |security/keys/trusted-keys/trusted_core.c:45:22: error: ‘migratable’ redeclared as different kind of symbol
> |   45 | static unsigned char migratable;
> |      |                      ^~~~~~~~~~
> |In file included from arch/arm64/include/asm/compat.h:16,
> |                 from arch/arm64/include/asm/stat.h:13,
> |                 from include/linux/stat.h:6,
> |                 from include/linux/sysfs.h:22,
> |                 from include/linux/kobject.h:20,
> |                 from include/linux/of.h:17,
> |                 from include/linux/irqdomain.h:35,
> |                 from include/linux/acpi.h:13,
> |                 from include/linux/tpm.h:21,
> |                 from include/keys/trusted-type.h:12,
> |                 from security/keys/trusted-keys/trusted_core.c:10:
> |include/linux/sched.h:1719:20: note: previous definition of ‘migratable’ was here
> | 1719 | static inline bool migratable(void)
> |      |                    ^~~~~~~~~~
> 
> Sebastian
> 

-- 

