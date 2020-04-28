Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD5DC83001
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6146206D9
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588081396;
	bh=YAQPWXTWLQI1KBUZVad+K6GoXX9q2TGOlTqaTMGI4f8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=V0neq6tJnmTNe7sQdKX0wJuL4LZg1j9jazzDIsIFMx2XNypa4yiTJcAaIYAxxMCqj
	 W9rVU7oesR5tkiQaGlRlnU0E7uyv3QOsAePgNWpilLUdQpWM+X8ExMjI2AfqCG4w7T
	 JKRNKW8C79Lxz/gY2SyNYOTb3zE2NfyvpTzvgUi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgD1NnM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgD1NnM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 09:43:12 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22FDA206D6;
        Tue, 28 Apr 2020 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588081391;
        bh=YAQPWXTWLQI1KBUZVad+K6GoXX9q2TGOlTqaTMGI4f8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uk3F1A15ec8HqYdsOiQRX3Hxn97WLoMVqvffDztTcUhxL0UhfR0K2P4PynvkAzv9l
         82dv0V41p0jJjB9/1eMUZR0Yfywlj42Ff1okUT+4lcqlA7wRqFF9UcSyUyFGvs+5a8
         AGEh6PJP2enuGeAdHYBUQx0LihQdOx0zLUTCj02s=
Message-ID: <a63a1c2aae7dca43334ff3b72c17adeefade6c8e.camel@kernel.org>
Subject: Re: [PATCH RT 10/30] hrtimer: Prevent using
 hrtimer_grab_expiry_lock() on migration_base
From:   Tom Zanussi <zanussi@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Julien Grall <julien.grall@arm.com>
Date:   Tue, 28 Apr 2020 08:43:10 -0500
In-Reply-To: <049616fa-8908-e845-057f-d9482a483597@prevas.dk>
References: <20200123203930.646725253@goodmis.org>
         <20200123203943.749508731@goodmis.org>
         <1a5e52a6-39e4-ac9a-e11a-5df261e83068@prevas.dk>
         <7fce15e17cd3bef1216473386718e3cfd67349a4.camel@kernel.org>
         <049616fa-8908-e845-057f-d9482a483597@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-04-28 at 15:07 +0200, Rasmus Villemoes wrote:
> On 28/04/2020 14.59, Tom Zanussi wrote:
> > On Tue, 2020-04-28 at 09:03 +0200, Rasmus Villemoes wrote:
> > > Hold on a second. This patch (hrtimer: Prevent using
> > > hrtimer_grab_expiry_lock() on migration_base) indeed seems to
> > > implement
> > > the optimization implied by the above, namely avoid the
> > > lock/unlock
> > > in
> > > case base == migration_base:
> > > 
> > > > -	if (timer->is_soft && base && base->cpu_base) {
> > > > +	if (timer->is_soft && base != &migration_base) {
> > > 
> > > But the followup patch (hrtimer: Add a missing bracket and hide
> > > `migration_base on !SMP) to fix the build on !SMP [the missing
> > > bracket
> > > part seems to have been fixed when backporting the above to 4.19-
> > > rt]
> > > replaces that logic by
> > > 
> > > +static inline bool is_migration_base(struct hrtimer_clock_base
> > > *base)
> > > +{
> > > +	return base == &migration_base;
> > > +}
> > > +
> > > ...
> > > -	if (timer->is_soft && base != &migration_base) {
> > > +	if (timer->is_soft && is_migration_base(base)) {
> > > 
> > > in the SMP case, i.e. the exact opposite condition. One of these
> > > can't
> > > be correct.
> > > 
> > > Assuming the followup patch was wrong and the condition should
> > > have
> > > read
> > > 
> > >   timer->is_soft && !is_migration_base(base)
> > > 
> > > while keeping is_migration_base() false on !SMP might explain the
> > > problem I see. But I'd like someone who knows this code to chime
> > > in.
> > > 
> > 
> > I don't know this code, but I think you're correct - the followup
> > patch
> > reversed the condition by forgetting the !.
> > 
> > So, does your problem go away when you make that change?
> 
> Yes, it does. (I'll have to ask the customer to check in their setup
> whether the boot hang also vanishes).
> 
> Essentially, adding that ! is equivalent to reverting the two patches
> on
> !SMP (which I also tested): Before, the condition was
> 
>   timer->is_soft && base && base->cpu_base
> 
> and, assuming the NULL pointer checks are indeed redundant, that's
> the
> same as "timer->is_soft". Appending " && !is_migration_base()" to
> that,
> with is_migration_base() always false as on !SMP, doesn't change
> anything.
> 

OK, great, thanks for tracking this down.

If you post a patch that makes that change and mention that it's a fix
for commit "40aae5708e7a hrtimer: Add a missing bracket and hide
`migration_base' on !SMP", I can pull it into a new update release.

Thanks,

Tom

> Thanks,
> Rasmus

