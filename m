Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4616AC7EE23
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 May 2023 23:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjEWXGH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 May 2023 19:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjEWXGG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 May 2023 19:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1258C2
        for <linux-rt-users@vger.kernel.org>; Tue, 23 May 2023 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684883119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JdB5Sa0Dy/Mm/0tqkDUHFpXD19A8Wp3WOtAPEdO30q4=;
        b=MNzRK/c7W00VP+YwWvPIhQd7SrZGyP0lBOWomVBslKI7g2VUkjbQqDGpbCn0FkaT1zjfmD
        0Y49HEmLW5f7BLvz9tWqQPRrMZUvBq5pCDXk6ZDbacJ39PtaiHsobMnOYMIJsmGlJYGXcu
        Rw8VInzAnceH/7/laf5jCEglGgDzioE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-EkxRop5KN6qhIXgJG6dLqw-1; Tue, 23 May 2023 19:05:17 -0400
X-MC-Unique: EkxRop5KN6qhIXgJG6dLqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 722B0800888;
        Tue, 23 May 2023 23:05:17 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14ECA1121314;
        Tue, 23 May 2023 23:05:17 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id A3ABD400E7189; Tue, 23 May 2023 20:04:17 -0300 (-03)
Date:   Tue, 23 May 2023 20:04:17 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Rod Webster <rod@vmn.com.au>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
 NIC
Message-ID: <ZG1GcdTf5q9ObM5N@tpad>
References: <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
 <20230516105950.kSgA5y-v@linutronix.de>
 <CANV1gkftrZvhUhXV-mJ-mYmsue3ER33cXCNmVD1bGAc6TmTHuA@mail.gmail.com>
 <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com>
 <20230519083745.AB0-5kD9@linutronix.de>
 <CANV1gkcah59yVOMZ-s_0TMeMEgpwOaDKSWbdL3Y2Y86RQ+UsKA@mail.gmail.com>
 <20230522093208.NtKNYiYn@linutronix.de>
 <CANV1gkf+m1n3bLdBg3vP3pzSxiQ1Na53TSbUvLrNNqmKVZvgQQ@mail.gmail.com>
 <ZGuAJu32i1Hf3awN@tpad>
 <CANV1gkcuPVZz6=BrNxWBd9SqB4ydNmJOge6Tir2xG9C050oH1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANV1gkcuPVZz6=BrNxWBd9SqB4ydNmJOge6Tir2xG9C050oH1w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, May 23, 2023 at 06:02:13AM +1000, Rod Webster wrote:
