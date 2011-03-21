From: Mike Galbraith <efault@gmx.de>
Subject: RE: kernel patch that does wonders
Date: Mon, 21 Mar 2011 03:50:25 +0100
Message-ID: <1300675825.10813.9.camel@marge.simson.net>
References: <196DF2FD54364145BB52EDC723887406@e1705>
	 ,<1300598099.10171.8.camel@marge.simson.net>
	 <SNT110-W211BD9DBA57A584FADCEC8A8B20@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Victor henri <nadaeck@hotmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:58088 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752617Ab1CUCub (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Mar 2011 22:50:31 -0400
In-Reply-To: <SNT110-W211BD9DBA57A584FADCEC8A8B20@phx.gbl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2011-03-20 at 18:18 +0100, Victor henri wrote:
> Hello Mike
> 
> >
> > On Sat, 2011-03-19 at 04:44 -0400, Madovsky wrote:
> > > www.phoronix.com/scan.php?page=article&item=linux_2637_video&num=2
> > >
> > > does anybody know this ?
> >
> > Ancient history ;-)
> >
> > > sched_autogroup_enabled=1 gives some miracles apparently
> >
> > No miracles there, it's just group scheduling showing it's good side.
> > It's in 2.6.38 if you want to give it a try.
> 
> I just checked the 2.6.38 kernel; the option is not activated by default; Is it worth a try?
> Will it help in any way? Will it lessen latency of a preemt kernel? or at least make it more solid?

It has both positive and negative sides, just like every other option.
There's only one way to find out what it will do for or to you.  Turn it
on and find out.  I use it daily.. but I turn it off when measuring max
performance, because group scheduling is not free.

If your box is always lightly loaded, you needn't bother.  You'll see no
benefit, but will pay the overhead price.  If you do interactive stuff
while box is chewing on a hefty load otoh, you may like it quite a lot.

	-Mike

