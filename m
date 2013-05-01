From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.2.44-rt64
Date: Wed, 01 May 2013 08:26:44 -0400
Message-ID: <1367411204.30667.76.camel@gandalf.local.home>
References: <1367378464.30667.73.camel@gandalf.local.home>
	 <5180DD9B.5070509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Dmitry Lysenko <dvl36.ripe.nick@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:12285 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab3EAM0p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 May 2013 08:26:45 -0400
In-Reply-To: <5180DD9B.5070509@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2013-05-01 at 12:17 +0300, Dmitry Lysenko wrote:
> Hello,
> There is typo. Beginning from 3.2.38-rt58 patch.
> 
> At rcutiny_plugin.h:
> 
> static void invoke_rcu_callbacks(void)
> {
>          have_rcu_kthread_work = 1;
>          swake_up(&rcu_kthread_wq);
>          ~~~~~~~~
> }
> 
> swake_up does not exist in 3.2.x-rt kernel tree.
> 
> Already reported ( 
> http://www.spinics.net/lists/linux-rt-users/msg09774.html ),
> but still exists.
> 

Thanks,

This needs to be fixed in the "RT update" release. This was just a
"stable merge" release.

Luckily, I plan on doing the "RT update" releases today ;-)

-- Steve


