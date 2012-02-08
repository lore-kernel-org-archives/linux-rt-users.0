From: "Darcy Watkins" <DWatkins@tranzeo.com>
Subject: jffs2 filesystem: possible circular locking dependency detected
Date: Wed, 8 Feb 2012 10:18:30 -0800
Message-ID: <D61182AC8012EA4EBC531B3AF23BE109B3C6C6@tranzeo-mail2.12stewart.tranzeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from testserv.tranzeo.com ([64.114.87.10]:64953 "EHLO
	mail2.tranzeo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab2BHSde convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 13:33:34 -0500
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I turned on some lock validation/debugging options in the kernel to deb=
ug some softlockups that occur as soon as I bring up eth0, but in my in=
itial dmesg output, I see something that doesn't look right in the jffs=
2 driver.

Anyone seen this?

Regards,

Darcy

----------

# dmesg
[    0.000000] Linux version 3.0.18-rt34 (darcy@tr-pentomino) (gcc vers=
ion 4.4.6 (crosstool-NG 1.12.4) ) #41 PREEMPT RT Wed Feb 8 10:04:00 PST=
 2012
[    0.000000] prom: fw_arg0=3D00000000, fw_arg1=3D00000000, fw_arg2=3D=
00000000, fw_arg3=3Db804000c
[    0.000000] MyLoader: sysp=3D20021107, boardp=3D20021103, parts=3D03=
110220
[    0.000000] MyLoader: id=3D11f6:0640, sub_id=3D11f6:0640
[    0.000000] prom: board=3DWP543
[    0.000000] prom: ethaddr=3D'00:80:48:6e:ae:d1'
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU revision is: 00019374 (MIPS 24Kc)
[    0.000000] SoC: Atheros AR7130 rev 2
[    0.000000] Clocks: CPU:300.000MHz, DDR:300.000MHz, AHB:150.000MHz, =
Ref:40.000MHz
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 02000000 @ 00000000 (usable)
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00002000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00002000
[    0.000000] On node 0 totalpages: 8192
[    0.000000] free_area_init_node: node 0, pgdat 803ad320, node_mem_ma=
p 81000000
[    0.000000]   Normal zone: 64 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 8128 pages, LIFO batch:0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 8128
[    0.000000] Kernel command line:  board=3DWP543 ethaddr=3D00:80:48:6=
e:ae:d1 root=3D/dev/mtdblock3 rw rootfstype=3Djffs2 noinitrd console=3D=
ttyS0,115200
[    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 b=
ytes)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 byt=
es)
[    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32=
 bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, lin=
esize 32 bytes
[    0.000000] Writing ErrCtl register=3D00020782
[    0.000000] Readback ErrCtl register=3D00020782
[    0.000000] Memory: 23284k/32768k available (2517k kernel code, 9484=
k reserved, 869k data, 192k init, 0k highmem)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:80
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.004000] Calibrating delay loop... 199.68 BogoMIPS (lpj=3D399360)
[    0.036000] pid_max: default: 32768 minimum: 301
[    0.036000] Mount-cache hash table entries: 512
[    0.092000] NET: Registered protocol family 16
[    0.120000] MIPS: machine is Compex WP543
[    2.632000] registering PCI controller with io_map_base unset
[    2.716000] bio: create slab <bio-0> at 0
[    2.752000] Switching to clocksource MIPS
[    2.756000] Switched to NOHz mode on CPU #0
[    2.784000] NET: Registered protocol family 2
[    2.788000] IP route cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    2.800000] TCP established hash table entries: 1024 (order: 1, 8192=
 bytes)
[    2.800000] TCP bind hash table entries: 1024 (order: 4, 98304 bytes=
)
[    2.804000] TCP: Hash tables configured (established 1024 bind 1024)
[    2.804000] TCP reno registered
[    2.804000] UDP hash table entries: 32 (order: 0, 6656 bytes)
[    2.808000] UDP-Lite hash table entries: 32 (order: 0, 6656 bytes)
[    2.812000] NET: Registered protocol family 1
[    2.812000] PCI: CLS 0 bytes, default 32
[    2.840000] JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Re=
d Hat, Inc.
[    2.844000] msgmni has been set to 45
[    2.848000] io scheduler noop registered
[    2.848000] io scheduler deadline registered
[    2.848000] io scheduler cfq registered (default)
[    2.848000] start plist test
[    2.868000] end plist test
[    4.228000] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    4.280000] serial8250.0: ttyS0 at MMIO 0x18020000 (irq =3D 11) is a=
 16550A
[    4.996000] console [ttyS0] enabled, bootconsole disabled
[    5.120000] brd: module loaded
[    5.172000] loop: module loaded
[    5.216000] m25p80 spi0.0: found m25p32, expected m25p80
[    5.216000] m25p80 spi0.0: m25p32 (4096 Kbytes)
[    5.220000] spi0.0: searching for MyLoader partition table at offset=
 0x10000
