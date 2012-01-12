From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Need complete Patch 3.0.12-rt30
Date: Wed, 11 Jan 2012 20:50:33 -0500
Message-ID: <1326333033.7642.62.camel@gandalf.stny.rr.com>
References: <CACpc7pfbSrqbtucWMYKyDY_mEeWsq1FQKjruTv4nZMPT1YDd_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Priyanka Gupta Jain <p.priyankagupta@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:41249 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2ALBuf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jan 2012 20:50:35 -0500
In-Reply-To: <CACpc7pfbSrqbtucWMYKyDY_mEeWsq1FQKjruTv4nZMPT1YDd_g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-01-11 at 16:52 +0530, Priyanka Gupta Jain wrote:
> hi,
> 
> I have Linux base version of Linux 3.0.12 with some in-house patches on it.
> Now, I want to add RT support in it. From where can I get the complete
> patch set.
> 
> Patch present at
> "http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/" is sort
> of incremental patch.

incr is not the directory you want. Try "older".

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/older/patch-3.0.12-rt30.patch.xz

-- Steve


