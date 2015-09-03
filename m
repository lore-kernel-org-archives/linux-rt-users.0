From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RCU splat on boot from an idle CPU
Date: Thu, 3 Sep 2015 13:12:34 -0400
Message-ID: <20150903131234.75abbd49@gandalf.local.home>
References: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
	<alpine.DEB.2.11.1509011721510.15006@nanos>
	<20150902153823.749a9f73@gandalf.local.home>
	<CA+0CQ20mdGqWn6+rsA+Q6LWiDotXW=GUj-xmWBKcCrvHC=Z_vA@mail.gmail.com>
	<20150902230729.GZ4029@linux.vnet.ibm.com>
	<20150903165411.GA25462@philipp-debian.peloton-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Philipp Schrader <philipp@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:48768 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757533AbbICRMh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Sep 2015 13:12:37 -0400
In-Reply-To: <20150903165411.GA25462@philipp-debian.peloton-tech.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 3 Sep 2015 09:55:46 -0700
Philipp Schrader <philipp@peloton-tech.com> wrote:


> Should I submit a patch for this or is this just a fix for my particular kernel
> configuration? I don't yet understand the code well enough to know the answer.

It should be added to the mainline -rt patches.

-- Steve

