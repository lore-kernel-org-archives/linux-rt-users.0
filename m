From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: nvidia bug or RT bug?
Date: Tue, 08 May 2012 11:15:00 -0400
Message-ID: <1336490100.14207.183.camel@gandalf.stny.rr.com>
References: <CAOcfFMwkXC1Ozs3+QhKUU18JY4KDzNaxAuLq34r+PQOCipSFSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:32888 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab2EHPPB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 May 2012 11:15:01 -0400
In-Reply-To: <CAOcfFMwkXC1Ozs3+QhKUU18JY4KDzNaxAuLq34r+PQOCipSFSg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2012-05-06 at 21:17 -0400, jordan wrote:
> Hey everyone.
> 
> I've been using linux-rt-3.0 series, which has been very stable using
> the nvidia proprietary drivers (pretty much flawlessly, actually). I
> had used rt-3.0 with nvidia all the way upto nvidia version 290.35. I
> never experienced any problems relating to nvidia, at all... But
> external/other reasons, recently I have upgraded to rt-3.2 which also
> seems to be working quite well. At the same time, i also upgraded my
> nvidia driver to the latest available driver, which is 302.07 (beta).
> 
> I know many of the RT devs aren't huge fans of the nvidia blob, but i
> would like to know whether this is an nvidia bug or rt bug;
> 
> [143335.564097] BUG: scheduling while atomic: irq/19-nvidia/1141/0x00000002

[..]

> 
> if this is an nvidia problem (which i assume it is), i would like to
> report it to them (and obviously, if it is an rt related bug - i would
> like to report it here.

It's both, but we don't care. Sorry. Seems that the nvidia driver is not
compatible with some of the changes that -rt has done. One is that you
can not call spinlocks after disabling preemption. If the nvidia driver
does this, it will break.

> 
> I am using an rt-patch for the nvidia driver. I simply adapted an
> existing package for my distro (Archlinux). the patch is available
> here, in case it matters;

Bring up the bug with the nvidia rt patch maintainer. That's about all
I'll say on this matter.

-- Steve



