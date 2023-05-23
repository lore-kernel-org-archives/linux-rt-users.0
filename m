Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B250C77B75
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 May 2023 23:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjEWXXg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 May 2023 19:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbjEWXXd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 May 2023 19:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA742DA
        for <linux-rt-users@vger.kernel.org>; Tue, 23 May 2023 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684884164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u/3c8EYXY7D0jZC9M/pD6Mg8XoIouVweoYZETn7GOmA=;
        b=DnWZSYsIPb+ufJ/aF7sMxVPdq54YgtZW/hUPBzvfPOqQ27xsIntPbd1FBFi2H+KxCe4lXe
        oYbcYItzr9S8eJwKiq3Cd09bCG69PJdIsVOdciFcKsc+mWbphtx7W19uHU1iF1lZxoTRoT
        //hac5cjcJtXo3d01X+oBJnMkCmpjdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-P1PPyj0JPt-Rm1oIXIgElg-1; Tue, 23 May 2023 19:22:39 -0400
X-MC-Unique: P1PPyj0JPt-Rm1oIXIgElg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6DE0800B2A;
        Tue, 23 May 2023 23:22:38 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 924958162;
        Tue, 23 May 2023 23:22:38 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 94724400DF148; Tue, 23 May 2023 20:21:28 -0300 (-03)
Date:   Tue, 23 May 2023 20:21:28 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Wallace <pcw@mesanet.com>
Cc:     Rod Webster <rod@vmn.com.au>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
 NIC
Message-ID: <ZG1KeAke2sb3XCqX@tpad>
References: <20230516105950.kSgA5y-v@linutronix.de>
 <CANV1gkftrZvhUhXV-mJ-mYmsue3ER33cXCNmVD1bGAc6TmTHuA@mail.gmail.com>
 <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com>
 <20230519083745.AB0-5kD9@linutronix.de>
 <CANV1gkcah59yVOMZ-s_0TMeMEgpwOaDKSWbdL3Y2Y86RQ+UsKA@mail.gmail.com>
 <20230522093208.NtKNYiYn@linutronix.de>
 <CANV1gkf+m1n3bLdBg3vP3pzSxiQ1Na53TSbUvLrNNqmKVZvgQQ@mail.gmail.com>
 <ZGuAJu32i1Hf3awN@tpad>
 <CANV1gkcuPVZz6=BrNxWBd9SqB4ydNmJOge6Tir2xG9C050oH1w@mail.gmail.com>
 <Pine.NEB.4.64.2305221323260.9144@freeby.mesanet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.64.2305221323260.9144@freeby.mesanet.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, May 22, 2023 at 01:37:19PM -0700, Peter Wallace wrote:
> On Tue, 23 May 2023, Rod Webster wrote:
> 
> > Date: Tue, 23 May 2023 06:02:13 +1000
> > From: Rod Webster <rod@vmn.com.au>
> > To: Marcelo Tosatti <mtosatti@redhat.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
> >     linux-rt-users@vger.kernel.org
> > Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
> >     NIC
> > 
> > This stuff is hard! I just realised that rtapi_app is a red herring!
> > rtapi_app is Linuxcnc and there is nothing wrong with it. Its thread
> > is on a 1000us cycle so it seems it gets all its jobs done in 200us
> > and then sleeps for 800us which makes perfect sense!
> > 
> > The issue we have is deeper than that. I think we should be looking at
> > the NIC interrupt (but don't trust the novice!).
> > The network communication is consuming more than the 800us slack from
> > time to time. When that happens, our hardware sees the timing overrun
> > and increments an internal packet error count. If too many of these
> > happen in succession, the hardware decides the RT environment can't be
> > relied on, disables further communication and returns an "error
> > finishing read" to Linuxcnc to say it's given up.
> > 
> > Marcelo, we didn't resort to C. We were able to use a bash script and
> > use a linuxcnc tool called halcmd to query the hardware as shown here.
> > #!/usr/bin/bash
> > stat=0
> > while (($stat < 1))
> > do
> > stat=`halcmd getp hm2_7i96s.0.packet-error-total`
> > done
> > trace-cmd stop
> > 
> > I think we need to increase the stat threshold  so we get more samples
> > in our trace before stopping it. The current trace will only have one
> > instance.
> > Thanks for letting me see the issue more clearly.
> > 
> > 
> > Rod Webster
> > 
> 
> 
> I should note that at least for Intel MACs, the 6.3.1-rt13 and 6.4.0-rc2-rt1
> kernels seem to solve the issue. Not sure what changed but maximum read time
> is now in the 200.. 250 usec peak region (about 100 usec more than average)
> This is the peak read latency after about 3 days of videos, compiling and
> local network activity.
> 
> Sadly 6.4.0-rc3-rt2 has regressed slightly in network latency on my test
> systems
> 
> My test systems were all Intel CPUs with 4 cores, isolcpus=3 and the Ethernet
> IRQ pinned to CPU3
> 
> 
> Peter Wallace

Are you guys using the realtime profiles from Tuned?

Edit /etc/tuned/realtime-virtual-host-variables.conf,

Then run

tuned-adm profile realtime-virtual-host

Note this will perform steps to isolate the configured CPU's,
including unpinning all IRQs from the isolated CPUs,
(which you can fix after applying the profile).
enabling nohz_full=, rcu_nocbs=, etc (can check 
/usr/lib/tuned/realtime-virtual-host/tuned.conf and script.sh 
to see what what it (and its parent profiles) do).