> This stuff is hard! I just realised that rtapi_app is a red herring!
> rtapi_app is Linuxcnc and there is nothing wrong with it. Its thread
> is on a 1000us cycle so it seems it gets all its jobs done in 200us
> and then sleeps for 800us which makes perfect sense!
> 
> The issue we have is deeper than that. I think we should be looking at
> the NIC interrupt (but don't trust the novice!).
> The network communication is consuming more than the 800us slack from
> time to time. When that happens, our hardware sees the timing overrun
> and increments an internal packet error count. If too many of these
> happen in succession, the hardware decides the RT environment can't be
> relied on, disables further communication and returns an "error
> finishing read" to Linuxcnc to say it's given up.
> 
> Marcelo, we didn't resort to C. We were able to use a bash script and
> use a linuxcnc tool called halcmd to query the hardware as shown here.
> #!/usr/bin/bash
> stat=0
> while (($stat < 1))
> do
> stat=`halcmd getp hm2_7i96s.0.packet-error-total`
> done
> trace-cmd stop

You can also write a value to the trace before stopping it:

echo "pin high, stopping tracing!" > /sys/kernel/debug/tracing/trace_marker

Just to make sure you are seeing the trace up to the correct event.

> I think we need to increase the stat threshold  so we get more samples
> in our trace before stopping it. The current trace will only have one
> instance.
> Thanks for letting me see the issue more clearly.
> 
> 
> Rod Webster
> 
> 
> 
> Rod Webster
> 
> VMN®
> 
> www.vmn.com.au
> 
> Ph: 1300 896 832
> 
> Mob: +61 435 765 611
> 
> 
> 
> 
> On Tue, 23 May 2023 at 03:13, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > On Mon, May 22, 2023 at 08:06:39PM +1000, Rod Webster wrote:
> > > Yes, I won't be using a DKMS driver and will test with the in-tree driver.
> > > I rolled a PC back to the Debian 6.1 RT kernel and the default in-tree
> > > R8169 driver yesterday with isolcpus=2,3.
> > >
> > > I had a shot at it last night with the napi thread but was confused by
> > > the trace results so will try again.
> > > I could not see our PacketErrorTest script appearing in the trace but
> > > it stopped the trace when it should.
> >
> > Rod,
> >
> > Can you describe the PacketErrorTest script and how do you know, from
> > it, that latency has crossed the threshold? What was confusing about
> > the traces?
> >
> > Earlier you wrote:
> > I've had some feedback from a hardware supplier.
> > The Linuxcnc RT ethernet driver has a pin that reports ethernet packet
> > error count.
> > This increments when the ethernet response exceeds our real time servo
> > thread period (typically 1 ms)
> > We should be able to monitor this pin and stop the trace if it is >  0
> > without too much effort.
> >
> > So you are seeing that pin increase its value?
> >
> > When you do, you should write to the "tracing_on" file (a zero):
> >
> >         /*
> >          * if we're not tracing and the tracing_on fd is not open,
> >          * open the tracing_on file so that we can stop the trace
> >          * if we hit a breaktrace threshold
> >          */
> >         if (trace_fd < 0) {
> >                 sprintf(path, "%s/%s", fileprefix, "tracing_on");
> >                 if ((trace_fd = open(path, O_WRONLY)) < 0)
> >                         warn("unable to open tracing_on file: %s\n", path);
> >         }
> >
> >         /* now stop any trace */
> >         write(trace_fd, "0\n", 2);
> >
> > The trace file (/sys/kernel/debug/tracing/trace) should now contain
> > the trace up to the write to tracing_on file.
> >
> > Sebastian: didnt see anything weird in the traces as well:
> >
> > "Follows the delta between a list of timestamped events,
> > where each event is: "TIMESTAMP: rtapi is scheduled IN CPU-3"
> > (there is at one time only a single process scheduled in cpu-3).
> >
> > [191.050245, 191.050278]: 0.000033
> > [191.050278, 191.050293]: 0.000015
> > [191.050293, 191.050307]: 0.000014
> > [191.050307, 191.050322]: 0.000015
> > [191.050322, 191.050336]: 0.000014
> >
> > rtapi_app goes to sleep for approximately 15us, and is awakened
> > by a timer.
> >
> > [191.050336, 191.050350]: 0.000014
> > [191.050350, 191.050365]: 0.000015
> > [191.050365, 191.050379]: 0.000014
> > [191.050379, 191.050393]: 0.000014
> > [191.050393, 191.050408]: 0.000015
> > [191.050408, 191.051243]: 0.000835
> > [191.051243, 191.051272]: 0.000029
> >
> > It eventually sleeps for 800us (and this pattern repeats)".
> >
> > Perhaps tracing the system call which sends out the packet would be
> > useful as well.
> >
> > > Also our RT process did not appear to be on an isolated thread which
> > > seemed odd. I did not get as far as setting the affinity for napi.
> > >
> > > I've also installed  Bookworm RC3 on another PC with the default RT
> > > kernel on a Gigabyte Brix N3160 with an R8111/R8168 NIC and the
> > > in-tree R8169 driver.
> > > This PC historically had max latency of about 130000 ns  back with
> > > kernel 4.x and now its reporting 23000 ns with the 6.1 kernel over 24
> > > hours testing with the linuxcnc tools. Quite amazing what you guys
> > > have achieved! It will be a few days before I can lug my hardware to
> > > work to test on it as well for another data point.
> > >
> > > I really appreciate your willingness to help. This remains a
> > > frustrating issue for many Linuxcnc users who are using my compiled
> > > 6.3 kernel to get out of jail.
> > > Bear with me as I bumble my way through!
> > >
> > > Rod Webster
> > >
> > >
> > >
> > >
> > >
> > > Rod Webster
> > >
> > > VMN®
> > >
> > > www.vmn.com.au
> > >
> > > Ph: 1300 896 832
> > >
> > > Mob: +61 435 765 611
> > >
> > >
> > >
> > >
> > > On Mon, 22 May 2023 at 19:32, Sebastian Andrzej Siewior
> > > <bigeasy@linutronix.de> wrote:
> > > >
> > > > On 2023-05-19 21:41:30 [+1000], Rod Webster wrote:
> > > > > I will do some testing tomorrow now I know what's going on but I
> > > > > wonder how relevant it will be given this turnaround?
> > > >
> > > > I'm not going to look at the dkms/OOT driver. If there is an actual
> > > > problem or something odd with mainline and RT and I will look into it.
> > > > I managed to find an older box which is using the r8169 and I'm going to
> > > > boot and see if there the driver is doing something odd what I didn't
> > > > see earlier…
> > > >
> > > > Please make sure that you are using the in-tree driver. If you
> > > > experience high latencies then I'm willing to help investigate.
> > > >
> > > > > Rod Webster
> > > >
> > > > Sebastian
> > >
> > >
> >
> 
> 

