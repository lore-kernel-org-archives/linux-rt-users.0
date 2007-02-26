From: Clark Williams <williams@redhat.com>
Subject: smp_processor_id() call in drain_array()
Date: Mon, 26 Feb 2007 11:40:29 -0600
Message-ID: <45E31B8D.6060708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60864 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030376AbXBZRka (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Feb 2007 12:40:30 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l1QHeTsO014403
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Feb 2007 12:40:29 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When I umount and eject my ipod while running the -rt kernel
(2.6.20-0119.rt8) I get the following trace:

- --------------------------0< snip 0<-------------------------------
usb 4-1.5: USB disconnect, address 6
printk: 6 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000000] code: khubd/164
caller is drain_array+0x15/0xf5
 [<c010503c>] dump_trace+0x63/0x1e8
 [<c01051dd>] show_trace_log_lvl+0x1c/0x39
 [<c01055d4>] show_trace+0x12/0x14
 [<c01055ea>] dump_stack+0x14/0x16
 [<c01f8481>] debug_smp_processor_id+0xa5/0xb4
 [<c017af84>] drain_array+0x15/0xf5
 [<c017b32d>] __cache_shrink+0x41/0x7e
 [<c017b490>] kmem_cache_destroy+0x58/0xca
 [<f88c1664>] scsi_destroy_command_freelist+0x51/0x5f [scsi_mod]
 [<f88c251d>] scsi_host_dev_release+0x74/0xa7 [scsi_mod]
 [<c02636d3>] device_release+0x2b/0x6d
 [<c01f3de0>] kobject_cleanup+0x44/0x64
 [<c01f3e0b>] kobject_release+0xb/0x10
 [<c01f4366>] kref_put+0x63/0x71
 [<c01f371f>] kobject_put+0x14/0x16
 [<c0263823>] put_device+0x11/0x13
 [<f88c1fb4>] scsi_host_put+0xd/0xf [scsi_mod]
 [<f9dd1c54>] release_everything+0xa9/0xad [usb_storage]
 [<f9dd1d04>] storage_disconnect+0x18/0x1b [usb_storage]
 [<c0298099>] usb_unbind_interface+0x30/0x63
 [<c0265754>] __device_release_driver+0x74/0x89
 [<c02659c4>] device_release_driver+0x1b/0x26
 [<c026516b>] bus_remove_device+0x7a/0x89
 [<c0264041>] device_del+0x142/0x19f
 [<c02968fe>] usb_disable_device+0x5f/0xbc
 [<c029314b>] usb_disconnect+0x7d/0xec
 [<c0293b54>] hub_thread+0x2e2/0x96e
 [<c013bc90>] kthread+0xb2/0xd7
 [<c0104c9b>] kernel_thread_helper+0x7/0x10
 =======================
- ---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
- ----------------------------------------
.. [<c01f8432>] .... debug_smp_processor_id+0x56/0xb4
.....[<c017af84>] ..   ( <= drain_array+0x15/0xf5)

BUG: khubd:164 task might have lost a preemption check!
 [<c010503c>] dump_trace+0x63/0x1e8
 [<c01051dd>] show_trace_log_lvl+0x1c/0x39
 [<c01055d4>] show_trace+0x12/0x14
 [<c01055ea>] dump_stack+0x14/0x16
 [<c0122b8a>] preempt_enable_no_resched+0x5a/0x5c
 [<c01f8486>] debug_smp_processor_id+0xaa/0xb4
 [<c017af84>] drain_array+0x15/0xf5
 [<c017b32d>] __cache_shrink+0x41/0x7e
 [<c017b490>] kmem_cache_destroy+0x58/0xca
 [<f88c1664>] scsi_destroy_command_freelist+0x51/0x5f [scsi_mod]
 [<f88c251d>] scsi_host_dev_release+0x74/0xa7 [scsi_mod]
 [<c02636d3>] device_release+0x2b/0x6d
 [<c01f3de0>] kobject_cleanup+0x44/0x64
 [<c01f3e0b>] kobject_release+0xb/0x10
 [<c01f4366>] kref_put+0x63/0x71
 [<c01f371f>] kobject_put+0x14/0x16
 [<c0263823>] put_device+0x11/0x13
 [<f88c1fb4>] scsi_host_put+0xd/0xf [scsi_mod]
 [<f9dd1c54>] release_everything+0xa9/0xad [usb_storage]
 [<f9dd1d04>] storage_disconnect+0x18/0x1b [usb_storage]
 [<c0298099>] usb_unbind_interface+0x30/0x63
 [<c0265754>] __device_release_driver+0x74/0x89
 [<c02659c4>] device_release_driver+0x1b/0x26
 [<c026516b>] bus_remove_device+0x7a/0x89
 [<c0264041>] device_del+0x142/0x19f
 [<c02968fe>] usb_disable_device+0x5f/0xbc
 [<c029314b>] usb_disconnect+0x7d/0xec
 [<c0293b54>] hub_thread+0x2e2/0x96e
 [<c013bc90>] kthread+0xb2/0xd7
 [<c0104c9b>] kernel_thread_helper+0x7/0x10
 =======================
- ---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
- ----------------------------------------
- --------------------------0< snip 0<-------------------------------

Should the call to smp_processor_id() in mm/slab.c be modified to a
raw_smp_processor_id() call (in the -rt patch)?

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFF4xuMHyuj/+TTEp0RAnkIAJ0eiYrOJfP6rPWQ+NRyvZuH+LGzPQCfTsZM
dvnzdI78lb8t3Vt91dp++7U=
=GAIT
-----END PGP SIGNATURE-----
