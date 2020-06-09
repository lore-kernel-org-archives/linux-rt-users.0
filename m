Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ABBC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 17:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C67A207C3
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 17:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgFIRK4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgFIRKu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 13:10:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CECC05BD1E;
        Tue,  9 Jun 2020 10:10:50 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jihlr-0005Kc-PB; Tue, 09 Jun 2020 19:10:43 +0200
Date:   Tue, 9 Jun 2020 19:10:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in
 double-enqueue
Message-ID: <20200609171043.vhvms7lowffqm6e4@linutronix.de>
References: <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
 <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
 <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
 <20200609154741.5kesuvl7txz4s3yu@linutronix.de>
 <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org>
 <20200609163446.efp76qbjzkbtl7nk@linutronix.de>
 <D6892A4E-18F7-4EB7-BA09-BD4DF9079BDE@gmail.com>
 <34E6C220-A85B-4296-AB8E-62DE6D9DC561@gmail.com>
 <20200609164213.bshzpfuqgioyvtpm@linutronix.de>
 <61D63A44-E3D9-4E7F-BE08-B887C078F445@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61D63A44-E3D9-4E7F-BE08-B887C078F445@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-09 20:07:06 [+0300], Ramon Fried wrote:
> Indeed
>  I'm truly sorry, I thought our crash kernel is configured as RT as well. 
> so, as I understand, if I build the RT kernel without preempt enabled I can hit this bug? 

Don't worry, I should have been better with the details in the log.

So you should _always_ hit the warning/bug if you compile a kernel
without SMP and RT. If you enable one of these then everything should be
fine.

Sebastian

