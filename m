From: Juuso Alasuutari <juuso.alasuutari@gmail.com>
Subject: Re: 2.6.23.8-rt11, tasks freezing
Date: Thu, 29 Nov 2007 13:25:25 +0200
Message-ID: <200711291325.26009.juuso.alasuutari@gmail.com>
References: <200711211250.39265.juuso.alasuutari@gmail.com> <Pine.LNX.4.58.0711210905530.767@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:15437 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbXK2LZd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Nov 2007 06:25:33 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1783196nfb
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Nov 2007 03:25:32 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0711210905530.767@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday 21 November 2007 16:11:48 Steven Rostedt wrote:
> On Wed, 21 Nov 2007, Juuso Alasuutari wrote:
<snip>
> > The system boots up nicely and seems to be running properly, until
> > something tips it off and some commands begin to get "jammed". What seems
> > to trigger it is accessing the hard disk, for instance doing something
> > like `grep -r foo /var`. When it happens the desktop seems mostly
> > responsive, but trying to run commands like `ls` will freeze the
> > terminal. Other commands will succeed, for instance `ps aux` works as
> > usual.
> >
> > Alt-SysRq-w shows more than one blocked pdflush task, as well as metalog
> > and whatever commands have become "jammed" so far, like `ls`.
> >
> > I'll be happy to post more information, I just need to know what. I'd
> > attach my .config here, but I can't access the computer from where I'm at
> > the moment.
>
> You can send me the .config off list. Also, if possible, the output of
> dmesg, sysrq-t and your sysrq-w as well as (try this last because it
> sometimes hangs the box hard) sysrq-L

Hi,

I sent you the output some time ago, have you had time to look at it?

Thanks,
Juuso
