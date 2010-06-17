From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Realtime linux kernel on multicore processor
Date: Thu, 17 Jun 2010 13:16:44 -0700
Message-ID: <4C1A82AC.1000804@us.ibm.com>
References: <AANLkTilTcAaRj49CiPgWmPkhWkDkz1CR5sHZygsHRyNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Neel Mehta <neelmehta89@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52532 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933058Ab0FQUQq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jun 2010 16:16:46 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5HJxjXE022079
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Jun 2010 15:59:45 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o5HKGjkX061190
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Jun 2010 16:16:45 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o5HKGjSl004879
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Jun 2010 16:16:45 -0400
In-Reply-To: <AANLkTilTcAaRj49CiPgWmPkhWkDkz1CR5sHZygsHRyNA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Neel Mehta wrote:
> Hi. I have 2 computers with ubuntu:
> 1. Core 2 Duo - Non realtime linux kernel
> 2. Quad core - Realtime linux kernel
> 
> Both of them are using ubuntu. I am running a process that generates 2
> threads, both of which are continuously processing something.
> 1. On core 2 duo (normal kernel): both the cores are running above 90% load.
> 2. on quad core(realtime kernel): only one core runs above 90%, and
> the other cores are not at such a high load. The core which is on high
> load keeps on alternating among the 4 cores.
> 
> So, my question is why doesnt 2 cores run on high load on quad core?
> Is there a problem in multiprocessing in realtime linux kernel? Can
> someone guide me where the source of problem could be?

I'll start with the obvious - if the same amount of work is
being done, but now on a larger number of cores, the load on
each individual core could reduce (since you don't say what
else is contributing to the load on the system, etc).

As an example of this class of behavior, look at your irq distribution.
The rotation of the load sounds a lot like it's being driven by
interrupt round-robining, for instance.

thanks,
Nivedita
