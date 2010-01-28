From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Replacement for Xenomai's Message queues?
Date: Thu, 28 Jan 2010 22:50:55 +0100
Message-ID: <4B6206BF.9080708@osadl.org>
References: <4B61DDF2.6010309@us.ibm.com> <21390406.1264666196447.JavaMail.ngmail@webmail08.arcor-online.net> <5579824.1264709193179.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dvhltc@us.ibm.com, linux-rt-users@vger.kernel.org
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:33113 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912Ab0A1WAQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jan 2010 17:00:16 -0500
In-Reply-To: <5579824.1264709193179.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Mathias,

> [..] I have two real time applications (two processes), each running 
> a few real time threads. For inter process communication I want to 
> exchange data between the two applications. For this I want to use 
> two queues - one for direction A->B and one for B->A. Now I have the 
> situation that one thread in B that handles the A->B queue is
> waiting for data from A. Whenever A has the data available, it writes
> the data into the A->B queue. Immediately after receiving data from
> A, B unblocks and computes some answer data that is written into the
> B->A queue. The time between sending the data in A and getting the
> data back from B should be as low as possible (real time
> requirements: at max tens of microseconds...).
> 
> The functionality of mq_send, mq_receive looks suitable.
Alternatively, you may consider to use shared memory and to synchronize
and protect accesses to that memory with semaphores. The rt-tests suite
contains several examples of how to do it. Before using these test
programs as template for your own application, you may even run them as
they are to check whether the worst-case latency of such mechanisms fits
your requirements.

	Carsten.
