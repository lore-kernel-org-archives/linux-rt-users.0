From: Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.33-rt4 core2duo oopses: what method to catch
Date: Mon, 1 Mar 2010 09:17:09 -0800
Message-ID: <5bdc1c8b1003010917p3b41ef6fib0fbe92732f76be0@mail.gmail.com>
References: <edada484761252d21f1ea67c507f6e98.squirrel@webmail.sonic.net>
	 <alpine.LFD.2.00.1003011403250.4245@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f179.google.com ([209.85.222.179]:49648 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab0CARYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 12:24:06 -0500
Received: by pzk9 with SMTP id 9so2060214pzk.25
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Mar 2010 09:24:06 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1003011403250.4245@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 1, 2010 at 5:11 AM, Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> On Sun, 28 Feb 2010, ulmo@sonic.net wrote:
>
>> I'm getting kernel faults in 2.6.33-rt4 on a core 2 duo. =C2=A0It ta=
kes a
>> moment to hard-crash, so there's a chance for the output to be diagn=
osed.
>
> Does the same problem happen with vanilla 2.6.33 ?
>
>> Please point me the way to best get the diagnostic data (kernel trac=
e).
>>
>> There used to be utilities to use System.map to give names to traces=
 (like
>> sysklogd). =C2=A0There also used to be a built-in method for System.=
map so the
>> kernel could do that. =C2=A0What's the option? =C2=A0What are my opt=
ions? =C2=A0I
>> currently use metalog for the syslog daemon.
>
> CONFIG_KALLSYMS=3Dy
> CONFIG_KALLSYMS_ALL=3Dy
> CONFIG_KALLSYMS_EXTRA_PASS=3Dy
>
> CONFIG_DEBUG_BUGVERBOSE=3Dy
>
>> What's the easiest way to write the oops to disk while in the initrd=
? =C2=A0I'm
>> getting the oopses while it's doing reiserfsck, and I only have a bi=
t of
>> room in /boot to stick some output. =C2=A0Is there a way to log to /=
boot the
>> oopses, with some small initrd-fitting binary that will cull kernel
>> logging for those and write them out? =C2=A0Just a standard logger?
>>
>> After that I can try to get some output for us to look at. =C2=A0Tha=
nks.
>
> Either serial console - requires a serial port - or netconsole. For
> both you need a second computer to log the output.
>
> Thanks,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tglx

I haven't heard of netconsole before but it makes sense. I did this
using the serial console a couple of times but none of my machines
have serial ports anymore (and could I find the right cable these days
anyway?)

Is there a good page describing how to set this up and use it?

Thanks,
Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
