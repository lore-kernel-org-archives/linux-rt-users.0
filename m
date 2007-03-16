From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: [2.6.20-rt8] "Neighbour table overflow."
Date: Fri, 16 Mar 2007 17:13:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703161653400.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: linux-rt-users@vger.kernel.org, irda-users@lists.sourceforge.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:54246 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965427AbXCPQOB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Mar 2007 12:14:01 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi

After fixing the irda spinlock init bug, here's the next one I've run 
into: after a long irnet/ppp test with a periodic disturbance, whereby the 
ppp connection is broken and restored every ~20 secnds, I've got this from 
the kernel:

user.warn kernel: Neighbour table overflow.

and the system cannot build any new outgoing network connections - ppp or 
ethernet. I can connect from outside, but from the system produces:

# ping 192.168.1.1
connect: No buffer space available

where "new" connections is to new hosts. To known hosts connections can be 
further built. And, here's another one:

# ping 192.168.1.5
PING 192.168.1.5 (192.168.1.5) 56(84) bytes of data.
64 bytes from 192.168.1.5: icmp_seq=1 ttl=64 time=3.45 ms
64 bytes from 192.168.1.5: icmp_seq=1 ttl=64 time=8.34 ms (DUP!)
64 bytes from 192.168.1.5: icmp_seq=1 ttl=64 time=9.29 ms (DUP!)
64 bytes from 192.168.1.5: icmp_seq=1 ttl=64 time=11.5 ms (DUP!)
64 bytes from 192.168.1.5: icmp_seq=2 ttl=64 time=4.79 ms
64 bytes from 192.168.1.5: icmp_seq=2 ttl=64 time=7.86 ms (DUP!)
64 bytes from 192.168.1.5: icmp_seq=2 ttl=64 time=10.8 ms (DUP!)
64 bytes from 192.168.1.5: icmp_seq=2 ttl=64 time=12.0 ms (DUP!)
64 bytes from 192.168.1.5: icmp_seq=3 ttl=64 time=4.04 ms
64 bytes from 192.168.1.5: icmp_seq=3 ttl=64 time=8.17 ms (DUP!)
64 bytes from 192.168.1.5: icmp_seq=3 ttl=64 time=11.1 ms (DUP!)
64 bytes from 192.168.1.5: icmp_seq=3 ttl=64 time=13.2 ms (DUP!)

any ideas?...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
