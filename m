From: "Jim Beck" <4805455@gmail.com>
Subject: Re: X86 Pentium M platform troubles at low temperatures
Date: Tue, 29 Jan 2008 14:40:14 -0800
Message-ID: <ed6c89dc0801291440l52cabd37w6c85dc5d0b50af29@mail.gmail.com>
References: <ed6c89dc0801251636i13a020e4s68a14b969003568f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:12877 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203AbYA2WkP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Jan 2008 17:40:15 -0500
Received: by an-out-0708.google.com with SMTP id d31so519230and.103
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Jan 2008 14:40:14 -0800 (PST)
In-Reply-To: <ed6c89dc0801251636i13a020e4s68a14b969003568f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Update: the RT patch seems to be irrelevant.  Something that changed
between 2.6.18 from Suse 10.2 and the vanilla 2.6.24 (not RT patched)
causes 2.6.24 to fail to boot at cold temperatures.  THis is very
strange.  It does work at normal temperatures, and Suse 10.2 works
even at the cold temperatures.  I suppose this is now no longer and
appropriate subject for RT users.  I will post future replies to the
normal kernel mailing list.

On Jan 25, 2008 4:36 PM, Jim Beck <4805455@gmail.com> wrote:
> This may sound strange, but we have a Pentium M system running
> 2.6.20-rt5 that fails to boot all the way (fails at spawning mingetty
> - then various strange behaviors) when the system is at -10 degrees C
> or less.  Oddly, it works fine if we used *unpatched* Linux.  My only
> guess can be that there is some hard-coded constants with regards to
> timers or clocks that somehow comes into play because of  some
> oscillator frequency change.  I was wondering if any of the authors
> can comment on any magic numbers or such that might be related to
> this.
>
> Of course I will let you know if I discover that I am crazy in the
> next few days.  I just wanted to run this by you to see if anyone else
> had experience with this.
>
