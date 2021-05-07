Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BACC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20593600D1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhEGQCl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbhEGQCk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:02:40 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD64C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:01:40 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i17so8922146qki.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vy/JWIki+BYxIP99howKkp5rcm1LMzux3d/exjF1EgU=;
        b=RuCOnvocLfNVF+mcajaky5B6fjeIkhvM88ouj/3/77asPVDtT1wbBMOAC4eo6QQRxh
         JiZF21izT1gGWjFNyUINThLY1lnqeIlrfysz1gDISiYMoFs2LCUMLH0uPSA1wqz/ScyA
         huf5kNFq7tmK/4od5vs4nMu7x+jLEYDf2N9B4/UrlL5EqHXbp8Tf37v4HAhYdYOyo0es
         77O1Eplc67HdZwdpVwZ0eborJFPzRJNj489jAz1s/H9fUkoNTjf9NJ+4hN1IWM6cMe2f
         hKs6H4a0PBupJlXX5MUKyb+k1DwJlG9vZLc32+z8xoHFuphG8fXcAfc36wtTB1I0EbiW
         gZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=vy/JWIki+BYxIP99howKkp5rcm1LMzux3d/exjF1EgU=;
        b=HEAXO3xYvvSmuOWO+7NUJB34kfyfqwFQWxCwZ+NU3rK+SjLxFF13oWhIYP56TszFr+
         47Ry7N0o84O/pMhksIssOatGoAvB63/VrGxOUGYlensyd/IgOHs4RDhu+OG8SA2Jc2nx
         dAeUhWr6jhrp/fWyNM/dEloLR6uJAEbUecjD88hUvN8R8ZphIGL/sLwCbBsIT4PJ+S+T
         6+oMpMtc9u/Y/Q//ivLNbOnjRgyvrLAatacBZzbcBuXP14i5MvEWixGgle4ivQhiI8zC
         jVzXKXOk0NR+ZaqmRsdNOeoFCcs0onzr9k5xBZdoHp+h1c5P+51hztP+W/O5Ep4/fSsB
         Xa6w==
X-Gm-Message-State: AOAM5303kCCNPaT2Ni4YSpjjwl7WCqTe+GDjEYrfx/kY9dwHsu6wiixg
        VXz5+r9VwDJIKRjZc9KQ42IZOy3URjgO2Q==
X-Google-Smtp-Source: ABdhPJx+FbwTgT+oV2P+wGZhBc+6LwbfmxA/cNde4FphKSKU0fGR/J+3wR4b+s5VLzTrpbZwWA3PDg==
X-Received: by 2002:a05:620a:5bd:: with SMTP id q29mr10468492qkq.226.1620403298769;
        Fri, 07 May 2021 09:01:38 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id 4sm5035404qtc.40.2021.05.07.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:01:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:01:30 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Jiafei Pan <jiafei.pan@nxp.com>
cc:     "williams@redhat.com" <williams@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] rt-tests: pi_stress: fix testing threads' smp affinity
In-Reply-To: <AS8PR04MB81825DF5E1C40EEED0C2DC2C8A579@AS8PR04MB8182.eurprd04.prod.outlook.com>
Message-ID: <bc53c555-a9ea-d9b5-e756-959e4f46990@redhat.com>
References: <20210326094404.18110-1-Jiafei.Pan@nxp.com> <AS8PR04MB81825DF5E1C40EEED0C2DC2C8A579@AS8PR04MB8182.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 7 May 2021, Jiafei Pan wrote:

> Any comments? thanks.
> 
> Best Regards,
> Jiafei.
> 
> > -----Original Message-----
> > From: Jiafei Pan <jiafei.pan@nxp.com>
> > Sent: Friday, March 26, 2021 5:44 PM
> > To: williams@redhat.com; jkacur@redhat.com
> > Cc: linux-rt-users@vger.kernel.org; Jiafei Pan <jiafei.pan@nxp.com>; Jiafei
> > Pan <jiafei.pan@nxp.com>
> > Subject: [PATCH] rt-tests: pi_stress: fix testing threads' smp affinity
> > 
> > This patch includes the following modification:
> > 1. Make sure test threads and admin threads don't run on the same CPU
> >    Core if uniprocessor is not set or not on single Core platform to
> >    avoid starve admin threads.

Doesn't the code already do this? The one exception I can think of is you 
are allowed one group of threads per online processor, so if you have the 
maximum number of groups, then one of those groups will run on the same 
processor as the admin thread. Even in this case though, the admin_thread
has the highest realtime priority.

> > 2. Force to use SCHED_RR if more than one Groups running one a CPU
> >    Core to avoid test failure because threads in different Groups
> >    are using the same priority, SCHED_FIFO which is default policy
> >    and it maybe trigger deadlock of testing threads.

Like a lot of things in realtime, we give you enough rope to hang 
yourself. We are trying to create a tool here that purposely triggers 
deadlocks that are resolved via priority inheritence in order to test 
priority inheritence, we're not trying to create a robust application that 
has safeguards to avoid this situation. So, with that in mind, why would 
we force the teste to use SCHED_RR if the user wants SCHED_FF ?

Trying to understand what you are trying to accomplish here. Is it that 
you want to get rid of the limitation of only allowing one inversion group 
per processor? If so, why is this useful?

Thanks

John

> > 
> > Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> > ---
> >  src/pi_tests/pi_stress.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> > 
> > diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c index
> > 49f89b7..8795908 100644
> > --- a/src/pi_tests/pi_stress.c
> > +++ b/src/pi_tests/pi_stress.c
> > @@ -237,6 +237,13 @@ int main(int argc, char **argv)
> >  	/* process command line arguments */
> >  	process_command_line(argc, argv);
> > 
> > +	if (ngroups > (num_processors - 1)) {
> > +		printf("Warning: One Core will used for administor thread, the other
> > CPU Core will run test thread,\n");
> > +		printf("\t it will running more than one Group on one Core (groups >
> > num_of_processors -1),\n");
> > +		printf("\t it will force to use SCHED_RR, or change groups number to
> > be lower than %ld \n", num_processors);
> > +		policy = SCHED_RR;
> > +	}
> > +
> >  	/* set default sched attributes */
> >  	setup_sched_config(policy);
> > 
> > @@ -285,9 +292,17 @@ int main(int argc, char **argv)
> >  			break;
> >  	for (i = 0; i < ngroups; i++) {
> >  		groups[i].id = i;
> > -		groups[i].cpu = core++;
> > -		if (core >= num_processors)
> > -			core = 0;
> > +		if (num_processors == 1 || uniprocessor) {
> > +			groups[i].cpu = 0;
> > +		} else {
> > +			groups[i].cpu = core;
> > +			/* Find next non-admin Core */
> > +			do {
> > +				core++;
> > +				if (core >= num_processors)
> > +					core = 0;
> > +			} while (CPU_ISSET(core, &admin_cpu_mask));
> > +		}
> >  		if (create_group(&groups[i]) != SUCCESS)
> >  			return FAILURE;
> >  	}
> > @@ -1143,7 +1158,7 @@ int create_group(struct group_parameters *group)
> >  	CPU_ZERO(&mask);
> >  	CPU_SET(group->cpu, &mask);
> > 
> > -	pi_debug("group %d bound to cpu %ld\n", group->id, group->cpu);
> > +	printf("group %d bound to cpu %ld\n", group->id, group->cpu);
> > 
> >  	/* start the low priority thread */
> >  	pi_debug("creating low priority thread\n");
> > --
> > 2.17.1
> 
> 
