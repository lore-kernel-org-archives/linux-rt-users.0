From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 0/8] Linux 3.2.53-rt76-rc1
Date: Thu, 16 Jan 2014 17:18:17 +0100
Message-ID: <52D80649.8040004@linutronix.de>
References: <20140116015824.201732155@goodmis.org>	<52D7A93C.9090801@pavlinux.ru> <20140116091847.0786c8af@gandalf.local.home> <52D7EE70.8000509@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: pavel@pavlinux.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43524 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbaAPQSY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Jan 2014 11:18:24 -0500
In-Reply-To: <52D7EE70.8000509@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/16/2014 03:36 PM, Pavel Vasilyev wrote:
> $ xz -cd /tmp/patch-3.2.53-rt75-rt76-rc1.patch.xz | patch -p1
> --dry-run
>=20
=E2=80=A6

> checking file include/linux/smp.h Hunk #1 succeeded at 117 with
> fuzz 1 (offset 16 lines). Hunk #2 FAILED at 147. 1 out of 2 hunks
> FAILED

I just fetched the 3.2.53 tar file & Steven's patches and I applied
the incremental patch and the all-in-one patch and I don't see this
fallout.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
