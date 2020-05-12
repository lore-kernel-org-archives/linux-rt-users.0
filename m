Return-Path: <SRS0=+khU=62=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A788C54E4A
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56630206DD
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 13:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgELNgP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 May 2020 09:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbgELNgO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 May 2020 09:36:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC137206D3;
        Tue, 12 May 2020 13:36:13 +0000 (UTC)
Date:   Tue, 12 May 2020 09:36:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Elana Copperman <Elana.Copperman@mobileye.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Vladimir Kondratiev (Mobileye)" 
        <63dc4b5d-c467-4bfb-bce5-74485907c850@intel.mail.onmicrosoft.com>
Subject: Re: cgroups CPU time management + PREEMPT_RT
Message-ID: <20200512093612.416899e1@gandalf.local.home>
In-Reply-To: <AM0PR09MB3794A1DA3C38B31A4A16E9DD99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
References: <AM0PR09MB3794D873EEAE20CD9201D14299A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
        <AM0PR09MB3794E9CFE8BA31852B712DAD99A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
        <AM0PR09MB3794F5E857CB761859BBEF0B99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
        <AM0PR09MB3794A1DA3C38B31A4A16E9DD99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 12 May 2020 13:30:27 +0000
Elana Copperman <Elana.Copperman@mobileye.com> wrote:

> Hi, can you help to clarify if there is any implementation support or
> evidence on configuring cgroups CPU time allocations for RT tasks in
> conjunction with the PREEMPT_RT patch?

What exactly are you trying to do with cgroups CPU time allocations, and
what is the problem you are seeing with the PREEMPT_RT patch with them?

I'm assuming you are using the 5.6-rt kernel.

-- Steve


> 
> Or are the two requirements contradictory in essence and not jointly
> feasible?
> 
> Thanks
> 
> Elana and Vladimir
> 
> 
> 
> 
> From: Elana Copperman
> 
> Sent: Thursday, May 7, 2020 10:08 PM
> 
> To: linux-rt-users <linux-rt-users@vger.kernel.org>; Vladimir Kondratiev
> (Mobileye)
> <63dc4b5d-c467-4bfb-bce5-74485907c850@intel.mail.onmicrosoft.com>
> 
> Subject: RE: cgroups CPU time management + PREEMPT_RT
> 
>  
> 
> 
> Hi,
> 
> We are new to the mailing list, and new to PREEMPT_RT.
> 
> We are working on a project with a safety requirement to configure
> cgroups for resource management, as well as functional requirement for
> deployment of PREEMPT_RT patch.
> 
> cgroups in general can be used in this context, in particular for
> managing resources such as memory; and even for managing CPU time for
> non-RT tasks. 
> 
> 
> However, we do see a potential problem with RT tasks, and how the CPU
> controller would work with the RT scheduling.
> 
> There is some obvious concern here, and this seems to be backed by what I
> find online regarding this question.
> 
> 
> 
> Can you help us to clarify what is the current state of implementation,
> and if there is any support for cgroup CPU controller configuration to
> work effectively with PREEMPT_RT for RT tasks? 
> 
> 
> Thanks 
> 
> Elana
> 
> 
> 
> 
> 

