From: Manfred Gruber <m.gruber@tirol.com>
Subject: warn on 2.6.23-rc2-rt2
Date: Fri, 10 Aug 2007 20:18:42 +0200
Message-ID: <200708102018.42098.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:43924 "EHLO
	viefep16-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756789AbXHJSSo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 14:18:44 -0400
Received: from [192.168.128.5] (really [212.186.13.45])
          by viefep16-int.chello.at
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20070810181842.RBBH1686.viefep16-int.chello.at@[192.168.128.5]>
          for <linux-rt-users@vger.kernel.org>;
          Fri, 10 Aug 2007 20:18:42 +0200
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hi !

i get this on mounting nfs rootfs, and don't know what it means, can someone 
explain me that output from lockdep:

IP-Config: Complete:
      device=eth0, addr=192.168.128.18, mask=255.255.255.0, 
gw=255.255.255.255,
     host=192.168.128.18, domain=, nis-domain=(none),
     bootserver=192.168.128.5, rootserver=192.168.128.5, rootpath=
Looking up port of RPC 100003/2 on 192.168.128.5
Looking up port of RPC 100005/1 on 192.168.128.5
VFS: Mounted root (nfs filesystem).
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                            *
*        CONFIG_FUNCTION_TRACE                                              *
*        CONFIG_DEBUG_SLAB                                                  *
*        CONFIG_LOCKDEP                                                     *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Freeing init memory: 392K
stopped custom tracer.
WARNING: at kernel/lockdep.c:2733 check_flags()
[<c006f9e8>] (dump_stack+0x0/0x18) from [<c00a84e8>] (check_flags+0xac/0x188)
[<c00a843c>] (check_flags+0x0/0x188) from [<c00ac888>] 
(lock_acquire+0x78/0xc0)
[<c00ac810>] (lock_acquire+0x0/0xc0) from [<c0325a14>] 
(rt_spin_lock+0x3c/0x70)
[<c03259d8>] (rt_spin_lock+0x0/0x70) from [<c00e0ea8>] 
(kmem_cache_alloc+0x4c/0x120)
 r6:000000d0 r5:00000000 r4:c07e3840
[<c00e0e5c>] (kmem_cache_alloc+0x0/0x120) from [<c00ed8f4>] 
(getname+0x28/0xe4)
 r7:000000c4 r6:c5f19ec8 r5:00000000 r4:0008ea50
[<c00ed8cc>] (getname+0x0/0xe4) from [<c00efc38>] (__user_walk_fd+0x24/0x68)
 r6:c5f19ec8 r5:00000000 r4:ffffff9c
[<c00efc14>] (__user_walk_fd+0x0/0x68) from [<c00e80f0>] 
(vfs_lstat_fd+0x28/0x58)
 r7:000000c4 r6:00000001 r5:c5f19ec8 r4:c5f19f40
[<c00e80c8>] (vfs_lstat_fd+0x0/0x58) from [<c00e8190>] (vfs_lstat+0x20/0x24)
 r5:bee9a900 r4:c5f19f40
[<c00e8170>] (vfs_lstat+0x0/0x24) from [<c00e81b8>] (sys_lstat64+0x24/0x48)
[<c00e8194>] (sys_lstat64+0x0/0x48) from [<c006afa0>] 
(ret_fast_syscall+0x0/0x2c)
 r5:bee9acfc r4:0008ea68
irq event stamp: 14391
hardirqs last  enabled at (14390): [<c00ab49c>] trace_hardirqs_on+0x18/0x1c
hardirqs last disabled at (14391): [<c00a931c>] trace_hardirqs_off+0x18/0x1c
softirqs last  enabled at (0): [<c0088208>] copy_process+0x3e4/0x132c
softirqs last disabled at (0): [<00000000>] 0x0
eth0: no IPv6 routers present

thanks, regards
-- 
mfg
	Manfred Gruber
