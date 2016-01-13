From: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1 (arm64)
Date: Wed, 13 Jan 2016 11:45:54 +0000
Message-ID: <CY1PR0701MB16008257A000E21747214FEBE1CB0@CY1PR0701MB1600.namprd07.prod.outlook.com>
References: <20151223225755.GA21121@linutronix.de>
 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
 <1451632781.9800.22.camel@gmail.com>,<568CF08F.3070001@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568CF08F.3070001@caviumnetworks.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi All,

I am trying to boot linux kernel 4.4.rc7 with the 4.4-rc6-rt1 patch on =
Cavium thunderX arm64 platform
Below is the bootlog with errors. =A0




=2E.....

=A0
ata4: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata1.00: ATA-8: WDC WD5003ABYZ-011FA0, 01.01S03, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0WDC WD5003ABYZ-0 1S0=
3 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't su=
pport DPO or FUA
=A0sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
sched: RT throttling activated
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 82
NOHZ: local_softirq_pending 82
NOHZ: local_softirq_pending 82
NOHZ: local_softirq_pending 82
NOHZ: local_softirq_pending 82
NOHZ: local_softirq_pending 82
NOHZ: local_softirq_pending 82
NOHZ: local_softirq_pending 82
NOHZ: local_softirq_pending 82
ata1.00: exception Emask 0x0 SAct 0x4000 SErr 0x0 action 0x6 frozen
ata1.00: failed command: READ FPDMA QUEUED
ata1.00: cmd 60/08:70:00:08:20/00:00:00:00:00/40 tag 14 ncq 4096 in
=A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (t=
imeout)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata1.00: revalidation failed (errno=3D-5)
ata1: hard resetting link
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata1.00: revalidation failed (errno=3D-5)
ata1.00: disabled
ata1.00: device reported invalid CHS sector 0
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata1: EH complete
sd 0:0:0:0: [sda] tag#16 UNKNOWN(0x2003) Result: hostbyte=3D0x04 driver=
byte=3D0x00
sd 0:0:0:0: [sda] tag#16 CDB: opcode=3D0x28 28 00 00 20 08 00 00 00 08 =
00
blk_update_request: I/O error, dev sda, sector 2099200
EXT4-fs (sda2): Can't read superblock on 2nd try
sd 0:0:0:0: [sda] tag#18 UNKNOWN(0x2003) Result: hostbyte=3D0x04 driver=
byte=3D0x00
sd 0:0:0:0: [sda] tag#18 CDB: opcode=3D0x28 28 00 00 20 08 02 00 00 02 =
00
blk_update_request: I/O error, dev sda, sector 2099202
EXT4-fs (sda2): unable to read superblock
sd 0:0:0:0: [sda] tag#20 UNKNOWN(0x2003) Result: hostbyte=3D0x04 driver=
byte=3D0x00
sd 0:0:0:0: [sda] tag#20 CDB: opcode=3D0x28 28 00 00 20 08 02 00 00 02 =
00
blk_update_request: I/O error, dev sda, sector 2099202
EXT2-fs (sda2): error: unable to read superblock
sd 0:0:0:0: [sda] tag#22 UNKNOWN(0x2003) Result: hostbyte=3D0x04 driver=
byte=3D0x00
sd 0:0:0:0: [sda] tag#22 CDB: opcode=3D0x28 28 00 00 20 08 00 00 00 01 =
00
blk_update_request: I/O error, dev sda, sector 2099200
=46AT-fs (sda2): unable to read boot sector
VFS: Cannot open root device "sda2" or unknown-block(8,2): error -5
Please append a correct "root=3D" boot option; here are the available p=
artitions:
0800 =A0 =A0 =A0 488386584 sda =A0driver: sd
=A0 0801 =A0 =A0 =A0 =A0 1048576 sda1 60ff81a8-b24d-49ac-bcf4-c8dd8fc66=
cba
=A0 0802 =A0 =A0 =A0 =A033800192 sda2 7549f29b-11b1-4284-9d21-efd6a9d8d=
fc1
=A0 0803 =A0 =A0 =A0 453536768 sda3 92c94e3c-2c71-4e1b-82d4-804bb7a68b8=
a


=A0 0802 =A0 =A0 =A0 =A033800192 sda2 7549f29b-11b1-4284-9d21-efd6a9d8d=
fc1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0
=A0 0803 =A0 =A0 =A0 453536768 sda3 92c94e3c-2c71-4e1b-82d4-804bb7a68b8=
a
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-blo=
ck(8,2)
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-rc7-rt1+ #11Call trace:
[<fffffe0000096a3c>] dump_backtrace+0x0/0x11c
[<fffffe0000096b6c>] show_stack+0x14/0x1c
[<fffffe000030a37c>] dump_stack+0x88/0xa8
[<fffffe000014be34>] panic+0xf0/0x23c
[<fffffe0000850ec4>] mount_block_root+0x1b8/0x25c
[<fffffe0000851090>] mount_root+0x128/0x144
[<fffffe00008511e8>] prepare_namespace+0x13c/0x184
[<fffffe0000850b54>] kernel_init_freeable+0x1d0/0x1f4
[<fffffe00005c7524>] kernel_init+0x10/0xd8
[<fffffe0000093980>] ret_from_fork+0x10/0x50
CPU2: stopping
