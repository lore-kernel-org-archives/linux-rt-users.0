From: Remy Bohmer <linux@bohmer.net>
Subject: Re: Questions on developing applications...
Date: Wed, 4 Feb 2009 13:49:12 +0100
Message-ID: <3efb10970902040449m25379e49l3fe6d08daa2da16c@mail.gmail.com>
References: <296402.26723.qm@web28616.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Brian Ford <bsfford@yahoo.co.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:61730 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbZBDMtO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 07:49:14 -0500
Received: by qyk4 with SMTP id 4so3300778qyk.13
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Feb 2009 04:49:12 -0800 (PST)
In-Reply-To: <296402.26723.qm@web28616.mail.ukl.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Brian,

> I'm new to real time linux programming, apologies if these questions are
> very simple.

There is no such thing as stupid questions, just stupid answers ;-)

> I've recently setup a real time Linux kernel using patch-2.6.24.7-rt26
> and got the simple "Hello World" program working. However, I'm unable
> to find any guides on how to write more complex software.
> Can you tell me how to do real time inter process message passing in linux?
> I'm familiar with shared memory and pipes -- is it ok to use these in
> a real time context?

Yes, shared memory is okay, as long as you make sure the memory is
committed to the RT process.
Related to pipes you can measure the impact of it on the RT-process as
described in the wiki.

> Also, I've read that printf may not provide real time performance.
> (http://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application)
> If I use printf/printk to a X UI terminal, will the output be deterministic (take a fixed time)?

In the wiki I described the behaviour of printf/k related to the
VGA-text console which is giving very annoying behaviour, not because
of determinism, but because of other interferences on X86.
printf __usually__ only gives 1 single pagefault when it is called the
first time in a process, it is _usually_ okay to printf to a
X-based-terminal.

For all the library calls, you cannot assume determinism in the sense
of fixed execution time. Usually all the userspace libraries on a
standard Linux box are written with a general purpose in mind, NOT a
realtime/deterministic mindset.
Implementations can vary between different versions of libraries, and
even bugfix updates.
So, library calls are always RT untrustworthy, until you prove
yourself that it suites your requirements. The lower your realtime
requirements, the higher the chance library calls are suitable.
For example, glibc supports PI-mutexes, but that does not make the
implementation deterministic in the sense of fixed execution time.

Many people talk about realtime when they talk about millisecond
accuracy, others talk about microsecond accuracy.
These are all different areas, with different requirements, different
constraints, and different solutions.

If a certain library call suites your needs, depends completely on
your hardware layout and your realtime requirements.
The closer you build your code to the scheduler, and the lesser you
depend on external code, the more predictable the system becomes.
On Linux, you can only _test_ if a certain solution suits your
requirements, there is no magic book that suits everybody.
You cannot mathematically proof the RT-correctness of the system, it
is too complex, and too variable.

Just be wise and test, test, test... and test again...

> I'm also interested in building a cyclic executive scheduler to control individual process. At
> the moment I'm guessing the only way to do this would be to modify the kernel scheduler.
> Is it possible to do this at the application/process level?

Depends on how 'scheduler' looks like, and what your requirements are.

Kind Regards,

Remy
