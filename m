From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: Looking for a real time IPC to be used with select
Date: Sat, 17 Apr 2010 16:42:59 +0200
Message-ID: <r2r6d09081c1004170742ia4f0b1c5vfa51005c934617fd@mail.gmail.com>
References: <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:64134 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab0DQOnE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Apr 2010 10:43:04 -0400
Received: by ewy20 with SMTP id 20so1100922ewy.1
        for <linux-rt-users@vger.kernel.org>; Sat, 17 Apr 2010 07:43:01 -0700 (PDT)
In-Reply-To: <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 16, 2010 at 4:12 PM, M. Koehrer <mathias_koehrer@arcor.de> wrote:

> Now I have the need that another real time thread B should also be able
> to trigger the "select()" in the thread_func_A() above.
> This means, I should add a suitable inter-process-communication
> between thread A and B that can be used with select() as well.
> Having this, the thread A can be triggered by the socket or
> by the IPC from thread B by adding two file desciptors to the readfds
> of select().
>
> My question is now: What kind of IPC is preferred here?
> The only IPC I see is a local socket communication, however
> this looks like a huge overhead for triggering...

POSIX message queues in the kernel work fine for me. I had one problem
with the accuracy of the timeouts in mq_timedreceieve and mq_timedsend
which has been now fixed and is available as part of the latest -rt
patch.

regards
/prady

-- 
http://www.prady.in
