From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Looking for a real time IPC to be used with select
Date: Fri, 16 Apr 2010 16:12:53 +0200 (CEST)
Message-ID: <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:55994 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758418Ab0DPOM4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Apr 2010 10:12:56 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id CA589256DD8
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Apr 2010 16:12:53 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id B3A48115963
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Apr 2010 16:12:53 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id A366E2AEA83
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Apr 2010 16:12:53 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I have a real time application with a couple of threads.
One thread is waiting on a select() call (with timeout)
for data coming in from a UDP Ethernet socket.
Once it gets data it does some computation and finally 
leads to the writing of data on the UDP socket.

The (simplified) code for this real time thread is:

void *thread_func_A(void *arg)
{
  while (1)
  {
     rc = select(...); // Read socket with timeout_value);
     if (rc > 0)
     {
        recv(.., data, .. ); // recv data from socket
        compute(data, data2);       // Compute data and modify them to data2
        send(..., data2, ...); // Send data2 to socket
     }
   }
}

This works fine.

Now I have the need that another real time thread B should also be able
to trigger the "select()" in the thread_func_A() above.
This means, I should add a suitable inter-process-communication
between thread A and B that can be used with select() as well.
Having this, the thread A can be triggered by the socket or
by the IPC from thread B by adding two file desciptors to the readfds
of select().

My question is now: What kind of IPC is preferred here?
The only IPC I see is a local socket communication, however
this looks like a huge overhead for triggering...

Both, threads A and B are real time threads, thus any IPC in use
should be supported by the RT_PREEMPT patch.

Setup: PC (Core2Quad, kernel 2.6.31.2-rt13)

Thanks for any feedback on this question.

Regards

Mathias



-- 
Mathias Koehrer
mathias_koehrer@arcor.de


Traumziele - von Beschreibung bis Buchung jetzt kompakt auf den Reise-Seiten von Arcor.de! http://www.arcor.de/rd/footer.reise
