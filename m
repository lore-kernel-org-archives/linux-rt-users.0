From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.25.4-rt2
Date: Tue, 20 May 2008 02:07:11 +0200
Message-ID: <4832162F.2010006@gmx.net>
References: <1211237032.14697.76.camel@localhost.localdomain> <4832105C.4030101@gmx.net> <Pine.LNX.4.58.0805191954100.4125@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:55473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754715AbYETAHx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 20:07:53 -0400
In-Reply-To: <Pine.LNX.4.58.0805191954100.4125@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> On Tue, 20 May 2008, Dragan Noveski wrote:
>   
>> Steven Rostedt wrote:
>>     
>>> We are pleased to announce the 2.6.25.4-rt2 tree, which can be
>>> downloaded from the location:
>>>
>>>   http://rt.et.redhat.com/download/
>>>
>>>       
>> hallo, when compiling of the source is finished i get this warning:
>>
>> .....
>>   Building modules, stage 2.
>>   MODPOST 268 modules
>> WARNING: modpost: Found 5 section mismatch(es).
>> To see full details build your kernel with:
>> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>>
>>
>>
>> i would be very thankful if someone could explain what this warning is
>> about.
>> should i expect any special troubles with this kernel?
>>     
>
>
> I get that same warning. Perhaps I should turn on that config option and
> see what's the trouble ;-)
>
> So far I haven't had any problems, but that doesn't mean that there isn't
> any. I'll start looking at what's causing that.
>
> Thanks,
>
> -- Steve
>
>   
hallo steve,
thanks for the fast response!

i can boot the kernel just fine, but when i try to compile the alsa 
drivers (v1.0.16) it breaks with this error:

.....
  CC [M]  
/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/rtctimer.o
  CC [M]  
/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/timer.o
/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/timer.c: In 
function 'snd_timer_request':
/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/timer.c:155: 
error: wrong type argument to unary exclamation mark
make[3]: *** 
[/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/timer.o] 
Fehler 1
make[2]: *** 
[/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore] Fehler 2
make[1]: *** 
[_module_/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16] Fehler 2
make[1]: Leaving directory `/usr/src/linux-2.6.25'
make: *** [compile] Fehler 2


...............

no idea if it is in any kind related, but it happens with both, 25.4-rt1 
and rt2, but alsa drivers just compiling fine with 24.7-rt7 you 
announced just today.

cheers,
doc
