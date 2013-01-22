From: John Stultz <john.stultz@linaro.org>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Mon, 21 Jan 2013 18:42:41 -0800
Message-ID: <50FDFCA1.8090703@linaro.org>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com> <alpine.LFD.2.02.1210311949400.2756@ionos> <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com> <50A55664.2090605@us.ibm.com> <OF701783A6.DD321DA8-ON86257AD9.0065C5C7-86257AD9.0071DB52@ni.com> <50D22A41.2070503@linaro.org> <20130105040946.GA17645@netboy.at.omicron.at> <OF48F68A41.A33D8F99-ON86257AFA.0053184D-86257AFA.0055C08D@ni.com> <50FD9226.6020206@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Richard Cochran <richardcochran@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Scot Salmon <scot.salmon@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55958 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab3AVCmp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Jan 2013 21:42:45 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so3680646pbc.36
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jan 2013 18:42:44 -0800 (PST)
In-Reply-To: <50FD9226.6020206@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/21/2013 11:08 AM, John Stultz wrote:
> On 01/21/2013 07:36 AM, Scot Salmon wrote:
>> As a side note, Richard mentioned that the idea of a CLOCK_TAI has been
>> thrown around before.  I agree with him that it would be a useful 
>> addition
>> for test & measurement applications.
> Yea, I've had some CLOCK_TAI patches in my tree for awhile now. 
> However, its sort of half done, as I need to still integrate CLOCK_TAI 
> hrtimer support before it can properly be merged. I've not had the 
> time recently to finish this, but I'm hoping to get to it before too 
> long (or so I've said for the last few releases).

So I figured I'd spend a few minutes and try to get some progress on this.

My current tree can be found here:
http://git.linaro.org/gitweb?p=people/jstultz/linux.git;a=shortlog;h=refs/heads/fortglx/3.10/time

There's still some issues around notifying the hrtimer when the 
tai_offset changes that have to be dealt with, but if folks want to play 
around with it, I'd appreciate any feedback.

thanks
-john

