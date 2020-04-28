Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F17C83006
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 12:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C4C2075E
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588078772;
	bh=UzdGhjHtfG1ERnaW9K3xUYidX61ZE5q/Gct7TlnXdMo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=NBnZmCefrQOHvJL7YLuygrrZMHFbizOp5Q2YGZ5em4h+8FdyyOxJHrY5BtdkvaDzP
	 IH8L0UlyYVaCcyx3P1ECDwPxLWfpNRQbCYY9jyunPXpQEBAHyUrIPB12oHQcwMyStC
	 WEQTFfetF2l9AfMD2+CHk22NWNTGwQhLjBfftRLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgD1M72 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgD1M72 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 08:59:28 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629D9206A1;
        Tue, 28 Apr 2020 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588078768;
        bh=UzdGhjHtfG1ERnaW9K3xUYidX61ZE5q/Gct7TlnXdMo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FFkhrdh1/qimqjyerdP5AUZRaJ9BFPa3KvosJDc0tZuYtKtDX8vV2nLerWxCVFzSc
         OtoiRyTwkwRXQ5PFRuUf8Un5dTd3XtOQotweFIEJWb0ZBRbEyiW+/TNt+ksZMV9pe4
         +NCuIkiV4mxhDD7HZPURacBXSmDlxuWZ4FPGyJ7g=
Message-ID: <7fce15e17cd3bef1216473386718e3cfd67349a4.camel@kernel.org>
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
Date:   Tue, 28 Apr 2020 07:59:26 -0500
In-Reply-To: <1a5e52a6-39e4-ac9a-e11a-5df261e83068@prevas.dk>
References: <20200123203930.646725253@goodmis.org>
         <20200123203943.749508731@goodmis.org>
         <1a5e52a6-39e4-ac9a-e11a-5df261e83068@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-04-28 at 09:03 +0200, Rasmus Villemoes wrote:
> On 23/01/2020 21.39, Steven Rostedt wrote:
> > 4.19.94-rt39-rc2 stable review patch.
> > If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Julien Grall <julien.grall@arm.com>
> > 
> > [ Upstream commit cef1b87f98823af923a386f3f69149acb212d4a1 ]
> > 
> > As tglx puts it:
> > > If base == migration_base then there is no point to lock
> > > soft_expiry_lock
> > > simply because the timer is not executing the callback in soft
> > > irq context
> > > and the whole lock/unlock dance can be avoided.
> 
> Hold on a second. This patch (hrtimer: Prevent using
> hrtimer_grab_expiry_lock() on migration_base) indeed seems to
> implement
> the optimization implied by the above, namely avoid the lock/unlock
> in
> case base == migration_base:
> 
> > -	if (timer->is_soft && base && base->cpu_base) {
> > +	if (timer->is_soft && base != &migration_base) {
> 
> But the followup patch (hrtimer: Add a missing bracket and hide
> `migration_base on !SMP) to fix the build on !SMP [the missing
> bracket
> part seems to have been fixed when backporting the above to 4.19-rt]
> replaces that logic by
> 
> +static inline bool is_migration_base(struct hrtimer_clock_base
> *base)
> +{
> +	return base == &migration_base;
> +}
> +
> ...
> -	if (timer->is_soft && base != &migration_base) {
> +	if (timer->is_soft && is_migration_base(base)) {
> 
> in the SMP case, i.e. the exact opposite condition. One of these
> can't
> be correct.
> 
> Assuming the followup patch was wrong and the condition should have
> read
> 
>   timer->is_soft && !is_migration_base(base)
> 
> while keeping is_migration_base() false on !SMP might explain the
> problem I see. But I'd like someone who knows this code to chime in.
> 

I don't know this code, but I think you're correct - the followup patch
reversed the condition by forgetting the !.

So, does your problem go away when you make that change?

Tom

> Thanks,
> Rasmus

