From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: How to find long execution times in kernel threads?
Date: Tue, 30 Apr 2013 18:52:01 +0200
Message-ID: <517FF6B1.9050204@osadl.org>
References: <517FCBA3.1000909@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:60344 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760830Ab3D3Q4H (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 12:56:07 -0400
In-Reply-To: <517FCBA3.1000909@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Stano,

> I am experimenting with the cyclictest on a system running
> several RT threads to find out where some latencies are
> coming from and to get a better undertanding how the system
> behaves.
>[..]
> Basically I'd like to trace what happened between a particular
> process (not the highest priority one) was woken up until
> it got scheduled, and stop if this took longer than some
> defined time. Can this be done with the current tracing
> infrastructure?
Sure, record everything (trace-cmd record -e all) and analyze the 
traces. Use kernelshark, if you prefer a GUI. I wrote a blog article on 
this topic about three years ago:
   https://www.osadl.org/Single-View.111+M5dc445b8ee7.0.html

Once you get an idea what is going on and which traces, events and/or 
processes are particularly interesting, you may filter the recording 
(trace-cmd record --help) in order to focus on your case and to reduce 
Heisenberg.

Hope this helps,
	-Carsten.
