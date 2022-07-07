Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD570C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jul 2022 14:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiGGOnI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiGGOnH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Jul 2022 10:43:07 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6532062
        for <linux-rt-users@vger.kernel.org>; Thu,  7 Jul 2022 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=53gHY85tL7DqN90mr4itmIsI00/TqUuYWC1idw12xOw=; b=nAKKl
        N31JWbFcbEyo/Ju1Jx7gLccAuabdNuCgIKFz2nXZV+D42ZeZGUC4yb5jeyjlxnHFsnLFfd8fWBmCg
        kSQLDyXir+eka3cwhvQGWqQpKURIfwnU5LiWenjaJeV2u0MbiPsRs37KnxvUbi83UCGrVN1B1PV3e
        6N5Z92rERRLyhBpL0O01v8dnVx2YjRnlcGOcaASWc+FCh3NfQEMX7mpZwvd9Bl1ecAI8VUtiqcbgF
        rwKlcsFUSc2mj2fsFfQmg2LgKGsRlHShFrGlohw6IXSwpbsgIJBMHc5v61/DxvZpOXFWV/o37GD2z
        AmySLCvNLslcXSeKteknFIzx1Y+Kg==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1o9Sie-0000VG-5X;
        Thu, 07 Jul 2022 15:43:05 +0100
Date:   Thu, 7 Jul 2022 15:43:03 +0100
From:   John Keeping <john@metanate.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT] Deadlock on filesystem operations v5.15+
Message-ID: <Ysbw904Lf1AXlSI0@donbot>
References: <YsL2gTPQk5YnI2W3@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsL2gTPQk5YnI2W3@donbot>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jul 04, 2022 at 03:17:39PM +0100, John Keeping wrote:
> I'm seeing a deadlock in filesystem operations on v5.15.49-rt47-rebase;
> after further testing this is reproducible in all v5.15 releases I
> tested as well as v5.19-rc3-rt5-rebase.  I believe it is specific to
> CONFIG_PREEMPT_RT.
> 
> With added logging, I've confirmed that the kworker here is plugged and
> the buffer tar is waiting for is one of those held up by the plug.  The
> vfat filesystem here is on a loop device.
> 
> Both tasks here are running at normal priority (SCHED_OTHER, nice 0).
> 
> This seems to be similar to the issue fixed by b0fdc01354f4
> ("sched/core: Schedule new worker even if PI-blocked") since the lock
> being used here is msdos_sb_info::s_lock which is a normal struct mutex
> and thus tsk_is_pi_blocked() will be false for non-RT but is returning
> true on RT meaning that blk_schedule_flush_plug() is skipped in
> sched_submit_work().  If I remove the tsk_is_pi_blocked() check then I
> can't reproduce the hang any more.
> 
> Is some further refinement of the condition here needed?

Having taken another look at why this wasn't happening in v5.10-rt
previously, the tsk_is_pi_blocked() check in sched_submit_work() was
removed by a patch [1] added in v5.9.1-rt20 but dropped in v5.13-rt1.

It looks like the rest of that patch was replaced by b4bfa3fcfe3b
("sched/core: Rework the __schedule() preempt argument") upstream but
the hunks dropping tsk_is_pi_blocked() have been totally lost.

So I've sent a patch to drop the check [2] as it seems this creates a
difference in the behaviour of always preemptible locks between RT and
!RT which this function isn't called at all by any of the locks that
become preemptible only with RT.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0022-locking-rtmutex-Use-custom-scheduling-function-for-s.patch?h=linux-5.10.y-rt-patches
[2] https://lore.kernel.org/lkml/20220707143902.529938-1-john@metanate.com/
