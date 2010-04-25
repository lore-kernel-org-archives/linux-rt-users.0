From: FC <prd.gtt@operamail.com>
Subject: [BUG] 2.6.33.2-rt13 and iptables
Date: Sun, 25 Apr 2010 19:55:11 +0200
Message-ID: <hr1vm2$2tk$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58654 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450Ab0DYSAF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Apr 2010 14:00:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1O667g-0005h5-4N
	for linux-rt-users@vger.kernel.org; Sun, 25 Apr 2010 20:00:04 +0200
Received: from dynamic-adsl-84-223-199-189.clienti.tiscali.it ([84.223.199.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 25 Apr 2010 20:00:04 +0200
Received: from prd.gtt by dynamic-adsl-84-223-199-189.clienti.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 25 Apr 2010 20:00:04 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- Updated Debian SID x86 32 bit
- kernel 2.6.33.2-rt13
- iptables v1.4.6

I've experimented some problems while displaying processed packets by 
iptables ( iptables -L -n -v ). The output displays a large number of 
processed packets with a very low network activity in my LAN ( max 1 
hundred of packets delivered )

A sample output obtained after loading iptables rules and quite 
immediately running iptables -L -n -v


Chain bad_packets (1 references)
  pkts bytes target     prot opt in     out     source destination
8600M 15024815T LOG        all  --  *      *       0.0.0.0/0 0.0.0.0/0 
        state INVALID LOG flags 0 level 4 prefix `fp=bad_packets:1 a=DROP '
15024815T 15066474T DROP       all  --  *      *       0.0.0.0/0 
0.0.0.0/0           state INVALID
13777492T 15024815T bad_tcp_packets  tcp  --  *      *       0.0.0.0/0 
        0.0.0.0/0
1337099T 7793M RETURN     all  --  *      *       0.0.0.0/0 0.0.0.0/0

Chain bad_tcp_packets (1 references)
  pkts bytes target     prot opt in     out     source destination
4295M     0 LOG        tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 tcp 
flags:!0x17/0x02 state NEW LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:1 a=DROP '
41659T 288230T DROP       tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 
     tcp flags:!0x17/0x02 state NEW
41659T 257832T LOG        tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 
     tcp flags:0x3F/0x00 LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:2 a=DROP '
41659T 144115T DROP       tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 
     tcp flags:0x3F/0x00
41659T 352428T LOG        tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 
     tcp flags:0x3F/0x3F LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:3 a=DROP '
72059T 13835076T DROP       tcp  --  *      *       0.0.0.0/0  0.0.0.0/0 
           tcp flags:0x3F/0x3F
72059T 15024832T LOG        tcp  --  *      *       0.0.0.0/0  0.0.0.0/0 
           tcp flags:0x3F/0x29 LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:4 a=DROP '
113717T 72074T DROP       tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 
     tcp flags:0x3F/0x29
72059T  155G LOG        tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 
tcp flags:0x3F/0x37 LOG flags 0 level 4 prefix `fp=bad_tcp_packets:5 
a=DROP '
3498M     0 DROP       tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 tcp 
flags:0x3F/0x37
     0   15T LOG        tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 
tcp flags:0x06/0x06 LOG flags 0 level 4 prefix `fp=bad_tcp_packets:6 
a=DROP '
72059T 4305M DROP       tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 
tcp flags:0x06/0x06
15024815T 8600M LOG        tcp  --  *      *       0.0.0.0/0 0.0.0.0/0 
        tcp flags:0x03/0x03 LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:7 a=DROP '
15024815T 15024815T DROP       tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x03/0x03
15066474T 15782 RETURN     tcp  --  *      *       0.0.0.0/0 0.0.0.0/0

The problem doesn't occur with other kernels ( vanilla 2.6.33.2 , 
2.6.33-zen1 ) and the number of processed packets is displayed correctly.

