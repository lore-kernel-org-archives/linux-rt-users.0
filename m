From: Manfred Gruber <m.gruber@tirol.com>
Subject: BUG on Voluntary Kernel Preemption
Date: Sun, 22 Jul 2007 19:16:07 +0200
Message-ID: <200707222022.53744.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:29083 "EHLO
	viefep17-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757736AbXGVSW5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 Jul 2007 14:22:57 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi !

I use 2.6.21.5-rt20 on armv4t . When I mount a sd-card on a usb-sd-card reader 
and scp a file to the sd-card i get a bug on Voluntary Kernel Preemption. 
Does someone have an idea ?

On:
2.6.21.5-rt20 No Forced Preemption (Server) --> No problem
2.6.21.5-rt20 Complete Preemption (Real-Time) --> No Problem
2.6.22 linus tree With Preemptible Kernel (EXPERIMENTAL) --> No Problem
2.6.22 linus tree Without Preemptible Kernel (EXPERIMENTAL) --> No Problem

With Voluntary Kernel Preemption 2.6.21.5-rt20 (Desktop) i get:

[root@micro9]\# mount /dev/sdd1 /mnt                                                                                                                                                                  
then scp a 15 MB file
[root@micro9]\# BUG: at kernel/sched.c:5030 cond_resched_softirq()                                                                                                                                    
[<c0025628>] (dump_stack+0x0/0x28) from [<c025d1c0>] 
(cond_resched_softirq+0x60/0xb8)                                                                                                                 
[<c025d160>] (cond_resched_softirq+0x0/0xb8) from [<c01b5090>] 
(release_sock+0x64/0xb4)                                                                                                               
 r4 = C18C4458                                                                                                                                                                                        
[<c01b502c>] (release_sock+0x0/0xb4) from [<c01e1040>] 
(tcp_sendmsg+0xad0/0xbf4)                                                                                                                      
 r7 = C15B6504  r6 = 00000030  r5 = C1BF4048  r4 = C1A97CD0                                                                                                                                           
[<c01e0570>] (tcp_sendmsg+0x0/0xbf4) from [<c01fd5f0>] 
(inet_sendmsg+0x60/0x68)                                                                                                                       
[<c01fd590>] (inet_sendmsg+0x0/0x68) from [<c01b24e0>] 
(sock_aio_write+0xec/0xf4)                                                                                                                     
 r7 = C1CB5F28  r6 = C1B5C7CC  r5 = 00000030  r4 = C1CB5E98                                                                                                                                           
[<c01b23f4>] (sock_aio_write+0x0/0xf4) from [<c0091d84>] 
(do_sync_write+0xc0/0x114)                                                                                                                   
 r8 = C0020E28  r7 = C1CB5F78  r6 = C1CB5F78  r5 = C1B5C7CC                                                                                                                                           
 r4 = C1CB5E98                                                                                                                                                                                        
[<c0091cc4>] (do_sync_write+0x0/0x114) from [<c00926c8>] 
(vfs_write+0xd8/0x140)                                                                                                                       
 r6 = 00000030  r5 = 0005ADB8  r4 = C1B5C7CC                                                                                                                                                          
[<c00925f0>] (vfs_write+0x0/0x140) from [<c0092cd0>] (sys_write+0x50/0x80)                                                                                                                            
 r7 = 00000004  r6 = 00000000  r5 = 00000000  r4 = C1B5C7CC                                                                                                                                           
[<c0092c80>] (sys_write+0x0/0x80) from [<c0020c80>] 
(ret_fast_syscall+0x0/0x2c)                                                                                                                       
 r6 = 00052E34  r5 = 00000030  r4 = 00000003
-- 
thanks regards 
	Manfred Gruber
	
