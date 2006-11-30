From: Tymoteusz Kielan <t.kielan@ente.com.pl>
Subject: Kernel 2.6.19-rt1 question
Date: Thu, 30 Nov 2006 12:51:36 +0100
Message-ID: <20061130125136.28d2e5d3@tkielan.ente.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_5abEPN74/dOed45tCA=+E0g"
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from res-243-25.sdc.pl ([193.178.243.25]:6613 "EHLO
	tartar.ente.com.pl") by vger.kernel.org with ESMTP id S936216AbWK3Ltf
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Nov 2006 06:49:35 -0500
Received: from tkielan.ente.local (unknown [192.168.233.24])
	by tartar.ente.com.pl (Postfix) with ESMTP id 2CBB54A220
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Nov 2006 12:49:29 +0100 (CET)
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--MP_5abEPN74/dOed45tCA=+E0g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I'm new here, and I don't know how to start.

I'm trying to setup an x86 costom platform on Linux RT branch.

Today, I was able to get 2.6.19-rt1 and run some tests.

I wrote some module that uses RT API an during modprobe, some thing unexpexted happened:

root@test:~# modprobe someModule
[  257.391000] softirq-tasklet/8[CPU#0]: BUG in rt_mutex_debug_task_free at kernel/rtmutex-debug.c:66
[  257.391000]  [<c0103e68>] dump_trace+0x82/0x20d
[  257.391000]  [<c01040cb>] show_trace_log_lvl+0x34/0x4a
[  257.391000]  [<c010410d>] show_trace+0x2c/0x2e
[  257.391000]  [<c010422a>] dump_stack+0x2b/0x2d
[  257.391000]  [<c011930b>] __WARN_ON+0x65/0x77
[  257.391000]  [<c0139c6a>] rt_mutex_debug_task_free+0x4b/0x88
[  257.391000]  [<c01151e4>] free_task+0x21/0x37
[  257.391000]  [<c01152bf>] __put_task_struct_cb+0xc5/0xcb
[  257.391000]  [<c0144c61>] rcu_process_callbacks+0x53/0x5e
[  257.391000]  [<c011d4fc>] __tasklet_action+0xc9/0xfc
[  257.391000]  [<c011d565>] tasklet_action+0x36/0x3b
[  257.391000]  [<c011d71c>] ksoftirqd+0xef/0x177
[  257.391000]  [<c012beb7>] kthread+0x90/0xb8
[  257.391000]  [<c0103d2f>] kernel_thread_helper+0x7/0x10
[  257.391000]  =======================

This bug is not critical, but I don't know what to expect from kernel giving me such
messages.
Is it my fault? This trace do not show any function calling from my someModule.

Following debug options are turned on:

CONFIG_DEBUG_RT_MUTEXES
CONFIG_FUNCTION_TRACE
CONFIG_LOCKDEP

Just to be sure I'll include full config.gz from running machine.

How can I track this bugs myself? What are they assocciated with?

Please, help

regards, Tim
-- 
Tim Kielan
Embedded Software Engineer
tel: +48 32 33 82 219
fax: +48 32 33 82 210
email: t.kielan@ente.eu
------------------------------------
ENTE Ltd.
44-100 Gliwice, Gaudiego 7
POLAND
------------------------------------

Wiadomosc ta oraz wszelkie jej zalaczniki (wiadomosc) sa przeznaczone
wylacznie dla ich odbiorcow i sa poufne. Jesli nie jestescie Panstwo
adresatami tej wiadomosci,  prosimy o jej usuniecie oraz o szybkie
powiadomienie o tym fakcie: nadawcy tej wiadomosci, lub ENTE Sp. z o.o. pod
numer telefonu + 48 32 33 82 200 lub adres e-mail postmaster@ente.com.pl

Kazde przegladanie, przekazywanie, rozpowszechnianie oraz kazde inne uzycie,
takze uzycie w zaufany sposob przez osoby inne niz zamierzony odbiorca, jest
zakazane.

Dziekujemy.

This e-mail message and any attachments (the message) is intended solely for
the addressees and is confidential. If you receive this message in error,
please delete it and immediately notify: the sender, or ENTE Sp. z o.o. at
+48 32 33 82 200, or at e-mail postmaster@ente.com.pl

Any review, retransmission, dissemination or other use of, or taking of any
action in reliance upon, this message by persons or entities other than the
intended recipient is prohibited.

Thank you.

--MP_5abEPN74/dOed45tCA=+E0g
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config.gz

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
Fqrff0HO5oygaQAA

--MP_5abEPN74/dOed45tCA=+E0g--
