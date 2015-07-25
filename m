From: DIXLOR <dixlor@gmail.com>
Subject: rtmutex deadlock detected (3.18.19-rt15)
Date: Sat, 25 Jul 2015 17:05:11 +0300
Message-ID: <55B39797.9020705@gmail.com>
Reply-To: dixlor@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:35033 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbbGYOFP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Jul 2015 10:05:15 -0400
Received: by lahh5 with SMTP id h5so27878763lah.2
        for <linux-rt-users@vger.kernel.org>; Sat, 25 Jul 2015 07:05:13 -0700 (PDT)
Received: from [192.168.1.2] (ppp85-140-254-10.pppoe.mtu-net.ru. [85.140.254.10])
        by smtp.googlemail.com with ESMTPSA id o18sm2602168lbg.1.2015.07.25.07.05.12
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jul 2015 07:05:12 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

# xfs_fsr;
^C

[ 3380.373641] WARNING: CPU: 6 PID: 3664 at kernel/locking/rtmutex.h:29 
0xffffffff814d4ea2()
[ 3380.373641] rtmutex deadlock detected
[ 3380.373645] Modules linked in: cpufreq_userspace cpufreq_powersave 
cpufreq_conservative nct6775 hwmon_vid xhci_hcd usbcore iTCO_wdt 
crct10dif_pclmul iTCO_vendor_support shpchp crc32c_intel i2c_i801 lpc_ich 
i2c_core usb_common mfd_core button processor dm_mod raid1 ahci libahci fan 
thermal thermal_sys [last unloaded: xhci_pci]
[ 3380.373646] CPU: 6 PID: 3664 Comm: xfs_fsr Tainted: G D        3.18.19-rt15 #3
[ 3380.373647] Hardware name: MSI MS-7823/B85M-G43 (MS-7823), BIOS V3.14B3 
06/23/2014
[ 3380.373647]  0000000000000000 0000000000000009 ffffffff814d1350 ffff8807ef65f538
[ 3380.373648]  ffffffff810498dd ffff8807cf289d10 ffff8807ef65f5c0 0000000000000000
[ 3380.373648]  0000000000000000 0000000000000002 ffffffff81049955 ffffffff81680648
[ 3380.373649] Call Trace:
[ 3380.373649]  [<ffffffff814d1350>] ? 0xffffffff814d1350
[ 3380.373649]  [<ffffffff810498dd>] ? 0xffffffff810498dd
[ 3380.373650]  [<ffffffff81049955>] ? 0xffffffff81049955
[ 3380.373650]  [<ffffffff814d4ea2>] ? 0xffffffff814d4ea2
[ 3380.373651]  [<ffffffff81245565>] ? 0xffffffff81245565
[ 3380.373651]  [<ffffffff81262cb0>] ? 0xffffffff81262cb0
[ 3380.373651]  [<ffffffff81245797>] ? 0xffffffff81245797
[ 3380.373651]  [<ffffffff8115a7d5>] ? 0xffffffff8115a7d5
[ 3380.373652]  [<ffffffff811558f8>] ? 0xffffffff811558f8
[ 3380.373652]  [<ffffffff81155a56>] ? 0xffffffff81155a56
[ 3380.373652]  [<ffffffff81140b23>] ? 0xffffffff81140b23
[ 3380.373653]  [<ffffffff81064074>] ? 0xffffffff81064074
[ 3380.373653]  [<ffffffff8104c366>] ? 0xffffffff8104c366
[ 3380.373653]  [<ffffffff810061f7>] ? 0xffffffff810061f7
[ 3380.373654]  [<ffffffff8103b2d6>] ? 0xffffffff8103b2d6
[ 3380.373654]  [<ffffffff8103bc6e>] ? 0xffffffff8103bc6e
[ 3380.373654]  [<ffffffff8125c3bb>] ? 0xffffffff8125c3bb
[ 3380.373655]  [<ffffffff8125c6dc>] ? 0xffffffff8125c6dc
[ 3380.373655]  [<ffffffff81234500>] ? 0xffffffff81234500
[ 3380.373655]  [<ffffffff81083a4d>] ? 0xffffffff81083a4d
[ 3380.373655]  [<ffffffff81234500>] ? 0xffffffff81234500
[ 3380.373656]  [<ffffffff814d7a22>] ? 0xffffffff814d7a22
[ 3380.373656]  [<ffffffff8115af85>] ? 0xffffffff8115af85
[ 3380.373656]  [<ffffffff81239492>] ? 0xffffffff81239492
[ 3380.373657]  [<ffffffff8120bf8d>] ? 0xffffffff8120bf8d
[ 3380.373657]  [<ffffffff81205d7f>] ? 0xffffffff81205d7f
[ 3380.373657]  [<ffffffff8120b656>] ? 0xffffffff8120b656
[ 3380.373658]  [<ffffffff8120ce11>] ? 0xffffffff8120ce11
[ 3380.373658]  [<ffffffff812322da>] ? 0xffffffff812322da
[ 3380.373659]  [<ffffffff811379cd>] ? 0xffffffff811379cd
[ 3380.373659]  [<ffffffff81237a6b>] ? 0xffffffff81237a6b
[ 3380.373659]  [<ffffffff8114159d>] ? 0xffffffff8114159d
[ 3380.373660]  [<ffffffff8113d4d6>] ? 0xffffffff8113d4d6
[ 3380.373660]  [<ffffffff811522b0>] ? 0xffffffff811522b0
[ 3380.373660]  [<ffffffff81152769>] ? 0xffffffff81152769
[ 3380.373661]  [<ffffffff811527d6>] ? 0xffffffff811527d6
[ 3380.373661]  [<ffffffff814d7a22>] ? 0xffffffff814d7a22
[ 3380.373661]  [<ffffffff814d64f2>] ? 0xffffffff814d64f2
[ 3380.373661] ---[ end trace 0000000000000003 ]---

