From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Build failure. Typo in the 3.2.43-rt63 patch?
Date: Wed, 01 May 2013 09:38:00 -0400
Message-ID: <1367415480.30667.77.camel@gandalf.local.home>
References: <51725B53.2030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Dmitry Lysenko <dvl36.ripe.nick@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:11247 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3EANiD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 May 2013 09:38:03 -0400
In-Reply-To: <51725B53.2030204@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2013-04-20 at 12:09 +0300, Dmitry Lysenko wrote:
> Hi,

> Finally I manualy changed swake_up to swait_wake in rcutiny_plugin.h 
> (line 886).
> (don't know is it right), but kernel is builded now.
> 

That looks correct. I'll add that to the next release.

Thanks,

-- Steve


