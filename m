From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 07:58:12 -0700
Message-ID: <20100915145812.GB2544@linux.vnet.ibm.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
 <201009141317.13439@zigzag.lvk.cs.msu.su>
 <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>
 <20100914094411.GB10841@pengutronix.de>
 <4C8F8500.5070002@theptrgroup.com>
 <AANLkTimq7RGABRJk=2YQasav_Xd8zC-Qzf63tJRCY12J@mail.gmail.com>
 <4C90C093.4070607@disco.unimib.it>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pradyumna Sampath <pradysam@gmail.com>,
	Jeff Angielski <jeff@theptrgroup.com>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	"Nikita V. Youshchenko" <yoush@cs.msu.su>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sergio Ruocco <ruocco@disco.unimib.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:58485 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840Ab0IOO6P (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 10:58:15 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FEhZSC024091
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 10:43:35 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8FEwEL2127434
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 10:58:14 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8FEwEFL010327
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 10:58:14 -0400
Content-Disposition: inline
In-Reply-To: <4C90C093.4070607@disco.unimib.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 15, 2010 at 02:48:19PM +0200, Sergio Ruocco wrote:
> Pradyumna Sampath wrote:
> > I agree. Hard, soft ... far too qualitative for a discussion like
> > this. Numbers, test cases and applications determine different
> > meanings of these words.
> 
> Right. Hard and Soft realtime discussions end up always in useless
> infinite loops. The *applications*' *requirements* are hard or soft.
> 
> These requirements reflect in the OS, the CPU, the IO devices, and more
> typically a convolution of all of them, depending on what the
> application does, i.e., the actual sequence of computations, OS
> syscalls, IO operations and so on...

I did a Linux Journal article on this topic a few years ago:

http://www.linuxjournal.com/article/9361

I also did a portion of a short course on this topic last year:

http://www.rdrop.com/users/paulmck/scalability/paper/ACACES2009/4-LKRT.2009.07.16a.pdf
http://www.rdrop.com/users/paulmck/scalability/paper/ACACES2009/5-AppRT.2009.07.17b.pdf

							Thanx, Paul

> > Top copy a phrase from one of the presentations from dresden.
> 
> Which presentation? I am curious to read it.
> 
> > Real-time need not always be real fast.
> 
> "Real fast is not real-time" is a catchy phrase which comes from this
> very old workshop:
> 
> http://www.langston.com/Papers/uk.pdf
> 
> I used it to motivate an investigation in the real-time properties of a
> "real fast" microkernel:
> 
> http://www.hindawi.com/journals/es/2008/234710.abs.html
> 
> Have fun!
> 
> 	Sergio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
