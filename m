Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C73C7EE23
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 May 2023 14:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjEXOJn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 May 2023 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjEXOJm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 May 2023 10:09:42 -0400
Received: from freeby.mesanet.com (freeby.mesanet.com [108.95.56.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E588130
        for <linux-rt-users@vger.kernel.org>; Wed, 24 May 2023 07:09:40 -0700 (PDT)
Received: from localhost (IDENT:pcw@localhost [127.0.0.1])
        by freeby.mesanet.com (8.14.3/8.11.0) with ESMTP id 34OE9P8Z022083;
        Wed, 24 May 2023 07:09:25 -0700 (PDT)
Date:   Wed, 24 May 2023 07:09:25 -0700 (PDT)
From:   Peter Wallace <pcw@mesanet.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Rod Webster <rod@vmn.com.au>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
 NIC
In-Reply-To: <ZG1KeAke2sb3XCqX@tpad>
Message-ID: <Pine.NEB.4.64.2305240708250.21944@freeby.mesanet.com>
References: <20230516105950.kSgA5y-v@linutronix.de>
 <CANV1gkftrZvhUhXV-mJ-mYmsue3ER33cXCNmVD1bGAc6TmTHuA@mail.gmail.com>
 <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com>
 <20230519083745.AB0-5kD9@linutronix.de> <CANV1gkcah59yVOMZ-s_0TMeMEgpwOaDKSWbdL3Y2Y86RQ+UsKA@mail.gmail.com>
 <20230522093208.NtKNYiYn@linutronix.de> <CANV1gkf+m1n3bLdBg3vP3pzSxiQ1Na53TSbUvLrNNqmKVZvgQQ@mail.gmail.com>
 <ZGuAJu32i1Hf3awN@tpad> <CANV1gkcuPVZz6=BrNxWBd9SqB4ydNmJOge6Tir2xG9C050oH1w@mail.gmail.com>
 <Pine.NEB.4.64.2305221323260.9144@freeby.mesanet.com> <ZG1KeAke2sb3XCqX@tpad>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

>
> Are you guys using the realtime profiles from Tuned?
>
> Edit /etc/tuned/realtime-virtual-host-variables.conf,
>
> Then run
>
> tuned-adm profile realtime-virtual-host
>
> Note this will perform steps to isolate the configured CPU's,
> including unpinning all IRQs from the isolated CPUs,
> (which you can fix after applying the profile).
> enabling nohz_full=, rcu_nocbs=, etc (can check
> /usr/lib/tuned/realtime-virtual-host/tuned.conf and script.sh
> to see what what it (and its parent profiles) do).
>
>

I will give this a try, thanks!

Peter Wallace
Mesa Electronics
