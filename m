From: Julia Cartwright <julia@ni.com>
Subject: Re: simulate load with cycletest
Date: Thu, 2 Feb 2017 08:53:47 -0600
Message-ID: <20170202145347.GT5599@jcartwri.amer.corp.natinst.com>
References: <CAJ2oMhKQkSsNqsmmJnnQ=JO9Haqoo4y10cg6JDFwAWVjt=YxnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:39309 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751730AbdBBOxv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Feb 2017 09:53:51 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMhKQkSsNqsmmJnnQ=JO9Haqoo4y10cg6JDFwAWVjt=YxnA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 02, 2017 at 07:53:55AM +0200, Ran Shalit wrote:
> Hello,

Hello Ran-

> I have followed instruction for using cycletest in:
> https://rt.wiki.kernel.org/index.php/Cyclictest
> 
> It described command lines for different scenarios.
> usually one with load and the next without load.
> Yet, I see no difference between the load 100% and no-load commands.
> 
> How can you simulate load with cycletest ?

cyclictest itself doesn't do any loading, it's common to run it with
some other processes in the background which generate a simulated load.

Keep in mind that the using a utility like the ones I've listed below is
only _simulating_ what a load _might_ be like in a real application.
The best thing to do is to actually test your application.

   - hackbench - scheduling load (nice because it's part of rt-tests)
   - stress - load-generating swiss-army knife
   - xfstests - disk / filesystem load
   - 'make -j' in a kernel source tree
   - iperf - network load
   - glxgears - gfx load

(those are the ones that come to mind, there are others I'm forgetting)

  Julia