[    5.224000] spi0.0: searching for MyLoader partition table at offset=
 0x20000
[    5.228000] 4 MyLoader partitions found on MTD device spi0.0
[    5.228000] Creating 4 MTD partitions on "spi0.0":
[    5.228000] 0x000000000000-0x000000020000 : "myloader"
[    5.260000] 0x000000020000-0x000000030000 : "partition_table"
[    5.276000] 0x000000030000-0x000000170000 : "kernel"
[    5.292000] 0x000000160000-0x000000400000 : "rootfs"
[    5.320000] mii_read: addr=3D0000, reg=3D0002, value=3Dffff
[    5.320000] mii_read: addr=3D0000, reg=3D0003, value=3Dffff
[    5.320000] mii_read: addr=3D0001, reg=3D0002, value=3Dffff
[    5.320000] mii_read: addr=3D0001, reg=3D0003, value=3Dffff
[    5.324000] mii_read: addr=3D0002, reg=3D0002, value=3Dffff
[    5.324000] mii_read: addr=3D0002, reg=3D0003, value=3Dffff
[    5.324000] mii_read: addr=3D0003, reg=3D0002, value=3D004d
[    5.324000] mii_read: addr=3D0003, reg=3D0003, value=3Dd021
[    5.328000] ag71xx_mdio: probed
[    5.328000] ag71xx_mdio: mii_cfg=3D00000007, mii_cmd=3D00000000, mii=
_addr=3D00000303
[    5.328000] ag71xx_mdio: mii_ctrl=3D00000000, mii_status=3D0000d021,=
 mii_ind=3D00000000
