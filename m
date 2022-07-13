Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33349C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Jul 2022 17:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiGMRjk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Jul 2022 13:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiGMRjj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Jul 2022 13:39:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E89B21E2A;
        Wed, 13 Jul 2022 10:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31FD9CE2349;
        Wed, 13 Jul 2022 17:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F8DC34114;
        Wed, 13 Jul 2022 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657733975;
        bh=hY34Ty6LLrpmsHEDeDeWG++UYJntFK70v8fR9W52Hm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uWVyM7OVw4ZwRHp7DHN5Pc2YfWEfQ2/e794Jk2qvJyKZ74r6b0udb8VBtpPiCuPK6
         EYJeQxuAMIrng8IXnhOdN2MkENapqZJr1oAVu6nxQ8lYWetlteOhG2MVfgb3fvJXXz
         ckUbsR5I1Pv8K4OdA78tgWO3UCRLbXGYNdYC/DJU=
Date:   Wed, 13 Jul 2022 10:39:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Message-Id: <20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
In-Reply-To: <xhsmh35f68tz4.mognet@vschneid.remote.csb>
References: <20220630223258.4144112-1-vschneid@redhat.com>
        <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
        <xhsmh35f68tz4.mognet@vschneid.remote.csb>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 12 Jul 2022 12:13:03 +0100 Valentin Schneider <vschneid@redhat.com> wrote:

> On 12/07/22 10:47, Baoquan He wrote:
> > Hi,
> >
> > On 06/30/22 at 11:32pm, Valentin Schneider wrote:
> >> Hi folks,
> >>
> >> Here's ~v3~ v4 where we now completely get rid of kexec_mutex.
> >>
> >> o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
> >>   having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
> >>   here. If that can't be done then I think we're better off with the combined
> >>   mutex+atomic var approach.
> >> o Patch 2 does the mutex -> atomic var switch.
> >
> > This series looks good, has it been taken into any tree?
> >
> 
> I don't think so, briefly poked around git and haven't seen it anywhere.

I'll stash it away for consideration after -rc1.
