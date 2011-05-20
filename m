From: Pedro Gonnet <gonnet@maths.ox.ac.uk>
Subject: Question regarding pthread_cond_wait/pthread_cond_signal latencies
Date: Fri, 20 May 2011 12:15:10 +0100
Message-ID: <1305890110.10494.32.camel@laika>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay2.mail.ox.ac.uk ([163.1.2.161]:48023 "EHLO
	relay2.mail.ox.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934203Ab1ETLPM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 May 2011 07:15:12 -0400
Received: from mail.maths.ox.ac.uk ([129.67.184.16])
	by relay2.mail.ox.ac.uk with esmtp (Exim 4.75)
	(envelope-from <gonnet@maths.ox.ac.uk>)
	id 1QNNfj-0003I0-82
	for linux-rt-users@vger.kernel.org; Fri, 20 May 2011 12:15:11 +0100
Received: from nat0.maths.ox.ac.uk ([129.67.184.43] helo=[10.1.128.17])
	by mail.maths.ox.ac.uk with esmtpsa (SSL3.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <gonnet@maths.ox.ac.uk>)
	id 1QNNfj-0004gH-E6
	for linux-rt-users@vger.kernel.org; Fri, 20 May 2011 12:15:11 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi guys,

I'm currently working on a shared-memory parallel Molecular Dynamics
simulation library (http://mdcore.sourceforge.net/) geared towards
multi-core systems.

The library uses pthreads (plus some OpenMP for some simple loops) and
uses pthread_cond_wait and pthread_cond_signal to coordinate a group of
worker threads.

I've been profiling the library on different machines and kernels and
have noticed that in many cases there are significant (several ms,
measured with Intel's Vtune-thing) lags between calls to
pthread_cond_signal and the waiting thread actually getting back to
work.

I've tried the Ubuntu -rt and -preempt kernels, and the whole simulation
runs twice as slowly, despite following the advice given here:

        https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application

My question is the following: which kernel (or set of configuration
options) will minimize these latencies? And if linux-rt is the answer,
in what ways do I have to be careful when porting the simulation for
this kernel?

Cheers and thanks,
Pedro