[    5.348000] eth0: Atheros AG71xx at 0xb9000000, irq 4
[    5.348000] eth0: mac_cfg1=3D00000000, mac_cfg2=3D00007000, ipg=3D40=
605060, hdx=3D00a1f037, mfl=3D00000600
[    5.348000] eth0: mac_ifctl=3D00000000, mac_addr1=3D00000000, mac_ad=
dr2=3D00000000
[    5.348000] eth0: fifo_cfg0=3D0000001f, fifo_cfg1=3D01ffffff, fifo_c=
fg2=3D015500aa
[    5.348000] eth0: fifo_cfg3=3D015503ff, fifo_cfg4=3D00000000, fifo_c=
fg5=3D000bffff
[    5.656000] eth0: dma_tx_ctrl=3D00000000, dma_tx_desc=3D00000000, dm=
a_tx_status=3D00000000
[    5.656000] eth0: dma_rx_ctrl=3D00000000, dma_rx_desc=3D00000000, dm=
a_rx_status=3D00000000
[    5.660000] eth0: dma_tx_ctrl=3D00000000, dma_tx_desc=3D01ee1000, dm=
a_tx_status=3D00000000
[    5.660000] eth0: dma_rx_ctrl=3D00000000, dma_rx_desc=3D01ee1000, dm=
a_rx_status=3D00000000
[    5.660000] eth0: mac_cfg1=3D0000000f, mac_cfg2=3D00007014, ipg=3D40=
605060, hdx=3D00a1f037, mfl=3D00000604
[    5.660000] eth0: mac_ifctl=3D00000000, mac_addr1=3D00000000, mac_ad=
dr2=3D00000000
[    5.660000] eth0: fifo_cfg0=3D001d1f00, fifo_cfg1=3D01ff0000, fifo_c=
fg2=3D000003ff
[    5.660000] eth0: fifo_cfg3=3D015503ff, fifo_cfg4=3D0000ffff, fifo_c=
fg5=3D0007efef
[    5.660000] eth0: PHY found at ag71xx-mdio.0:03, uid=3D004dd021
[    5.660000] mii_read: addr=3D0003, reg=3D0001, value=3D7949
[    5.660000] mii_read: addr=3D0003, reg=3D000f, value=3D0000
[    5.660000] ag71xx ag71xx.0: eth0: connected to PHY at ag71xx-mdio.0=
:03 [uid=3D004dd021, driver=3DGeneric PHY]
[    5.668000] i2c /dev entries driver
[    5.692000] Registered led device: wp543:green:led1
[    5.696000] Registered led device: wp543:green:led2
[    5.696000] Registered led device: wp543:green:wlan
[    5.700000] Registered led device: wp543:green:conn
[    5.700000] Registered led device: wp543:green:diag
[    5.708000] TCP cubic registered
[    5.708000] NET: Registered protocol family 17
[    5.724000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   13.672000] JFFS2 notice: (1) jffs2_build_xattr_subsystem: complete =
building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of =
xref (0 dead, 0 orphan) found.
[   13.708000] VFS: Mounted root (jffs2 filesystem) on device 31:3.
[   13.712000] Freeing unused kernel memory: 192k freed
[   20.932000]
[   20.932000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   20.932000] [ INFO: possible circular locking dependency detected ]
[   20.932000] 3.0.18-rt34 #41
[   20.932000] -------------------------------------------------------
[   20.932000] depmod/734 is trying to acquire lock:
[   20.932000]  (&mm->mmap_sem){++++++}, at: [<800e82d0>] might_fault+0=
x4c/0xa4
[   20.932000]
[   20.932000] but task is already holding lock:
[   20.932000]  (&f->sem){+.+.+.}, at: [<80184f88>] jffs2_readdir+0x108=
/0x1c0
[   20.932000]
[   20.932000] which lock already depends on the new lock.
[   20.932000]
[   20.932000]
[   20.932000] the existing dependency chain (in reverse order) is:
[   20.932000]
[   20.932000] -> #1 (&f->sem){+.+.+.}:
[   20.932000]        [<800bae14>] lock_acquire+0x60/0x88
[   20.932000]        [<802d3a84>] _mutex_lock+0x34/0x48
[   20.932000]        [<80185754>] jffs2_readpage+0x24/0x54
[   20.932000]        [<800d91e8>] __do_page_cache_readahead+0x274/0x2d=
c
[   20.932000]        [<800d9278>] ra_submit+0x28/0x34
[   20.932000]        [<800d1320>] filemap_fault+0x1a8/0x48c
[   20.932000]        [<800e898c>] __do_fault+0x70/0x468
[   20.932000]        [<800e9df8>] handle_pte_fault+0x388/0xd28
[   20.932000]        [<800eaa44>] handle_mm_fault+0xf4/0x11c
[   20.932000]        [<8006c230>] do_page_fault+0x110/0x300
[   20.932000]        [<80062c04>] ret_from_exception+0x0/0x10
[   20.932000]        [<801c3cb4>] __bzero+0x38/0x164
[   20.932000]        [<8014121c>] padzero+0x58/0x84
[   20.932000]        [<80142b18>] load_elf_binary+0x774/0x12fc
[   20.932000]        [<80102c60>] search_binary_handler+0xec/0x318
[   20.932000]        [<801044c4>] do_execve+0x158/0x264
[   20.932000]        [<800670a8>] sys_execve+0x44/0x6c
[   20.932000]        [<8006a3b8>] stack_done+0x20/0x40
[   20.932000]
[   20.932000] -> #0 (&mm->mmap_sem){++++++}:
[   20.932000]        [<800ba1f4>] __lock_acquire+0x1228/0x1934
[   20.932000]        [<800bae14>] lock_acquire+0x60/0x88
[   20.932000]        [<800e82f8>] might_fault+0x74/0xa4
[   20.932000]        [<8010dd80>] filldir64+0xe0/0x144
[   20.932000]        [<80184fe4>] jffs2_readdir+0x164/0x1c0
[   20.932000]        [<8010e070>] vfs_readdir+0x74/0xcc
[   20.932000]        [<8010e13c>] sys_getdents64+0x74/0xd8
[   20.932000]        [<8006a3b8>] stack_done+0x20/0x40
[   20.932000]
[   20.932000] other info that might help us debug this:
[   20.932000]
[   20.932000]  Possible unsafe locking scenario:
[   20.932000]
[   20.932000]        CPU0                    CPU1
[   20.932000]        ----                    ----
[   20.932000]   lock(&f->sem);
[   20.932000]                                lock(&mm->mmap_sem);
[   20.932000]                                lock(&f->sem);
[   20.932000]   lock(&mm->mmap_sem);
[   20.932000]
[   20.932000]  *** DEADLOCK ***
[   20.932000]
[   20.932000] 2 locks held by depmod/734:
[   20.932000]  #0:  (&sb->s_type->i_mutex_key#3){+.+.+.}, at: [<8010e0=
44>] vfs_readdir+0x48/0xcc
[   20.932000]  #1:  (&f->sem){+.+.+.}, at: [<80184f88>] jffs2_readdir+=
0x108/0x1c0
[   20.932000]
[   20.932000] stack backtrace:
[   20.932000] Call Trace:
[   20.932000] [<802d103c>] dump_stack+0x8/0x34
[   20.932000] [<800b8960>] print_circular_bug+0x2bc/0x2e8
[   20.932000] [<800ba1f4>] __lock_acquire+0x1228/0x1934
[   20.932000] [<800bae14>] lock_acquire+0x60/0x88
[   20.932000] [<800e82f8>] might_fault+0x74/0xa4
[   20.932000] [<8010dd80>] filldir64+0xe0/0x144
[   20.932000] [<80184fe4>] jffs2_readdir+0x164/0x1c0
[   20.932000] [<8010e070>] vfs_readdir+0x74/0xcc
[   20.932000] [<8010e13c>] sys_getdents64+0x74/0xd8
[   20.932000] [<8006a3b8>] stack_done+0x20/0x40
[   20.932000]
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
