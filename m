From: John Stultz <john.stultz@linaro.org>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Mon, 21 Jan 2013 11:08:22 -0800
Message-ID: <50FD9226.6020206@linaro.org>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com> <alpine.LFD.2.02.1210311949400.2756@ionos> <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com> <50A55664.2090605@us.ibm.com> <OF701783A6.DD321DA8-ON86257AD9.0065C5C7-86257AD9.0071DB52@ni.com> <50D22A41.2070503@linaro.org> <20130105040946.GA17645@netboy.at.omicron.at> <OF48F68A41.A33D8F99-ON86257AFA.0053184D-86257AFA.0055C08D@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Richard Cochran <richardcochran@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Scot Salmon <scot.salmon@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:33085 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab3AUTIZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Jan 2013 14:08:25 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so2828424dam.4
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jan 2013 11:08:24 -0800 (PST)
In-Reply-To: <OF48F68A41.A33D8F99-ON86257AFA.0053184D-86257AFA.0055C08D@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/21/2013 07:36 AM, Scot Salmon wrote:
>
> One drawback of that solution for me is that for the specific clocks I
> care about (MONO and REAL) it is not optimal.  The delta between those two
> clocks is available in the kernel timekeeping data, so a syscall just
> handling those two would be able to get the exact offset quickly.  I'd
> still really like to be able to get that offset.
>
> One way to do that would be to take a small step along the clock_gettime2
> path and just have it return an error if the clockid's are anything other
> than MONO and REAL.  That seems ugly, but it's straightforward to
> implement, and would work for me and maybe others with basically similar
> requirements, so I'll throw it out there.  Another option is to continue
> all the way down the clock_gettime2 path, as John suggested:
>
>> Basically you need to split the current accsessor functions into two
> parts:
>> 1) The clocksource hardware read
>> 2) The time calculation, given the clocksource value
>>
>> Then for the gettime2() implementation, do a *single* read of the
>> hardware, and pass that clocksource value into the different specified
>> clockid functions.
>>
>> Another important thing to consider here, is that if we are considering
>> adding a new syscall, we should avoid the 2038 issue, and specify a new
>> time64_t and timespec64 types, and use them in the new interface. This
>> way we can provide a 64bit time interface for 32bit systems.
> This is something I'd like to work on, but it seems like a significant
> project, and I'm wondering if it might be acceptable to start with the
> reduced functionality version I mentioned above and work towards this.

Yea, its likely to be a reasonable amount of work to do it right 
(although really, its not too crazy, given its pretty limited scope - 
you're really just moving code into sub-functions). The problem with 
starting with the reduced functionality, especially when there's a sense 
of what the right approach should be, is that if we merge that, 
*someone* still has to clean things up to really finish the interface. 
So its usually not a good idea to merge such an approach unless there's 
a clear commitment and history of the submitter following through.

The exceptions for this are usually when there's some interesting 
feature, but no one knows how to best integrate it (ie: how deeply), and 
in those cases, having a reduced functionality (even hackish) 
implementation, lets folks get a better sense of the functionality and 
what it duplicates or would integrate well with. In those cases, having 
something merged to learn from is more valuable.

Now, as far as the 2038 issue goes, just defining the interface to be 
64bit would be fine. You wouldn't have to convert all the internals to 
64bits for just the interface to be useful (since converting the 
internals to be 64bits is something on my todo already, and on 64bit 
systems it would already be supported).


> As a side note, Richard mentioned that the idea of a CLOCK_TAI has been
> thrown around before.  I agree with him that it would be a useful addition
> for test & measurement applications.
Yea, I've had some CLOCK_TAI patches in my tree for awhile now. However, 
its sort of half done, as I need to still integrate CLOCK_TAI hrtimer 
support before it can properly be merged. I've not had the time recently 
to finish this, but I'm hoping to get to it before too long (or so I've 
said for the last few releases).

thanks
-john
