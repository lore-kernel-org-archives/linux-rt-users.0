Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC849C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D846124A
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhKEReU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhKEReS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Nov 2021 13:34:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1196C061714;
        Fri,  5 Nov 2021 10:31:38 -0700 (PDT)
Date:   Fri, 5 Nov 2021 18:31:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636133497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ts8j1QROyL2Q1IkqPuaPqGQfSd91bT1/QUKgYhlETfA=;
        b=pIJ4gcsilQz9T2mLMe84k+lon0OBooO7M1PPqdGumxoRc8u6h8zxSi0PX7L7z1Sse09Mui
        /FkXhizaEWjl4ypDTMcspYlXPFTK3zG5SZqPjhbw190N3A7nKIMbGHmaF+ON+AjwXaztts
        KPEmpamDqGHsaBl1YPzQyEjxVvnfkslhIXWwYcRPhinHbOHaz60JRD+XBw58GyoJpBOvWn
        lNqDohKz8H446B9gGEgzvjiPQvh7v4hGzzSQXZy3hGNrv3Wmc4LPSXi+0X3ZW+Seywt1CF
        TvjfZcg9dhjsHI+ILe6SsQHDZ5BAi93VbuJ9GjveOXdlZ7IeOHdBnnaBw9L4qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636133497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ts8j1QROyL2Q1IkqPuaPqGQfSd91bT1/QUKgYhlETfA=;
        b=iNFiBit3u8oqCoNk1GJA1+OnOpRF7qh/YQ/qLTK0TrMt8xUKwRdIQRoFr+u5jLuzm4yqm6
        01OdFOyc+5W0sLDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Luis Goncalves <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of raw_v6_hashinfo.lock in
 raw_seq_start()
Message-ID: <20211105173136.4sej6bfbvejzebph@linutronix.de>
References: <YVuwBEWw4F7NGUd2@uudg.org>
 <20211011163333.2o64amr4qks4gpdm@linutronix.de>
 <CAD8J---eDMZb7Z39vYLY+vZZYhvTokv3NgsCCa=oJhH_hTYH6w@mail.gmail.com>
 <20211027090650.fqpqtze6wfetihej@linutronix.de>
 <CAD8J---Dxofu+k3yxyMxvUBd5sQfBZEHM8N3Q-S8f8-1dfa4Fw@mail.gmail.com>
 <20211105171816.3osasfqdxcv7wjr4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211105171816.3osasfqdxcv7wjr4@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-05 18:18:16 [+0100], To Luis Goncalves wrote:
> On 2021-11-04 15:48:46 [-0300], Luis Goncalves wrote:
> > Yes, sure!
> > 
> > Just as a reminder, I was able to reproduce that backtrace in v5.14-rt
> > up to v5.14-rc6-rt11. But starting from v5.14-rc7-rt12 I no longer
> > reproduced the problem.
> 
> So I'm about to this but patch but this mail confused me. Can you bisect
> which change is responsible for that? Based on the arguing, the same
> callchain should exist in v5.15, too. And a diff
> v5.14-rc6-rt11..v5.14-rc7-rt12 didn't show any change in that area.

Just to be clear:
- raw_seq_start() does read_lock(&h->lock) which is fine on its own.
- raw_seq_show() does local_bh_disable() via sock_i_ino() which nests
  into the former lock. So the problem as lockdep says is:
  
   Thread1                           Thread2
  raw_seq_start()
   -> read_lock(&h->lock)
                                     raw_hash_sk()
				     -> write_lock_bh(&h->lock)
				        -> local_bh_disable()
					-> write_lock(&h->lock) // blocks on T1
  raw_seq_show()
  -> sock_i_ino()
     -> local_bh_disable() // blocks on T2

and is valid on the same CPU.

Sebastian
