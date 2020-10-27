Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48B4C4363A
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 10:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C8720727
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 10:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421306AbgJ0Kwc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 06:52:32 -0400
Received: from mail.monom.org ([188.138.9.77]:54546 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421168AbgJ0Kwb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 06:52:31 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id A69EE50046C;
        Tue, 27 Oct 2020 11:52:26 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 6250E500299;
        Tue, 27 Oct 2020 11:52:26 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:52:26 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] v5.9.1-rt19
Message-ID: <20201027105226.pzqqgeni572juhje@beryllium.lan>
References: <20201024091838.gzhn2dlx2j7xnixg@linutronix.de>
 <20201027093616.5vn6xinmthxulhvx@beryllium.lan>
 <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
 <20201027102547.y6wop7j2ovzg2tyx@beryllium.lan>
 <20201027102851.gizepjlu4opensqb@linutronix.de>
 <20201027103411.h5ushvwsrovxls5u@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027103411.h5ushvwsrovxls5u@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Oct 27, 2020 at 11:34:11AM +0100, Daniel Wagner wrote:
> It says so, let me double check if those task really run with SCHED_FIFO.

I just got an RCU stall without any background load. Anyway, just for
completeness here is the ps output:

root@c2d:~# ps -eLo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm
  PID   TID CLS RTPRIO  NI PRI PSR %CPU STAT WCHAN          COMMAND
    1     1 TS       -   0  19   0  0.0 Ss   -              systemd
    2     2 TS       -   0  19   0  0.0 S    -              kthreadd
    3     3 TS       - -20  39   0  0.0 I<   -              rcu_gp
    4     4 TS       - -20  39   0  0.0 I<   -              rcu_par_gp
    6     6 TS       - -20  39   0  0.0 I<   -              kworker/0:0H-events_highpri
    8     8 TS       - -20  39   0  0.0 I<   -              mm_percpu_wq
    9     9 TS       -   0  19   0  0.0 S    -              ksoftirqd/0
   10    10 FF       1   -  41   0  0.0 S    -              rcuc/0
   11    11 FF       1   -  41   0  0.0 I    -              rcu_preempt
   12    12 FF       1   -  41   0  0.0 S    -              rcub/0
   13    13 FF      99   - 139   0  0.0 S    -              migration/0
   14    14 TS       -   0  19   0  0.0 S    -              cpuhp/0
   15    15 TS       -   0  19   1  0.0 S    -              cpuhp/1
   16    16 FF      99   - 139   1  0.0 S    -              migration/1
   17    17 FF       1   -  41   1  0.0 R    -              rcuc/1
   18    18 TS       -   0  19   1  0.0 R    -              ksoftirqd/1
   19    19 TS       -   0  19   1  0.0 I    -              kworker/1:0-events_freezable_power_
   20    20 TS       - -20  39   1  0.0 I<   -              kworker/1:0H-kblockd
   21    21 TS       -   0  19   1  0.0 S    -              kdevtmpfs
   22    22 TS       - -20  39   0  0.0 I<   -              netns
   23    23 TS       -   0  19   1  0.0 S    -              rcu_tasks_kthre
   24    24 TS       -   0  19   1  0.0 S    -              rcu_tasks_rude_
   25    25 TS       -   0  19   0  0.0 S    -              kauditd
   26    26 TS       -   0  19   1  0.0 I    -              kworker/1:1-events_freezable_power_
   27    27 TS       -   0  19   0  0.0 I    -              kworker/0:1-ata_sff
   28    28 TS       -   0  19   1  0.0 S    -              oom_reaper
   29    29 TS       - -20  39   1  0.0 I<   -              writeback
   30    30 TS       -   0  19   0  0.0 S    -              kcompactd0
   50    50 TS       - -20  39   1  0.0 I<   -              kblockd
   51    51 FF      50   -  90   1  0.0 S    -              irq/9-acpi
   52    52 TS       - -20  39   1  0.0 I<   -              ata_sff
   53    53 TS       - -20  39   0  0.0 I<   -              md
   54    54 TS       - -20  39   0  0.0 I<   -              rpciod
   55    55 TS       - -20  39   0  0.0 I<   -              kworker/u9:0-xprtiod
   56    56 TS       - -20  39   0  0.0 I<   -              xprtiod
   57    57 TS       - -20  39   1  0.0 I<   -              cfg80211
   58    58 TS       -   0  19   0  0.0 S    -              kswapd0
   59    59 TS       - -20  39   1  0.0 I<   -              nfsiod
   61    61 TS       - -20  39   1  0.0 I<   -              acpi_thermal_pm
   63    63 FF      50   -  90   0  0.0 S    -              card0-crtc0
   64    64 FF      50   -  90   0  0.0 S    -              card0-crtc1
   65    65 FF      50   -  90   0  0.0 S    -              irq/16-i915
   66    66 TS       - -20  39   0  0.0 I<   -              kworker/0:1H-kblockd
   67    67 FF      50   -  90   1  0.0 S    -              irq/14-ata_piix
   68    68 FF      50   -  90   0  0.0 S    -              irq/15-ata_piix
   69    69 TS       -   0  19   1  0.0 S    -              scsi_eh_0
   70    70 TS       - -20  39   1  0.0 I<   -              scsi_tmf_0
   71    71 TS       -   0  19   1  0.0 S    -              scsi_eh_1
   72    72 TS       - -20  39   0  0.0 I<   -              scsi_tmf_1
   78    78 FF      50   -  90   1  0.0 S    -              irq/23-ehci_hcd
   79    79 FF      50   -  90   1  0.0 S    -              irq/23-uhci_hcd
   80    80 FF      50   -  90   0  0.0 S    -              irq/19-uhci_hcd
   81    81 FF      50   -  90   1  0.0 S    -              irq/18-uhci_hcd
   82    82 FF      50   -  90   0  0.0 S    -              irq/16-uhci_hcd
   83    83 FF      50   -  90   0  0.0 S    -              irq/1-i8042
   84    84 FF      50   -  90   1  0.0 S    -              irq/8-rtc0
   85    85 FF      50   -  90   0  0.0 S    -              irq/19-i801_smb
   86    86 TS       - -20  39   1  0.0 I<   -              ipv6_addrconf
   88    88 TS       -   0  19   0  0.2 S    -              pr/ttyS0
   89    89 TS       -   0  19   0  0.0 S    -              pr/netcon0
   93    93 TS       - -20  39   1  0.0 I<   -              kworker/1:1H-kblockd
   94    94 FF      50   -  90   0  0.0 S    -              irq/26-eth0
   95    95 TS       -   0  19   1  0.0 S    -              scsi_eh_2
   96    96 TS       - -20  39   1  0.0 I<   -              scsi_tmf_2
   97    97 TS       -   0  19   0  0.0 S    -              usb-storage
  105   105 TS       - -20  39   1  0.0 I<   -              kworker/u9:1-xprtiod
  106   106 TS       -   0  19   0  0.0 S    -              NFSv4 callback
  114   114 TS       -   0  19   0  0.0 I    -              kworker/u8:8-events_unbound
  158   158 TS       -   0  19   0  0.0 Ss   -              systemd-journal
  167   167 TS       -   0  19   0  0.0 Ss   -              systemd-udevd
  175   175 TS       -   0  19   0  0.0 Ss   -              systemd-network
  195   195 TS       -   0  19   0  0.0 Ssl  -              systemd-timesyn
  195   200 TS       -   0  19   0  0.0 Ssl  -              sd-resolve
  224   224 TS       -   0  19   0  0.0 Ss   -              sshd
  226   226 TS       -   0  19   1  0.0 Ss+  -              agetty
  227   227 TS       -   0  19   0  0.0 Ss+  -              agetty
  228   228 TS       -   0  19   1  0.0 Ss+  -              agetty
  232   232 TS       -   0  19   0  0.0 Ss+  -              agetty
  233   233 TS       -   0  19   1  0.0 Ss+  -              agetty
  234   234 TS       -   0  19   0  0.0 Ss+  -              agetty
  236   236 TS       -   0  19   1  0.0 Ss+  -              agetty
  241   241 FF      50   -  90   1  0.0 S    -              irq/4-ttyS0
  263   263 TS       -   0  19   0  0.0 I    -              kworker/u8:47-rpciod
  266   266 TS       -   0  19   1  0.0 R    -              kworker/1:2+events_freezable_power_
  267   267 TS       -   0  19   0  0.0 I    -              kworker/0:0-events_power_efficient
  269   269 TS       -   0  19   0  0.0 Ss   -              sshd
  275   275 TS       -   0  19   0  0.0 Ss   -              bash
  282   282 FF       4   -  44   0  0.0 Sl+  -              pi_stress
  282   283 FF       1   -  41   1 42.0 Rl+  -              pi_stress
  282   284 FF       2   -  42   1 22.1 Sl+  -              pi_stress
  282   285 FF       3   -  43   1 35.7 Rl+  -              pi_stress
  297   297 TS       -   0  19   1  0.0 R    -              kworker/1:3
  303   303 TS       -   0  19   0  0.0 I    -              kworker/0:2-ata_sff
  308   308 TS       -   0  19   1  0.0 R    -              kworker/1:4
  312   312 TS       -   0  19   0  0.0 I    -              kworker/0:3-ata_sff
  316   316 TS       -   0  19   0  0.0 I    -              kworker/u8:0-rpciod
  317   317 TS       -   0  19   0  0.0 I    -              kworker/u8:1-rpciod
  320   320 TS       -   0  19   0  1.0 Ss   -              sshd
  326   326 TS       -   0  19   0  0.0 Ss   -              bash
  329   329 TS       -   0  19   0  0.0 R+   -              ps
