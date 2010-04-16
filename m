From: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Subject: RE: Looking for a real time IPC to be used with select
Date: Fri, 16 Apr 2010 16:30:50 -0400
Message-ID: <8C8865ED624BB94F8FE50259E2B5C5B304610C21FF@palmail03.lsi.com>
References: <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "M. Koehrer" <mathias_koehrer@arcor.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:53500 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932445Ab0DPUqz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Apr 2010 16:46:55 -0400
In-Reply-To: <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> owner@vger.kernel.org] On Behalf Of M. Koehrer
> Sent: Friday, April 16, 2010 9:13 AM
> To: linux-rt-users@vger.kernel.org
> Subject: Looking for a real time IPC to be used with select
> 
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
>         compute(data, data2);       // Compute data and modify them to
> data2
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


You could try pipe() and take a look at epoll(). My testing shows it's reasonably efficient and the epoll() API is quite flexible.  

I've thought about using eventfd() and epoll() for exactly the purpose you mention but haven't had time to try it. 

I've used select(), poll(), epoll(), siqueue(), async i/o, pipes, regular signals, etc (just waiting for the next method that fixes the asynch i/o problem, really, really, this time :-) 

Of all the techniques I've used for network smashing, the async i/o has always been problematic for me. Epoll() seems better. Using a fd for signaling always sort of bothered me but I see it all over the place even for high throughput.

I generally let epoll() time out when it isn't busy and handle messaging at that time. If you are being hammered, you might never service the IPC event, however. For me, that condition is handled by a thread watchdog -or- checking for EINTR. In this case its like a denial of service attack.

All of these (excepting eventfd, which I have not tried) seem to work OK with rt patch although have not tested latest.  

Maybe eventfd() is the "right" way to do it? 

Always a bit nervous about posting stuff like this since everyone has different experience but hope this gives you some useful ideas to work with.


-Bob
