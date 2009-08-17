From: Bo Hansen <bh@newtec.dk>
Subject: kernel oops 2.6.31-rc6-rt2
Date: Mon, 17 Aug 2009 11:16:16 +0200
Message-ID: <4A891FE0.6070803@newtec.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:34838 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbZHQJfV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Aug 2009 05:35:21 -0400
Received: from [192.168.0.120] (unknown [93.165.103.94])
	by pasmtpB.tele.dk (Postfix) with ESMTP id D25E1E30DC5
	for <linux-rt-users@vger.kernel.org>; Mon, 17 Aug 2009 11:16:16 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am running the latest release on a AT91RM9200 based board. I get the 
following during bootup:
Unable to handle kernel NULL pointer dereference at virtual address 
00000000   
pgd = 
c0004000                                                                 
[00000000] 
*pgd=00000000                                                       
Internal error: Oops: 5 [#1] 
PREEMPT                                           
Modules linked 
in:                                                             
CPU: 0    Not tainted  (2.6.31-rc6-rt2 
#1)                                     
PC is at 
__wake_up_common+0x30/0x88                                            
LR is at 
__wake_up+0x3c/0x4c                                                   
pc : [<c002f420>]    lr : [<c00306e0>]    psr: 
00000013                        
sp : c3851f48  ip : fffffff4  fp : 
c3851f74                                    
r10: 00000006  r9 : 00000000  r8 : 
c0313e38                                    
r7 : 00000001  r6 : 00000001  r5 : 00000001  r4 : 
00000006                     
r3 : 00000001  r2 : 00000001  r1 : 00000006  r0 : 
c0313e38                     
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment 
kernel            
Control: c000717f  Table: 20004000  DAC: 
00000017                              
Process irq/100-eth0 (pid: 253, stack limit = 
0xc3850270)                      
Stack: (0xc3851f48 to 
0xc3852000)                                              
1f40:                   00000001 00000006 00000001 c0313e20 00000000 
00000000  
1f60: 00000000 00000000 c3851f9c c3851f78 c00306e0 c002f400 00000000 
c3850000  
1f80: c3851fa4 c0313ddc c3850000 c387bba0 00000000 c3851fa0 c00640a0 
c00306b4  
1fa0: c024ffb4 00000032 c3821e30 c3821e30 c387bba0 c0063f7c 00000000 
c004b810  
1fc0: 00000000 00000000 c3851fc8 c3851fc8 c3851fd0 c3851fd0 00000000 
00000000  
1fe0: c3851fe0 c3851fe0 00000000 00000000 00000000 c00257a0 13dc7148 
338c31c4  
[<c002f420>] (__wake_up_common+0x30/0x88) from [<c00306e0>] 
(__wake_up+0x3c/0x4)
[<c00306e0>] (__wake_up+0x3c/0x4c) from [<c00640a0>] 
(irq_thread+0x124/0x1ac)  
[<c00640a0>] (irq_thread+0x124/0x1ac) from [<c004b810>] 
(kthread+0x7c/0x84)    
[<c004b810>] (kthread+0x7c/0x84) from [<c00257a0>] 
(kernel_thread_exit+0x0/0x8)
Code: e1a0a001 e1a08000 e1a06002 e59b9004 
(e59c300c)                           
---[ end trace 3cc2d5361266da66 
]---                                           
exiting task "irq/100-eth0" (253) is an active IRQ thread (irq 0) 

The systems boots and seems to be running ok, although I noticed that 
network activity
results in a higher worst case latency in cyclictest than with 2.6.29-rt23.

Best regards,
Bo

