From: Alexander Gerasiov <gq@cs.msu.su>
Subject: Re: [PATCH 1/2] raid5: Use raw_spinlock for stripe management.
Date: Thu, 27 Apr 2017 18:57:41 +0300
Message-ID: <20170427185719.708758b6@brick.gerasiov.net>
References: <1493040816-24038-1-git-send-email-gq@cs.msu.su>
        <20170425154646.GK25232@jcartwri.amer.corp.natinst.com>
        <20170425210929.GN25232@jcartwri.amer.corp.natinst.com>
        <20170427183407.6b6c9d47@brick.gerasiov.net>
        <20170427154317.GQ25232@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from off.redlab-i.ru ([195.16.34.157]:52782 "EHLO mail.gerasiov.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936276AbdD0QGP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Apr 2017 12:06:15 -0400
In-Reply-To: <20170427154317.GQ25232@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Julia,

On Thu, 27 Apr 2017 10:43:17 -0500
Julia Cartwright <julia@ni.com> wrote:

> On Thu, Apr 27, 2017 at 06:34:07PM +0300, Alexander Gerasiov wrote:
> > Hello Julia,
> > 
> > On Tue, 25 Apr 2017 16:09:29 -0500
> > Julia Cartwright <julia@ni.com> wrote:
> >   
> > > Looking at this some more, I imagine the callpath which is
> > > problematic is:
> > > 
> > >    <writeback kworker>
> > >    ...
> > >    add_stripe_bio()
> > >      stripe_add_to_batch_list()
> > >        lock_two_stripes()
> > >          local_irq_disable()
> > >          spin_lock(&sh{1,2}->stripe_lock) --> ___might_sleep() -->
> > > BOOM
> > > 
> > > That is, it's the local_irq_disable() in lock_two_stripes() which
> > > is the problem.  That's my gut feel, anyway. Can you give this
> > > patch a try and see if works?  You'll probably still want the
> > > second patch in your series.  
> > 
> > Ouch, you are absolutely right, it was not atomic context this
> > time, so changing spinlocks from mutex to real ones is not
> > necessary. My fault.
> > 
> > Do you want me to resubmit the patch, or do it yourself?  
> 
> If you can confirm that the proposed patch fixes the problem you are
> seeing, I'll send a proper patch.
Yes, I confirm the fix.


-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1

-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
