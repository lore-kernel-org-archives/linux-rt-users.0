From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] fix migrating softirq [cause of network hang]
Date: Wed, 13 Jun 2007 19:55:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0706131954220.20636@gandalf.stny.rr.com>
References: <fa4052ef0706131414o27b2281bp81d3f5b3d3104f87@mail.gmail.com>
 <Pine.LNX.4.58.0706131723430.20636@gandalf.stny.rr.com>
 <fa4052ef0706131520x619ff3f5ke23cf649b8ff2b79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu
To: Shane <gnome42@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:64147 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbXFMXzi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jun 2007 19:55:38 -0400
In-Reply-To: <fa4052ef0706131520x619ff3f5ke23cf649b8ff2b79@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 13 Jun 2007, Shane wrote:

> On 6/13/07, Steven Rostedt <rostedt@goodmis.org> wrote:
> > > I have applied this patch to 2.6.21.4-rt13 and I think it might have
> > > solved my bizarre nfs hangage issues that cropped up lately. Thanks
> > > for tracking that down it was driving me nutz!
> > >
> > > It has only been a few hours, but if you don't hear back from me in
> > > the next day or so then it's good to go IMVHO. :)
> > >
> >
> > Hi Shane,
> >
> > That's great to hear!  Well, if it does go well, could you post to LKML
> > and linux-rt mailing lists, as well as CC'ng Ingo. Good news like this
> > should be shared ;-)
> >
> > Heh, even if it doesn't go well, you can post to the above too.
>
> Heh, I spoke too soon. This patch doesn't seem to help my problem after all. :/
>

Really?  Darn.

So it seemed to work? Just curious to why you thought it worked and but it
didn't?

-- Steve
