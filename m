From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.4.106-rt131
Date: Fri, 6 Feb 2015 14:45:21 -0500
Message-ID: <20150206144521.3d50317f@gandalf.local.home>
References: <20150206131842.06b07b37@gandalf.local.home>
	<CAMjaK3D_fBFoO2p-98vfViDL5DUg7ZZ+f0eVdv_sLx8SBpyVLg@mail.gmail.com>
	<20150206144048.2a75eb8f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Dmitry Lysenko <dvl36.ripe.nick@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:53244 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753612AbbBFTpX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Feb 2015 14:45:23 -0500
In-Reply-To: <20150206144048.2a75eb8f@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 6 Feb 2015 14:40:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 6 Feb 2015 21:34:22 +0200
> Dmitry Lysenko <dvl36.ripe.nick@gmail.com> wrote:
> 
> > So 3.2.x-RTx does not supported anymore? Or maybe I missed something.
> > 
> 
> No, a regression in 3.2 was added to stable that makes 3.2-rt fail
> (and breaks 3.2 in general). I reported this to Ben Hutchings and he is
> aware of it. As I will not push out a known broken version of -rt, I'm
> waiting till another 3.2 comes out that fixes the issue.
> 

Note, if you are curious to what the regressions are, I posted them to
the list. There were two of them.

http://marc.info/?l=linux-kernel&m=142150909924885
http://marc.info/?l=linux-kernel&m=142170417702964

-- Steve

