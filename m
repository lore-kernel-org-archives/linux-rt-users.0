From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/3] rt-tests: Silence unused-but-set warning in rt-migrate-test
Date: Wed, 21 Mar 2012 18:46:49 +0100
Message-ID: <CAONaPpE0SEeQL4fnLMasPruBjTKZEYudd_DV14vP5CPgRtNVzA@mail.gmail.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
	<b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com>
	<1332338731.23924.40.camel@gandalf.stny.rr.com>
	<4F69E940.9060808@linux.intel.com>
	<CAONaPpHsCHG6QS+k9QRnQr7e1ZLEqFPHUf=-V6cw8bN+XWZPUA@mail.gmail.com>
	<1332346704.23924.42.camel@gandalf.stny.rr.com>
	<1332349901.23924.51.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Darren Hart <dvhart@linux.intel.com>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58709 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab2CURqt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 13:46:49 -0400
Received: by dajr28 with SMTP id r28so1881485daj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 10:46:49 -0700 (PDT)
In-Reply-To: <1332349901.23924.51.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 21, 2012 at 6:11 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 2012-03-21 at 12:18 -0400, Steven Rostedt wrote:
>> On Wed, 2012-03-21 at 15:56 +0100, John Kacur wrote:
>> > >
>> >
>> > Yup, shows up on my F16 machine too, with a slightly different gcc version.
>> > gcc --version
>> > gcc (GCC) 4.6.2 20111027 (Red Hat 4.6.2-1)
>>
>> Egad! This is an old version. It still uses *gasp* logdev!
>
> Oops, sorry for the confusion.
>
> I started to reply about the compiler (working) and then I saw that
> logdev was being used by rt-migrate-test. I was so shocked by the
> rt-migrate-test using logdev, I didn't start a new email and just
> replied where I left off.
>
> I didn't even notice that I left the version of gcc in my email :-p
>

Yeah, after I already hit the sent button, I thought, wait a minute,
"logdev", "ftrace", he's talking about the kernel. But once you hit
return, it's out there forever. Sigh.
My question to Darren is still valid though, assuming it is really
gcc, and he already answered that.

Thanks
John
