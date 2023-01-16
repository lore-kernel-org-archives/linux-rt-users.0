Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66632C54EBE
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Jan 2023 18:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjAPSpN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjAPSom (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Jan 2023 13:44:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F267C2B634
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jan 2023 10:41:48 -0800 (PST)
Date:   Mon, 16 Jan 2023 19:41:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673894506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8G84Pmh9bjYmwFQyzQMPFYHAgt14rimO87mWnKCo9Y=;
        b=vThYwbDVOHiK+WKjpqunOeyPpiLjgtN3RYqhm6Eag39lQAnlsXOeD3TdNuDGyTZK4HHQO4
        g+RXWa2v/Fs5PudqfdRzKyV12N2i2MUfJomyW3u5shohWLTp7sKDXaqGw/54vrYZ7vi12U
        g8Q91kqV9qi7HZFfMJQQ5MvDVIbkVAxloBt1ovlkWM84lL2wwv0GwS4LO9cI7vJDhCCsDW
        G9zLJwJVD+b/HXa3ZoglkhshsrVGjBIBXIlKOtJaA43ByE2/CrJmj2OJw64iyAFH6PrP+7
        lXMMRadagY8sFdPkSNyG/bdTl4NGzkoqKb8vP/5/g1+yMkMf2yzkXc/dFg8Gnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673894506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8G84Pmh9bjYmwFQyzQMPFYHAgt14rimO87mWnKCo9Y=;
        b=4AWVDGVCE1n1TCp7EHLsbctGkcMfy2h00lwvJgK80drDf9ebSpMiV9ei7S2zHR3FiC8f3a
        +A0rDLgMIi+jJoCA==
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-numa: Use a reasonable default max CPU value.
Message-ID: <Y8WaaXViNE5dEuyc@lx-t490>
References: <Y7/aS/dW0H0CK8Oe@linutronix.de>
 <5515f090-51cf-37fd-68a-66283fb0c639@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5515f090-51cf-37fd-68a-66283fb0c639@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 16 Jan 2023, John Kacur wrote:
>
> On Thu, 12 Jan 2023, Sebastian Andrzej Siewior wrote:
>
> > numa_num_task_cpus() returns here > 100 CPUs while the system has only
> > 32 populated. The BIOS assumes that I can probably use larger CPUs (with
> > more cores) on the socket so the number of "configured CPUs" is rather
> > high.
> > For default configuration, only with the -S option, it makes sense to
> > use the current affinity instead looking at the number of possible CPUs
> > which could be brought online. It still depends on the affinity of the
> > created threads if the additional CPUs can be used. In a container setup
> > this may not be the case.
> >
> > Use sched_getaffinity() to figure out the number of possible CPUs.
...
>
> In cyclictest we have
>
> 	if (num_threads == -1)
> 		num_threads = get_available_cpus(affinity_mask);
>
>
> But the num_threads can be set to -1 in OPT_THREADS too,
> not just for OPT_SMP

A sane default for --smp, which is almost-always used in sane cyclictest
invocations, is still valuable IMHO.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
