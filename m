From: FC <prd.gtt@operamail.com>
Subject: Re: [BUG] 2.6.33.2-rt13 and iptables
Date: Tue, 27 Apr 2010 19:03:29 +0200
Message-ID: <hr75d4$edc$1@dough.gmane.org>
References: <hr1vm2$2tk$1@dough.gmane.org> <alpine.LFD.2.00.1004271012280.2951@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:38333 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003Ab0D0RDn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Apr 2010 13:03:43 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1O6oCC-0004SL-Oy
	for linux-rt-users@vger.kernel.org; Tue, 27 Apr 2010 19:03:40 +0200
Received: from dynamic-adsl-84-222-164-32.clienti.tiscali.it ([84.222.164.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 27 Apr 2010 19:03:40 +0200
Received: from prd.gtt by dynamic-adsl-84-222-164-32.clienti.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 27 Apr 2010 19:03:40 +0200
In-Reply-To: <alpine.LFD.2.00.1004271012280.2951@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 27/04/2010 10:13, Thomas Gleixner wrote:
> On Sun, 25 Apr 2010, FC wrote:
>
>> - Updated Debian SID x86 32 bit
>> - kernel 2.6.33.2-rt13
>> - iptables v1.4.6
>>
>> I've experimented some problems while displaying processed packets by
>> iptables ( iptables -L -n -v ). The output displays a large number of
>> processed packets with a very low network activity in my LAN ( max 1 hundred
>> of packets delivered )
>>
>> A sample output obtained after loading iptables rules and quite immediately
>> running iptables -L -n -v
>
> Can you please test the patch below on top of -rt ?
>
> Thanks,
>
> 	tglx
>

The problem doesn't occur with kernel 2.6.33.3-rt14 which includes your 
patch.

The same sample output displayed under the same conditions ( loading 
rules , typing iptables -L -n -v )

Chain bad_packets (1 references)
  pkts bytes target     prot opt in     out     source 
destination
     0     0 LOG        all  --  *      *       0.0.0.0/0 
0.0.0.0/0           state INVALID LOG flags 0 level 4 prefix 
`fp=bad_packets:1 a=DROP '
     0     0 DROP       all  --  *      *       0.0.0.0/0 
0.0.0.0/0           state INVALID
   316 21488 bad_tcp_packets  tcp  --  *      *       0.0.0.0/0 
    0.0.0.0/0
   317 21635 RETURN     all  --  *      *       0.0.0.0/0 
0.0.0.0/0

Chain bad_tcp_packets (1 references)
  pkts bytes target     prot opt in     out     source 
destination
     0     0 LOG        tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:!0x17/0x02 state NEW LOG flags 0 level 4 
prefix `fp=bad_tcp_packets:1 a=DROP '
     0     0 DROP       tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:!0x17/0x02 state NEW
     0     0 LOG        tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x3F/0x00 LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:2 a=DROP '
     0     0 DROP       tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x3F/0x00
     0     0 LOG        tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x3F/0x3F LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:3 a=DROP '
     0     0 DROP       tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x3F/0x3F
     0     0 LOG        tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x3F/0x29 LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:4 a=DROP '
     0     0 DROP       tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x3F/0x29
     0     0 LOG        tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x3F/0x37 LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:5 a=DROP '
     0     0 DROP       tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x3F/0x37
     0     0 LOG        tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x06/0x06 LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:6 a=DROP '
     0     0 DROP       tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x06/0x06
     0     0 LOG        tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x03/0x03 LOG flags 0 level 4 prefix 
`fp=bad_tcp_packets:7 a=DROP '
     0     0 DROP       tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0           tcp flags:0x03/0x03
   316 21488 RETURN     tcp  --  *      *       0.0.0.0/0 
0.0.0.0/0

