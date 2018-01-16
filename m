From: Christoph Mathys <eraserix@gmail.com>
Subject: [4.9-rt][report] latency with i915 on skylake
Date: Tue, 16 Jan 2018 08:26:37 +0100
Message-ID: <CALqGcGr06F8POQT+JGj0f7xRYXCtkF3j=btnhXqERqdm6MeP=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:41311 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeAPH0i (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jan 2018 02:26:38 -0500
Received: by mail-io0-f174.google.com with SMTP id f6so15740165ioh.8
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Jan 2018 23:26:38 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On a Intel G4400 "Skylake" with kernel 4.9.47-rt37 I get a
reproducible latency spike (>200us) when the screen goes to standby.
The display is connected to the onboard DVI connector. The same thing
works fine on an older Ivy Bridge CPU. To trigger the spike when in
Xorg I use:

xset dpms force off

After setting the options below for the i915 kernel module I was no
longer able to reproduce the spikes:
- enable_rc6=0
- enable_dc=0
- disable_power_well=0

Below an excerpt of the trace before the latency occurred:

    Xorg-1385    1....11. 15579034us : pin_current_cpu <-migrate_disable
    Xorg-1385    1.....11 15579035us : rt_spin_unlock <-gen9_read32
    Xorg-1385    1.....11 15579035us : migrate_enable <-rt_spin_unlock
    Xorg-1385    1....11. 15579035us : unpin_current_cpu <-migrate_enable
    Xorg-1385    1....... 15579035us : gen9_read32 <-gen9_set_dc_state
    Xorg-1385    1....... 15579035us : rt_spin_lock <-gen9_read32
    Xorg-1385    1....... 15579035us : migrate_disable <-rt_spin_lock
    Xorg-1385    1....11. 15579035us : pin_current_cpu <-migrate_disable
    Xorg-1385    1.....11 15579035us : rt_spin_unlock <-gen9_read32
    Xorg-1385    1.....11 15579035us : migrate_enable <-rt_spin_unlock
    Xorg-1385    1....11. 15579035us : unpin_current_cpu <-migrate_enable
    Xorg-1385    1....... 15579035us : gen9_read32 <-gen9_set_dc_state
    Xorg-1385    1....... 15579036us : rt_spin_lock <-gen9_read32
    Xorg-1385    1....... 15579036us : migrate_disable <-rt_spin_lock
    Xorg-1385    1....11. 15579036us!: pin_current_cpu <-migrate_disable
    Xorg-1385    1d....11 15579425us : smp_apic_timer_interrupt
<-apic_timer_interrupt
    Xorg-1385    1d....11 15579425us : irq_enter <-smp_apic_timer_interrupt
    Xorg-1385    1d....11 15579425us : rcu_irq_enter <-irq_enter
    Xorg-1385    1d..h.11 15579425us : exit_idle <-smp_apic_timer_interrupt


Christoph
