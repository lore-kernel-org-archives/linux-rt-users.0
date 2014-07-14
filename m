From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [PATCH RT 0/4] Linux 3.2.60-rt89-rc1
Date: Tue, 15 Jul 2014 03:05:35 +0400
Message-ID: <53C4623F.5090901@pavlinux.ru>
References: <20140714200634.590977709@goodmis.org>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp01.mtu.ru ([62.5.255.10]:36999 "EHLO imp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757203AbaGNXIv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jul 2014 19:08:51 -0400
In-Reply-To: <20140714200634.590977709@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

15.07.2014 00:06, Steven Rostedt =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Dear RT Folks,
>
> This is the RT stable review cycle of patch 3.2.60-rt89-rc1.

Actually 3.2.61

kernel/irq/manage.c
kernel/rtmutex.c

This files FUZZED :(
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
