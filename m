From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.23.1-rt5 rtc lost interrupt
Date: Wed, 31 Oct 2007 18:55:08 +0000
Message-ID: <4728CF8C.5070407@gmx.net>
References: <47289310.4000506@gmx.net> <Pine.LNX.4.58.0710311229020.17607@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:54237 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752223AbXJaR6U (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2007 13:58:20 -0400
In-Reply-To: <Pine.LNX.4.58.0710311229020.17607@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:
> --
> When I'm asked what language is my mother tongue,
> I simply answer "C".
>
> On Wed, 31 Oct 2007, Dragan Noveski wrote:
>
>   
>> hallo list, yesterday strange thing happened here.
>> i am running 2.6.23.1-rt5, and actually it is running good, but
>> yesterday partially my keyboard stopped working. usually if i press any
>> key (inside of xterm) and do not release, but keep pressed, the
>> letter/sign will be printed all the time again and again as long as i
>> release the key.
>> something like:
>>
>> aaaaaaaaaaaaaaaaaaaaa
>>     
>
> What X drivers are you running (hopefully not nVidia or some other
> proprietary module).
>   
no it is perhaps one of these both:

00:02.0 VGA compatible controller: Intel Corporation 82852/855GM 
Integrated Graphics Device (rev 02)
00:02.1 Display controller: Intel Corporation 82852/855GM Integrated 
Graphics Device (rev 02)

...but nothing proprietary here.

>   
>> but yesterday, if i was holding the key, the letter got displayed on the
>> screen just one time.
>> if i released and pressed again, one more time.....
>> so i was not able to press only one time a key and hold to get sth like
>> these:
>>
>> ........................
>>
>> than in /var/log/system i found this lines:
>>
>>
>> Oct 30 21:22:37 murija2 kernel: rtc: lost 8 interrupts
>> Oct 30 21:22:50 murija2 kernel: rtc: lost 4 interrupts
>> Oct 30 21:22:50 murija2 kernel: rtc: lost 20 interrupts
>>     
>
> Unfortunately, this gives me no clue to what went wrong. Perhaps, you have
> a high priority process running somewhere that is keeping things from
> running.
>   

ok, but this gives me an idea, because i was just backtracing 'aqualung' 
and 'bristol synth emulator' and letting them crash again and again.
but i was not thinking that this could be causing the issue.
> What type of system is this? SMP?
>   
no, ibm-thinkpad-r50e with celeronM
>   
>> this also appeared in dmesg.
>>
>> is this explained so that someone is able to understand?
>> does any one has an idea what went wrong here?
>>
>> after a reboot the keyboard was working as usually again and the issue
>> did not happened again since them.
>>
>> hope to get some suggestions/answers?!
>>
>>     
>
> I can't figure out much with the current info.
>
> -- Steve
>
>   
i was expecting that the info i had is not info enough!

anyway, it did not appeared again, so i will not be scared too much now, 
if it comes again, you ll hear from me.

cheers,
doc
