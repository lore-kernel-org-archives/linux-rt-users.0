From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Looking for a real time IPC to be used with select
Date: Sat, 17 Apr 2010 09:55:01 +0200
Message-ID: <4BC96955.2080003@steinhoff.de>
References: <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64471 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab0DQIqq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Apr 2010 04:46:46 -0400
In-Reply-To: <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,

have a look to http://www.zeromq.org ... it does probably  what you want.

Armin Steinhoff
---
Armin Steinhoff   <as@Steinhoff-Automation.com>  
STEINHOFF Automation &  Fieldbus-Systems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
TEL +49-6431 -529366  or  -570 99 70
FAX +49-6431 - 57454  or  -570 99 80
http://www.steinhoff-automation.com

 

M. Koehrer wrote:
> Hi all,
>
> I have a real time application with a couple of threads.
> One thread is waiting on a select() call (with timeout)
> for data coming in from a UDP Ethernet socket.
> Once it gets data it does some computation and finally 
> leads to the writing of data on the UDP socket.
>
> The (simplified) code for this real time thread is:
>
> void *thread_func_A(void *arg)
> {
>   while (1)
>   {
>      rc = select(...); // Read socket with timeout_value);
>      if (rc > 0)
>      {
>         recv(.., data, .. ); // recv data from socket
>         compute(data, data2);       // Compute data and modify them to data2
>         send(..., data2, ...); // Send data2 to socket
>      }
>    }
> }
>
> This works fine.
>
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
>
> Both, threads A and B are real time threads, thus any IPC in use
> should be supported by the RT_PREEMPT patch.
>
> Setup: PC (Core2Quad, kernel 2.6.31.2-rt13)
>
> Thanks for any feedback on this question.
>
> Regards
>
> Mathias
>
>
>
>   

