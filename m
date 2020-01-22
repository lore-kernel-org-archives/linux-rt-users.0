Return-Path: <SRS0=RBrU=3L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6941AC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jan 2020 11:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480D42468A
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jan 2020 11:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAVLei convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVLei (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Jan 2020 06:34:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A012524685;
        Wed, 22 Jan 2020 11:34:35 +0000 (UTC)
Date:   Wed, 22 Jan 2020 06:34:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>, Borislav Petkov <bp@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Austin Clements <austin@google.com>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Chase <drchase@golang.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ian@airs.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Bleecher Snyder <josharian@gmail.com>,
        x86-ml <x86@kernel.org>, stable-rt@vger.kernel.org
Subject: Re: [PATCH RT 27/32] x86/fpu: Dont cache access to
 fpu_fpregs_owner_ctx
Message-ID: <20200122063434.68a78066@gandalf.local.home>
In-Reply-To: <20200122084352.nyqnlfaumjgnvgih@linutronix.de>
References: <20200117174111.282847363@goodmis.org>
        <20200117174131.455165326@goodmis.org>
        <20200122084352.nyqnlfaumjgnvgih@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 22 Jan 2020 09:43:52 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-01-17 12:41:38 [-0500], Steven Rostedt wrote:
> > 4.19.94-rt39-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> >   
> …
> > Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")  
> 
> This isn't needed for the v4.19 tree. As far as I can tell, there is no
> "Defer FPU state load until return to userspace" in it.
> 

OK, I'll drop this one too.

-- Steve
