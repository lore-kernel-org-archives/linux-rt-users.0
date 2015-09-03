From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RCU splat on boot from an idle CPU
Date: Thu, 3 Sep 2015 12:53:45 -0400
Message-ID: <20150903125345.6343e76b@gandalf.local.home>
References: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
	<alpine.DEB.2.11.1509011721510.15006@nanos>
	<20150902153823.749a9f73@gandalf.local.home>
	<CA+0CQ20mdGqWn6+rsA+Q6LWiDotXW=GUj-xmWBKcCrvHC=Z_vA@mail.gmail.com>
	<20150902230729.GZ4029@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Philipp Schrader <philipp@peloton-tech.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:34597 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753199AbbICQxs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Sep 2015 12:53:48 -0400
In-Reply-To: <20150902230729.GZ4029@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2 Sep 2015 16:07:29 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

 
> > Does that look reasonable?
> > Or could this cause a problem down the road?
> 
> Looks good to me!

If it looks good to Paul, it looks good to me :-)

> 
> > Still reading up on RCUs and how they work.
> 
> Me too.  ;-)

Who are you reading up on RCUs from?

-- Steve

