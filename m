Return-Path: <SRS0=HWFh=7I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75217C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A732065F
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 14:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgEZOdo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 May 2020 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgEZOdn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 May 2020 10:33:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92045C03E96D
        for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2020 07:33:43 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdaeC-0004Bs-AK; Tue, 26 May 2020 16:33:40 +0200
Date:   Tue, 26 May 2020 16:33:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Elana Copperman <Elana.Copperman@mobileye.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Vladimir Kondratiev (Mobileye)" 
        <63dc4b5d-c467-4bfb-bce5-74485907c850@intel.mail.onmicrosoft.com>
Subject: Re: cgroups CPU time management + PREEMPT_RT
Message-ID: <20200526143340.ooykhoszyd4lxi2g@linutronix.de>
References: <AM0PR09MB3794D873EEAE20CD9201D14299A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
 <AM0PR09MB3794E9CFE8BA31852B712DAD99A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
 <AM0PR09MB3794F5E857CB761859BBEF0B99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
 <AM0PR09MB3794A1DA3C38B31A4A16E9DD99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
 <20200512093612.416899e1@gandalf.local.home>
 <AM0PR09MB3794A35CEC4017897544E40999BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM0PR09MB3794A35CEC4017897544E40999BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-05-12 13:41:03 [+0000], Elana Copperman wrote:
> 
> 

I think you missed to write a reply or I didn't find it.
So if this is about RT_GROUP_SCHED then it is disabled in RT because it
was once broken. Since then people asked about it and I told them to
please test it and report back what the results are but I never got a
reply back.

Sebastian
