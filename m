From: John Kacur <jkacur@redhat.com>
Subject: Re: 2.6.33-rt4 core2duo oopses: what method to catch
Date: Mon, 1 Mar 2010 20:13:17 +0100
Message-ID: <520f0cf11003011113y6b71eb09ie70b5a341302996c@mail.gmail.com>
References: <edada484761252d21f1ea67c507f6e98.squirrel@webmail.sonic.net>
	 <alpine.LFD.2.00.1003011403250.4245@localhost.localdomain>
	 <5bdc1c8b1003010917p3b41ef6fib0fbe92732f76be0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:41661 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab0CATNS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 14:13:18 -0500
Received: by ewy20 with SMTP id 20so1483614ewy.21
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Mar 2010 11:13:17 -0800 (PST)
In-Reply-To: <5bdc1c8b1003010917p3b41ef6fib0fbe92732f76be0@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 1, 2010 at 6:17 PM, Mark Knecht <markknecht@gmail.com> wrot=
e:
> On Mon, Mar 1, 2010 at 5:11 AM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>> On Sun, 28 Feb 2010, ulmo@sonic.net wrote:
>>
>>> I'm getting kernel faults in 2.6.33-rt4 on a core 2 duo. =A0It take=
s a
>>> moment to hard-crash, so there's a chance for the output to be diag=
nosed.
>>
>> Does the same problem happen with vanilla 2.6.33 ?
>>
>>> Please point me the way to best get the diagnostic data (kernel tra=
ce).
>>>
>>> There used to be utilities to use System.map to give names to trace=
s (like
>>> sysklogd). =A0There also used to be a built-in method for System.ma=
p so the
>>> kernel could do that. =A0What's the option? =A0What are my options?=
 =A0I
>>> currently use metalog for the syslog daemon.
>>
>> CONFIG_KALLSYMS=3Dy
>> CONFIG_KALLSYMS_ALL=3Dy
>> CONFIG_KALLSYMS_EXTRA_PASS=3Dy
>>
>> CONFIG_DEBUG_BUGVERBOSE=3Dy
>>
>>> What's the easiest way to write the oops to disk while in the initr=
d? =A0I'm
>>> getting the oopses while it's doing reiserfsck, and I only have a b=
it of
>>> room in /boot to stick some output. =A0Is there a way to log to /bo=
ot the
>>> oopses, with some small initrd-fitting binary that will cull kernel
>>> logging for those and write them out? =A0Just a standard logger?
>>>
>>> After that I can try to get some output for us to look at. =A0Thank=
s.
>>
>> Either serial console - requires a serial port - or netconsole. For
>> both you need a second computer to log the output.
>>
>> Thanks,
>>
>> =A0 =A0 =A0 =A0tglx
>
> I haven't heard of netconsole before but it makes sense. I did this
> using the serial console a couple of times but none of my machines
> have serial ports anymore (and could I find the right cable these day=
s
> anyway?)
>
> Is there a good page describing how to set this up and use it?
>

In the kernel itself, Documentation/networking/netconsole.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
