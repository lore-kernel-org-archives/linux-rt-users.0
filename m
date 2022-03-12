Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C7EC433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 12 Mar 2022 15:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiCLP5n (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 12 Mar 2022 10:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiCLP5l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 12 Mar 2022 10:57:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D054F443;
        Sat, 12 Mar 2022 07:56:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35872CE0B17;
        Sat, 12 Mar 2022 15:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69156C340EB;
        Sat, 12 Mar 2022 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647100592;
        bh=TcO0NxHTbnpKvaWjE4GD70DnXuHVoDaWrcZuG2xk37g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P1Qa3UOF3+yV+edXNmyCQO6PzbMgyMZ5F+9FYjj7YCphw7vS1GndUk39esLzzEOJZ
         SaAwOFl+FOgrHjlbnybORn6a3mLXROOioetSueC5pLbmKmAsocNziT8Vbf0x+3j++J
         MPK961hDcevJhWmwcV1BmNMBO1SHKcIsdVUna5kYZR/BJLWhrGTbtHLgEprb5E7cmY
         Kxs8yFZL+ztbMQ6nX7pSol70+c4zUSIHg+EUTTxp0TMd8SoNFtS1ICDdHmyAbt4PFZ
         KB/Oq5eE8RH4olPOXAlEjBk349kI37Dk0m32ivXyLBkeOebAZi5br/oyGsNxFOvCeo
         VCoFSd2F8fmnQ==
Message-ID: <50999bd57f5dacee8cf2077bec6de3bf275e6d75.camel@kernel.org>
Subject: Re: [ANNOUNCE] 5.4.182-rt71
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Date:   Sat, 12 Mar 2022 09:56:30 -0600
In-Reply-To: <YivIg2H6BY5KuMQ/@linutronix.de>
References: <0af02f70d3a0b3653bb3079266878f13e6682a69.camel@kernel.org>
         <YivIg2H6BY5KuMQ/@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2022-03-11 at 23:09 +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-11 15:46:23 [-0600], Tom Zanussi wrote:
> > index 79e34e98f812..e1dfb01f4623 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -802,6 +802,18 @@ struct task_struct {
> >  	/* to be used once the psi infrastructure lands upstream. */
> >  	unsigned			use_memdelay:1;
> >  #endif
> > +#ifdef CONFIG_PSI
> > +	/* Stalled due to lack of memory */
> > +	unsigned			in_memstall:1;
> > +#endif
> > +#ifdef CONFIG_PAGE_OWNER
> > +	/* Used by page_owner=on to detect recursion in page tracking.
> > */
> > +	unsigned			in_page_owner:1;
> > +#endif
> 
> the upper two don't look like they belong here.

You're right, they don't - I missed those when fixing the conflict in
this file.  Will do a new release shortly to fix that.

Thanks for reviewing and pointing it out.

Tom

> 
> > +#ifdef CONFIG_EVENTFD
> > +	/* Recursion prevention for eventfd_signal() */
> > +	unsigned			in_eventfd_signal:1;
> > +#endif
> >  
> >  	unsigned long			atomic_flags; /* Flags
> > requiring atomic access. */
> >  
> > diff --git a/localversion-rt b/localversion-rt
> 
> Sebastian

