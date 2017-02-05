From: Ran Shalit <ranshalit@gmail.com>
Subject: Latency difference between posix & non-posix timer
Date: Sun, 5 Feb 2017 19:11:01 +0200
Message-ID: <CAJ2oMhLAwf7AEjOGLTx9Lhd0DVH1Psd-rmOoQkiKVTAiVaDXMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35576 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdBERLD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Feb 2017 12:11:03 -0500
Received: by mail-wr0-f174.google.com with SMTP id 89so12062064wrr.2
        for <linux-rt-users@vger.kernel.org>; Sun, 05 Feb 2017 09:11:03 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

We made some testing on out cpu, installed with 4.1.15-rt17 kernel,
and we observed significant difference in latency between posic to
non-posix cyclictest benchmark.

with non posix we reach max ~50usec
while with posix we reach max ~170usec

On checking the exaples in cyclic test wiki, it seems that the
difference should not be that big :
https://rt.wiki.kernel.org/index.php/Cyclictest

What is the reason for such difference in behaviour ?
Does it mean we better use non-posix timer in application ?

kernel version
==========
user@user-desktop:~/rt-tests-1.0$ uname -a
Linux user-desktop 4.1.15-rt17mah #6 SMP PREEMPT RT Wed Dec 23
20:12:08 CET 2015 x86_64 x86_64 x86_64 GNU/Linux

cpu information
==========
user@user-desktop:~/rt-tests-1.0$ cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 55
model name    : Intel(R) Atom(TM) CPU  E3815  @ 1.46GHz
stepping    : 9
microcode    : 0x903
cpu MHz        : 1463.000
cache size    : 512 KB
physical id    : 0
siblings    : 1
core id        : 0
cpu cores    : 1
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt
tsc_deadline_timer aes rdrand lahf_lm 3dnowprefetch arat epb dtherm
tpr_shadow vnmi flexpriority ept vpid tsc_adjust smep erms
bugs        :
bogomips    : 2930.40
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

Best Regards,
Ran
