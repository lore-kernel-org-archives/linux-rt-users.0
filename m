From: Wolfgang Johann BETZ <wolfgang.betz@st.com>
Subject: Re: 2.6.29.4-rt19
Date: Tue, 16 Jun 2009 15:49:40 +0200
Message-ID: <4A37A2F4.1010509@st.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0903252154040.3397@localhost.localdomain> <alpine.LFD.2.00.0904020155320.12916@localhost.localdomain> <alpine.LFD.2.00.0904031918090.12916@localhost.localdomain> <alpine.LFD.2.00.0904081937191.21577@localhost.localdomain> <alpine.LFD.2.00.0904092046440.21577@localhost.localdomain> <alpine.LFD.2.00.0904110003370.21577@localhost.localdomain> <alpine.LFD.2.00.0904181204420.21577@localhost.localdomain> <alpine.LFD.2.00.0904251500150.4529@localhost.localdomain> <alpine.LFD.2.00.0904290036500.4529@localhost.localdomain> <alpine.LFD.2.00.0905012348200.3375@localhost.localdomain> <alpine.LFD.2.00.0905130122250.3561@localhost.localdomain> <alpine.LFD.2.00.0905221459030.3570@localhost.localdomain> <alpine.LFD.2.00
 .0906101803210.3367@localhost.localdomain> <alpine.LFD.2.00.0906121800590.3369@localhost.localdomain> <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040107060700090301090902"
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:56821 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751341AbZFPOVe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 10:21:34 -0400
In-Reply-To: <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040107060700090301090902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ciao Thomas,

this new version of the preempt-rt patch seems to be a good step forward 
with respect to a problem I have in a benchmark application I am running 
on top of a kernel v2.6.29.4 patched with it on a quad-core Intel(R) 
Xeon(R) machine. Within this benchmark I am making use of pthreads and 
semaphores and sometime it happens that a call to "sem_wait()" returns 
"-1" and sets the "errno" to "512" - which corresponds to "ERESTARTSYS" 
- which up to my poor kernel knowledge should never be delivered to the 
user space.
Now, with the new version of the preempt-rt patch, the frequency of 
these odd "sem_wait()" return values has notably diminished, though not 
completely stopped. So, I thought it might be interesting for you if I 
share a workaround with you which seems to eliminate the odd 
"sem_wait()" return values (as it did work already for preempt-rt patch 
version rt17). Note, that this for sure is not a bug fix, but just a 
workaround for which I am even not a 100% sure that it is semantically 
correct, but maybe it gives you a hint on what might still go wrong in 
the RT patch. Pls. find attach the "rcsdiff" output on file 
"kernel/futex.c" containing the workaround.

Best regards,
Wolfgang Betz


--------------040107060700090301090902
Content-Type: text/plain;
 name="futex_rcsdiff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="futex_rcsdiff.txt"

===================================================================
RCS file: kernel/RCS/futex.c,v
retrieving revision 1.1
diff -r1.1 kernel/futex.c

--------------040107060700090301090902
Content-Type: text/plain;
 name="futex_diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="futex_diff.txt"

1839a1840,1849
> 	// betzw: added WARN_ON(!signal_pending(current))
> 	if(!signal_pending(current)) {
> 	  static unsigned int warn_count = 1;
> 
> 	  // WARN_ON(!signal_pending(current));
> 	  printk(KERN_WARNING "=====> betzw: futex_wait warning #%u\n", warn_count++);
> 
> 	  // betzw: trial for a workaround
> 	  set_tsk_thread_flag(current,TIF_SIGPENDING);
> 	}
2600a2611,2619
> 
> 	// betzw: added WARN_ON(!signal_pending(current))
> 	if((ret < -256) && !signal_pending(current)) {
> 	  static unsigned int warn_count = 1;
> 
> 	  // WARN_ON(!signal_pending(current));
> 	  printk(KERN_WARNING "=====> betzw: do_futex warning (ret: %d, cmd: %d) #%u\n", -ret, cmd, warn_count++);
> 	}
> 

--------------040107060700090301090902--
