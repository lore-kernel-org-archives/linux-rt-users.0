From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Slab error in kmem_cache_destroy(): Can't free all objects -- on
 rmmod
Date: Fri, 7 Oct 2011 10:18:50 -0300
Message-ID: <20111007131850.GA14351@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47008 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab1JGNS7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Oct 2011 09:18:59 -0400
Received: by wyg34 with SMTP id 34so3876567wyg.19
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Oct 2011 06:18:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I did a simple test to modprobe and remove a module and hit a scary WARNING
in the slab code. I was able to reproduce this issue usually in the first
attempt but in a few tests I had to repeat the modprobe/rmmod a few times.

I tried a few modules and the ones that triggered the issue were cifs and
nfs.

=== clean boot ===

[root@neverland ~]# modprobe cifs; rmmod cifs

[ 1818.065143] slab error in kmem_cache_destroy(): cache `cifs_mpx_ids':
Can't free all objects
[ 1818.065149] Pid: 8512, comm: rmmod Not tainted 3.0.6-rt16+ #21
[ 1818.065151] Call Trace:
[ 1818.065160]  [<ffffffff810faf07>] kmem_cache_destroy+0x81/0xd0
[ 1818.065172]  [<ffffffffa0528769>] cifs_destroy_mids+0x21/0x23 [cifs]
[ 1818.065182]  [<ffffffffa0528982>] exit_cifs+0x26/0x2d [cifs]
[ 1818.065187]  [<ffffffff810755ca>] sys_delete_module+0x1ba/0x22c
[ 1818.065208]  [<ffffffff8108ebfa>] ? audit_syscall_entry+0x11c/0x148
[ 1818.065212]  [<ffffffff813c25c2>] system_call_fastpath+0x16/0x1b
[ 1818.065362] slab error in kmem_cache_destroy(): cache `cifs_small_rq':
Can't free all objects
[ 1818.065364] Pid: 8512, comm: rmmod Not tainted 3.0.6-rt16+ #21
[ 1818.065366] Call Trace:
[ 1818.065368]  [<ffffffff810faf07>] kmem_cache_destroy+0x81/0xd0
[ 1818.065375]  [<ffffffffa05287a4>] cifs_destroy_request_bufs+0x39/0x3b
[cifs]
[ 1818.065381]  [<ffffffffa0528987>] exit_cifs+0x2b/0x2d [cifs]
[ 1818.065384]  [<ffffffff810755ca>] sys_delete_module+0x1ba/0x22c
[ 1818.065387]  [<ffffffff8108ebfa>] ? audit_syscall_entry+0x11c/0x148
[ 1818.065390]  [<ffffffff813c25c2>] system_call_fastpath+0x16/0x1b

[root@neverland ~]# modprobe cifs; rmmod cifs

[ 1882.573468] SLAB: cache with size 448 has lost its name
[ 1882.573474] SLAB: cache with size 128 has lost its name
[ 1882.573532] SLAB: cache with size 448 has lost its name
[ 1882.573536] SLAB: cache with size 128 has lost its name
[ 1882.573590] SLAB: cache with size 448 has lost its name
[ 1882.573594] SLAB: cache with size 128 has lost its name
[ 1882.573695] SLAB: cache with size 448 has lost its name
[ 1882.573700] SLAB: cache with size 128 has lost its name


=== reboot ===

[root@neverland ~]# modprobe nfs; rmmod nfs
[root@neverland ~]# modprobe nfs; rmmod nfs


[  164.167470] slab error in kmem_cache_destroy(): cache `nfs_read_data':
Can't free all objects
[  164.167474] Pid: 8938, comm: rmmod Not tainted 3.0.6-rt16+ #21
[  164.167476] Call Trace:
[  164.167483]  [<ffffffff810faf07>] kmem_cache_destroy+0x81/0xd0
[  164.167498]  [<ffffffffa0541312>] nfs_destroy_readpagecache+0x21/0x23
[nfs]
[  164.167510]  [<ffffffffa055a5be>] exit_nfs_fs+0x13/0x46 [nfs]
[  164.167514]  [<ffffffff810755ca>] sys_delete_module+0x1ba/0x22c
[  164.167519]  [<ffffffff8108ebfa>] ? audit_syscall_entry+0x11c/0x148
[  164.167523]  [<ffffffff813c25c2>] system_call_fastpath+0x16/0x1b
[  165.465486] SLAB: cache with size 768 has lost its name
[  165.465553] SLAB: cache with size 768 has lost its name
[  165.465602] SLAB: cache with size 768 has lost its name
[  165.465815] SLAB: cache with size 768 has lost its name
[  165.465956] SLAB: cache with size 768 has lost its name


Cheers,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
