From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch] drivers/block/zram: Replace bit spinlocks with
 rtmutex for -rt
Date: Tue, 22 Mar 2016 11:34:51 +0100
Message-ID: <1458642891.15742.11.camel@gmail.com>
References: <1458641979.15742.6.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34940 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959AbcCVKez (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 06:34:55 -0400
Received: by mail-wm0-f44.google.com with SMTP id l68so145660290wml.0
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 03:34:54 -0700 (PDT)
In-Reply-To: <1458641979.15742.6.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

ltp says it works fine.. though I personally can't imagine ever wanting
to use the thing.

[ 1119.471828] zram: Added device: zram0
[ 1119.474630] zram0: detected capacity change from 0 to 536870912
[ 1120.027155] zram: 16356 (zram01) Attribute compr_data_size (and others) will be removed. See zram documentation.
[ 1120.808081] zram0: detected capacity change from 536870912 to 0
[ 1120.809625] zram: Removed device: zram0
[ 1120.833365] zram: Added device: zram0
[ 1120.833903] zram: Added device: zram1
[ 1120.834365] zram: Added device: zram2
[ 1120.835769] zram: Added device: zram3
[ 1120.846528] zram0: detected capacity change from 0 to 26214400
[ 1120.846898] zram1: detected capacity change from 0 to 26214400
[ 1120.847165] zram2: detected capacity change from 0 to 26214400
[ 1120.847352] zram3: detected capacity change from 0 to 26214400
[ 1120.872719] BTRFS: device fsid 65d42bcc-8185-47d2-984f-64e097dd3356 devid 1 transid 3 /dev/zram3
[ 1120.875637] EXT4-fs (zram0): mounting ext3 file system using the ext4 subsystem
[ 1120.875825] EXT4-fs (zram0): mounted filesystem with ordered data mode. Opts: (null)
[ 1120.878829] EXT4-fs (zram1): mounted filesystem with ordered data mode. Opts: (null)
[ 1120.881819] XFS (zram2): Mounting V4 Filesystem
[ 1120.883469] XFS (zram2): Ending clean mount
[ 1120.886281] BTRFS info (device zram3): disk space caching is enabled
[ 1120.886285] BTRFS: has skinny extents
[ 1120.886985] BTRFS: detected SSD devices, enabling SSD mode
[ 1120.887022] BTRFS: creating UUID tree
[ 1159.016910] XFS (zram2): Unmounting Filesystem
[ 1159.060865] zram0: detected capacity change from 26214400 to 0
[ 1159.060976] zram1: detected capacity change from 26214400 to 0
[ 1159.061155] zram2: detected capacity change from 26214400 to 0
[ 1159.061263] zram3: detected capacity change from 26214400 to 0
[ 1159.061776] zram: Removed device: zram0
[ 1159.079823] zram: Removed device: zram1
[ 1159.094944] zram: Removed device: zram2
[ 1159.110827] zram: Removed device: zram3
[ 1159.143375] zram: Added device: zram0
[ 1159.543950] zram0: detected capacity change from 0 to 107374182400
[ 1159.551720] Adding 104857596k swap on /dev/zram0.  Priority:-1 extents:1 across:104857596k SSFS
[ 1159.742644] zram0: detected capacity change from 107374182400 to 0
[ 1159.743304] zram: Removed device: zram0
[ 1159.771532] zram: Added device: zram0
[ 1159.773866] zram0: detected capacity change from 0 to 536870912
[ 1160.334486] zram: 28112 (zram03) Attribute compr_data_size (and others) will be removed. See zram documentation.
[ 1161.129510] zram0: detected capacity change from 536870912 to 0
[ 1161.131034] zram: Removed device: zram0


