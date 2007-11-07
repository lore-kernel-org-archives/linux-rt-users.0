From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 7 Nov 2007 11:33:38 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711071129560.8572@gandalf.stny.rr.com>
References: <1194413959.8827.66.camel@localhost.localdomain> <4731C90E.7030509@gmx.net>
 <47317A05.BA47.005A.0@novell.com> <4731D580.5000902@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Dragan Noveski <perodog@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:38111 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbXKGQdn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 11:33:43 -0500
In-Reply-To: <4731D580.5000902@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 7 Nov 2007, Dragan Noveski wrote:

> Gregory Haskins wrote:
> > Doh!  Your error made me realize that I broke uniprocessor in -rt9.  Will fix right away.
> >
> > As far as -rt7 is concerned, that doesn't make a lot of sense since cpupri isnt introduced until -rt9.  Perhaps your tree was dirtied from a previous application of -rt9?  Let me know if that doesn't appear to be the case.
> >
> > Regards,
> > -Greg
> >
> >
> >
> sorry, i am not sure if i did not done some missmatch by copying the
> config file into the tree, but i am always doing 'rm -r', and unpacking
> the tree before compiling.
> i tried again the rt9 (100% without missmatching) but it does not work....
> i ll give a try with the rt6 now.
>
> very much thanks for the support and cheers,


-rt6 is broken.

I'd recommend doing the following:

 wget -O /usr/local/bin/ketchup http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt1

 mkdir tmp
 cd tmp
 ketchup -r -G 2.6.23.1-rt7

This will get you the 2.6.23.1-rt7 kernel and rename the "tmp" directory
to linux-2.6.23.1-rt7

After you compiled and install -rt7 while in the same directory you can do

 ketchup -r -G 2.6.23.1-rt10

and it will update that kernel tree to 2.6.23.1-rt10 and again rename that
directory. (2.6.23.1-rt10 which BTW has the compile fix).


-- Steve
